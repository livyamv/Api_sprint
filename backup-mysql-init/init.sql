CREATE DATABASE  IF NOT EXISTS `agenda_senai` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `agenda_senai`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: db    Database: agenda_senai
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cancelamento_reserva`
--

DROP TABLE IF EXISTS `cancelamento_reserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cancelamento_reserva` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_schedule` int DEFAULT NULL,
  `fk_id_usuario` int DEFAULT NULL,
  `fk_number` char(5) DEFAULT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `inicio_periodo` datetime DEFAULT NULL,
  `fim_periodo` datetime DEFAULT NULL,
  `cancelado_em` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cancelamento_reserva`
--

LOCK TABLES `cancelamento_reserva` WRITE;
/*!40000 ALTER TABLE `cancelamento_reserva` DISABLE KEYS */;
INSERT INTO `cancelamento_reserva` VALUES (1,13,1,'A2','asdfghjkl','2025-02-20 14:00:00','2025-02-20 15:00:00','2025-05-21 16:11:33');
/*!40000 ALTER TABLE `cancelamento_reserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom`
--

DROP TABLE IF EXISTS `classroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classroom` (
  `number` char(5) NOT NULL,
  `description` varchar(255) NOT NULL,
  `capacity` int NOT NULL,
  PRIMARY KEY (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom`
--

