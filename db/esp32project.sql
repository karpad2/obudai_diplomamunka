-- MariaDB dump 10.18  Distrib 10.4.17-MariaDB, for Linux (x86_64)
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
-- Temporary table structure for view `active_devices`
--

DROP TABLE IF EXISTS `active_devices`;
/*!50001 DROP VIEW IF EXISTS `active_devices`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `active_devices` (
  `device_id` tinyint NOT NULL,
  `device_name` tinyint NOT NULL,
  `device_mode` tinyint NOT NULL,
  `ip_address` tinyint NOT NULL,
  `device_password` tinyint NOT NULL,
  `room_id` tinyint NOT NULL,
  `status` tinyint NOT NULL,
  `user_id` tinyint NOT NULL,
  `last_online` tinyint NOT NULL,
  `active` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `blocks`
--

DROP TABLE IF EXISTS `blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blocks` (
  `bl_pr_id` varchar(30) NOT NULL,
  `bl_text` text NOT NULL,
  PRIMARY KEY (`bl_pr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blocks`
--

LOCK TABLES `blocks` WRITE;
/*!40000 ALTER TABLE `blocks` DISABLE KEYS */;
INSERT INTO `blocks` VALUES ('controls_if','If modul'),('controls_whileUntil',''),('logic_boolean',''),('logic_compare',''),('logic_negate',''),('logic_operation',''),('math_arithmetic',''),('math_single','');
/*!40000 ALTER TABLE `blocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cameras`
--

DROP TABLE IF EXISTS `cameras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cameras` (
  `camera_id` int(11) NOT NULL AUTO_INCREMENT,
  `camera_name` varchar(255) DEFAULT 'Camera',
  `user_id` int(11) DEFAULT NULL,
  `camera_url` varchar(255) DEFAULT NULL,
  `room_id` int(11) DEFAULT 1,
  PRIMARY KEY (`camera_id`),
  KEY `cameras_escape_rooms_room_id_fk` (`room_id`),
  KEY `cameras_users_user_id_fk` (`user_id`),
  CONSTRAINT `cameras_escape_rooms_room_id_fk` FOREIGN KEY (`room_id`) REFERENCES `escape_rooms` (`room_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cameras_users_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cameras`
--

LOCK TABLES `cameras` WRITE;
/*!40000 ALTER TABLE `cameras` DISABLE KEYS */;
INSERT INTO `cameras` VALUES (1,'Kamera 1',3,'http://192.168.1.160:4646/stream',2),(2,'Kamera 2',3,'http://192.168.1.161:4646/stream',2);
/*!40000 ALTER TABLE `cameras` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `config` VALUES ('about_link','<ul class=\"list-unstyled text-small\">\n                <li><a class=\"link-secondary\" href=\"#\">Team</a></li>\n                <li><a class=\"link-secondary\" href=\"#\">Locations</a></li>\n                <li><a class=\"link-secondary\" href=\"index.php?mod=privacy\">Privacy</a></li>\n                <li><a class=\"link-secondary\" href=\"#\">Terms</a></li>\n            </ul>'),('about_us','<main class=\"px-3\">\r\n    <h1>Cover your page.</h1>\r\n    <p class=\"lead\">Cover is a one-page template for building simple and beautiful home pages. Download, edit the text, and add your own fullscreen background photo to make it your own.</p>\r\n    <p class=\"lead\">\r\n      <a href=\"#\" class=\"btn btn-lg btn-secondary fw-bold border-white bg-white\">Learn more</a>\r\n    </p>\r\n\r\n  </main>\r\n'),('debug','0'),('features',' <ul class=\"list-unstyled text-small\">\n                <li><a class=\"link-secondary\" href=\"index.php?mod=teams\">Teams in our database</a></li>\n                <li><a class=\"link-secondary\" href=\"#\">Random feature</a></li>\n                <li><a class=\"link-secondary\" href=\"#\">Team feature</a></li>\n                <li><a class=\"link-secondary\" href=\"#\">Stuff for developers</a></li>\n                <li><a class=\"link-secondary\" href=\"#\">Another one</a></li>\n                <li><a class=\"link-secondary\" href=\"#\">Last time</a></li>\n            </ul>'),('privacy','<section class=\"jumbotron text-center\">\n    <div class=\"container\">\n      <h1>Album example</h1>\n      <p class=\"lead text-muted\">Something short and leading about the collection below—its contents, the creator, etc. Make it short and sweet, but not too short so folks don’t simply skip over it entirely.</p>\n      <p>\n        <a href=\"#\" class=\"btn btn-primary my-2\">Main call to action</a>\n        <a href=\"#\" class=\"btn btn-secondary my-2\">Secondary action</a>\n      </p>\n    </div>\n  </section>'),('resources','<ul class=\"list-unstyled text-small\">\n                <li><a class=\"link-secondary\" href=\"#\">Resource</a></li>\n                <li><a class=\"link-secondary\" href=\"#\">Resource name</a></li>\n                <li><a class=\"link-secondary\" href=\"#\">Another resource</a></li>\n                <li><a class=\"link-secondary\" href=\"#\">Final resource</a></li>\n            </ul>'),('website_name','Escape Room'),('welcome_text','<div class=\"pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center\">\r\n    <h1 class=\"display-4\">Pricing</h1>\r\n    <p class=\"lead\">Quickly build an effective pricing table for your potential customers with this Bootstrap example. It’s built with default Bootstrap components and utilities with little customization.</p>\r\n</div>\r\n\r\n<div class=\"row row-cols-1 row-cols-md-3 mb-3 text-center\">\r\n    <div class=\"col\">\r\n        <div class=\"card mb-4 shadow-sm\">\r\n            <div class=\"card-header\">\r\n                <h4 class=\"my-0 fw-normal\">Free</h4>\r\n            </div>\r\n            <div class=\"card-body\">\r\n                <h1 class=\"card-title pricing-card-title\">$0 <small class=\"text-muted\">/ mo</small></h1>\r\n                <ul class=\"list-unstyled mt-3 mb-4\">\r\n                    <li>10 users included</li>\r\n                    <li>2 GB of storage</li>\r\n                    <li>Email support</li>\r\n                    <li>Help center access</li>\r\n                </ul>\r\n                <button type=\"button\" class=\"w-100 btn btn-lg btn-outline-primary\">Sign up for free</button>\r\n            </div>\r\n        </div>\r\n    </div>\r\n    <div class=\"col\">\r\n        <div class=\"card mb-4 shadow-sm\">\r\n            <div class=\"card-header\">\r\n                <h4 class=\"my-0 fw-normal\">Pro</h4>\r\n            </div>\r\n            <div class=\"card-body\">\r\n                <h1 class=\"card-title pricing-card-title\">$15 <small class=\"text-muted\">/ mo</small></h1>\r\n                <ul class=\"list-unstyled mt-3 mb-4\">\r\n                    <li>20 users included</li>\r\n                    <li>10 GB of storage</li>\r\n                    <li>Priority email support</li>\r\n                    <li>Help center access</li>\r\n                </ul>\r\n                <button type=\"button\" class=\"w-100 btn btn-lg btn-primary\">Get started</button>\r\n            </div>\r\n        </div>\r\n    </div>\r\n    <div class=\"col\">\r\n        <div class=\"card mb-4 shadow-sm\">\r\n            <div class=\"card-header\">\r\n                <h4 class=\"my-0 fw-normal\">Enterprise</h4>\r\n            </div>\r\n            <div class=\"card-body\">\r\n                <h1 class=\"card-title pricing-card-title\">$29 <small class=\"text-muted\">/ mo</small></h1>\r\n                <ul class=\"list-unstyled mt-3 mb-4\">\r\n                    <li>30 users included</li>\r\n                    <li>15 GB of storage</li>\r\n                    <li>Phone and email support</li>\r\n                    <li>Help center access</li>\r\n                </ul>\r\n                <button type=\"button\" class=\"w-100 btn btn-lg btn-primary\">Contact us</button>\r\n            </div>\r\n        </div>\r\n    </div>\r\n</div>');
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
  `user_id` int(11) DEFAULT 2,
  `last_online` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`device_id`),
  KEY `devices_users_user_id_fk` (`user_id`),
  CONSTRAINT `devices_users_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devices`
--

LOCK TABLES `devices` WRITE;
/*!40000 ALTER TABLE `devices` DISABLE KEYS */;
INSERT INTO `devices` VALUES (1,'ESP32','relay','192.168.1.1','7a554fc586a0054c63c2ffa242f8c523',2,0,3,'2021-03-03 13:58:34');
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
  `tier` varchar(50) COLLATE utf8_general_nopad_ci DEFAULT 'free',
  PRIMARY KEY (`room_id`),
  KEY `escape_rooms_users_user_id_fk` (`user_id`),
  CONSTRAINT `escape_rooms_users_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_nopad_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `escape_rooms`
--

LOCK TABLES `escape_rooms` WRITE;
/*!40000 ALTER TABLE `escape_rooms` DISABLE KEYS */;
INSERT INTO `escape_rooms` VALUES (1,2,'Only registered','unlimited'),(2,3,'Szoba','free');
/*!40000 ALTER TABLE `escape_rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `finished_runs`
--

