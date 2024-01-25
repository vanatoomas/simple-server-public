-- MariaDB dump 10.19  Distrib 10.9.4-MariaDB, for osx10.17 (arm64)
--
-- Host: 127.0.0.1    Database: simple
-- ------------------------------------------------------
-- Server version	10.9.4-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `data_type`
--

DROP TABLE IF EXISTS `data_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `data_type_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_type`
--

LOCK TABLES `data_type` WRITE;
/*!40000 ALTER TABLE `data_type` DISABLE KEYS */;
INSERT INTO `data_type` VALUES
(1,'Employee competencies'),
(2,'Collective competencies'),
(3,'Organization need'),
(4,'Desired competencies'),
(5,'Potential competencies'),
(6,'Job profiles'),
(7,'Salary info');
/*!40000 ALTER TABLE `data_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `department_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES
(1,'Strategic management'),
(2,'Human resources'),
(3,'Training governance'),
(4,'Core employees');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evaluation`
--

DROP TABLE IF EXISTS `evaluation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `evaluation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_user` int(11) NOT NULL,
  `fk_period` int(11) NOT NULL,
  `completed` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_evaluation_id_uindex` (`id`),
  KEY `user_evaluation___fk_user` (`fk_user`),
  KEY `evaluation___fk_period` (`fk_period`),
  CONSTRAINT `evaluation___fk_period` FOREIGN KEY (`fk_period`) REFERENCES `evaluation_period` (`id`),
  CONSTRAINT `user_evaluation___fk_user` FOREIGN KEY (`fk_user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluation`
--

LOCK TABLES `evaluation` WRITE;
/*!40000 ALTER TABLE `evaluation` DISABLE KEYS */;
INSERT INTO `evaluation` VALUES
(38,1,1,1);
/*!40000 ALTER TABLE `evaluation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evaluation_action`
--

DROP TABLE IF EXISTS `evaluation_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `evaluation_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `activity` varchar(255) NOT NULL,
  `fk_period` int(11) NOT NULL,
  `fk_user` int(11) NOT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `evaluation_activity_id_uindex` (`id`),
  KEY `evaluation_activity___fk_evaluation` (`fk_period`),
  KEY `evaluation_activity___fk_user` (`fk_user`),
  CONSTRAINT `evaluation_activity___fk_evaluation` FOREIGN KEY (`fk_period`) REFERENCES `evaluation_period` (`id`),
  CONSTRAINT `evaluation_activity___fk_user` FOREIGN KEY (`fk_user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluation_action`
--

LOCK TABLES `evaluation_action` WRITE;
/*!40000 ALTER TABLE `evaluation_action` DISABLE KEYS */;
INSERT INTO `evaluation_action` VALUES
(1,'Testin seda',1,1,NULL);
/*!40000 ALTER TABLE `evaluation_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evaluation_data_type_criteria_score`
--

DROP TABLE IF EXISTS `evaluation_data_type_criteria_score`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `evaluation_data_type_criteria_score` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_evaluation` int(11) NOT NULL,
  `fk_data_type` int(11) NOT NULL,
  `fk_criteria` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `evaluation_data_type_criteria_score_id_uindex` (`id`),
  KEY `evaluation_data_type_criteria_score___fk_criteria` (`fk_criteria`),
  KEY `evaluation_data_type_criteria_score___fk_evaluation` (`fk_evaluation`),
  KEY `evaluation_data_type_criteria_score___fk_data_type` (`fk_data_type`),
  CONSTRAINT `evaluation_data_type_criteria_score___fk_criteria` FOREIGN KEY (`fk_criteria`) REFERENCES `quality_criteria` (`id`),
  CONSTRAINT `evaluation_data_type_criteria_score___fk_data_type` FOREIGN KEY (`fk_data_type`) REFERENCES `data_type` (`id`),
  CONSTRAINT `evaluation_data_type_criteria_score___fk_evaluation` FOREIGN KEY (`fk_evaluation`) REFERENCES `evaluation` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=345 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluation_data_type_criteria_score`
--

LOCK TABLES `evaluation_data_type_criteria_score` WRITE;
/*!40000 ALTER TABLE `evaluation_data_type_criteria_score` DISABLE KEYS */;
/*!40000 ALTER TABLE `evaluation_data_type_criteria_score` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evaluation_period`
--

DROP TABLE IF EXISTS `evaluation_period`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `evaluation_period` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `date_start` date NOT NULL,
  `date_end` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `evaluation_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluation_period`
--

LOCK TABLES `evaluation_period` WRITE;
/*!40000 ALTER TABLE `evaluation_period` DISABLE KEYS */;
INSERT INTO `evaluation_period` VALUES
(1,'Test','2023-11-15','2023-11-29');
/*!40000 ALTER TABLE `evaluation_period` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evaluation_process`
--

DROP TABLE IF EXISTS `evaluation_process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `evaluation_process` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_evaluation` int(11) NOT NULL,
  `fk_process` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `evaluation_process_id_uindex` (`id`),
  KEY `evaluation_process___fk_process` (`fk_process`),
  KEY `evaluation_process___fk_evaluation` (`fk_evaluation`),
  CONSTRAINT `evaluation_process___fk_evaluation` FOREIGN KEY (`fk_evaluation`) REFERENCES `evaluation` (`id`),
  CONSTRAINT `evaluation_process___fk_process` FOREIGN KEY (`fk_process`) REFERENCES `process` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluation_process`
--

LOCK TABLES `evaluation_process` WRITE;
/*!40000 ALTER TABLE `evaluation_process` DISABLE KEYS */;
/*!40000 ALTER TABLE `evaluation_process` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evaluation_process_data_type`
--

DROP TABLE IF EXISTS `evaluation_process_data_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `evaluation_process_data_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_evaluation_process` int(11) NOT NULL,
  `fk_data_type` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `evaluation_process_data_type_id_uindex` (`id`),
  KEY `evaluation_process_data_type__fk_data_type` (`fk_data_type`),
  KEY `evaluation_process_data_type__fk_evaluation_process` (`fk_evaluation_process`),
  CONSTRAINT `evaluation_process_data_type__fk_data_type` FOREIGN KEY (`fk_data_type`) REFERENCES `data_type` (`id`),
  CONSTRAINT `evaluation_process_data_type__fk_evaluation_process` FOREIGN KEY (`fk_evaluation_process`) REFERENCES `evaluation_process` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=453 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluation_process_data_type`
--

LOCK TABLES `evaluation_process_data_type` WRITE;
/*!40000 ALTER TABLE `evaluation_process_data_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `evaluation_process_data_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `process`
--

DROP TABLE IF EXISTS `process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `process` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `process_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `process`
--

LOCK TABLES `process` WRITE;
/*!40000 ALTER TABLE `process` DISABLE KEYS */;
INSERT INTO `process` VALUES
(1,'Career pathing'),
(2,'Competency gap'),
(3,'Competency suggestions'),
(4,'Competency statistics'),
(5,'Team formation'),
(6,'Training and development'),
(7,'Performance improvement'),
(19,'Wat1'),
(20,'Wat2'),
(21,'Tiimide ülevaatus'),
(22,'Veel üks protsess'),
(23,'Uus protsess'),
(24,'Järgmine'),
(26,'Abc'),
(27,'Test22'),
(28,'Adadada'),
(29,'Adada111'),
(30,'adafaf'),
(31,'adgakrflgjmrfg'),
(32,'sfcadf'),
(33,'dagafgfr'),
(34,'dfad'),
(35,'agafg'),
(36,'dfad'),
(37,'agafg'),
(38,'adfagafg'),
(39,'adgafgha'),
(40,'adgafgha'),
(41,'dfad'),
(42,'agafg'),
(43,'adfagafg'),
(44,'adgafgha'),
(45,'dfad'),
(46,'agafg'),
(47,'adfagafg'),
(48,'adgafgha'),
(49,'dfad'),
(50,'agafg'),
(51,'adfagafg'),
(52,'adgafgha'),
(53,'dfad'),
(54,'agafg'),
(55,'adfagafg'),
(56,'adgafgha'),
(57,'dfad'),
(58,'agafg'),
(59,'adfagafg'),
(60,'adgafgha'),
(61,'dfad'),
(62,'agafg'),
(63,'adfagafg'),
(64,'adgafgha'),
(65,'dfad'),
(66,'agafg'),
(67,'adfagafg'),
(68,'adgafgha'),
(69,'dfad'),
(70,'agafg'),
(71,'adfagafg'),
(72,'adgafgha'),
(73,'dfad'),
(74,'agafg'),
(75,'adfagafg'),
(76,'adgafgha'),
(77,'Test123'),
(78,'Sihtotsing'),
(79,'Kick-off meeting'),
(80,'Kontakti võtmine'),
(81,'Esimene kõne'),
(82,'Vestlusel hindamine'),
(83,'Vestlus juhi ja tooteomanikuga'),
(84,'Tehniline valideerimine'),
(85,'Taustakontroll'),
(86,'Soovitajad ja kontroll'),
(87,'Psühhomeetrilised testid (tripod, wopi või disc)'),
(88,'Pakkumine & läbirääkimine'),
(89,'Pre-boarding, onboarding'),
(90,'Vallandamine'),
(91,'Hiring');
/*!40000 ALTER TABLE `process` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quality_criteria`
--

DROP TABLE IF EXISTS `quality_criteria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quality_criteria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `quality_criteria_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quality_criteria`
--

LOCK TABLES `quality_criteria` WRITE;
/*!40000 ALTER TABLE `quality_criteria` DISABLE KEYS */;
INSERT INTO `quality_criteria` VALUES
(1,'Completeness'),
(2,'Timeliness'),
(3,'Relevance'),
(4,'Precision'),
(5,'Accessibility'),
(6,'Truthfulness');
/*!40000 ALTER TABLE `quality_criteria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_email_uindex` (`email`),
  UNIQUE KEY `user_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES
(1,'hr.bigboss@asd.com','$2a$10$pl8pqBvXhXJ6B3W3HkaGqODOtx1vH0h.snewbqJb8Y4a6Lol5iHua','HR','Bigboss'),
(2,'ashley.baker@asd.com','$2a$10$pl8pqBvXhXJ6B3W3HkaGqODOtx1vH0h.snewbqJb8Y4a6Lol5iHua','Ashley','Baker'),
(3,'amanda.smith@asd.com','$2a$10$pl8pqBvXhXJ6B3W3HkaGqODOtx1vH0h.snewbqJb8Y4a6Lol5iHua','Amanda','Smith'),
(4,'anthony.davis@asd.com','$2a$10$pl8pqBvXhXJ6B3W3HkaGqODOtx1vH0h.snewbqJb8Y4a6Lol5iHua','Anthony','Davis'),
(5,'lorem@ipsum.com','$2a$10$pl8pqBvXhXJ6B3W3HkaGqODOtx1vH0h.snewbqJb8Y4a6Lol5iHua','Lorem','Ipsum'),
(6,'yolo@swagginz.net','$2a$10$pl8pqBvXhXJ6B3W3HkaGqODOtx1vH0h.snewbqJb8Y4a6Lol5iHua','Yolo','Swagginz');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_department`
--

DROP TABLE IF EXISTS `user_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_user` int(11) NOT NULL,
  `fk_department` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_department_id_uindex` (`id`),
  KEY `user_department___fk_department` (`fk_department`),
  KEY `user_department___fk_user` (`fk_user`),
  CONSTRAINT `user_department___fk_department` FOREIGN KEY (`fk_department`) REFERENCES `department` (`id`),
  CONSTRAINT `user_department___fk_user` FOREIGN KEY (`fk_user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_department`
--

LOCK TABLES `user_department` WRITE;
/*!40000 ALTER TABLE `user_department` DISABLE KEYS */;
INSERT INTO `user_department` VALUES
(1,1,2),
(2,2,1),
(3,3,3),
(4,4,3),
(5,5,4),
(6,6,4);
/*!40000 ALTER TABLE `user_department` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-25 15:38:13
