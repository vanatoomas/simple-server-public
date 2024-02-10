const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const mariadb = require("mariadb");

const app = express();

const port = 8080;

const pool = mariadb.createPool({
  host: "localhost",
  database: "simple",
  user: "simple",
  password: "S1mpl3P4ssw0rd!",
  connectionLimit: 5,
  insertIdAsNumber: true,
  supportBigNumbers: true,
});

const connectDatabase = async (callback) => {
  let connection;
  try {
    connection = await pool.getConnection();
    await connection.beginTransaction();
    const response = await callback(connection);
    await connection.commit();
    return response;
  } catch (e) {
    if (connection) {
      await connection.rollback();
    }
    throw e;
  } finally {
    if (connection) {
      await connection.end();
    }
  }
};

app.use(cors());
app.use(bodyParser.json());

const withErrorHandling = (handler) => async (req, res) => {
  try {
    await handler(req, res);
  } catch (error) {
    console.error("An error occurred:", error);
    res.status(500).send("Internal Server Error");
  }
};

function getCurrentTime() {
  const date = new Date();

  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, "0");
  const day = String(date.getDate()).padStart(2, "0");
  const hours = String(date.getHours()).padStart(2, "0");
  const minutes = String(date.getMinutes()).padStart(2, "0");
  const seconds = String(date.getSeconds()).padStart(2, "0");

  const formattedDate = `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
  return formattedDate;
}

app.get(
  "/api/users",
  withErrorHandling(async (req, res) => {
    const response = await connectDatabase(async (connection) => {
      return await connection.query(
        "SELECT id, first_name as firstName, last_name as lastName FROM user;"
      );
    });
    res.send(response);
  })
);

app.get(
  "/api/stakeholders",
  withErrorHandling(async (req, res) => {
    const response = await connectDatabase(async (connection) => {
      return await connection.query(
        "SELECT d.id AS id, d.name AS name, JSON_ARRAYAGG(JSON_OBJECT('id', u.id, 'firstName', u.first_name, 'lastName', u.last_name)) AS users FROM department d JOIN user_department ud ON d.id = ud.fk_department JOIN user u ON ud.fk_user = u.id GROUP BY d.id;"
      );
    });
    res.send(response);
  })
);

app.get(
  "/api/processes",
  withErrorHandling(async (req, res) => {
    const response = await connectDatabase(async (connection) => {
      return await connection.query("SELECT id, name FROM process;");
    });
    res.send(response);
  })
);

app.get(
  "/api/data-types",
  withErrorHandling(async (req, res) => {
    const response = await connectDatabase(async (connection) => {
      return await connection.query("SELECT id, name FROM data_type;");
    });
    res.send(response);
  })
);

app.get(
  "/api/quality-criteria",
  withErrorHandling(async (req, res) => {
    const response = await connectDatabase(async (connection) => {
      return await connection.query("SELECT id, name FROM quality_criteria;");
    });
    res.send(response);
  })
);

app.get(
  "/api/evaluation-period",
  withErrorHandling(async (req, res) => {
    const { evaluationId } = req.query;
    const response = await connectDatabase(async (connection) => {
      return await connection.query(
        `SELECT fk_period as evaluationPeriodId
       FROM evaluation
       WHERE id = ${evaluationId}`
      );
    });
    res.send(response);
  })
);

app.get(
  "/api/evaluation/stakeholders",
  withErrorHandling(async (req, res) => {
    const { evaluationPeriodId } = req.query;
    const result = await connectDatabase(async (connection) => {
      return await connection.query(`SELECT fk_user
                                   FROM evaluation_stakeholders
                                   WHERE fk_period = ${evaluationPeriodId};`);
    });
    res.send(result.map((evaluation) => evaluation.fk_user));
  })
);

app.post(
  "/api/evaluation/stakeholders",
  withErrorHandling(async (req, res) => {
    const { evaluationPeriodId, users } = req.body;
    const values = users.map((userId) => [evaluationPeriodId, userId]);
    const formattedValues = values
      .map((value) => `(${value.join(",")})`)
      .join(",");
    await connectDatabase(async (connection) => {
      await connection.query(
        `DELETE FROM evaluation_stakeholders WHERE fk_period = ?`,
        [evaluationPeriodId]
      );
      await connection.query(`INSERT INTO evaluation_stakeholders (fk_period, fk_user)
                              VALUES ${formattedValues}`);
    });
    res.send();
  })
);

app.get(
  "/api/evaluation/processes",
  withErrorHandling(async (req, res) => {
    const { evaluationId } = req.query;
    const response = await connectDatabase(async (connection) => {
      return await connection.query(`SELECT p.id, p.name, ep.id as evaluationProcessId
                                   FROM process p
                                            JOIN evaluation_process ep ON p.id = ep.fk_process
                                   WHERE ep.fk_evaluation = ${evaluationId};`);
    });
    res.send(response);
  })
);

app.post(
  "/api/evaluation/processes",
  withErrorHandling(async (req, res) => {
    const { evaluationId, processes, newProcesses } = req.body;
    const values = processes.map((processId) => [evaluationId, processId]);
    const newInserts = [];
    await connectDatabase(async (connection) => {
      for (const newProcess of newProcesses) {
        const result = await connection.query(`INSERT INTO process (name)
                                             VALUES ('${newProcess.name}')`);
        const { insertId } = result;
        newInserts.push([evaluationId, insertId]);
      }
      const allValues = [...values, ...newInserts];
      const formattedValues = allValues
        .map((value) => `(${value.join(",")})`)
        .join(",");
      await connection.query(`INSERT INTO evaluation_process (fk_evaluation, fk_process)
                            VALUES ${formattedValues}`);
    });
    res.send();
  })
);

app.get(
  "/api/evaluation/data-types",
  withErrorHandling(async (req, res) => {
    const { evaluationId } = req.query;
    const response = await connectDatabase(async (connection) => {
      return await connection.query(`SELECT ep.fk_process AS processId, fk_data_type AS dataTypeId
                                   FROM evaluation_process_data_type
                                            JOIN evaluation_process ep
                                                 ON evaluation_process_data_type.fk_evaluation_process = ep.id
                                   WHERE ep.fk_evaluation = ${evaluationId};`);
    });
    res.send(response);
  })
);

app.post(
  "/api/evaluation/data-types",
  withErrorHandling(async (req, res) => {
    const { data } = req.body;
    const values = data.map((val) => [val.evaluationProcessId, val.dataTypeId]);
    const formattedValues = values
      .map((value) => `(${value.join(",")})`)
      .join(",");
    await connectDatabase(async (connection) => {
      const evaluationProcessIds = [
        ...new Set(values.map((value) => value[0])),
      ];
      const placeholders = evaluationProcessIds.map(() => "?").join(",");
      await connection.query(
        `DELETE FROM evaluation_process_data_type WHERE fk_evaluation_process IN (${placeholders})`,
        evaluationProcessIds
      );
      await connection.query(`INSERT INTO evaluation_process_data_type (fk_evaluation_process, fk_data_type)
                            VALUES ${formattedValues}`);
    });
    res.send();
  })
);

app.get(
  "/api/evaluation/scores/data-types",
  withErrorHandling(async (req, res) => {
    const { evaluationId } = req.query;
    const response = await connectDatabase(async (connection) => {
      return await connection.query(`SELECT dt.id, dt.name, count(dt.id) as count
                                   from data_type dt
                                            JOIN evaluation_process_data_type epdt
                                                 on dt.id = epdt.fk_data_type
                                            JOIN evaluation_process ev on epdt.fk_evaluation_process = ev.id
                                            JOIN evaluation e on ev.fk_evaluation = e.id
                                   WHERE e.fk_period =
                                         (SELECT fk_period from evaluation where id = ${evaluationId})
                                   GROUP BY dt.id
                                   ORDER BY count desc
                                   LIMIT 5;`);
    });
    res.send(response);
  })
);

app.get(
  "/api/evaluation/scores",
  withErrorHandling(async (req, res) => {
    const { evaluationId } = req.query;
    const result = await connectDatabase(async (connection) => {
      return await connection.query(`SELECT fk_data_type as dataTypeId,
                                          fk_criteria  as criteriaId,
                                          score        as value
                                   FROM evaluation_data_type_criteria_score
                                   WHERE fk_evaluation = ${evaluationId}`);
    });
    const response = {};
    result.forEach((score) => {
      const criteriaScores = Object.keys(response).includes(score.criteriaId)
        ? { ...response[score.criteriaId] }
        : {};
      criteriaScores[score.dataTypeId] = score.value;
      response[score.criteriaId] = {
        ...response[score.criteriaId],
        ...criteriaScores,
      };
    });
    res.send(response);
  })
);

app.post(
  "/api/evaluation/scores",
  withErrorHandling(async (req, res) => {
    const { evaluationId, scores } = req.body;
    const evaluations = [];
    const currentTime = getCurrentTime();
    Object.keys(scores).forEach((criteriaId) => {
      const criteriaDataTypeScores = scores[criteriaId];
      const dataTypeIds = Object.keys(criteriaDataTypeScores);
      dataTypeIds.forEach((dataTypeId) => {
        evaluations.push([
          evaluationId,
          dataTypeId,
          criteriaId,
          criteriaDataTypeScores[dataTypeId],
        ]);
      });
    });
    const formattedValues = evaluations
      .map((value) => `(${value.join(",")})`)
      .join(",");
    await connectDatabase(async (connection) => {
      await connection.query(`INSERT INTO evaluation_data_type_criteria_score (fk_evaluation, fk_data_type, fk_criteria, score)
                            VALUES ${formattedValues}`);
      await connection.query(`UPDATE evaluation
                            SET completed = 1
                            WHERE id = ${evaluationId};`);
      await connection.query(
        `UPDATE evaluation_period
      SET date_end = ?
      WHERE id = (SELECT fk_period FROM evaluation WHERE id = ?)`,
        [currentTime, evaluationId]
      );
    });
    res.send();
  })
);

app.get(
  "/api/evaluation/results",
  withErrorHandling(async (req, res) => {
    const { evaluationId } = req.query;
    const result = await connectDatabase(async (connection) => {
      return await connection.query(`SELECT edtcs.fk_data_type as dataTypeId,
                                          edtcs.fk_criteria  as criteriaId,
                                          SUM(edtcs.score)   as value
                                   FROM evaluation_data_type_criteria_score edtcs
                                            JOIN evaluation e on edtcs.fk_evaluation = e.id
                                   WHERE e.fk_period = (SELECT fk_period
                                                        FROM evaluation ev
                                                        WHERE ev.id = ${evaluationId})
                                   GROUP BY fk_data_type, fk_criteria;`);
    });
    const response = {};
    result.forEach((score) => {
      const criteriaScores = Object.keys(response).includes(score.criteriaId)
        ? { ...response[score.criteriaId] }
        : {};
      criteriaScores[score.dataTypeId] = score.value;
      response[score.criteriaId] = {
        ...response[score.criteriaId],
        ...criteriaScores,
      };
    });
    res.send(response);
  })
);

app.get(
  "/api/evaluation/total-evaluations",
  withErrorHandling(async (req, res) => {
    const { evaluationId } = req.query;
    const response = await connectDatabase(async (connection) => {
      return await connection.query(`SELECT count(*) as total
                                   FROM evaluation
                                   WHERE fk_period = (SELECT e.fk_period
                                                      FROM evaluation e
                                                      WHERE e.id = ${evaluationId})
                                     AND completed = 1;`);
    });
    res.send({ total: response.length > 0 ? response[0].total : 1 });
  })
);

app.get(
  "/api/evaluation/summary/data-types",
  withErrorHandling(async (req, res) => {
    const { evaluationId } = req.query;
    const response = await connectDatabase(async (connection) => {
      return await connection.query(`SELECT dt.id,
                                          dt.name,
                                          count(*)                    AS priority,
                                          sum(edtcs.score),
                                          sum(edtcs.score) / count(*) AS calculatedScore
                                   FROM data_type dt
                                            JOIN evaluation_process_data_type epdt
                                                 ON dt.id = epdt.fk_data_type
                                            JOIN evaluation_data_type_criteria_score edtcs
                                                 ON dt.id = edtcs.fk_data_type
                                            JOIN evaluation_process ep ON epdt.fk_evaluation_process = ep.id
                                            JOIN evaluation e ON edtcs.fk_evaluation = e.id
                                   WHERE e.fk_period =
                                         (SELECT fk_period FROM evaluation WHERE id = ${evaluationId})
                                     AND e.completed = 1
                                   GROUP BY dt.id
                                   ORDER BY priority DESC;`);
    });
    res.send(response);
  })
);

app.get(
  "/api/evaluation/summary/quality-criteria",
  withErrorHandling(async (req, res) => {
    const { evaluationId } = req.query;
    const response = await connectDatabase(async (connection) => {
      return await connection.query(`SELECT criteria.id,
                                          criteria.name,
                                          count(*)                    AS priority,
                                          sum(edtcs.score),
                                          sum(edtcs.score) / count(*) AS calculatedScore
                                   FROM quality_criteria criteria
                                            JOIN evaluation_data_type_criteria_score edtcs
                                                 ON criteria.id = edtcs.fk_criteria
                                            JOIN evaluation e ON edtcs.fk_evaluation = e.id
                                   WHERE e.fk_period =
                                         (SELECT fk_period FROM evaluation WHERE id = ${evaluationId})
                                     AND e.completed = 1
                                   GROUP BY criteria.id
                                   ORDER BY priority DESC;`);
    });
    res.send(response);
  })
);

app.get(
  "/api/evaluation/actions",
  withErrorHandling(
    withErrorHandling(async (req, res) => {
      const { evaluationPeriodId } = req.query;
      const response = await connectDatabase(async (connection) => {
        return await connection.query(`SELECT id, activity, fk_user as userId, status
                                   FROM evaluation_action
                                   WHERE fk_period = ${evaluationPeriodId}`);
      });
      res.send(response);
    })
  )
);

app.post(
  "/api/evaluation/actions",
  withErrorHandling(async (req, res) => {
    const { evaluationPeriodId, actions } = req.body;
    const values = actions.map((action) => [
      action.activity,
      evaluationPeriodId,
      action.userId,
    ]);
    await connectDatabase(async (connection) => {
      for (let value of values) {
        await connection.query(
          `INSERT INTO evaluation_action (activity, fk_period, fk_user) VALUES (?, ?, ?)`,
          value
        );
      }
    });
    res.send();
  })
);

app.get(
  "/api/evaluations",
  withErrorHandling(async (req, res) => {
    const response = await connectDatabase(async (connection) => {
      return await connection.query(
        `SELECT e.id, e.fk_user as user, e.completed, e.eval_name as evalName, ep.date_start as createdTime, ep.date_end as endTime 
        FROM evaluation e
        INNER JOIN evaluation_period ep ON e.fk_period = ep.id;`
      );
    });
    res.send(response);
  })
);

app.post(
  "/api/evaluation",
  withErrorHandling(async (req, res) => {
    const { userId, evalName } = req.body;
    const currentTime = getCurrentTime();
    let evalResponse;
    await connectDatabase(async (connection) => {
      const evalPeriodResponse = await connection.query(
        `INSERT INTO evaluation_period (date_start)
      VALUES (?)`,
        [currentTime]
      );
      const { insertId } = evalPeriodResponse;
      evalResponse = await connection.query(
        `INSERT INTO evaluation (fk_user, fk_period, completed, eval_name)
      VALUES (?, ?, 0, ?)`,
        [userId, insertId, evalName]
      );
      await connection.query(
        `INSERT INTO evaluation_stakeholders (fk_user, fk_period)
      VALUES (?, ?)`,
        [userId, insertId]
      );
    });
    res.send({ evaluationId: evalResponse.insertId });
  })
);

app.get(
  "/api/tools",
  withErrorHandling(async (req, res) => {
    const response = await connectDatabase(async (connection) => {
      return await connection.query("SELECT id, name FROM tool;");
    });
    res.send(response);
  })
);

app.get(
  "/api/evaluation/tools",
  withErrorHandling(async (req, res) => {
    const { evaluationId } = req.query;
    const response = await connectDatabase(async (connection) => {
      return await connection.query(`SELECT t.id, t.name
                                   FROM tool t
                                            JOIN evaluation_tools et ON t.id = et.fk_tool_id
                                   WHERE et.fk_evaluation_id = ${evaluationId};`);
    });
    res.send(response);
  })
);

app.post(
  "/api/evaluation/tools",
  withErrorHandling(async (req, res) => {
    const { evaluationId, tools } = req.body;
    const values = tools.map((toolId) => [evaluationId, toolId]);
    const formattedValues = values
      .map((value) => `(${value.join(",")})`)
      .join(",");
    await connectDatabase(async (connection) => {
      await connection.query(`INSERT INTO evaluation_tools (fk_evaluation_id, fk_tool_id)
                            VALUES ${formattedValues}`);
    });
    res.send();
  })
);

app.get("/api", async (req, res) => {
  res.send("Hello from our server!");
});

app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
