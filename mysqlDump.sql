CREATE DATABASE  IF NOT EXISTS `cab_svc` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cab_svc`;
-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: localhost    Database: cab_svc
-- ------------------------------------------------------
-- Server version	8.0.29

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
-- Table structure for table `cab`
--

DROP TABLE IF EXISTS `cab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cab` (
  `cab_id` int NOT NULL AUTO_INCREMENT,
  `cab_user_id` int NOT NULL,
  `cab_number` varchar(150) NOT NULL,
  `cab_state` varchar(150) NOT NULL,
  `cab_city_id` varchar(150) NOT NULL,
  `cab_lat` varchar(150) DEFAULT NULL,
  `cab_long` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`cab_id`),
  KEY `cab_user_id` (`cab_user_id`),
  CONSTRAINT `cab_ibfk_1` FOREIGN KEY (`cab_user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cab`
--

LOCK TABLES `cab` WRITE;
/*!40000 ALTER TABLE `cab` DISABLE KEYS */;
INSERT INTO `cab` VALUES (1,2,'MH12 JZ 3244','idle','2',NULL,NULL),(2,4,'MH32 fdfdf','idle','6','232434','4324323'),(3,4,'MH32 fdfdf','ontrip','4',NULL,NULL),(4,4,'MH32 fdfdf','idle','2','11111111','222222'),(5,4,'MH32 fdfdf','ontrip','4',NULL,NULL);
/*!40000 ALTER TABLE `cab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `city_id` int NOT NULL AUTO_INCREMENT,
  `city_name` varchar(200) NOT NULL,
  `state_name` varchar(200) DEFAULT NULL,
  `service_available` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (1,'Solapur','MH','true'),(2,'Pune','MH','true'),(3,'Mumbai','MH','true'),(4,'Akluj','MH','1'),(5,'Akluj','MH','true'),(6,'Hyderbad','AP','true'),(7,'Hyderbad','AP','true'),(8,'Hyderbad','AP','true');
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journey`
--

DROP TABLE IF EXISTS `journey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `journey` (
  `jn_id` int NOT NULL AUTO_INCREMENT,
  `cab_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `booked_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `start_city_id` int DEFAULT NULL,
  `end_city_id` int DEFAULT NULL,
  `start_lat` varchar(150) DEFAULT NULL,
  `start_long` varchar(150) DEFAULT NULL,
  `end_lat` varchar(150) DEFAULT NULL,
  `end_long` varchar(150) DEFAULT NULL,
  `travelled_dist` int DEFAULT NULL,
  `bill_amount` float DEFAULT NULL,
  PRIMARY KEY (`jn_id`),
  KEY `cab_id` (`cab_id`),
  KEY `customer_id` (`customer_id`),
  KEY `start_city_id` (`start_city_id`),
  KEY `end_city_id` (`end_city_id`),
  CONSTRAINT `journey_ibfk_1` FOREIGN KEY (`cab_id`) REFERENCES `cab` (`cab_id`),
  CONSTRAINT `journey_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `journey_ibfk_3` FOREIGN KEY (`start_city_id`) REFERENCES `city` (`city_id`),
  CONSTRAINT `journey_ibfk_4` FOREIGN KEY (`end_city_id`) REFERENCES `city` (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journey`
--

LOCK TABLES `journey` WRITE;
/*!40000 ALTER TABLE `journey` DISABLE KEYS */;
INSERT INTO `journey` VALUES (1,3,1,'2022-05-21 13:48:33','2022-05-20 00:30:01','2022-05-21 06:30:01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,3,3,'2022-05-21 13:48:33','2022-05-21 07:30:01','2022-05-21 11:50:01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,3,2,'2022-05-21 15:23:19',NULL,NULL,4,3,NULL,NULL,NULL,NULL,NULL,NULL),(4,5,2,'2022-05-21 15:27:29',NULL,NULL,4,3,NULL,NULL,NULL,NULL,NULL,NULL),(5,3,2,'2022-05-21 15:28:01',NULL,NULL,4,3,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `journey` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_full_name` varchar(200) NOT NULL,
  `user_address` varchar(200) DEFAULT NULL,
  `user_phone` varchar(45) DEFAULT NULL,
  `user_role` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'vaibhav kale','akluj','8888888','customer'),(2,'vaibhav kale','akluj','8888888','customer'),(3,'vaibhav kale','akluj','8888888','customer'),(4,'vaibhav kale','akluj','8888888','customer'),(5,'vaibhav kale','akluj','8888888','driver'),(6,'abc','akluj','8888888','admin'),(7,'vaibhav kale','akluj','8888888','customer'),(8,'vaibhav kale','akluj','8888888','driver'),(9,'abc','akluj','8888888','admin');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-21 21:27:22
