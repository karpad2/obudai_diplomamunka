-- MariaDB dump 10.17  Distrib 10.4.14-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: esp32project
-- ------------------------------------------------------
-- Server version	10.4.14-MariaDB

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
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `config_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `config_text` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`config_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES ('about_us','<main class=\"px-3\">\r\n    <h1>Cover your page.</h1>\r\n    <p class=\"lead\">Cover is a one-page template for building simple and beautiful home pages. Download, edit the text, and add your own fullscreen background photo to make it your own.</p>\r\n    <p class=\"lead\">\r\n      <a href=\"#\" class=\"btn btn-lg btn-secondary fw-bold border-white bg-white\">Learn more</a>\r\n    </p>\r\n  </main>\r\n'),('website_name','Escape Room'),('welcome_text','<div class=\"pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center\">\r\n    <h1 class=\"display-4\">Pricing</h1>\r\n    <p class=\"lead\">Quickly build an effective pricing table for your potential customers with this Bootstrap example. It’s built with default Bootstrap components and utilities with little customization.</p>\r\n</div>\r\n\r\n<div class=\"row row-cols-1 row-cols-md-3 mb-3 text-center\">\r\n    <div class=\"col\">\r\n        <div class=\"card mb-4 shadow-sm\">\r\n            <div class=\"card-header\">\r\n                <h4 class=\"my-0 fw-normal\">Free</h4>\r\n            </div>\r\n            <div class=\"card-body\">\r\n                <h1 class=\"card-title pricing-card-title\">$0 <small class=\"text-muted\">/ mo</small></h1>\r\n                <ul class=\"list-unstyled mt-3 mb-4\">\r\n                    <li>10 users included</li>\r\n                    <li>2 GB of storage</li>\r\n                    <li>Email support</li>\r\n                    <li>Help center access</li>\r\n                </ul>\r\n                <button type=\"button\" class=\"w-100 btn btn-lg btn-outline-primary\">Sign up for free</button>\r\n            </div>\r\n        </div>\r\n    </div>\r\n    <div class=\"col\">\r\n        <div class=\"card mb-4 shadow-sm\">\r\n            <div class=\"card-header\">\r\n                <h4 class=\"my-0 fw-normal\">Pro</h4>\r\n            </div>\r\n            <div class=\"card-body\">\r\n                <h1 class=\"card-title pricing-card-title\">$15 <small class=\"text-muted\">/ mo</small></h1>\r\n                <ul class=\"list-unstyled mt-3 mb-4\">\r\n                    <li>20 users included</li>\r\n                    <li>10 GB of storage</li>\r\n                    <li>Priority email support</li>\r\n                    <li>Help center access</li>\r\n                </ul>\r\n                <button type=\"button\" class=\"w-100 btn btn-lg btn-primary\">Get started</button>\r\n            </div>\r\n        </div>\r\n    </div>\r\n    <div class=\"col\">\r\n        <div class=\"card mb-4 shadow-sm\">\r\n            <div class=\"card-header\">\r\n                <h4 class=\"my-0 fw-normal\">Enterprise</h4>\r\n            </div>\r\n            <div class=\"card-body\">\r\n                <h1 class=\"card-title pricing-card-title\">$29 <small class=\"text-muted\">/ mo</small></h1>\r\n                <ul class=\"list-unstyled mt-3 mb-4\">\r\n                    <li>30 users included</li>\r\n                    <li>15 GB of storage</li>\r\n                    <li>Phone and email support</li>\r\n                    <li>Help center access</li>\r\n                </ul>\r\n                <button type=\"button\" class=\"w-100 btn btn-lg btn-primary\">Contact us</button>\r\n            </div>\r\n        </div>\r\n    </div>\r\n</div>');
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devices`
--

DROP TABLE IF EXISTS `devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devices` (
  `device_id` int(11) NOT NULL AUTO_INCREMENT,
  `device_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'esp32-controller',
  `device_mode` enum('relay','rfid','') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'relay',
  `ip_address` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `device_password` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`device_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devices`
--

