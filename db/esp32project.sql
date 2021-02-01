-- MariaDB dump 10.18  Distrib 10.4.17-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: esp32project
-- ------------------------------------------------------
-- Server version	10.4.17-MariaDB

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
  `room_id` int(11) DEFAULT 1,
  `status` int(11) DEFAULT 0,
  PRIMARY KEY (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devices`
--

LOCK TABLES `devices` WRITE;
/*!40000 ALTER TABLE `devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `escape_rooms`
--

DROP TABLE IF EXISTS `escape_rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `escape_rooms` (
  `room_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `room_name` varchar(255) COLLATE utf8_general_nopad_ci NOT NULL DEFAULT 'Room',
  PRIMARY KEY (`room_id`),
  KEY `escape_rooms_users_user_id_fk` (`user_id`),
  CONSTRAINT `escape_rooms_users_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_nopad_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `escape_rooms`
--

LOCK TABLES `escape_rooms` WRITE;
/*!40000 ALTER TABLE `escape_rooms` DISABLE KEYS */;
INSERT INTO `escape_rooms` VALUES (1,2,'Only registered');
/*!40000 ALTER TABLE `escape_rooms` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (1,'Select username from users where username=\'karpad2\';',1),(2,'insert into users (username,password) values (\'karpad2\',\'md5(\'123456789asdfghjkl123456789\')\')',1),(3,'Select username from users where username=\'karpad2\';',1),(4,'insert into users (username,password) values (\'karpad2\',md5(\'123456789asdfghjkl123456789\'))',1),(5,'Select username from users where username=\'karpad2\';',1),(6,'Select username from users where username=\'karpad2\';',1),(7,'Select username from users where username=\'karpad2\';',1),(8,'Select username from users where username=\'karpad2\';',1),(9,'Select username from users where username=\'karpad2\';',1),(10,'Select username from users where username=\'karpad2\';',1),(11,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(12,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(13,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(14,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(15,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(16,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(17,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(18,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(19,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(20,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(21,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(22,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(23,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(24,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(25,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(26,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(27,'update users set ip_address=::1 where user_id=;',1),(28,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(29,'update users set ip_address=::1 where user_id=;',1),(30,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(31,'update users set ip_address=::1 where user_id=;',1),(32,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(33,'update users set ip_address=::1 where user_id=;',1),(34,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(35,'update users set ip_address=::1 where user_id=;',1),(36,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(37,'update users set ip_address=\'::1\' where user_id=\'\';',1),(38,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(39,'update users set ip_address=\'::1\' where user_id=\'\';',1),(40,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(41,'update users set ip_address=\'::1\' where user_id=\'\';',1),(42,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(43,'update users set ip_address=\'::1\' where user_id=\'\';',1),(44,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(45,'update users set ip_address=\'::1\' where user_id=\'\';',1),(46,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(47,'update users set ip_address=\'::1\' where user_id=\'\';',1),(48,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(49,'update users set ip_address=\'::1\' where user_id=\'\';',1),(50,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(51,'update users set ip_address=\'192.168.1.1\' where user_id=\'\';',1),(52,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(53,'update users set ip_address=\'192.168.1.1\' where user_id=\'\';',1),(54,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(55,'update users set ip_address=\'192.168.1.1\' where user_id=\'3\';',3),(56,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',3),(57,'update users set ip_address=\'192.168.1.1\' where user_id=\'3\';',3),(58,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',3),(59,'update users set ip_address=\'192.168.1.1\' where user_id=\'3\';',3),(60,'select * from programs where user_id=\'3\'',3),(61,'select * from programs where user_id=\'3\'',3),(62,'select * from programs where user_id=\'3\'',3),(63,'select * from programs where user_id=\'3\'',3),(64,'select * from programs where user_id=\'3\'',3),(65,'select * from programs where user_id=\'3\'',3),(66,'select * from programs where user_id=\'3\'',3),(67,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(68,'update users set ip_address=\'192.168.1.1\' where user_id=\'3\';',3),(69,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(70,'update users set ip_address=\'192.168.1.1\' where user_id=\'3\';',3),(71,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(72,'update users set ip_address=\'192.168.1.1\' where user_id=\'3\';',3),(73,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(74,'update users set ip_address=\'192.168.1.1\' where user_id=\'3\';',3),(75,'select * from programs where user_id=\'3\'',3),(76,'select * from programs where user_id=\'3\'',3),(77,'select * from programs where user_id=\'3\'',3),(78,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(79,'update users set ip_address=\'192.168.1.1\' where user_id=\'3\';',3),(80,'select * from programs where user_id=\'3\'',3),(81,'select * from programs where user_id=\'3\'',3),(82,'select * from devices join users_devices ud on devices.device_id = ud.device_id where user_id=\'3\'',3),(83,'select * from devices join users_devices ud on devices.device_id = ud.device_id where user_id=\'3\'',3),(84,'select * from devices join users_devices ud on devices.device_id = ud.device_id where user_id=\'3\'',3),(85,'select * from devices join users_devices ud on devices.device_id = ud.device_id where user_id=\'3\'',3),(86,'select * from programs where user_id=\'3\'',3),(87,'select * from devices join users_devices ud on devices.device_id = ud.device_id where user_id=\'3\'',3),(88,'select * from devices join users_devices ud on devices.device_id = ud.device_id where user_id=\'3\'',3),(89,'select * from devices join users_devices ud on devices.device_id = ud.device_id where user_id=\'3\'',3),(90,'select * from devices join users_devices ud on devices.device_id = ud.device_id where user_id=\'3\'',3),(91,'select * from devices join users_devices ud on devices.device_id = ud.device_id where user_id=\'3\'',3),(92,'select * from devices join users_devices ud on devices.device_id = ud.device_id where user_id=\'3\'',3),(93,'select * from programs where user_id=\'3\'',3),(94,'select * from devices join users_devices ud on devices.device_id = ud.device_id where user_id=\'3\'',3),(95,'select * from programs where user_id=\'3\'',3),(96,'select * from devices join users_devices ud on devices.device_id = ud.device_id where user_id=\'3\'',3),(97,'select * from programs where user_id=\'3\'',3),(98,'insert into devices (device_name,device_mode,ip_address) values(\'ESP32\',\'relay\',\'192.168.1.1\')',1),(99,'insert into devices (device_name,device_mode,ip_address) values(\'ESP32\',\'relay\',\'192.168.1.1\')',1),(100,'insert into devices (device_name,device_mode,ip_address) values(\'ESP32\',\'relay\',\'192.168.1.1\')',1),(101,'insert into devices (device_name,device_mode,ip_address) values(\'ESP32\',\'relay\',\'192.168.1.1\')',1),(102,'insert into devices (device_name,device_mode,ip_address) values(\'ESP32\',\'relay\',\'192.168.1.1\')',1),(103,'insert into devices (device_name,device_mode,ip_address) values(\'ESP32\',\'relay\',\'192.168.1.1\')',1),(104,'insert into devices (device_name,device_mode,ip_address) values(\'ESP32\',\'relay\',\'192.168.1.1\')',1),(105,'insert into devices (device_name,device_mode,ip_address) values(\'ESP32\',\'relay\',\'192.168.1.1\')',1),(106,'insert into devices (device_name,device_mode,ip_address) values(\'ESP32\',\'relay\',\'192.168.1.1\')',1),(107,'insert into devices (device_name,device_mode,ip_address) values(\'ESP32\',\'relay\',\'192.168.1.1\')',1),(108,'insert into devices (device_name,device_mode,ip_address) values(\'ESP32\',\'relay\',\'192.168.1.1\')',1),(109,'update devices set (device_password=\'8935bf77b07eb8ca616cecc8c4cdc18d\') where device_id=\'14\';',1),(110,'insert into devices (device_name,device_mode,ip_address) values(\'ESP32\',\'relay\',\'192.168.1.1\')',1),(111,'update devices set device_password=\'e95a400104a5bddd59db78c8b1e6fbfd\' where device_id=\'15\';',1),(112,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(113,'update users set ip_address=\'::1\' where user_id=\'3\';',3),(114,'select * from programs where user_id=\'3\'',3),(115,'select * from programs where user_id=\'3\'',3),(116,'select * from devices join users_devices ud on devices.device_id = ud.device_id where user_id=\'3\'',3),(117,'select * from programs where user_id=\'3\'',3),(118,'select * from users where username=\'karpad2\' and password=md5(\'123456789ASDFGHJKL123456789\');',1),(119,'select * from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(120,'update users set ip_address=\'192.168.1.1\' where user_id=\'3\';',3);
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
  `rfid_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
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
  `room_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`program_id`),
  KEY `programs_users_user_id_fk` (`user_id`),
  KEY `programs_escape_rooms_room_id_fk` (`room_id`),
  CONSTRAINT `programs_escape_rooms_room_id_fk` FOREIGN KEY (`room_id`) REFERENCES `escape_rooms` (`room_id`) ON DELETE CASCADE ON UPDATE CASCADE,
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
-- Table structure for table `rfid_cards`
--

DROP TABLE IF EXISTS `rfid_cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rfid_cards` (
  `rfid-code` varchar(255) COLLATE utf8_general_nopad_ci NOT NULL,
  `rfid_name` varchar(255) COLLATE utf8_general_nopad_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `tasks` int(11) DEFAULT 0,
  PRIMARY KEY (`rfid-code`,`user_id`),
  KEY `rfid_cards_users_user_id_fk` (`user_id`),
  CONSTRAINT `rfid_cards_users_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_nopad_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rfid_cards`
--

LOCK TABLES `rfid_cards` WRITE;
/*!40000 ALTER TABLE `rfid_cards` DISABLE KEYS */;
INSERT INTO `rfid_cards` VALUES ('0','Default',1,0);
/*!40000 ALTER TABLE `rfid_cards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `run_program_task`
--

DROP TABLE IF EXISTS `run_program_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `run_program_task` (
  `run_id` int(11) NOT NULL,
  `program_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_nopad_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `run_program_task`
--

LOCK TABLES `run_program_task` WRITE;
/*!40000 ALTER TABLE `run_program_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `run_program_task` ENABLE KEYS */;
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
  `active` int(11) DEFAULT NULL,
  PRIMARY KEY (`task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (1,'relay_on',1),(2,'relay_off',0),(3,'rfid_on',1),(4,'rfid_off',0),(5,'read_rfid',3);
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
  `admin_mod` int(11) DEFAULT 0,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'root',' ','2021-01-23 19:21:51','127.0.0.1',0),(2,'esp32',' ','2021-01-24 14:53:29','127.0.0.1',0),(3,'karpad2','f961d8d0e488e133589c139716c8885e','2021-01-30 08:16:49','192.168.1.1',0);
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

-- Dump completed on 2021-02-01 15:51:25
