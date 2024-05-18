-- MariaDB dump 10.19-11.2.2-MariaDB, for osx10.19 (arm64)
--
-- Host: viaduct.proxy.rlwy.net    Database: 
-- ------------------------------------------------------
-- Server version	11.2.2-MariaDB-1:11.2.2+maria~ubu2204

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
-- Current Database: `railway`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `railway` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `railway`;

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
  `completed` tinyint(4) DEFAULT NULL,
  `eval_name` varchar(255) DEFAULT NULL,
  `owner_uid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_evaluation_id_uindex` (`id`),
  KEY `user_evaluation___fk_user` (`fk_user`),
  KEY `evaluation___fk_period` (`fk_period`),
  CONSTRAINT `evaluation___fk_period` FOREIGN KEY (`fk_period`) REFERENCES `evaluation_period` (`id`),
  CONSTRAINT `user_evaluation___fk_user` FOREIGN KEY (`fk_user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluation`
--

LOCK TABLES `evaluation` WRITE;
/*!40000 ALTER TABLE `evaluation` DISABLE KEYS */;
INSERT INTO `evaluation` VALUES
(125,1,42,1,'sample','cMs7yyprZZZASd41FzlbiwS09ts2'),
(126,3,43,0,'Not completed sample','cMs7yyprZZZASd41FzlbiwS09ts2');
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluation_action`
--

LOCK TABLES `evaluation_action` WRITE;
/*!40000 ALTER TABLE `evaluation_action` DISABLE KEYS */;
INSERT INTO `evaluation_action` VALUES
(28,'test action',42,1,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=681 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluation_data_type_criteria_score`
--

LOCK TABLES `evaluation_data_type_criteria_score` WRITE;
/*!40000 ALTER TABLE `evaluation_data_type_criteria_score` DISABLE KEYS */;
INSERT INTO `evaluation_data_type_criteria_score` VALUES
(663,125,1,1,5),
(664,125,2,1,5),
(665,125,3,1,5),
(666,125,1,2,3),
(667,125,2,2,3),
(668,125,3,2,3),
(669,125,1,3,4),
(670,125,2,3,4),
(671,125,3,3,4),
(672,125,1,4,2),
(673,125,2,4,2),
(674,125,3,4,2),
(675,125,1,5,4),
(676,125,2,5,4),
(677,125,3,5,4),
(678,125,1,6,5),
(679,125,2,6,2),
(680,125,3,6,1);
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
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `evaluation_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluation_period`
--

LOCK TABLES `evaluation_period` WRITE;
/*!40000 ALTER TABLE `evaluation_period` DISABLE KEYS */;
INSERT INTO `evaluation_period` VALUES
(42,'2024-04-16 20:09:02','2024-04-16 20:10:27'),
(43,'2024-04-16 20:11:19',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluation_process`
--

LOCK TABLES `evaluation_process` WRITE;
/*!40000 ALTER TABLE `evaluation_process` DISABLE KEYS */;
INSERT INTO `evaluation_process` VALUES
(124,125,1),
(125,125,4),
(126,125,5),
(127,126,2),
(128,126,7);
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
) ENGINE=InnoDB AUTO_INCREMENT=825 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluation_process_data_type`
--

LOCK TABLES `evaluation_process_data_type` WRITE;
/*!40000 ALTER TABLE `evaluation_process_data_type` DISABLE KEYS */;
INSERT INTO `evaluation_process_data_type` VALUES
(819,124,1),
(820,124,2),
(821,124,3),
(822,125,2),
(823,125,3),
(824,126,3);
/*!40000 ALTER TABLE `evaluation_process_data_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evaluation_stakeholders`
--

DROP TABLE IF EXISTS `evaluation_stakeholders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `evaluation_stakeholders` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `fk_user` int(11) DEFAULT NULL,
  `fk_period` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_period_unique` (`fk_user`,`fk_period`),
  KEY `period` (`fk_period`),
  CONSTRAINT `evaluation_stakeholders_ibfk_1` FOREIGN KEY (`fk_user`) REFERENCES `user` (`id`),
  CONSTRAINT `evaluation_stakeholders_ibfk_2` FOREIGN KEY (`fk_period`) REFERENCES `evaluation_period` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluation_stakeholders`
--

LOCK TABLES `evaluation_stakeholders` WRITE;
/*!40000 ALTER TABLE `evaluation_stakeholders` DISABLE KEYS */;
INSERT INTO `evaluation_stakeholders` VALUES
(144,1,42),
(148,1,43),
(147,2,43),
(146,3,43);
/*!40000 ALTER TABLE `evaluation_stakeholders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evaluation_tools`
--

DROP TABLE IF EXISTS `evaluation_tools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `evaluation_tools` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_evaluation_id` int(11) DEFAULT NULL,
  `fk_tool_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_evaluation_id` (`fk_evaluation_id`),
  KEY `fk_tool_id` (`fk_tool_id`),
  CONSTRAINT `evaluation_tools_ibfk_3` FOREIGN KEY (`fk_evaluation_id`) REFERENCES `evaluation` (`id`),
  CONSTRAINT `evaluation_tools_ibfk_4` FOREIGN KEY (`fk_tool_id`) REFERENCES `tool` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluation_tools`
--

LOCK TABLES `evaluation_tools` WRITE;
/*!40000 ALTER TABLE `evaluation_tools` DISABLE KEYS */;
INSERT INTO `evaluation_tools` VALUES
(26,125,3),
(27,125,2),
(28,125,4);
/*!40000 ALTER TABLE `evaluation_tools` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
(21,'Tiimide ülevaatus'),
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
(90,'Vallandamine');
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
-- Table structure for table `selected_timezone`
--

DROP TABLE IF EXISTS `selected_timezone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `selected_timezone` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `uid` varchar(255) DEFAULT NULL,
  `timezoneId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`),
  KEY `FK_TimezoneId` (`timezoneId`),
  CONSTRAINT `FK_TimezoneId` FOREIGN KEY (`timezoneId`) REFERENCES `timezones` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `selected_timezone`
--

LOCK TABLES `selected_timezone` WRITE;
/*!40000 ALTER TABLE `selected_timezone` DISABLE KEYS */;
INSERT INTO `selected_timezone` VALUES
(22,'cMs7yyprZZZASd41FzlbiwS09ts2',85);
/*!40000 ALTER TABLE `selected_timezone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timezones`
--

DROP TABLE IF EXISTS `timezones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timezones` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `name` varchar(255) DEFAULT NULL,
  `offsetFromUTC` time DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timezones`
--

LOCK TABLES `timezones` WRITE;
/*!40000 ALTER TABLE `timezones` DISABLE KEYS */;
INSERT INTO `timezones` VALUES
(71,'Niue Time','-11:00:00'),
(72,'Samoa Standard Time','-11:00:00'),
(73,'Hawaii-Aleutian Standard Time','-10:00:00'),
(74,'Hawaii Standard Time','-10:00:00'),
(75,'Tokelau Time','-10:00:00'),
(76,'Marquesas Time','-09:30:00'),
(77,'Alaska Standard Time','-09:00:00'),
(78,'Pitcairn Standard Time','-08:00:00'),
(79,'Pacific Standard Time','-08:00:00'),
(80,'Mountain Standard Time','-07:00:00'),
(81,'Central Standard Time','-06:00:00'),
(82,'Eastern Standard Time','-06:00:00'),
(83,'Easter Is. Time','-06:00:00'),
(84,'Galapagos Time','-06:00:00'),
(85,'Colombia Time','-05:00:00'),
(86,'Ecuador Time','-05:00:00'),
(87,'Cuba Standard Time','-05:00:00'),
(88,'Peru Time','-05:00:00'),
(89,'Eastern Standard Time','-05:00:00'),
(90,'Venezuela Time','-04:30:00'),
(91,'Atlantic Standard Time','-04:00:00'),
(92,'Paraguay Time','-04:00:00'),
(93,'Newfoundland Standard Time','-03:30:00'),
(94,'Argentine Time','-03:00:00'),
(95,'Brasilia Time','-03:00:00'),
(96,'French Guiana Time','-03:00:00'),
(97,'Fernando de Noronha Time','-02:00:00'),
(98,'South Georgia Standard Time','-02:00:00'),
(99,'Azores Time','-01:00:00'),
(100,'Cape Verde Time','-01:00:00'),
(101,'Greenwich Mean Time','00:00:00'),
(102,'Western European Time','00:00:00'),
(103,'Coordinated Universal Time','00:00:00'),
(104,'Central European Time','01:00:00'),
(105,'Western African Time','01:00:00'),
(106,'Israel Standard Time','02:00:00'),
(107,'Eastern European Time','02:00:00'),
(108,'Eastern African Time','03:00:00'),
(109,'GMT+03:07','03:07:00'),
(110,'Iran Standard Time','03:30:00'),
(111,'Armenia Time','04:00:00'),
(112,'Seychelles Time','04:00:00'),
(113,'Mauritius Time','04:00:00'),
(114,'Armenia Time','04:00:00'),
(115,'Moscow Standard Time','04:00:00'),
(116,'Afghanistan Time','04:30:00'),
(117,'India Standard Time','05:30:00'),
(118,'Nepal Time','05:45:00'),
(119,'Bhutan Time','06:00:00'),
(120,'Myanmar Time','06:30:00'),
(121,'Cocos Islands Time','06:30:00'),
(122,'Davis Time','07:00:00'),
(123,'Indochina Time','07:00:00'),
(124,'Brunei Time','08:00:00'),
(125,'Choibalsan Time','08:00:00'),
(126,'Hong Kong Time','08:00:00'),
(127,'Philippines Time','08:00:00'),
(128,'Central Western Standard Time (Australia)','08:45:00'),
(129,'Palau Time','09:00:00'),
(130,'Central Standard Time (Northern Territory)','09:30:00'),
(131,'Yakutsk Time','10:00:00'),
(132,'Lord Howe Standard Time','10:30:00'),
(133,'Solomon Is. Time','11:00:00'),
(134,'Norfolk Time','11:30:00'),
(135,'New Zealand Standard Time','12:00:00'),
(136,'Marshall Islands Time','12:00:00'),
(137,'Nauru Time','12:00:00'),
(138,'Chatham Standard Time','12:45:00'),
(139,'Tonga Time','13:00:00'),
(140,'Line Is. Time','14:00:00');
/*!40000 ALTER TABLE `timezones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tool`
--

DROP TABLE IF EXISTS `tool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tool` (
  `name` varchar(255) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tool`
--

LOCK TABLES `tool` WRITE;
/*!40000 ALTER TABLE `tool` DISABLE KEYS */;
INSERT INTO `tool` VALUES
('GitHub',1),
('LinkedIn',2),
('Slack',3),
('Teams',4),
('Zoom',5),
('Outlook',6),
('Tableau',7),
('PowerBI',8),
('D3.js',9),
('Microsoft Excel',10),
('RapidMiner',11),
('Sisense',12),
('Moodle',13),
('Blackboard Learn',14),
('MySQL',15),
('Hadoop',16),
('Apache Spark',17),
('Google Analytics',18),
('Ahrefs',19),
('Nielsen',20),
('MailChimp',21),
('Skype',22),
('Google Data Studio',23),
('Salesforce',24),
('Pipedrive',25),
('SEMrush',26),
('Coursera for Business',27),
('LinkedIn Learning',28),
('Airtable',29),
('Google Sheets',30),
('PubMed',31),
('CDC',32),
('Doximity',33),
('Epic Systems',34),
('IBM Watson',35),
('Meditech',36),
('SimChart',37),
('Oracle',38),
('MongoDB',39);
/*!40000 ALTER TABLE `tool` ENABLE KEYS */;
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

-- Dump completed on 2024-04-16 20:13:15