LOCK TABLES `classroom` WRITE;
/*!40000 ALTER TABLE `classroom` DISABLE KEYS */;
INSERT INTO `classroom` VALUES ('A2','ELETRÔNICA',16),('A3','CLP',16),('A4','AUTOMAÇÃO',20),('A5','METROLOGIA',16),('A6','PNEUMÁTICA/HIDRÁULICA',20),('AJFR','OFICINA DE AJUSTAGEM/FRESAGEM',16),('ALI','LAB. ALIMENTOS',16),('AUTO','OFICINA DE MANUTENÇÃO AUTOMOTIVA',20),('B10','LAB. INFORMÁTICA',16),('B11','LAB. INFORMÁTICA',40),('B12','LAB. INFORMÁTICA',40),('B2','SALA DE AULA',32),('B3','SALA DE AULA',32),('B5','SALA DE AULA',40),('B6','SALA DE AULA',32),('B7','SALA DE AULA',32),('B8','LAB. INFORMÁTICA',20),('B9','LAB. INFORMÁTICA',16),('C1','SALA DE AULA',24),('C2','LAB. DE INFORMÁTICA',32),('C3','SALA DE MODELAGEM VESTUÁRIO',20),('C4','SALA DE MODELAGEM VESTUÁRIO',20),('C5','SALA DE AULA',16),('CNC','OFICINA DE CNC',16),('COEL','OFICINA DE COMANDOS ELÉTRICOS',16),('CORT1','OFICINA DE CORTE - G1',16),('CORT2','OFICINA DE CORTE - G2',16),('D1','SALA MODELAGEM',16),('D2','SALA DE MODELAGEM',20),('D3','SALA DE AULA',16),('D4','SALA DE CRIAÇÃO',18),('ITEL1','OFICINA DE INSTALAÇÕES ELÉTRICAS - G1',16),('ITEL2','OFICINA DE INSTALAÇÕES ELÉTRICAS - G2',16),('MMC','OFICINA DE MANUTENÇÃO MECÂNICA',16),('MONT1','OFICINA DE MONTAGEM - G1',16),('MONT2','OFICINA DE MONTAGEM - G2',16),('MPESP','OFICINA DE MANUTENÇÃO PESPONTO',16),('PESP1','OFICINA DE PESPONTO - G1',16),('PESP2','OFICINA DE PESPONTO - G2',16),('PESP3','OFICINA DE PESPONTO - G3',16),('PRE','OFICINA DE PREPARAÇÃO',16),('SOLD','OFICINA DE SOLDAGEM',16),('test','SALA DE REUNIÃO',40),('TOR','OFICINA DE TORNEARIA',20),('VEST','OFICINA DE VESTUÁRIO',20);
/*!40000 ALTER TABLE `classroom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedule` (
  `id_schedule` int NOT NULL AUTO_INCREMENT,
  `fk_id_usuario` int NOT NULL,
  `fk_number` char(5) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `inicio_periodo` datetime NOT NULL,
  `fim_periodo` datetime NOT NULL,
  PRIMARY KEY (`id_schedule`),
  KEY `fk_id_usuario` (`fk_id_usuario`),
  KEY `fk_number` (`fk_number`),
  CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`fk_id_usuario`) REFERENCES `user` (`id_usuario`),
  CONSTRAINT `schedule_ibfk_2` FOREIGN KEY (`fk_number`) REFERENCES `classroom` (`number`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule`
--

LOCK TABLES `schedule` WRITE;
/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
INSERT INTO `schedule` VALUES (4,2,'A2','asdfghjkl','2025-02-20 21:00:00','2025-02-20 22:00:00'),(5,1,'A2','asdfghjkl','2025-02-20 14:00:00','2025-02-20 15:00:00'),(7,1,'b7','Reunião de equipe','2025-05-01 10:00:00','2025-05-01 11:00:00'),(8,1,'A2','aulas','2025-05-04 11:00:00','2025-05-04 12:00:00'),(9,3,'c3','Ffdffffdr','2025-02-02 13:00:00','2025-02-02 14:00:00'),(10,1,'C2','Eeeee3','2025-02-02 13:22:00','2025-02-02 13:56:00'),(11,1,'MONT1','Project ','2025-02-02 10:00:00','2025-02-02 11:00:00'),(12,1,'MONT1','Ui','2025-02-02 10:00:00','2025-02-02 11:00:00');
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `cancelamento_reserva` AFTER DELETE ON `schedule` FOR EACH ROW BEGIN
  INSERT INTO cancelamento_reserva (
    id_schedule,
    fk_id_usuario,
    fk_number,
    descricao,
    inicio_periodo,
    fim_periodo
  )
  VALUES (
    OLD.id_schedule,
    OLD.fk_id_usuario,
    OLD.fk_number,
    OLD.descricao,
    OLD.inicio_periodo,
    OLD.fim_periodo
  );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `time_slots`
--

DROP TABLE IF EXISTS `time_slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_slots` (
  `id` int NOT NULL AUTO_INCREMENT,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_slots`
--

LOCK TABLES `time_slots` WRITE;
/*!40000 ALTER TABLE `time_slots` DISABLE KEYS */;
INSERT INTO `time_slots` VALUES (31,'07:30:00','08:30:00'),(32,'08:00:00','09:00:00'),(33,'08:30:00','09:30:00'),(34,'09:00:00','10:00:00'),(35,'09:30:00','10:30:00'),(36,'10:00:00','11:00:00'),(37,'10:30:00','11:30:00'),(38,'11:00:00','12:00:00'),(39,'11:30:00','12:30:00'),(40,'12:00:00','13:00:00'),(41,'12:30:00','13:30:00'),(42,'13:00:00','14:00:00'),(43,'13:30:00','14:30:00'),(44,'14:00:00','15:00:00'),(45,'14:30:00','15:30:00'),(46,'15:00:00','16:00:00'),(47,'15:30:00','16:30:00'),(48,'16:00:00','17:00:00'),(49,'16:30:00','17:30:00'),(50,'17:00:00','18:00:00'),(51,'17:30:00','18:30:00'),(52,'18:00:00','19:00:00'),(53,'18:30:00','19:30:00'),(54,'19:00:00','20:00:00'),(55,'19:30:00','20:30:00'),(56,'20:00:00','21:00:00'),(57,'20:30:00','21:30:00'),(58,'21:00:00','22:00:00'),(59,'21:30:00','22:30:00');
/*!40000 ALTER TABLE `time_slots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `cpf` char(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `cpf` (`cpf`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Livia','12345680091','livia@gmail.com','12345678'),(2,'Ana Clara','67644444444','ana@gmail.com','09876543'),(3,'Maria Clara','12345660091','maria@gmail.com','09090909'),(5,'Maria Luisa','11111111111','malu@gmail.com','12345678'),(6,'Mari','45677654321','mari@.gmail.com','123'),(7,'Aninha','98796895869','aninha@.gmail.com','985'),(8,'eu','22345680098','eu@gmail.com','12345678');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'agenda_senai'
--

--
-- Dumping routines for database 'agenda_senai'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-21 16:14:30