DROP TABLE IF EXISTS `finished_runs`;
/*!50001 DROP VIEW IF EXISTS `finished_runs`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `finished_runs` (
  `time_sec` tinyint NOT NULL,
  `teams_name` tinyint NOT NULL,
  `room_name` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

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
) ENGINE=InnoDB AUTO_INCREMENT=1100 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (1,'select * from programs where room_id=\'2\'',3),(2,'select * from devices where user_id=\'3\'',3),(3,'select * from cameras where room_id=\'2\'',3),(4,'select * from programs where room_id=\'2\'',3),(5,'select * from devices where user_id=\'3\'',3),(6,'select * from cameras where room_id=\'2\'',3),(7,'select * from programs where room_id=\'2\'',3),(8,'select * from devices where user_id=\'3\'',3),(9,'select * from cameras where room_id=\'2\'',3),(10,'select * from escape_rooms where user_id=\'3\'',3),(11,'select * from programs where room_id=\'2\'',3),(12,'select * from devices where user_id=\'3\'',3),(13,'select * from cameras where room_id=\'2\'',3),(14,'update cameras set camera_name=\'Kamera 1\',camera_url=\'http://192.168.1.160:4646/stream\' where camera_id=\'1\'',3),(15,'select * from programs where room_id=\'2\'',3),(16,'select * from devices where user_id=\'3\'',3),(17,'select * from cameras where room_id=\'2\'',3),(18,'select * from escape_rooms where user_id=\'3\'',3),(19,'select * from escape_rooms where user_id=\'3\'',3),(20,'select * from programs where room_id=\'2\'',3),(21,'select * from devices where user_id=\'3\'',3),(22,'select * from cameras where room_id=\'2\'',3),(23,'update programs set active=\'0\' where room_id=\'2\'',3),(24,'update programs set active=\'1\' where room_id=\'2\' and program_id=\'new\'',3),(25,'select * from programs where room_id=\'2\'',3),(26,'select * from devices where user_id=\'3\'',3),(27,'select * from cameras where room_id=\'2\'',3),(28,'select * from escape_rooms where user_id=\'3\'',3),(29,'select * from devices join users_devices ud on devices.device_id = ud.device_id where room_id=\'2\' and user_id=\'3\'',3),(30,'select * from devices where room_id=\'2\'',3),(31,'select * from blocks',3),(32,'select * from rfid_cards where user_id=\'3\'',3),(33,'select * from devices d join users_devices us on d.device_id=us.device_id where us.user_id=\'3\'',3),(34,'select * from devices where room_id=\'2\'',3),(35,'select * from blocks',3),(36,'select * from rfid_cards where user_id=\'3\'',3),(37,'select * from rfid_cards where room_id=\'\'',3),(38,'select * from devices where room_id=\'2\'',3),(39,'select * from blocks',3),(40,'select * from rfid_cards where user_id=\'3\'',3),(41,'select * from rfid_cards where room_id=\'2\'',3),(42,'select * from devices where room_id=\'2\'',3),(43,'select * from blocks',3),(44,'select * from rfid_cards where user_id=\'3\'',3),(45,'select * from rfid_cards where room_id=\'2\'',3),(46,'select * from devices where room_id=\'2\'',3),(47,'select * from blocks',3),(48,'select * from rfid_cards where user_id=\'3\'',3),(49,'select * from rfid_cards where room_id=\'2\'',3),(50,'select * from devices where room_id=\'2\'',3),(51,'select * from blocks',3),(52,'select * from rfid_cards where user_id=\'3\'',3),(53,'select * from rfid_cards where room_id=\'2\'',3),(54,'select * from devices where room_id=\'2\'',3),(55,'select * from blocks',3),(56,'select * from rfid_cards where user_id=\'3\'',3),(57,'select * from rfid_cards where room_id=\'2\'',3),(58,'select * from devices where room_id=\'2\'',3),(59,'select * from blocks',3),(60,'select * from rfid_cards where user_id=\'3\'',3),(61,'select * from rfid_cards where room_id=\'2\'',3),(62,'select * from devices where room_id=\'2\'',3),(63,'select * from blocks',3),(64,'select * from rfid_cards where user_id=\'3\'',3),(65,'select * from rfid_cards where room_id=\'2\'',3),(66,'select * from escape_rooms where user_id=\'3\'',3),(67,'select * from programs where room_id=\'2\'',3),(68,'select * from devices where user_id=\'3\'',3),(69,'select * from cameras where room_id=\'2\'',3),(70,'update programs set active=\'0\' where room_id=\'2\'',3),(71,'update programs set active=\'1\' where room_id=\'2\' and program_id=\'new\'',3),(72,'select * from programs where room_id=\'2\'',3),(73,'select * from devices where user_id=\'3\'',3),(74,'select * from cameras where room_id=\'2\'',3),(75,'select * from devices where room_id=\'2\'',3),(76,'select * from blocks',3),(77,'select * from rfid_cards where user_id=\'3\'',3),(78,'select * from rfid_cards where room_id=\'2\'',3),(79,'select * from devices where room_id=\'2\'',3),(80,'select * from blocks',3),(81,'select * from rfid_cards where user_id=\'3\'',3),(82,'select * from rfid_cards where room_id=\'2\'',3),(83,'select * from devices where room_id=\'2\'',3),(84,'select * from blocks',3),(85,'select * from rfid_cards where user_id=\'3\'',3),(86,'select * from rfid_cards where room_id=\'2\'',3),(87,'select * from devices where room_id=\'2\'',3),(88,'select * from blocks',3),(89,'select * from rfid_cards where user_id=\'3\'',3),(90,'select * from rfid_cards where room_id=\'2\'',3),(91,'select UPPER(tier) as \'tier\', escape_room, devices, price from tiers order by price asc',1),(92,'select user_id,username,ip_address,admin_mod from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(93,'update users set ip_address=\'192.168.1.1\' where user_id=\'3\';',3),(94,'select * from escape_rooms where user_id=\'3\'',3),(95,'select * from programs where room_id=\'2\'',3),(96,'select * from devices where user_id=\'3\'',3),(97,'select * from cameras where room_id=\'2\'',3),(98,'update programs set active=\'0\' where room_id=\'2\'',3),(99,'update programs set active=\'1\' where room_id=\'2\' and program_id=\'new\'',3),(100,'select * from programs where room_id=\'2\'',3),(101,'select * from devices where user_id=\'3\'',3),(102,'select * from cameras where room_id=\'2\'',3),(103,'select * from devices where room_id=\'2\'',3),(104,'select * from blocks',3),(105,'select * from rfid_cards where user_id=\'3\'',3),(106,'select * from rfid_cards where room_id=\'2\'',3),(107,'select * from escape_rooms where user_id=\'3\'',3),(108,'select * from escape_rooms where user_id=\'3\'',3),(109,'select UPPER(tier) as \'tier\', escape_room, devices, price from tiers order by price asc',1),(110,'select user_id,username,ip_address,admin_mod from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(111,'update users set ip_address=\'192.168.1.1\' where user_id=\'3\';',3),(112,'select * from escape_rooms where user_id=\'3\'',3),(113,'select UPPER(tier) as \'tier\', escape_room, devices, price from tiers order by price asc',1),(114,'select user_id,username,ip_address,admin_mod from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(115,'update users set ip_address=\'192.168.1.1\' where user_id=\'3\';',3),(116,'select * from escape_rooms where user_id=\'3\'',3),(117,'select * from programs where room_id=\'2\'',3),(118,'select * from devices where user_id=\'3\'',3),(119,'select * from cameras where room_id=\'2\'',3),(120,'update programs set active=\'0\' where room_id=\'2\'',3),(121,'update programs set active=\'1\' where room_id=\'2\' and program_id=\'new\'',3),(122,'select * from programs where room_id=\'2\'',3),(123,'select * from devices where user_id=\'3\'',3),(124,'select * from cameras where room_id=\'2\'',3),(125,'select * from devices where room_id=\'2\'',3),(126,'select * from blocks',3),(127,'select * from rfid_cards where user_id=\'3\'',3),(128,'select * from rfid_cards where room_id=\'2\'',3),(129,'select * from devices where room_id=\'2\'',3),(130,'select * from blocks',3),(131,'select * from rfid_cards where user_id=\'3\'',3),(132,'select * from rfid_cards where room_id=\'2\'',3),(133,'select * from escape_rooms where user_id=\'3\'',3),(134,'select * from escape_rooms where user_id=\'3\'',3),(135,'select * from programs where room_id=\'2\'',3),(136,'select * from devices where user_id=\'3\'',3),(137,'select * from cameras where room_id=\'2\'',3),(138,'update programs set active=\'0\' where room_id=\'2\'',3),(139,'update programs set active=\'1\' where room_id=\'2\' and program_id=\'new\'',3),(140,'select * from programs where room_id=\'2\'',3),(141,'select * from devices where user_id=\'3\'',3),(142,'select * from cameras where room_id=\'2\'',3),(143,'select * from devices where room_id=\'2\'',3),(144,'select * from blocks',3),(145,'select * from rfid_cards where user_id=\'3\'',3),(146,'select * from rfid_cards where room_id=\'2\'',3),(147,'select * from devices where room_id=\'2\'',3),(148,'select * from blocks',3),(149,'select * from rfid_cards where user_id=\'3\'',3),(150,'select * from rfid_cards where room_id=\'2\'',3),(151,'select * from escape_rooms where user_id=\'3\'',3),(152,'select * from escape_rooms where user_id=\'3\'',3),(153,'select * from programs where room_id=\'2\'',3),(154,'select * from devices where user_id=\'3\'',3),(155,'select * from cameras where room_id=\'2\'',3),(156,'update programs set active=\'0\' where room_id=\'2\'',3),(157,'update programs set active=\'1\' where room_id=\'2\' and program_id=\'new\'',3),(158,'select * from programs where room_id=\'2\'',3),(159,'select * from devices where user_id=\'3\'',3),(160,'select * from cameras where room_id=\'2\'',3),(161,'select * from devices where room_id=\'2\'',3),(162,'select * from blocks',3),(163,'select * from rfid_cards where user_id=\'3\'',3),(164,'select * from rfid_cards where room_id=\'2\'',3),(165,'select UPPER(tier) as \'tier\', escape_room, devices, price from tiers order by price asc',1),(166,'select user_id,username,ip_address,admin_mod from users where username=\'karpad2\' and password=md5(\'123456789ARPad78*123456789\');',1),(167,'select user_id,username,ip_address,admin_mod from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(168,'update users set ip_address=\'192.168.1.1\' where user_id=\'3\';',3),(169,'select * from escape_rooms where user_id=\'3\'',3),(170,'select * from programs where room_id=\'2\'',3),(171,'select * from devices where user_id=\'3\'',3),(172,'select * from cameras where room_id=\'2\'',3),(173,'update programs set active=\'0\' where room_id=\'2\'',3),(174,'update programs set active=\'1\' where room_id=\'2\' and program_id=\'new\'',3),(175,'select * from programs where room_id=\'2\'',3),(176,'select * from devices where user_id=\'3\'',3),(177,'select * from cameras where room_id=\'2\'',3),(178,'select * from devices where room_id=\'2\'',3),(179,'select * from blocks',3),(180,'select * from rfid_cards where user_id=\'3\'',3),(181,'select * from rfid_cards where room_id=\'2\'',3),(182,'update devices set device_mode=\'relay\', status=0 where device_id=\'1\' and user_id=\'3\'',3),(183,'update devices set device_mode=\'relay\', status=0 where device_id=\'1\' and user_id=\'3\'',3),(184,'update devices set device_mode=\'relay\', status=1 where device_id=\'1\' and user_id=\'3\'',3),(185,'update devices set device_mode=\'relay\', status=1 where device_id=\'1\' and user_id=\'3\'',3),(186,'update devices set device_mode=\'relay\', status=1 where device_id=\'1\' and user_id=\'3\'',3),(187,'update devices set device_mode=\'relay\', status=1 where device_id=\'1\' and user_id=\'3\'',3),(188,'update devices set device_mode=\'relay\', status=1 where device_id=\'1\' and user_id=\'3\'',3),(189,'update devices set device_mode=\'relay\', status=1 where device_id=\'1\' and user_id=\'3\'',3),(190,'update devices set device_mode=\'relay\', status=1 where device_id=\'1\' and user_id=\'3\'',3),(191,'update devices set device_mode=\'relay\', status=0 where device_id=\'1\' and user_id=\'3\'',3),(192,'update devices set device_mode=\'relay\', status=0 where device_id=\'1\' and user_id=\'3\'',3),(193,'update devices set device_mode=\'relay\', status=0 where device_id=\'1\' and user_id=\'3\'',3),(194,'update devices set device_mode=\'relay\', status=0 where device_id=\'1\' and user_id=\'3\'',3),(195,'update devices set device_mode=\'relay\', status=0 where device_id=\'1\' and user_id=\'3\'',3),(196,'update devices set device_mode=\'relay\', status=2 where device_id=\'1\' and user_id=\'3\'',3),(197,'update devices set device_mode=\'relay\', status=2 where device_id=\'1\' and user_id=\'3\'',3),(198,'update devices set device_mode=\'relay\', status=2 where device_id=\'1\' and user_id=\'3\'',3),(199,'update devices set device_mode=\'relay\', status=2 where device_id=\'1\' and user_id=\'3\'',3),(200,'update devices set device_mode=\'relay\', status=2 where device_id=\'1\' and user_id=\'3\'',3),(201,'update devices set device_mode=\'relay\', status=2 where device_id=\'1\' and user_id=\'3\'',3),(202,'update devices set device_mode=\'relay\', status=2 where device_id=\'1\' and user_id=\'3\'',3),(203,'update devices set device_mode=\'relay\', status=2 where device_id=\'1\' and user_id=\'3\'',3),(204,'update devices set device_mode=\'relay\', status=2 where device_id=\'1\' and user_id=\'3\'',3),(205,'update devices set device_mode=\'relay\', status=2 where device_id=\'1\' and user_id=\'3\'',3),(206,'update devices set device_mode=\'relay\', status=2 where device_id=\'1\' and user_id=\'3\'',3),(207,'update devices set device_mode=\'relay\', status=2 where device_id=\'1\' and user_id=\'3\'',3),(208,'update devices set device_mode=\'relay\', status=2 where device_id=\'1\' and user_id=\'3\'',3),(209,'update devices set device_mode=\'relay\', status=2 where device_id=\'1\' and user_id=\'3\'',3),(210,'update devices set device_mode=\'relay\', status=2 where device_id=\'1\' and user_id=\'3\'',3),(211,'update devices set device_mode=\'relay\', status=1 where device_id=\'1\' and user_id=\'3\'',3),(212,'update devices set device_mode=\'relay\', status=0 where device_id=\'1\' and user_id=\'3\'',3),(213,'update devices set device_mode=\'relay\', status=0 where device_id=\'1\' and user_id=\'3\'',3),(214,'update devices set device_mode=\'relay\', status= where device_id=\'1\' and user_id=\'3\'',3),(215,'update devices set device_mode=\'relay\', status= where device_id=\'1\' and user_id=\'3\'',3),(216,'update devices set device_mode=\'relay\', status= where device_id=\'1\' and user_id=\'3\'',3),(217,'update devices set device_mode=\'relay\', status= where device_id=\'1\' and user_id=\'3\'',3),(218,'update devices set device_mode=\'relay\', status= where device_id=\'1\' and user_id=\'3\'',3),(219,'update devices set device_mode=\'relay\', status= where device_id=\'1\' and user_id=\'3\'',3),(220,'update devices set device_mode=\'relay\', status= where device_id=\'1\' and user_id=\'3\'',3),(221,'select * from escape_rooms where user_id=\'3\'',3),(222,'select * from escape_rooms where user_id=\'3\'',3),(223,'select * from escape_rooms where user_id=\'3\'',3),(224,'select * from escape_rooms where user_id=\'3\'',3),(225,'select * from escape_rooms where user_id=\'3\'',3),(226,'select * from escape_rooms where user_id=\'3\'',3),(227,'select * from escape_rooms where user_id=\'3\'',3),(228,'select * from escape_rooms where user_id=\'3\'',3),(229,'select UPPER(tier) as \'tier\', escape_room, devices, price from tiers order by price asc',1),(230,'select user_id,username,ip_address,admin_mod from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(231,'update users set ip_address=\'192.168.1.1\' where user_id=\'3\';',3),(232,'select * from escape_rooms where user_id=\'3\'',3),(233,'select * from escape_rooms where user_id=\'3\'',3),(234,'select * from devices where user_id=\'3\'',3),(235,'select * from devices where room_id=\'2\'',3),(236,'select * from blocks',3),(237,'select * from rfid_cards where user_id=\'3\'',3),(238,'select * from rfid_cards where room_id=\'2\'',3),(239,'select * from devices where room_id=\'2\'',3),(240,'select * from blocks',3),(241,'select * from rfid_cards where user_id=\'3\'',3),(242,'select * from rfid_cards where room_id=\'2\'',3),(243,'select * from devices where room_id=\'2\'',3),(244,'select * from blocks',3),(245,'select * from rfid_cards where user_id=\'3\'',3),(246,'select * from rfid_cards where room_id=\'2\'',3),(247,'select * from devices where room_id=\'2\'',3),(248,'select * from blocks',3),(249,'select * from rfid_cards where user_id=\'3\'',3),(250,'select * from rfid_cards where room_id=\'2\'',3),(251,'select * from devices where room_id=\'2\'',3),(252,'select * from blocks',3),(253,'select * from rfid_cards where user_id=\'3\'',3),(254,'select * from rfid_cards where room_id=\'2\'',3),(255,'select * from devices where room_id=\'2\'',3),(256,'select * from blocks',3),(257,'select * from rfid_cards where user_id=\'3\'',3),(258,'select * from rfid_cards where room_id=\'2\'',3),(259,'select * from devices where room_id=\'2\'',3),(260,'select * from blocks',3),(261,'select * from rfid_cards where user_id=\'3\'',3),(262,'select * from rfid_cards where room_id=\'2\'',3),(263,'select * from devices where room_id=\'2\'',3),(264,'select * from blocks',3),(265,'select * from rfid_cards where user_id=\'3\'',3),(266,'select * from rfid_cards where room_id=\'2\'',3),(267,'select * from devices where room_id=\'2\'',3),(268,'select * from blocks',3),(269,'select * from rfid_cards where user_id=\'3\'',3),(270,'select * from rfid_cards where room_id=\'2\'',3),(271,'select * from devices where room_id=\'2\'',3),(272,'select * from blocks',3),(273,'select * from rfid_cards where user_id=\'3\'',3),(274,'select * from rfid_cards where room_id=\'2\'',3),(275,'select * from devices where room_id=\'2\'',3),(276,'select * from blocks',3),(277,'select * from rfid_cards where user_id=\'3\'',3),(278,'select * from rfid_cards where room_id=\'2\'',3),(279,'select * from devices where room_id=\'2\'',3),(280,'select * from blocks',3),(281,'select * from rfid_cards where user_id=\'3\'',3),(282,'select * from rfid_cards where room_id=\'2\'',3),(283,'select * from devices where room_id=\'2\'',3),(284,'select * from blocks',3),(285,'select * from rfid_cards where user_id=\'3\'',3),(286,'select * from rfid_cards where room_id=\'2\'',3),(287,'select * from devices where room_id=\'2\'',3),(288,'select * from blocks',3),(289,'select * from rfid_cards where user_id=\'3\'',3),(290,'select * from rfid_cards where room_id=\'2\'',3),(291,'select * from devices where room_id=\'2\'',3),(292,'select * from blocks',3),(293,'select * from rfid_cards where user_id=\'3\'',3),(294,'select * from rfid_cards where room_id=\'2\'',3),(295,'select * from devices where room_id=\'2\'',3),(296,'select * from blocks',3),(297,'select * from rfid_cards where user_id=\'3\'',3),(298,'select * from rfid_cards where room_id=\'2\'',3),(299,'select * from devices where room_id=\'2\'',3),(300,'select * from blocks',3),(301,'select * from rfid_cards where user_id=\'3\'',3),(302,'select * from rfid_cards where room_id=\'2\'',3),(303,'select * from devices where room_id=\'2\'',3),(304,'select * from blocks',3),(305,'select * from rfid_cards where user_id=\'3\'',3),(306,'select * from rfid_cards where room_id=\'2\'',3),(307,'select * from devices where room_id=\'2\'',3),(308,'select * from blocks',3),(309,'select * from rfid_cards where user_id=\'3\'',3),(310,'select * from rfid_cards where room_id=\'2\'',3),(311,'select * from devices where room_id=\'2\'',1),(312,'select * from blocks',1),(313,'select * from rfid_cards where user_id=\'\'',1),(314,'select * from rfid_cards where room_id=\'2\'',1),(315,'select * from devices where room_id=\'2\'',1),(316,'select * from blocks',1),(317,'select * from rfid_cards where user_id=\'\'',1),(318,'select * from rfid_cards where room_id=\'2\'',1),(319,'select * from devices where room_id=\'2\'',1),(320,'select * from blocks',1),(321,'select * from rfid_cards where user_id=\'\'',1),(322,'select * from rfid_cards where room_id=\'2\'',1),(323,'select * from devices where room_id=\'2\'',3),(324,'select * from blocks',3),(325,'select * from rfid_cards where user_id=\'3\'',3),(326,'select * from rfid_cards where room_id=\'2\'',3),(327,'select * from devices where room_id=\'2\'',3),(328,'select * from blocks',3),(329,'select * from rfid_cards where user_id=\'3\'',3),(330,'select * from rfid_cards where room_id=\'2\'',3),(331,'select * from devices where room_id=\'2\'',3),(332,'select * from blocks',3),(333,'select * from rfid_cards where user_id=\'3\'',3),(334,'select * from rfid_cards where room_id=\'2\'',3),(335,'select * from devices where room_id=\'2\'',1),(336,'select * from blocks',1),(337,'select * from rfid_cards where user_id=\'\'',1),(338,'select * from rfid_cards where room_id=\'2\'',1),(339,'select * from devices where room_id=\'2\'',1),(340,'select * from blocks',1),(341,'select * from rfid_cards where user_id=\'\'',1),(342,'select * from rfid_cards where room_id=\'2\'',1),(343,'select * from devices where room_id=\'2\'',1),(344,'select * from blocks',1),(345,'select * from rfid_cards where user_id=\'\'',1),(346,'select * from rfid_cards where room_id=\'2\'',1),(347,'select UPPER(tier) as \'tier\', escape_room, devices, price from tiers order by price asc',1),(348,'select user_id,username,ip_address,admin_mod from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(349,'update users set ip_address=\'192.168.1.1\' where user_id=\'3\';',3),(350,'select * from escape_rooms where user_id=\'3\'',3),(351,'select * from programs where room_id=\'2\'',3),(352,'select * from devices where user_id=\'3\'',3),(353,'select * from cameras where room_id=\'2\'',3),(354,'update programs set active=\'0\' where room_id=\'2\'',3),(355,'update programs set active=\'1\' where room_id=\'2\' and program_id=\'new\'',3),(356,'select * from programs where room_id=\'2\'',3),(357,'select * from devices where user_id=\'3\'',3),(358,'select * from cameras where room_id=\'2\'',3),(359,'select * from devices where room_id=\'2\'',3),(360,'select * from blocks',3),(361,'select * from rfid_cards where user_id=\'3\'',3),(362,'select * from rfid_cards where room_id=\'2\'',3),(363,'select * from escape_rooms where user_id=\'3\'',3),(364,'select * from programs where room_id=\'2\'',3),(365,'select * from devices where user_id=\'3\'',3),(366,'select * from cameras where room_id=\'2\'',3),(367,'update programs set active=\'0\' where room_id=\'2\'',3),(368,'update programs set active=\'1\' where room_id=\'2\' and program_id=\'new\'',3),(369,'select * from programs where room_id=\'2\'',3),(370,'select * from devices where user_id=\'3\'',3),(371,'select * from cameras where room_id=\'2\'',3),(372,'select * from devices where room_id=\'2\'',3),(373,'select * from blocks',3),(374,'select * from rfid_cards where user_id=\'3\'',3),(375,'select * from rfid_cards where room_id=\'2\'',3),(376,'select * from programs where room_id=\'2\'',3),(377,'select * from devices where user_id=\'3\'',3),(378,'select * from cameras where room_id=\'2\'',3),(379,'update programs set active=\'0\' where room_id=\'2\'',3),(380,'update programs set active=\'1\' where room_id=\'2\' and program_id=\'new\'',3),(381,'select * from programs where room_id=\'2\'',3),(382,'select * from devices where user_id=\'3\'',3),(383,'select * from cameras where room_id=\'2\'',3),(384,'select * from devices where room_id=\'2\'',3),(385,'select * from blocks',3),(386,'select * from rfid_cards where user_id=\'3\'',3),(387,'select * from rfid_cards where room_id=\'2\'',3),(388,'select * from devices where room_id=\'2\'',3),(389,'select * from blocks',3),(390,'select * from devices where user_id=\'3\'',3),(391,'select * from rfid_cards where room_id=\'2\'',3),(392,'select * from devices where room_id=\'2\'',3),(393,'select * from blocks',3),(394,'select * from devices where user_id=\'3\'',3),(395,'select * from rfid_cards where room_id=\'2\'',3),(396,'select * from devices where room_id=\'2\'',3),(397,'select * from blocks',3),(398,'select * from devices where user_id=\'3\'',3),(399,'select * from rfid_cards where room_id=\'2\'',3),(400,'select * from escape_rooms where user_id=\'3\'',3),(401,'select * from programs where room_id=\'2\'',3),(402,'select * from devices where user_id=\'3\'',3),(403,'select * from cameras where room_id=\'2\'',3),(404,'update programs set active=\'0\' where room_id=\'2\'',3),(405,'update programs set active=\'1\' where room_id=\'2\' and program_id=\'new\'',3),(406,'select * from programs where room_id=\'2\'',3),(407,'select * from devices where user_id=\'3\'',3),(408,'select * from cameras where room_id=\'2\'',3),(409,'select * from devices where room_id=\'2\'',3),(410,'select * from blocks',3),(411,'select * from devices where user_id=\'3\'',3),(412,'select * from rfid_cards where room_id=\'2\'',3),(413,'select user_id,username,ip_address,admin_mod from users where username=\'karpad2\' and password=md5(\'123456789asdfghjlk123456789\');',1),(414,'select user_id,username,ip_address,admin_mod from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(415,'update users set ip_address=\'192.168.1.1\' where user_id=\'3\';',3),(416,'select * from escape_rooms where user_id=\'3\'',3),(417,'select * from programs where room_id=\'2\'',3),(418,'select * from devices where user_id=\'3\'',3),(419,'select * from cameras where room_id=\'2\'',3),(420,'update programs set active=\'0\' where room_id=\'2\'',3),(421,'update programs set active=\'1\' where room_id=\'2\' and program_id=\'new\'',3),(422,'select * from programs where room_id=\'2\'',3),(423,'select * from devices where user_id=\'3\'',3),(424,'select * from cameras where room_id=\'2\'',3),(425,'select * from devices where room_id=\'2\'',3),(426,'select * from blocks',3),(427,'select * from devices where user_id=\'3\'',3),(428,'select * from rfid_cards where room_id=\'2\'',3),(429,'select * from devices where room_id=\'2\'',3),(430,'select * from blocks',3),(431,'select * from devices where user_id=\'3\'',3),(432,'select * from rfid_cards where room_id=\'2\'',3),(433,'select * from devices where room_id=\'2\'',3),(434,'select * from blocks',3),(435,'select * from devices where user_id=\'3\'',3),(436,'select * from rfid_cards where room_id=\'2\'',3),(437,'select * from devices where room_id=\'2\'',3),(438,'select * from blocks',3),(439,'select * from devices where user_id=\'3\'',3),(440,'select * from rfid_cards where room_id=\'2\'',3),(441,'select * from devices where room_id=\'2\'',3),(442,'select * from blocks',3),(443,'select * from devices where user_id=\'3\'',3),(444,'select * from rfid_cards where room_id=\'2\'',3),(445,'select * from devices where room_id=\'2\'',3),(446,'select * from blocks',3),(447,'select * from devices where user_id=\'3\'',3),(448,'select * from rfid_cards where room_id=\'2\'',3),(449,'select * from devices where room_id=\'2\'',3),(450,'select * from blocks',3),(451,'select * from devices where user_id=\'3\'',3),(452,'select * from rfid_cards where room_id=\'2\'',3),(453,'select * from devices where room_id=\'2\'',3),(454,'select * from blocks',3),(455,'select * from devices where user_id=\'3\'',3),(456,'select * from rfid_cards where room_id=\'2\'',3),(457,'select * from devices where room_id=\'2\'',3),(458,'select * from blocks',3),(459,'select * from devices where user_id=\'3\'',3),(460,'select * from rfid_cards where room_id=\'2\'',3),(461,'select * from devices where room_id=\'2\'',3),(462,'select * from blocks',3),(463,'select * from devices where user_id=\'3\'',3),(464,'select * from rfid_cards where room_id=\'2\'',3),(465,'select * from devices where room_id=\'2\'',3),(466,'select * from blocks',3),(467,'select * from devices where user_id=\'3\'',3),(468,'select * from rfid_cards where room_id=\'2\'',3),(469,'select * from devices where room_id=\'2\'',3),(470,'select * from blocks',3),(471,'select * from devices where user_id=\'3\'',3),(472,'select * from rfid_cards where room_id=\'2\'',3),(473,'select * from devices where room_id=\'2\'',3),(474,'select * from blocks',3),(475,'select * from devices where user_id=\'3\'',3),(476,'select * from rfid_cards where room_id=\'2\'',3),(477,'select * from devices where room_id=\'2\'',3),(478,'select * from blocks',3),(479,'select * from devices where user_id=\'3\'',3),(480,'select * from rfid_cards where room_id=\'2\'',3),(481,'select * from devices where room_id=\'2\'',3),(482,'select * from blocks',3),(483,'select * from devices where user_id=\'3\'',3),(484,'select * from rfid_cards where room_id=\'2\'',3),(485,'select * from devices where room_id=\'2\'',3),(486,'select * from blocks',3),(487,'select * from devices where user_id=\'3\'',3),(488,'select * from rfid_cards where room_id=\'2\'',3),(489,'select * from devices where room_id=\'2\'',3),(490,'select * from blocks',3),(491,'select * from devices where user_id=\'3\'',3),(492,'select * from rfid_cards where room_id=\'2\'',3),(493,'select * from devices where room_id=\'2\'',3),(494,'select * from blocks',3),(495,'select * from devices where user_id=\'3\'',3),(496,'select * from rfid_cards where room_id=\'2\'',3),(497,'select * from devices where room_id=\'2\'',3),(498,'select * from blocks',3),(499,'select * from devices where user_id=\'3\'',3),(500,'select * from rfid_cards where room_id=\'2\'',3),(501,'select * from devices where room_id=\'2\'',3),(502,'select * from blocks',3),(503,'select * from devices where user_id=\'3\'',3),(504,'select * from rfid_cards where room_id=\'2\'',3),(505,'select * from devices where room_id=\'2\'',3),(506,'select * from blocks',3),(507,'select * from devices where user_id=\'3\'',3),(508,'select * from rfid_cards where room_id=\'2\'',3),(509,'select * from devices where room_id=\'2\'',3),(510,'select * from blocks',3),(511,'select * from devices where user_id=\'3\'',3),(512,'select * from rfid_cards where room_id=\'2\'',3),(513,'select * from escape_rooms where user_id=\'3\'',3),(514,'select * from programs where room_id=\'2\'',3),(515,'select * from devices where user_id=\'3\'',3),(516,'select * from cameras where room_id=\'2\'',3),(517,'update programs set active=\'0\' where room_id=\'2\'',3),(518,'update programs set active=\'1\' where room_id=\'2\' and program_id=\'new\'',3),(519,'select * from programs where room_id=\'2\'',3),(520,'select * from devices where user_id=\'3\'',3),(521,'select * from cameras where room_id=\'2\'',3),(522,'select * from devices where room_id=\'2\'',3),(523,'select * from blocks',3),(524,'select * from devices where user_id=\'3\'',3),(525,'select * from rfid_cards where room_id=\'2\'',3),(526,'select * from devices where room_id=\'2\'',3),(527,'select * from blocks',3),(528,'select * from devices where user_id=\'3\'',3),(529,'select * from rfid_cards where room_id=\'2\'',3),(530,'select * from devices where room_id=\'2\'',3),(531,'select * from blocks',3),(532,'select * from devices where user_id=\'3\'',3),(533,'select * from rfid_cards where room_id=\'2\'',3),(534,'select * from devices where room_id=\'2\'',3),(535,'select * from blocks',3),(536,'select * from devices where user_id=\'3\'',3),(537,'select * from rfid_cards where room_id=\'2\'',3),(538,'select * from devices where room_id=\'2\'',3),(539,'select * from blocks',3),(540,'select * from devices where user_id=\'3\'',3),(541,'select * from rfid_cards where room_id=\'2\'',3),(542,'select * from devices where room_id=\'2\'',3),(543,'select * from blocks',3),(544,'select * from devices where user_id=\'3\'',3),(545,'select * from rfid_cards where room_id=\'2\'',3),(546,'select * from escape_rooms where user_id=\'3\'',3),(547,'select * from programs where room_id=\'2\'',3),(548,'select * from devices where user_id=\'3\'',3),(549,'select * from cameras where room_id=\'2\'',3),(550,'select * from programs where room_id=\'2\'',3),(551,'select * from devices where user_id=\'3\'',3),(552,'select * from cameras where room_id=\'2\'',3),(553,'update programs set active=\'0\' where room_id=\'2\'',3),(554,'update programs set active=\'1\' where room_id=\'2\' and program_id=\'1\'',3),(555,'select * from programs where room_id=\'2\'',3),(556,'select * from devices where user_id=\'3\'',3),(557,'select * from cameras where room_id=\'2\'',3),(558,'update programs set active=\'0\' where room_id=\'2\'',3),(559,'update programs set active=\'1\' where room_id=\'2\' and program_id=\'1\'',3),(560,'select * from programs where room_id=\'2\'',3),(561,'select * from devices where user_id=\'3\'',3),(562,'select * from cameras where room_id=\'2\'',3),(563,'update programs set active=\'0\' where room_id=\'2\'',3),(564,'update programs set active=\'1\' where room_id=\'2\' and program_id=\'new\'',3),(565,'select * from programs where room_id=\'2\'',3),(566,'select * from devices where user_id=\'3\'',3),(567,'select * from cameras where room_id=\'2\'',3),(568,'select * from devices where room_id=\'2\'',3),(569,'select * from blocks',3),(570,'select * from devices where user_id=\'3\'',3),(571,'select * from rfid_cards where room_id=\'2\'',3),(572,'update programs set active=\'0\' where room_id=\'2\'',3),(573,'update programs set active=\'1\' where room_id=\'2\' and program_id=\'1\'',3),(574,'select * from programs where room_id=\'2\'',3),(575,'select * from devices where user_id=\'3\'',3),(576,'select * from cameras where room_id=\'2\'',3),(577,'update programs set active=\'0\' where room_id=\'2\'',3),(578,'update programs set active=\'1\' where room_id=\'2\' and program_id=\'1\'',3),(579,'select * from programs where room_id=\'2\'',3),(580,'select * from devices where user_id=\'3\'',3),(581,'select * from cameras where room_id=\'2\'',3),(582,'select * from programs where user_id=\'3\'',3),(583,'select * from escape_rooms where user_id=\'3\'',3),(584,'select * from programs where room_id=\'2\'',3),(585,'select * from devices where user_id=\'3\'',3),(586,'select * from cameras where room_id=\'2\'',3),(587,'select * from programs where room_id=\'2\'',3),(588,'select * from devices where user_id=\'3\'',3),(589,'select * from cameras where room_id=\'2\'',3),(590,'update programs set active=\'0\' where room_id=\'2\'',3),(591,'update programs set active=\'1\' where room_id=\'2\' and program_id=\'1\'',3),(592,'select * from programs where room_id=\'2\'',3),(593,'select * from devices where user_id=\'3\'',3),(594,'select * from cameras where room_id=\'2\'',3),(595,'update programs set active=\'0\' where room_id=\'2\'',3),(596,'update programs set active=\'1\' where room_id=\'2\' and program_id=\'new\'',3),(597,'select * from programs where room_id=\'2\'',3),(598,'select * from devices where user_id=\'3\'',3),(599,'select * from cameras where room_id=\'2\'',3),(600,'select * from devices where room_id=\'2\'',3),(601,'select * from blocks',3),(602,'select * from devices where user_id=\'3\'',3),(603,'select * from rfid_cards where room_id=\'2\'',3),(604,'select * from devices where room_id=\'2\'',3),(605,'select * from blocks',3),(606,'select * from devices where user_id=\'3\'',3),(607,'select * from rfid_cards where room_id=\'2\'',3),(608,'select * from escape_rooms where user_id=\'3\'',3),(609,'select * from escape_rooms where user_id=\'3\'',3),(610,'select * from programs where user_id=\'3\'',3),(611,'select program_id,program_name,room_name,room_id from programs p join escape_rooms e  on p.room_id=e.room_id where user_id=\'3\'',3),(612,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where user_id=\'3\'',3),(613,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where user_id=\'3\'',3),(614,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where user_id=\'3\'',3),(615,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where user_id=\'3\'',3),(616,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(617,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(618,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(619,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(620,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(621,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(622,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(623,'select * from programs where program_id=\'\'',3),(624,'select * from blocks',3),(625,'select * from devices where user_id=\'3\'',3),(626,'select * from rfid_cards where room_id=\'\'',3),(627,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(628,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(629,'select * from devices where room_id=\'2program_id=1\'',3),(630,'select * from blocks',3),(631,'select * from devices where user_id=\'3\'',3),(632,'select * from rfid_cards where room_id=\'2program_id=1\'',3),(633,'select * from escape_rooms where user_id=\'3\'',3),(634,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(635,'select * from programs where program_id=\'2\'',3),(636,'select * from devices where room_id=\'2\'',3),(637,'select * from blocks',3),(638,'select * from devices where user_id=\'3\'',3),(639,'select * from rfid_cards where room_id=\'2\'',3),(640,'select * from programs where program_id=\'2\'',3),(641,'select * from devices where room_id=\'2\'',3),(642,'select * from blocks',3),(643,'select * from devices where user_id=\'3\'',3),(644,'select * from rfid_cards where room_id=\'2\'',3),(645,'select * from programs where program_id=\'2\'',3),(646,'select * from devices where room_id=\'2\'',3),(647,'select * from blocks',3),(648,'select * from devices where user_id=\'3\'',3),(649,'select * from rfid_cards where room_id=\'2\'',3),(650,'select * from programs where program_id=\'2\'',3),(651,'select * from devices where room_id=\'2\'',3),(652,'select * from blocks',3),(653,'select * from devices where user_id=\'3\'',3),(654,'select * from rfid_cards where room_id=\'2\'',3),(655,'select * from escape_rooms where user_id=\'3\'',3),(656,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(657,'select * from programs where program_id=\'2\'',3),(658,'select * from devices where room_id=\'2\'',3),(659,'select * from blocks',3),(660,'select * from devices where user_id=\'3\'',3),(661,'select * from rfid_cards where room_id=\'2\'',3),(662,'select * from escape_rooms where user_id=\'3\'',3),(663,'select * from programs where room_id=\'2\'',3),(664,'select * from devices where user_id=\'3\'',3),(665,'select * from cameras where room_id=\'2\'',3),(666,'select * from escape_rooms where user_id=\'3\'',3),(667,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(668,'select * from programs where program_id=\'2\'',3),(669,'select * from devices where room_id=\'2\'',3),(670,'select * from blocks',3),(671,'select * from devices where user_id=\'3\'',3),(672,'select * from rfid_cards where room_id=\'2\'',3),(673,'select * from programs where program_id=\'2\'',3),(674,'select * from devices where room_id=\'2\'',3),(675,'select * from blocks',3),(676,'select * from devices where user_id=\'3\'',3),(677,'select * from rfid_cards where room_id=\'2\'',3),(678,'select * from programs where program_id=\'2\'',3),(679,'select * from devices where room_id=\'2\'',3),(680,'select * from blocks',3),(681,'select * from devices where user_id=\'3\'',3),(682,'select * from rfid_cards where room_id=\'2\'',3),(683,'select * from devices where room_id=\'2\'',3),(684,'select * from blocks',3),(685,'select * from devices where user_id=\'3\'',3),(686,'select * from rfid_cards where room_id=\'2\'',3),(687,'select * from devices where room_id=\'2\'',3),(688,'select * from blocks',3),(689,'select * from devices where user_id=\'3\'',3),(690,'select * from rfid_cards where room_id=\'2\'',3),(691,'select * from devices where room_id=\'2\'',3),(692,'select * from blocks',3),(693,'select * from devices where user_id=\'3\'',3),(694,'select * from rfid_cards where room_id=\'2\'',3),(695,'select * from devices where room_id=\'2\'',3),(696,'select * from blocks',3),(697,'select * from devices where user_id=\'3\'',3),(698,'select * from rfid_cards where room_id=\'2\'',3),(699,'select * from devices where room_id=\'2\'',3),(700,'select * from blocks',3),(701,'select * from devices where user_id=\'3\'',3),(702,'select * from rfid_cards where room_id=\'2\'',3),(703,'select * from devices where room_id=\'2\'',3),(704,'select * from blocks',3),(705,'select * from devices where user_id=\'3\'',3),(706,'select * from rfid_cards where room_id=\'2\'',3),(707,'select * from devices where room_id=\'2\'',3),(708,'select * from blocks',3),(709,'select * from devices where user_id=\'3\'',3),(710,'select * from rfid_cards where room_id=\'2\'',3),(711,'select * from devices where room_id=\'2\'',3),(712,'select * from blocks',3),(713,'select * from devices where user_id=\'3\'',3),(714,'select * from rfid_cards where room_id=\'2\'',3),(715,'select * from devices where room_id=\'2\'',3),(716,'select * from blocks',3),(717,'select * from devices where user_id=\'3\'',3),(718,'select * from rfid_cards where room_id=\'2\'',3),(719,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(720,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(721,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(722,'select * from programs where program_id=\'2\'',3),(723,'select * from devices where room_id=\'2\'',3),(724,'select * from blocks',3),(725,'select * from devices where user_id=\'3\'',3),(726,'select * from rfid_cards where room_id=\'2\'',3),(727,'select * from programs where program_id=\'2\'',3),(728,'select * from devices where room_id=\'2\'',3),(729,'select * from blocks',3),(730,'select * from devices where user_id=\'3\'',3),(731,'select * from rfid_cards where room_id=\'2\'',3),(732,'select * from programs where program_id=\'2\'',3),(733,'select * from devices where room_id=\'2\'',3),(734,'select * from blocks',3),(735,'select * from devices where user_id=\'3\'',3),(736,'select * from rfid_cards where room_id=\'2\'',3),(737,'select * from programs where program_id=\'2\'',3),(738,'select * from devices where room_id=\'2\'',3),(739,'select * from blocks',3),(740,'select * from devices where user_id=\'3\'',3),(741,'select * from rfid_cards where room_id=\'2\'',3),(742,'select * from programs where program_id=\'2\'',3),(743,'select * from devices where room_id=\'2\'',3),(744,'select * from blocks',3),(745,'select * from devices where user_id=\'3\'',3),(746,'select * from rfid_cards where room_id=\'2\'',3),(747,'select * from programs where program_id=\'2\'',3),(748,'select * from devices where room_id=\'2\'',3),(749,'select * from blocks',3),(750,'select * from devices where user_id=\'3\'',3),(751,'select * from rfid_cards where room_id=\'2\'',3),(752,'select * from programs where program_id=\'2\'',3),(753,'select * from devices where room_id=\'2\'',3),(754,'select * from blocks',3),(755,'select * from devices where user_id=\'3\'',3),(756,'select * from rfid_cards where room_id=\'2\'',3),(757,'select * from programs where program_id=\'2\'',3),(758,'select * from devices where room_id=\'2\'',3),(759,'select * from blocks',3),(760,'select * from devices where user_id=\'3\'',3),(761,'select * from rfid_cards where room_id=\'2\'',3),(762,'select * from escape_rooms where user_id=\'3\'',3),(763,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(764,'select * from programs where program_id=\'2\'',3),(765,'select * from devices where room_id=\'2\'',3),(766,'select * from blocks',3),(767,'select * from devices where user_id=\'3\'',3),(768,'select * from rfid_cards where room_id=\'2\'',3),(769,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(770,'select * from programs where program_id=\'2\'',3),(771,'select * from devices where room_id=\'2\'',3),(772,'select * from blocks',3),(773,'select * from devices where user_id=\'3\'',3),(774,'select * from rfid_cards where room_id=\'2\'',3),(775,'select * from programs where program_id=\'1\' and user_id=\'3\'',3),(776,'select * from devices where room_id=\'2\'',3),(777,'select * from blocks',3),(778,'select * from devices where user_id=\'3\'',3),(779,'select * from rfid_cards where room_id=\'2\'',3),(780,'select * from programs where program_id=\'1\' and user_id=\'3\'',3),(781,'select * from devices where room_id=\'2\'',3),(782,'select * from blocks',3),(783,'select * from devices where user_id=\'3\'',3),(784,'select * from rfid_cards where room_id=\'2\'',3),(785,'select * from programs where program_id=\'1\' and user_id=\'3\'',3),(786,'select * from devices where room_id=\'2\'',3),(787,'select * from blocks',3),(788,'select * from devices where user_id=\'3\'',3),(789,'select * from rfid_cards where room_id=\'2\'',3),(790,'select * from programs where program_id=\'1\' and user_id=\'3\'',3),(791,'select * from devices where room_id=\'2\'',3),(792,'select * from blocks',3),(793,'select * from devices where user_id=\'3\'',3),(794,'select * from rfid_cards where room_id=\'2\'',3),(795,'select * from programs where program_id=\'1\' and user_id=\'3\'',3),(796,'select * from devices where room_id=\'2\'',3),(797,'select * from blocks',3),(798,'select * from devices where user_id=\'3\'',3),(799,'select * from rfid_cards where room_id=\'2\'',3),(800,'select * from programs where program_id=\'1\' and user_id=\'3\'',3),(801,'select * from devices where room_id=\'2\'',3),(802,'select * from blocks',3),(803,'select * from devices where user_id=\'3\'',3),(804,'select * from rfid_cards where room_id=\'2\'',3),(805,'select * from programs where program_id=\'1\' and user_id=\'3\'',3),(806,'select * from devices where room_id=\'2\'',3),(807,'select * from blocks',3),(808,'select * from devices where user_id=\'3\'',3),(809,'select * from rfid_cards where room_id=\'2\'',3),(810,'select * from programs where program_id=\'1\' and user_id=\'3\'',3),(811,'select * from devices where room_id=\'2\'',3),(812,'select * from blocks',3),(813,'select * from devices where user_id=\'3\'',3),(814,'select * from rfid_cards where room_id=\'2\'',3),(815,'select * from programs where program_id=\'1\' and user_id=\'3\'',3),(816,'select * from devices where room_id=\'2\'',3),(817,'select * from blocks',3),(818,'select * from devices where user_id=\'3\'',3),(819,'select * from rfid_cards where room_id=\'2\'',3),(820,'select * from programs where program_id=\'1\' and user_id=\'3\'',3),(821,'select * from devices where room_id=\'2\'',3),(822,'select * from blocks',3),(823,'select * from devices where user_id=\'3\'',3),(824,'select * from rfid_cards where room_id=\'2\'',3),(825,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(826,'select * from programs where program_id=\'2\' and user_id=\'3\'',3),(827,'select * from devices where room_id=\'2\'',3),(828,'select * from blocks',3),(829,'select * from devices where user_id=\'3\'',3),(830,'select * from rfid_cards where room_id=\'2\'',3),(831,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(832,'select * from devices where user_id=\'3\'',3),(833,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(834,'select * from programs where program_id=\'2\' and user_id=\'3\'',3),(835,'select * from devices where room_id=\'2\'',3),(836,'select * from blocks',3),(837,'select * from devices where user_id=\'3\'',3),(838,'select * from rfid_cards where room_id=\'2\'',3),(839,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(840,'select * from escape_rooms where user_id=\'3\'',3),(841,'select * from escape_rooms where user_id=\'3\'',3),(842,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(843,'select * from escape_rooms where user_id=\'3\'',3),(844,'select * from escape_rooms where user_id=\'3\'',3),(845,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(846,'delete from program where program_id=\'2\' and user_id=\'3\'',3),(847,'select * from escape_rooms where user_id=\'3\'',3),(848,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(849,'delete from program where program_id=\'2\' and user_id=\'3\'',3),(850,'select * from escape_rooms where user_id=\'3\'',3),(851,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(852,'delete from programs where program_id=\'2\' and user_id=\'3\'',3),(853,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(854,'select * from programs where program_id=\'1\' and user_id=\'3\'',3),(855,'select * from devices where room_id=\'2\'',3),(856,'select * from blocks',3),(857,'select * from devices where user_id=\'3\'',3),(858,'select * from rfid_cards where room_id=\'2\'',3),(859,'update programs set program_name=\'cuccos\',program_xml_block=\'<xml xmlns=\"https://developers.google.com/blockly/xml\"></xml>\',program_javascript_block=\'\' where program_id=\'1\' and user_id=\'3\'',3),(860,'select * from programs where program_id=\'1\' and user_id=\'3\'',3),(861,'select * from devices where room_id=\'2\'',3),(862,'select * from blocks',3),(863,'select * from devices where user_id=\'3\'',3),(864,'select * from rfid_cards where room_id=\'2\'',3),(865,'select * from programs where program_id=\'1\' and user_id=\'3\'',3),(866,'select * from devices where room_id=\'2\'',3),(867,'select * from blocks',3),(868,'select * from devices where user_id=\'3\'',3),(869,'select * from rfid_cards where room_id=\'2\'',3),(870,'select * from escape_rooms where user_id=\'3\'',3),(871,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(872,'select * from programs where program_id=\'1\' and user_id=\'3\'',3),(873,'select * from devices where room_id=\'2\'',3),(874,'select * from blocks',3),(875,'select * from devices where user_id=\'3\'',3),(876,'select * from rfid_cards where room_id=\'2\'',3),(877,'select * from escape_rooms where user_id=\'3\'',3),(878,'select * from programs where room_id=\'2\'',3),(879,'select * from devices where user_id=\'3\'',3),(880,'select * from cameras where room_id=\'2\'',3),(881,'select * from programs where room_id=\'2\'',3),(882,'select * from devices where user_id=\'3\'',3),(883,'select * from cameras where room_id=\'2\'',3),(884,'update programs set active=\'0\' where room_id=\'2\'',3),(885,'update programs set active=\'1\' where room_id=\'2\' and program_id=\'1\'',3),(886,'select * from programs where room_id=\'2\'',3),(887,'select * from devices where user_id=\'3\'',3),(888,'select * from cameras where room_id=\'2\'',3),(889,'update cameras set camera_name=\'Kamera 1\',camera_url=\'http://192.168.1.160:4646/stream\' where camera_id=\'1\'',3),(890,'select * from programs where room_id=\'2\'',3),(891,'select * from devices where user_id=\'3\'',3),(892,'select * from cameras where room_id=\'2\'',3),(893,'select * from escape_rooms where user_id=\'3\'',3),(894,'select * from programs where room_id=\'2\'',3),(895,'select * from devices where user_id=\'3\'',3),(896,'select * from cameras where room_id=\'2\'',3),(897,'select * from programs where room_id=\'2\'',3),(898,'select * from devices where user_id=\'3\'',3),(899,'select * from cameras where room_id=\'2\'',3),(900,'select * from programs where room_id=\'2\'',3),(901,'select * from devices where user_id=\'3\'',3),(902,'select * from cameras where room_id=\'2\'',3),(903,'select * from programs where room_id=\'2\'',3),(904,'select * from devices where user_id=\'3\'',3),(905,'select * from cameras where room_id=\'2\'',3),(906,'select * from programs where room_id=\'2\'',3),(907,'select * from devices where user_id=\'3\'',3),(908,'select * from cameras where room_id=\'2\'',3),(909,'select * from programs where room_id=\'2\'',3),(910,'select * from devices where user_id=\'3\'',3),(911,'select * from cameras where room_id=\'2\'',3),(912,'select * from programs where room_id=\'2\'',3),(913,'select * from devices where user_id=\'3\'',3),(914,'select * from cameras where room_id=\'2\'',3),(915,'select * from programs where room_id=\'2\'',3),(916,'select * from devices where user_id=\'3\'',3),(917,'select * from cameras where room_id=\'2\'',3),(918,'select * from programs where room_id=\'2\'',3),(919,'select * from devices where user_id=\'3\'',3),(920,'select * from cameras where room_id=\'2\'',3),(921,'select * from programs where room_id=\'2\'',3),(922,'select * from devices where user_id=\'3\'',3),(923,'select * from cameras where room_id=\'2\'',3),(924,'update programs set active=\'0\' where room_id=\'2\'',3),(925,'update programs set active=\'1\' where room_id=\'2\' and program_id=\'new\'',3),(926,'select * from programs where room_id=\'2\'',3),(927,'select * from devices where user_id=\'3\'',3),(928,'select * from cameras where room_id=\'2\'',3),(929,'select * from devices where room_id=\'2\'',3),(930,'select * from blocks',3),(931,'select * from devices where user_id=\'3\'',3),(932,'select * from rfid_cards where room_id=\'2\'',3),(933,'select * from escape_rooms where user_id=\'3\'',3),(934,'select * from escape_rooms where user_id=\'3\'',3),(935,'select * from programs where room_id=\'2\'',3),(936,'select * from devices where user_id=\'3\'',3),(937,'select * from cameras where room_id=\'2\'',3),(938,'select * from programs where room_id=\'2\'',3),(939,'select * from devices where user_id=\'3\'',3),(940,'select * from cameras where room_id=\'2\'',3),(941,'select * from programs where room_id=\'2\'',3),(942,'select * from devices where user_id=\'3\'',3),(943,'select * from cameras where room_id=\'2\'',3),(944,'select * from devices where user_id=\'3\'',3),(945,'select * from escape_rooms where user_id=\'3\'',3),(946,'select * from devices where user_id=\'3\'',3),(947,'select * from escape_rooms where user_id=\'3\'',3),(948,'select * from escape_rooms where user_id=\'3\'',3),(949,'select UPPER(tier) as \'tier\', escape_room, devices, price from tiers order by price asc',1),(950,'select user_id,username,ip_address,admin_mod from users where username=\'karpad2\' and password=md5(\'123456789ARPad78*123456789\');',1),(951,'select user_id,username,ip_address,admin_mod from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(952,'update users set ip_address=\'192.168.1.1\' where user_id=\'3\';',3),(953,'select * from escape_rooms where user_id=\'3\'',3),(954,'select * from programs where room_id=\'2\'',3),(955,'select * from devices where user_id=\'3\'',3),(956,'select * from cameras where room_id=\'2\'',3),(957,'select * from programs where room_id=\'2\'',3),(958,'select * from devices where user_id=\'3\'',3),(959,'select * from cameras where room_id=\'2\'',3),(960,'select * from programs where room_id=\'2\'',3),(961,'select * from devices where user_id=\'3\'',3),(962,'select * from cameras where room_id=\'2\'',3),(963,'select * from programs where room_id=\'2\'',3),(964,'select * from devices where user_id=\'3\'',3),(965,'select * from cameras where room_id=\'2\'',3),(966,'select * from programs where room_id=\'2\'',3),(967,'select * from devices where user_id=\'3\'',3),(968,'select * from cameras where room_id=\'2\'',3),(969,'select * from programs where room_id=\'2\'',3),(970,'select * from devices where user_id=\'3\'',3),(971,'select * from cameras where room_id=\'2\'',3),(972,'select * from programs where room_id=\'2\'',3),(973,'select * from devices where user_id=\'3\'',3),(974,'select * from cameras where room_id=\'2\'',3),(975,'select * from programs where room_id=\'2\'',3),(976,'select * from devices where user_id=\'3\'',3),(977,'select * from cameras where room_id=\'2\'',3),(978,'select * from escape_rooms where user_id=\'3\'',3),(979,'select * from programs where room_id=\'2\'',3),(980,'select * from devices where user_id=\'3\'',3),(981,'select * from cameras where room_id=\'2\'',3),(982,'select * from programs where room_id=\'2\'',3),(983,'select * from devices where user_id=\'3\'',3),(984,'select * from cameras where room_id=\'2\'',3),(985,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(986,'select * from escape_rooms where user_id=\'3\'',3),(987,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(988,'select * from programs where program_id=\'1\' and user_id=\'3\'',3),(989,'select * from devices where room_id=\'2\'',3),(990,'select * from blocks',3),(991,'select * from devices where user_id=\'3\'',3),(992,'select * from rfid_cards where room_id=\'2\'',3),(993,'select * from escape_rooms where user_id=\'3\'',3),(994,'select * from devices where user_id=\'3\'',3),(995,'select * from escape_rooms where user_id=\'3\'',3),(996,'select * from escape_rooms where user_id=\'3\'',3),(997,'select * from escape_rooms where user_id=\'3\'',3),(998,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(999,'select * from programs where program_id=\'1\' and user_id=\'3\'',3),(1000,'select * from devices where room_id=\'2\'',3),(1001,'select * from blocks',3),(1002,'select * from devices where user_id=\'3\'',3),(1003,'select * from rfid_cards where room_id=\'2\'',3),(1004,'select * from escape_rooms where user_id=\'3\'',3),(1005,'select * from escape_rooms where user_id=\'3\'',3),(1006,'select * from programs where room_id=\'2\'',3),(1007,'select * from devices where user_id=\'3\'',3),(1008,'select * from cameras where room_id=\'2\'',3),(1009,'select * from programs where room_id=\'2\'',3),(1010,'select * from devices where user_id=\'3\'',3),(1011,'select * from cameras where room_id=\'2\'',3),(1012,'update cameras set camera_name=\'Kamera 1\',camera_url=\'http://192.168.1.160:4646/stream\' where camera_id=\'1\'',3),(1013,'select * from programs where room_id=\'2\'',3),(1014,'select * from devices where user_id=\'3\'',3),(1015,'select * from cameras where room_id=\'2\'',3),(1016,'select * from programs where room_id=\'2\'',3),(1017,'select * from devices where user_id=\'3\'',3),(1018,'select * from cameras where room_id=\'2\'',3),(1019,'select * from escape_rooms where user_id=\'3\'',3),(1020,'select * from devices where user_id=\'3\'',3),(1021,'select program_id,program_name,room_name,p.room_id from programs p left join escape_rooms e on p.room_id=e.room_id where p.user_id=\'3\'',3),(1022,'select * from escape_rooms where user_id=\'3\'',3),(1023,'select * from programs where room_id=\'2\'',3),(1024,'select * from devices where user_id=\'3\'',3),(1025,'select * from cameras where room_id=\'2\'',3),(1026,'select * from programs where room_id=\'2\'',3),(1027,'select * from devices where user_id=\'3\'',3),(1028,'select * from cameras where room_id=\'2\'',3),(1029,'select * from programs where room_id=\'2\'',3),(1030,'select * from devices where user_id=\'3\'',3),(1031,'select * from cameras where room_id=\'2\'',3),(1032,'select * from programs where room_id=\'2\'',3),(1033,'select * from devices where user_id=\'3\'',3),(1034,'select * from cameras where room_id=\'2\'',3),(1035,'update cameras set camera_name=\'Kamera 2\',camera_url=\'http://192.168.1.161:4646/stream\' where camera_id=\'2\'',3),(1036,'select * from programs where room_id=\'2\'',3),(1037,'select * from devices where user_id=\'3\'',3),(1038,'select * from cameras where room_id=\'2\'',3),(1039,'update cameras set camera_name=\'Kamera 2\',camera_url=\'http://192.168.1.161:4646/stream\' where camera_id=\'2\'',3),(1040,'select * from programs where room_id=\'2\'',3),(1041,'select * from devices where user_id=\'3\'',3),(1042,'select * from cameras where room_id=\'2\'',3),(1043,'select * from escape_rooms where user_id=\'3\'',3),(1044,'select * from escape_rooms where user_id=\'3\'',3),(1045,'select * from escape_rooms where user_id=\'3\'',3),(1046,'select * from escape_rooms where user_id=\'3\'',3),(1047,'select * from escape_rooms where user_id=\'3\'',3),(1048,'select * from escape_rooms where user_id=\'3\'',3),(1049,'select * from escape_rooms where user_id=\'3\'',3),(1050,'select * from escape_rooms where user_id=\'3\'',3),(1051,'select teams_name from teams',3),(1052,'select teams_name from teams',3),(1053,'select * from escape_rooms where user_id=\'3\'',3),(1054,'select * from escape_rooms where user_id=\'3\'',3),(1055,'select * from escape_rooms where user_id=\'3\'',3),(1056,'select * from escape_rooms where user_id=\'3\'',3),(1057,'select * from escape_rooms where user_id=\'3\'',3),(1058,'select UPPER(tier) as \'tier\', escape_room, devices, price from tiers order by price asc',1),(1059,'select user_id,username,ip_address,admin_mod from users where username=\'karpad2\' and password=md5(\'123456789asdfghjkl123456789\');',1),(1060,'update users set ip_address=\'192.168.1.1\' where user_id=\'3\';',3),(1061,'select * from escape_rooms where user_id=\'3\'',3),(1062,'select * from devices where user_id=\'3\'',3),(1063,'select * from escape_rooms where user_id=\'3\'',3),(1064,'select * from escape_rooms where user_id=\'3\'',3),(1065,'select * from escape_rooms where user_id=\'3\'',3),(1066,'select * from escape_rooms where user_id=\'3\'',3),(1067,'select * from escape_rooms where user_id=\'3\'',3),(1068,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1069,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1070,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1071,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1072,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1073,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1074,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1075,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1076,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1077,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1078,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1079,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1080,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1081,'select * from escape_rooms where user_id=\'3\'',3),(1082,'select * from escape_rooms where user_id=\'3\'',3),(1083,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1084,'select * from escape_rooms where user_id=\'3\'',3),(1085,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1086,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1087,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1088,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1089,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1090,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1091,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1092,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1093,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1094,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1095,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1096,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1097,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1098,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3),(1099,'select count(device_id) as \'device_number\',sum(active) as \'active_number\' from active_devices where room_id=\'2\' group by room_id',3);
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
  `active` int(11) DEFAULT 0,
  `program_xml_block` text COLLATE utf8_unicode_ci DEFAULT '',
  `program_javascript_block` text COLLATE utf8_unicode_ci DEFAULT '',
  PRIMARY KEY (`program_id`),
  KEY `programs_users_user_id_fk` (`user_id`),
  KEY `programs_escape_rooms_room_id_fk` (`room_id`),
  CONSTRAINT `programs_escape_rooms_room_id_fk` FOREIGN KEY (`room_id`) REFERENCES `escape_rooms` (`room_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `programs_users_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programs`
--

LOCK TABLES `programs` WRITE;
/*!40000 ALTER TABLE `programs` DISABLE KEYS */;
INSERT INTO `programs` VALUES (1,'cuccos',3,2,0,'<xml xmlns=\"https://developers.google.com/blockly/xml\">\r\n  <block type=\"text\" id=\"nP($:35;UVkKNZ]6?6%^\" x=\"145\" y=\"48\">\r\n    <field name=\"TEXT\"></field>\r\n  </block>\r\n</xml>','\';\r\n');
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
  `room_id` int(11) DEFAULT 1,
  PRIMARY KEY (`rfid-code`,`user_id`),
  KEY `rfid_cards_users_user_id_fk` (`user_id`),
  KEY `rfid_cards_escape_rooms_room_id_fk` (`room_id`),
  CONSTRAINT `rfid_cards_escape_rooms_room_id_fk` FOREIGN KEY (`room_id`) REFERENCES `escape_rooms` (`room_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rfid_cards_users_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_nopad_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rfid_cards`
--

LOCK TABLES `rfid_cards` WRITE;
/*!40000 ALTER TABLE `rfid_cards` DISABLE KEYS */;
INSERT INTO `rfid_cards` VALUES ('0','Default',1,0,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams`
--

LOCK TABLES `teams` WRITE;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
INSERT INTO `teams` VALUES (1,'Default');
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tiers`
--

DROP TABLE IF EXISTS `tiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tiers` (
  `tier` varchar(50) NOT NULL,
  `escape_room` int(11) NOT NULL,
  `devices` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `extra` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tiers`
--

LOCK TABLES `tiers` WRITE;
/*!40000 ALTER TABLE `tiers` DISABLE KEYS */;
INSERT INTO `tiers` VALUES ('basic',2,30,10,'Email Support'),('free',1,10,0,NULL),('pro',5,100,50,'Email Support'),('unlimited',9999,9999,250,'24/7 Email Support');
/*!40000 ALTER TABLE `tiers` ENABLE KEYS */;
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
INSERT INTO `users` VALUES (1,'root',' ','2021-01-23 19:21:51','127.0.0.1',0),(2,'esp32',' ','2021-01-24 14:53:29','127.0.0.1',0),(3,'karpad2','f961d8d0e488e133589c139716c8885e','2021-01-30 08:16:49','192.168.1.1',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `active_devices`
--

/*!50001 DROP TABLE IF EXISTS `active_devices`*/;
/*!50001 DROP VIEW IF EXISTS `active_devices`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`karpad2`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `active_devices` AS select `d`.`device_id` AS `device_id`,`d`.`device_name` AS `device_name`,`d`.`device_mode` AS `device_mode`,`d`.`ip_address` AS `ip_address`,`d`.`device_password` AS `device_password`,`d`.`room_id` AS `room_id`,`d`.`status` AS `status`,`d`.`user_id` AS `user_id`,`d`.`last_online` AS `last_online`,timestampdiff(MINUTE,`d`.`last_online`,current_timestamp()) > 3 AS `active` from `devices` `d` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `finished_runs`
--

/*!50001 DROP TABLE IF EXISTS `finished_runs`*/;
/*!50001 DROP VIEW IF EXISTS `finished_runs`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `finished_runs` AS select `runs`.`finishing_time` - `runs`.`starting_time` AS `time_sec`,`t`.`teams_name` AS `teams_name`,`es`.`room_name` AS `room_name` from (((`runs` join `teams` `t` on(`runs`.`team_id` = `t`.`teams_id`)) join `programs` `p` on(`runs`.`program_id` = `p`.`program_id`)) join `escape_rooms` `es` on(`p`.`room_id` = `runs`.`program_id`)) where `runs`.`finishing_time` is not null order by `runs`.`finishing_time` - `runs`.`starting_time` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-04 14:58:47