LOCK TABLES `devices` WRITE;
/*!40000 ALTER TABLE `devices` DISABLE KEYS */;
INSERT INTO `devices` VALUES (1,'ESP32','relay','192.168.1.1',NULL),(2,'ESP32','relay','::1',NULL),(3,'ESP32','relay','::1',NULL);
/*!40000 ALTER TABLE `devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `logtext` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  KEY `log_user__fk` (`user_id`),
  CONSTRAINT `log_user__fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (1,'',1),(2,'',1),(3,'insert into devices (device_name,device_mode,ip_address) values(\'ESP32\',\'relay\',\'192.168.1.1\')',1),(4,'insert into devices (device_name,device_mode,ip_address) values(\'ESP32\',\'relay\',\'192.168.1.1\')',1),(5,'insert into devices (device_name,device_mode,ip_address) values(\'ESP32\',\'relay\',\'192.168.1.1\')',1),(6,'select config_text from config where config_name=\'welcome_text\'',1),(7,'select config_text from config where config_name=\'welcome_text\'',1),(8,'select config_text from config where config_name=\'welcome_text\'',1),(9,'select config_text from config where config_name=\'welcome_text\'',1),(10,'select config_text from config where config_name=\'welcome_text\'',1),(11,'select config_text from config where config_name=\'welcome_text\'',1),(12,'select config_text from config where config_name=\'welcome_text\'',1),(13,'select config_text from config where config_name=\'welcome_text\'',1),(14,'select config_text from config where config_name=\'welcome_text\'',1),(15,'select config_text from config where config_name=\'welcome_text\'',1),(16,'select config_text from config where config_name=\'welcome_text\'',1),(17,'select config_text from config where config_name=\'welcome_text\'',1),(18,'select config_text from config where config_name=\'welcome_text\'',1),(19,'select config_text from config where config_name=\'welcome_text\'',1),(20,'select config_text from config where config_name=\'welcome_text\'',1),(21,'select config_text from config where config_name=\'welcome_text\'',1),(22,'select config_text from config where config_name=\'welcome_text\'',1),(23,'select config_text from config where config_name=\'welcome_text\'',1),(24,'select config_text from config where config_name=\'welcome_text\'',1),(25,'select config_text from config where config_name=\'welcome_text\'',1),(26,'select config_text from config where config_name=\'welcome_text\'',1),(27,'select config_text from config where config_name=\'welcome_text\'',1),(28,'select config_text from config where config_name=\'welcome_text\'',1),(29,'select config_text from config where config_name=\'welcome_text\'',1),(30,'select config_text from config where config_name=\'welcome_text\'',1),(31,'select config_text from config where config_name=\'welcome_text\'',1),(32,'select config_text from config where config_name=\'welcome_text\'',1),(33,'select config_text from config where config_name=\'welcome_text\'',1),(34,'select config_text from config where config_name=\'welcome_text\'',1),(35,'select config_text from config where config_name=\'welcome_text\'',1),(36,'select config_text from config where config_name=\'welcome_text\'',1),(37,'select config_text from config where config_name=\'welcome_text\'',1),(38,'select config_text from config where config_name=\'welcome_text\'',1),(39,'select config_text from config where config_name=\'welcome_text\'',1),(40,'select config_text from config where config_name=\'welcome_text\'',1),(41,'select config_text from config where config_name=\'welcome_text\'',1),(42,'select config_text from config where config_name=\'welcome_text\'',1),(43,'select config_text from config where config_name=\'welcome_text\'',1),(44,'select config_text from config where config_name=\'welcome_text\'',1),(45,'select config_text from config where config_name=\'welcome_text\'',1),(46,'select config_text from config where config_name=\'welcome_text\'',1),(47,'select config_text from config where config_name=\'welcome_text\'',1),(48,'select config_text from config where config_name=\'welcome_text\'',1),(49,'select config_text from config where config_name=\'welcome_text\'',1),(50,'select config_text from config where config_name=\'welcome_text\'',1),(51,'select config_text from config where config_name=\'welcome_text\'',1),(52,'select config_text from config where config_name=\'welcome_text\'',1),(53,'select config_text from config where config_name=\'welcome_text\'',1),(54,'select config_text from config where config_name=\'welcome_text\'',1),(55,'select config_text from config where config_name=\'about_us\'',1),(56,'select config_text from config where config_name=\'welcome_text\'',1),(57,'select config_text from config where config_name=\'welcome_text\'',1),(58,'select config_text from config where config_name=\'welcome_text\'',1),(59,'select config_text from config where config_name=\'welcome_text\'',1),(60,'insert into devices (device_name,device_mode,ip_address) values(\'ESP32\',\'relay\',\'::1\')',1),(61,'insert into devices (device_name,device_mode,ip_address) values(\'ESP32\',\'relay\',\'::1\')',1),(62,'select config_text from config where config_name=\'website-name\'',1),(63,'select config_text from config where config_name=\'website-name\'',1);
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_tasks`
--

DROP TABLE IF EXISTS `program_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_tasks` (
  `program_id` int(11) NOT NULL,
  `order_number` int(11) NOT NULL,
  `device_id` int(11) DEFAULT NULL,
  `task_id` int(11) NOT NULL,
  PRIMARY KEY (`program_id`,`order_number`),
  KEY `program_tasks_devices_device_id_fk` (`device_id`),
  KEY `program_tasks_tasks_task_id_fk` (`task_id`),
  CONSTRAINT `program_tasks_devices_device_id_fk` FOREIGN KEY (`device_id`) REFERENCES `devices` (`device_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `program_tasks_programs_program_id_fk` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `program_tasks_tasks_task_id_fk` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`task_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_tasks`
--

LOCK TABLES `program_tasks` WRITE;
/*!40000 ALTER TABLE `program_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `program_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programs`
--

DROP TABLE IF EXISTS `programs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `programs` (
  `program_id` int(11) NOT NULL AUTO_INCREMENT,
  `program_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Program',
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`program_id`),
  KEY `programs_users_user_id_fk` (`user_id`),
  CONSTRAINT `programs_users_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programs`
--

LOCK TABLES `programs` WRITE;
/*!40000 ALTER TABLE `programs` DISABLE KEYS */;
/*!40000 ALTER TABLE `programs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `runs`
--

DROP TABLE IF EXISTS `runs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `runs` (
  `run_id` int(11) NOT NULL AUTO_INCREMENT,
  `program_id` int(11) DEFAULT NULL,
  `team_id` int(11) NOT NULL,
  `progress` int(11) NOT NULL DEFAULT 0,
  `starting_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `finishing_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`run_id`),
  KEY `runs_programs_program_id_fk` (`program_id`),
  KEY `runs_teams_teams_id_fk` (`team_id`),
  CONSTRAINT `runs_programs_program_id_fk` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `runs_teams_teams_id_fk` FOREIGN KEY (`team_id`) REFERENCES `teams` (`teams_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `runs`
--

LOCK TABLES `runs` WRITE;
/*!40000 ALTER TABLE `runs` DISABLE KEYS */;
/*!40000 ALTER TABLE `runs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tasks` (
  `task_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teams`
--

DROP TABLE IF EXISTS `teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teams` (
  `teams_id` int(11) NOT NULL AUTO_INCREMENT,
  `teams_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '"John Doe"',
  PRIMARY KEY (`teams_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams`
--

LOCK TABLES `teams` WRITE;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `ip_address` varchar(45) COLLATE utf8_unicode_ci DEFAULT '127.0.0.1',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'root',' ','2021-01-23 19:21:51','127.0.0.1'),(2,'esp32',' ','2021-01-24 14:53:29','127.0.0.1');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_devices`
--

DROP TABLE IF EXISTS `users_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_devices` (
  `device_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `device_mode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DeviceName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  UNIQUE KEY `users_devices_pk` (`device_id`,`user_id`),
  KEY `users_devices_user__fk` (`user_id`),
  CONSTRAINT `users_devices_device__fk` FOREIGN KEY (`device_id`) REFERENCES `devices` (`device_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `users_devices_user__fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_devices`
--

LOCK TABLES `users_devices` WRITE;
/*!40000 ALTER TABLE `users_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_devices` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-28 18:01:19
