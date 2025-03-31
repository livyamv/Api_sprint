CREATE DATABASE  IF NOT EXISTS `agenda_senai` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `agenda_senai`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: agenda_senai
-- ------------------------------------------------------
-- Server version	8.0.36

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
INSERT INTO `classroom` VALUES ('A1','asdfghjkjhgfds',20),('A2','ELETRÔNICA',16),('A3','CLP',16),('A4','AUTOMAÇÃO',20),('A5','METROLOGIA',16),('A6','PNEUMÁTICA/HIDRÁULICA',20),('AJFR','OFICINA DE AJUSTAGEM/FRESAGEM',16),('ALI','LAB. ALIMENTOS',16),('AUTO','OFICINA DE MANUTENÇÃO AUTOMOTIVA',20),('B10','LAB. INFORMÁTICA',16),('B11','LAB. INFORMÁTICA',40),('B12','LAB. INFORMÁTICA',40),('B2','SALA DE AULA',32),('B3','SALA DE AULA',32),('B5','SALA DE AULA',40),('B6','SALA DE AULA',32),('B7','SALA DE AULA',32),('B8','LAB. INFORMÁTICA',20),('B9','LAB. INFORMÁTICA',16),('C1','SALA DE AULA',24),('C2','LAB. DE INFORMÁTICA',32),('C3','SALA DE MODELAGEM VESTUÁRIO',20),('C4','SALA DE MODELAGEM VESTUÁRIO',20),('C5','SALA DE AULA',16),('CNC','OFICINA DE CNC',16),('COEL','OFICINA DE COMANDOS ELÉTRICOS',16),('CORT1','OFICINA DE CORTE - G1',16),('CORT2','OFICINA DE CORTE - G2',16),('D1','SALA MODELAGEM',16),('D2','SALA DE MODELAGEM',20),('D3','SALA DE AULA',16),('D4','SALA DE CRIAÇÃO',18),('ITEL1','OFICINA DE INSTALAÇÕES ELÉTRICAS - G1',16),('ITEL2','OFICINA DE INSTALAÇÕES ELÉTRICAS - G2',16),('MMC','OFICINA DE MANUTENÇÃO MECÂNICA',16),('MONT1','OFICINA DE MONTAGEM - G1',16),('MONT2','OFICINA DE MONTAGEM - G2',16),('MPESP','OFICINA DE MANUTENÇÃO PESPONTO',16),('PESP1','OFICINA DE PESPONTO - G1',16),('PESP2','OFICINA DE PESPONTO - G2',16),('PESP3','OFICINA DE PESPONTO - G3',16),('PRE','OFICINA DE PREPARAÇÃO',16),('SOLD','OFICINA DE SOLDAGEM',16),('test','SALA DE REUNIÃO',40),('TOR','OFICINA DE TORNEARIA',20),('VEST','OFICINA DE VESTUÁRIO',20);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule`
--

LOCK TABLES `schedule` WRITE;
/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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

-- Dump completed on 2025-03-31 10:16:16
