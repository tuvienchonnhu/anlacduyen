Enter password: 
-- MySQL dump 10.13  Distrib 26.7.0, for Linux (x86_64)
--
-- Host: localhost    Database: SALESMANAGER1
-- ------------------------------------------------------
-- Server version	26.7.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
Warning: A partial dump from a server that has GTIDs will by default include the GTIDs of all transactions, even those that changed suppressed parts of the database. If you don't want to restore GTIDs, pass --set-gtid-purged=OFF. To make a complete dump, pass --all-databases --triggers --routines --events. 
Warning: A dump from a server that has GTIDs enabled will by default include the GTIDs of all transactions, even those that were executed during its extraction and might not be represented in the dumped data. This might result in an inconsistent data dump. 
In order to ensure a consistent backup of the database, pass --single-transaction or --lock-all-tables or --source-data. 
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '6bf54fee-a2f0-11f1-8dfa-a2c9eeb68919:1-20423';

--
-- Table structure for table `AVAILABILITY_VARIATION`
--

DROP TABLE IF EXISTS `AVAILABILITY_VARIATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AVAILABILITY_VARIATION` (
  `PRODUCT_AVAIL_ID` bigint NOT NULL,
  `PRODUCT_VARIANTION_ID` bigint NOT NULL,
  PRIMARY KEY (`PRODUCT_AVAIL_ID`,`PRODUCT_VARIANTION_ID`),
  KEY `FK1gxel47p32k4xsnp72ooxd0ne` (`PRODUCT_VARIANTION_ID`),
  CONSTRAINT `FK1gxel47p32k4xsnp72ooxd0ne` FOREIGN KEY (`PRODUCT_VARIANTION_ID`) REFERENCES `PRODUCT_VARIATION` (`PRODUCT_VARIANTION_ID`),
  CONSTRAINT `FK2khsh7gvb4pf291j0oosnv7fs` FOREIGN KEY (`PRODUCT_AVAIL_ID`) REFERENCES `PRODUCT_AVAILABILITY` (`PRODUCT_AVAIL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AVAILABILITY_VARIATION`
--

LOCK TABLES `AVAILABILITY_VARIATION` WRITE;
/*!40000 ALTER TABLE `AVAILABILITY_VARIATION` DISABLE KEYS */;
/*!40000 ALTER TABLE `AVAILABILITY_VARIATION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CATALOG`
--

DROP TABLE IF EXISTS `CATALOG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CATALOG` (
  `id` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `CODE` varchar(100) NOT NULL,
  `DEFAULT_CATALOG` bit(1) DEFAULT NULL,
  `SORT_ORDER` int DEFAULT NULL,
  `VISIBLE` bit(1) DEFAULT NULL,
  `MERCHANT_ID` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK32mubpubtaqu30n34bwl7xiis` (`MERCHANT_ID`,`CODE`),
  CONSTRAINT `FKranq0rweb0r6j31j565ak51g8` FOREIGN KEY (`MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CATALOG`
--

LOCK TABLES `CATALOG` WRITE;
/*!40000 ALTER TABLE `CATALOG` DISABLE KEYS */;
/*!40000 ALTER TABLE `CATALOG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CATALOG_ENTRY`
--

DROP TABLE IF EXISTS `CATALOG_ENTRY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CATALOG_ENTRY` (
  `id` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `VISIBLE` bit(1) DEFAULT NULL,
  `CATALOG_ID` bigint NOT NULL,
  `CATEGORY_ID` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK5q8159i414r299kia2w9re90k` (`CATEGORY_ID`,`CATALOG_ID`),
  KEY `FKqp2j48hb3vodovb8gn2o4gox` (`CATALOG_ID`),
  CONSTRAINT `FK374wks7em54d0oghju0earttl` FOREIGN KEY (`CATEGORY_ID`) REFERENCES `CATEGORY` (`CATEGORY_ID`),
  CONSTRAINT `FKqp2j48hb3vodovb8gn2o4gox` FOREIGN KEY (`CATALOG_ID`) REFERENCES `CATALOG` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CATALOG_ENTRY`
--

LOCK TABLES `CATALOG_ENTRY` WRITE;
/*!40000 ALTER TABLE `CATALOG_ENTRY` DISABLE KEYS */;
/*!40000 ALTER TABLE `CATALOG_ENTRY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CATEGORY`
--

DROP TABLE IF EXISTS `CATEGORY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CATEGORY` (
  `CATEGORY_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `CATEGORY_IMAGE` varchar(100) DEFAULT NULL,
  `CATEGORY_STATUS` bit(1) DEFAULT NULL,
  `CODE` varchar(100) NOT NULL,
  `DEPTH` int DEFAULT NULL,
  `FEATURED` bit(1) DEFAULT NULL,
  `LINEAGE` varchar(255) DEFAULT NULL,
  `SORT_ORDER` int DEFAULT NULL,
  `VISIBLE` bit(1) DEFAULT NULL,
  `MERCHANT_ID` int NOT NULL,
  `PARENT_ID` bigint DEFAULT NULL,
  PRIMARY KEY (`CATEGORY_ID`),
  UNIQUE KEY `UK3mq9i6qmgquvoieslx39pej6x` (`MERCHANT_ID`,`CODE`),
  KEY `FKn3kekntr7pm8g9v8ask698ato` (`PARENT_ID`),
  CONSTRAINT `FK8a09asq5fcx0a88i4m8nsixy` FOREIGN KEY (`MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`),
  CONSTRAINT `FKn3kekntr7pm8g9v8ask698ato` FOREIGN KEY (`PARENT_ID`) REFERENCES `CATEGORY` (`CATEGORY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CATEGORY`
--

LOCK TABLES `CATEGORY` WRITE;
/*!40000 ALTER TABLE `CATEGORY` DISABLE KEYS */;
INSERT INTO `CATEGORY` VALUES (1,'2026-09-19 01:39:05','2026-09-19 01:39:05','admin@shopizer.com',NULL,_binary '\0','Gao',0,_binary '','/1/',1,_binary '',1,NULL),(50,'2026-09-19 15:08:40','2026-09-19 15:08:40','admin@shopizer.com',NULL,_binary '\0','Ba Lô Túi Xách',0,_binary '\0','/50/',1,_binary '',1,NULL);
/*!40000 ALTER TABLE `CATEGORY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CATEGORY_DESCRIPTION`
--

DROP TABLE IF EXISTS `CATEGORY_DESCRIPTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CATEGORY_DESCRIPTION` (
  `DESCRIPTION_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `DESCRIPTION` longtext,
  `NAME` varchar(120) NOT NULL,
  `TITLE` varchar(100) DEFAULT NULL,
  `CATEGORY_HIGHLIGHT` varchar(255) DEFAULT NULL,
  `META_DESCRIPTION` varchar(255) DEFAULT NULL,
  `META_KEYWORDS` varchar(255) DEFAULT NULL,
  `META_TITLE` varchar(120) DEFAULT NULL,
  `SEF_URL` varchar(120) DEFAULT NULL,
  `LANGUAGE_ID` int NOT NULL,
  `CATEGORY_ID` bigint NOT NULL,
  PRIMARY KEY (`DESCRIPTION_ID`),
  UNIQUE KEY `UKbuesqq6cyx7e5hy3mf30cfieq` (`CATEGORY_ID`,`LANGUAGE_ID`),
  KEY `FKl4j5boteutpu1p8f67kydpnmd` (`LANGUAGE_ID`),
  CONSTRAINT `FKa58u7d0ydfgref1iaux5efyov` FOREIGN KEY (`CATEGORY_ID`) REFERENCES `CATEGORY` (`CATEGORY_ID`),
  CONSTRAINT `FKl4j5boteutpu1p8f67kydpnmd` FOREIGN KEY (`LANGUAGE_ID`) REFERENCES `LANGUAGE` (`LANGUAGE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CATEGORY_DESCRIPTION`
--

LOCK TABLES `CATEGORY_DESCRIPTION` WRITE;
/*!40000 ALTER TABLE `CATEGORY_DESCRIPTION` DISABLE KEYS */;
INSERT INTO `CATEGORY_DESCRIPTION` VALUES (1,'2026-09-19 01:39:05','2026-09-19 01:39:05',NULL,'<p>  越南大米</p>\n','越南大米',NULL,'越南大米','','越南大米','越南大米','rice-vn',53,1),(2,'2026-09-19 01:39:05','2026-09-19 01:39:05',NULL,'<p>\n  <strong>Présentation du riz vietnamien</strong> Le Vietnam est l’un\n  des plus grands exportateurs de riz au monde. Le riz vietnamien est\n  réputé pour sa qualité, sa saveur délicate et sa diversité. On\n  distingue plusieurs variétés, comme le riz parfumé (riz jasmin), le\n  riz gluant et le riz blanc traditionnel. Le riz est non seulement un\n  aliment de base au Vietnam, mais aussi un produit d’exportation\n  essentiel qui contribue fortement à l’économie nationale.</p>\n','riz vietnamien',NULL,'riz vietnamien','','riz vietnamien','riz vietnamien','riz-vietnamien',52,1),(3,'2026-09-19 01:39:05','2026-09-19 01:39:05',NULL,'','Rice Viet Nam',NULL,'Rice Viet Nam','','','Rice Viet Nam','rice-viet-nam',51,1),(4,'2026-09-19 01:39:05','2026-09-19 01:39:05',NULL,'<p>  gạo Việt Nam</p>\n','Gạo Việt Nam',NULL,'Gạo','gạo','gạo','Gạo Việt Nam','gao-viet-nam',50,1),(5,'2026-09-19 15:08:40','2026-09-19 15:08:40',NULL,'<p>  Ba Lô Túi Xách</p>\n','Ba Lô Túi Xách',NULL,'','','Ba Lô Túi Xách','Ba Lô Túi Xách','balotuixach',50,50),(6,'2026-09-19 15:08:40','2026-09-19 15:08:40',NULL,'<p>  Bag / Handbag</p>\n','Bag / Handbag',NULL,'Bag / Handbag','','Bag / Handbag','Bag / Handbag','bag-handbag',51,50),(7,'2026-09-19 15:08:40','2026-09-19 15:08:40',NULL,'<p>  包 / 手提包</p>\n','包 / 手提包',NULL,'包 / 手提包','包 / 手提包','包 / 手提包','包 / 手提包','balotuixach',53,50),(8,'2026-09-19 15:08:40','2026-09-19 15:08:40',NULL,'<p>  Sac / Sac à main</p>\n','Sac / Sac à main',NULL,'Sac / Sac à main','Sac / Sac à main','Sac / Sac à main','Sac / Sac à main','sac-sac-main',52,50);
/*!40000 ALTER TABLE `CATEGORY_DESCRIPTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CONTENT`
--

DROP TABLE IF EXISTS `CONTENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CONTENT` (
  `CONTENT_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `CODE` varchar(100) NOT NULL,
  `CONTENT_POSITION` varchar(10) DEFAULT NULL,
  `CONTENT_TYPE` varchar(10) DEFAULT NULL,
  `LINK_TO_MENU` bit(1) DEFAULT NULL,
  `PRODUCT_GROUP` varchar(255) DEFAULT NULL,
  `SORT_ORDER` int DEFAULT NULL,
  `VISIBLE` bit(1) DEFAULT NULL,
  `MERCHANT_ID` int NOT NULL,
  PRIMARY KEY (`CONTENT_ID`),
  UNIQUE KEY `UKt1v2ld0mrwviquqourql4uub0` (`MERCHANT_ID`,`CODE`),
  KEY `CODE_IDX` (`CODE`),
  CONSTRAINT `FKfmoi0fkjbtfty3o8fs94t11r1` FOREIGN KEY (`MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONTENT`
--

LOCK TABLES `CONTENT` WRITE;
/*!40000 ALTER TABLE `CONTENT` DISABLE KEYS */;
INSERT INTO `CONTENT` VALUES (1,NULL,NULL,NULL,'LANDING_PAGE',NULL,'SECTION',_binary '\0',NULL,0,_binary '',1);
/*!40000 ALTER TABLE `CONTENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CONTENT_DESCRIPTION`
--

DROP TABLE IF EXISTS `CONTENT_DESCRIPTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CONTENT_DESCRIPTION` (
  `DESCRIPTION_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `DESCRIPTION` longtext,
  `NAME` varchar(120) NOT NULL,
  `TITLE` varchar(100) DEFAULT NULL,
  `META_DESCRIPTION` varchar(255) DEFAULT NULL,
  `META_KEYWORDS` varchar(255) DEFAULT NULL,
  `META_TITLE` varchar(255) DEFAULT NULL,
  `SEF_URL` varchar(120) DEFAULT NULL,
  `LANGUAGE_ID` int NOT NULL,
  `CONTENT_ID` bigint NOT NULL,
  PRIMARY KEY (`DESCRIPTION_ID`),
  UNIQUE KEY `UKn0w5r7ctbp88r4rvk7ayklofm` (`CONTENT_ID`,`LANGUAGE_ID`),
  KEY `FK47yxf681u0rfw2kvarhqb0r3v` (`LANGUAGE_ID`),
  CONSTRAINT `FK47yxf681u0rfw2kvarhqb0r3v` FOREIGN KEY (`LANGUAGE_ID`) REFERENCES `LANGUAGE` (`LANGUAGE_ID`),
  CONSTRAINT `FKk7fabfxn2flvcofwwpyg5sys` FOREIGN KEY (`CONTENT_ID`) REFERENCES `CONTENT` (`CONTENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONTENT_DESCRIPTION`
--

LOCK TABLES `CONTENT_DESCRIPTION` WRITE;
/*!40000 ALTER TABLE `CONTENT_DESCRIPTION` DISABLE KEYS */;
INSERT INTO `CONTENT_DESCRIPTION` VALUES (1,'2026-09-19 01:03:18','2026-09-19 01:56:05',NULL,'<p>\n  <img alt=\"\" src=\"/static/files/DEFAULT/IMAGE/banner-resized.jpg\" style=\"height: 200.0px;float: left;border-width: 5.0px;border-style: solid;margin: 1.0px 15.0px;width: 1000.0px;\" /></p>\n','An Lạc Duyên','An Lạc Duyên','An Lạc Duyên','An Lạc Duyên',NULL,NULL,50,1),(2,'2026-09-19 01:03:18','2026-09-19 01:56:05',NULL,'<p>\n  <img alt=\"\" src=\"/static/files/DEFAULT/IMAGE/banner-resized.jpg\" style=\"height: 200.0px;float: left;border-width: 5.0px;border-style: solid;margin: 1.0px 15.0px;width: 1000.0px;\" /></p>\n','An Lac Duyen','An Lac Duyen','An Lac Duyen','An Lac Duyen',NULL,NULL,51,1),(3,'2026-09-19 01:03:18','2026-09-19 01:56:05',NULL,'<p>\n  <img alt=\"\" src=\"/static/files/DEFAULT/IMAGE/banner-resized.jpg\" style=\"height: 200.0px;float: left;border-width: 5.0px;border-style: solid;margin: 1.0px 15.0px;width: 1000.0px;\" /></p>\n','Condition de paix et de félicité','Condition de paix et de félicité','La solidarité et la justice sont des conditions de paix et de félicité.','La solidarité et la justice sont des conditions de paix et de félicité.',NULL,NULL,52,1),(4,'2026-09-19 01:03:18','2026-09-19 01:56:05',NULL,'<p>\n  <img alt=\"\" src=\"/static/files/DEFAULT/IMAGE/banner-resized.jpg\" style=\"height: 200.0px;float: left;border-width: 5.0px;border-style: solid;margin: 1.0px 15.0px;width: 1000.0px;\" /></p>\n','安乐缘','安乐缘','修善行是安乐缘。','修善行是安乐缘。',NULL,NULL,53,1);
/*!40000 ALTER TABLE `CONTENT_DESCRIPTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COUNTRY`
--

DROP TABLE IF EXISTS `COUNTRY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `COUNTRY` (
  `COUNTRY_ID` int NOT NULL,
  `COUNTRY_ISOCODE` varchar(255) NOT NULL,
  `COUNTRY_SUPPORTED` bit(1) DEFAULT NULL,
  `GEOZONE_ID` bigint DEFAULT NULL,
  PRIMARY KEY (`COUNTRY_ID`),
  UNIQUE KEY `UK_dqb99v22pt27v0tgeqo958e6x` (`COUNTRY_ISOCODE`),
  KEY `FKd2q9e14kh1j6tm1gpbct2xwws` (`GEOZONE_ID`),
  CONSTRAINT `FKd2q9e14kh1j6tm1gpbct2xwws` FOREIGN KEY (`GEOZONE_ID`) REFERENCES `GEOZONE` (`GEOZONE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COUNTRY`
--

LOCK TABLES `COUNTRY` WRITE;
/*!40000 ALTER TABLE `COUNTRY` DISABLE KEYS */;
INSERT INTO `COUNTRY` VALUES (250,'AF',_binary '',NULL),(251,'AX',_binary '',NULL),(252,'AL',_binary '',NULL),(253,'DZ',_binary '',NULL),(254,'AS',_binary '',NULL),(255,'AD',_binary '',NULL),(256,'AO',_binary '',NULL),(257,'AI',_binary '',NULL),(258,'AG',_binary '',NULL),(259,'AR',_binary '',NULL),(260,'AM',_binary '',NULL),(261,'AW',_binary '',NULL),(262,'AU',_binary '',NULL),(263,'AT',_binary '',NULL),(264,'AZ',_binary '',NULL),(265,'BS',_binary '',NULL),(266,'BH',_binary '',NULL),(267,'BD',_binary '',NULL),(268,'BB',_binary '',NULL),(269,'BY',_binary '',NULL),(270,'BE',_binary '',NULL),(271,'BZ',_binary '',NULL),(272,'BJ',_binary '',NULL),(273,'BM',_binary '',NULL),(274,'BT',_binary '',NULL),(275,'BO',_binary '',NULL),(276,'BA',_binary '',NULL),(277,'BW',_binary '',NULL),(278,'BR',_binary '',NULL),(279,'IO',_binary '',NULL),(280,'BN',_binary '',NULL),(281,'BG',_binary '',NULL),(282,'BF',_binary '',NULL),(283,'BI',_binary '',NULL),(284,'KH',_binary '',NULL),(285,'CM',_binary '',NULL),(286,'CA',_binary '',NULL),(287,'CV',_binary '',NULL),(288,'KY',_binary '',NULL),(289,'CF',_binary '',NULL),(290,'TD',_binary '',NULL),(291,'CL',_binary '',NULL),(292,'CN',_binary '',NULL),(293,'CX',_binary '',NULL),(294,'CC',_binary '',NULL),(295,'CO',_binary '',NULL),(296,'KM',_binary '',NULL),(297,'CG',_binary '',NULL),(298,'CD',_binary '',NULL),(299,'CK',_binary '',NULL),(300,'CR',_binary '',NULL),(301,'CI',_binary '',NULL),(302,'HR',_binary '',NULL),(303,'CU',_binary '',NULL),(304,'CY',_binary '',NULL),(305,'CZ',_binary '',NULL),(306,'DK',_binary '',NULL),(307,'DJ',_binary '',NULL),(308,'DM',_binary '',NULL),(309,'DO',_binary '',NULL),(310,'EC',_binary '',NULL),(311,'EG',_binary '',NULL),(312,'SV',_binary '',NULL),(313,'GQ',_binary '',NULL),(314,'ER',_binary '',NULL),(315,'EE',_binary '',NULL),(316,'ET',_binary '',NULL),(317,'FK',_binary '',NULL),(318,'FO',_binary '',NULL),(319,'FJ',_binary '',NULL),(320,'FI',_binary '',NULL),(321,'FR',_binary '',NULL),(322,'GF',_binary '',NULL),(323,'PF',_binary '',NULL),(324,'GA',_binary '',NULL),(325,'GM',_binary '',NULL),(326,'GE',_binary '',NULL),(327,'DE',_binary '',NULL),(328,'GH',_binary '',NULL),(329,'GI',_binary '',NULL),(330,'GR',_binary '',NULL),(331,'GL',_binary '',NULL),(332,'GD',_binary '',NULL),(333,'GP',_binary '',NULL),(334,'GU',_binary '',NULL),(335,'GT',_binary '',NULL),(336,'GG',_binary '',NULL),(337,'GN',_binary '',NULL),(338,'GW',_binary '',NULL),(339,'GY',_binary '',NULL),(340,'HT',_binary '',NULL),(341,'VA',_binary '',NULL),(342,'HN',_binary '',NULL),(343,'HK',_binary '',NULL),(344,'HU',_binary '',NULL),(345,'IS',_binary '',NULL),(346,'IN',_binary '',NULL),(347,'ID',_binary '',NULL),(348,'IR',_binary '',NULL),(349,'IQ',_binary '',NULL),(350,'IE',_binary '',NULL),(351,'IM',_binary '',NULL),(352,'IL',_binary '',NULL),(353,'IT',_binary '',NULL),(354,'JM',_binary '',NULL),(355,'JP',_binary '',NULL),(356,'JE',_binary '',NULL),(357,'JO',_binary '',NULL),(358,'KZ',_binary '',NULL),(359,'KE',_binary '',NULL),(360,'KI',_binary '',NULL),(361,'KP',_binary '',NULL),(362,'KR',_binary '',NULL),(363,'KW',_binary '',NULL),(364,'KG',_binary '',NULL),(365,'LA',_binary '',NULL),(366,'LV',_binary '',NULL),(367,'LB',_binary '',NULL),(368,'LS',_binary '',NULL),(369,'LR',_binary '',NULL),(370,'LY',_binary '',NULL),(371,'LI',_binary '',NULL),(372,'LT',_binary '',NULL),(373,'LU',_binary '',NULL),(374,'MO',_binary '',NULL),(375,'MK',_binary '',NULL),(376,'MG',_binary '',NULL),(377,'MW',_binary '',NULL),(378,'MY',_binary '',NULL),(379,'ML',_binary '',NULL),(380,'MT',_binary '',NULL),(381,'MH',_binary '',NULL),(382,'MQ',_binary '',NULL),(383,'MR',_binary '',NULL),(384,'MU',_binary '',NULL),(385,'YT',_binary '',NULL),(386,'MX',_binary '',NULL),(387,'FM',_binary '',NULL),(388,'MD',_binary '',NULL),(389,'MC',_binary '',NULL),(390,'MN',_binary '',NULL),(391,'ME',_binary '',NULL),(392,'MS',_binary '',NULL),(393,'MA',_binary '',NULL),(394,'MZ',_binary '',NULL),(395,'MM',_binary '',NULL),(396,'NA',_binary '',NULL),(397,'NR',_binary '',NULL),(398,'NP',_binary '',NULL),(399,'NL',_binary '',NULL),(400,'NC',_binary '',NULL),(401,'NZ',_binary '',NULL),(402,'NI',_binary '',NULL),(403,'NE',_binary '',NULL),(404,'NG',_binary '',NULL),(405,'NU',_binary '',NULL),(406,'NF',_binary '',NULL),(407,'MP',_binary '',NULL),(408,'NO',_binary '',NULL),(409,'OM',_binary '',NULL),(410,'PK',_binary '',NULL),(411,'PW',_binary '',NULL),(412,'PS',_binary '',NULL),(413,'PA',_binary '',NULL),(414,'PG',_binary '',NULL),(415,'PY',_binary '',NULL),(416,'PE',_binary '',NULL),(417,'PH',_binary '',NULL),(418,'PN',_binary '',NULL),(419,'PL',_binary '',NULL),(420,'PT',_binary '',NULL),(421,'PR',_binary '',NULL),(422,'QA',_binary '',NULL),(423,'RE',_binary '',NULL),(424,'RO',_binary '',NULL),(425,'RU',_binary '',NULL),(426,'RW',_binary '',NULL),(427,'SH',_binary '',NULL),(428,'KN',_binary '',NULL),(429,'LC',_binary '',NULL),(430,'PM',_binary '',NULL),(431,'VC',_binary '',NULL),(432,'WS',_binary '',NULL),(433,'SM',_binary '',NULL),(434,'ST',_binary '',NULL),(435,'SA',_binary '',NULL),(436,'SN',_binary '',NULL),(437,'RS',_binary '',NULL),(438,'SC',_binary '',NULL),(439,'SL',_binary '',NULL),(440,'SG',_binary '',NULL),(441,'SK',_binary '',NULL),(442,'SI',_binary '',NULL),(443,'SB',_binary '',NULL),(444,'SO',_binary '',NULL),(445,'ZA',_binary '',NULL),(446,'ES',_binary '',NULL),(447,'LK',_binary '',NULL),(448,'SD',_binary '',NULL),(449,'SR',_binary '',NULL),(450,'SJ',_binary '',NULL),(451,'SZ',_binary '',NULL),(452,'SE',_binary '',NULL),(453,'CH',_binary '',NULL),(454,'SY',_binary '',NULL),(455,'TW',_binary '',NULL),(456,'TJ',_binary '',NULL),(457,'TZ',_binary '',NULL),(458,'TH',_binary '',NULL),(459,'TL',_binary '',NULL),(460,'TG',_binary '',NULL),(461,'TK',_binary '',NULL),(462,'TO',_binary '',NULL),(463,'TT',_binary '',NULL),(464,'TN',_binary '',NULL),(465,'TR',_binary '',NULL),(466,'TM',_binary '',NULL),(467,'TC',_binary '',NULL),(468,'TV',_binary '',NULL),(469,'UG',_binary '',NULL),(470,'UA',_binary '',NULL),(471,'AE',_binary '',NULL),(472,'GB',_binary '',NULL),(473,'US',_binary '',NULL),(474,'UM',_binary '',NULL),(475,'UY',_binary '',NULL),(476,'UZ',_binary '',NULL),(477,'VU',_binary '',NULL),(478,'VE',_binary '',NULL),(479,'VN',_binary '',NULL),(480,'VG',_binary '',NULL),(481,'VI',_binary '',NULL),(482,'WF',_binary '',NULL),(483,'EH',_binary '',NULL),(484,'YE',_binary '',NULL),(485,'ZM',_binary '',NULL),(486,'ZW',_binary '',NULL);
/*!40000 ALTER TABLE `COUNTRY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COUNTRY_DESCRIPTION`
--

DROP TABLE IF EXISTS `COUNTRY_DESCRIPTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `COUNTRY_DESCRIPTION` (
  `DESCRIPTION_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `DESCRIPTION` longtext,
  `NAME` varchar(120) NOT NULL,
  `TITLE` varchar(100) DEFAULT NULL,
  `LANGUAGE_ID` int NOT NULL,
  `COUNTRY_ID` int NOT NULL,
  PRIMARY KEY (`DESCRIPTION_ID`),
  UNIQUE KEY `UKt7nshki1rbp6157ed0v6cx4y4` (`COUNTRY_ID`,`LANGUAGE_ID`),
  KEY `FKersrbjot9p9nfukxfd2l27c7t` (`LANGUAGE_ID`),
  CONSTRAINT `FKersrbjot9p9nfukxfd2l27c7t` FOREIGN KEY (`LANGUAGE_ID`) REFERENCES `LANGUAGE` (`LANGUAGE_ID`),
  CONSTRAINT `FKkd2sy7q97wr2ahvyiiqc4txji` FOREIGN KEY (`COUNTRY_ID`) REFERENCES `COUNTRY` (`COUNTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COUNTRY_DESCRIPTION`
--

LOCK TABLES `COUNTRY_DESCRIPTION` WRITE;
/*!40000 ALTER TABLE `COUNTRY_DESCRIPTION` DISABLE KEYS */;
INSERT INTO `COUNTRY_DESCRIPTION` VALUES (945,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'Afghanistan',NULL,50,250),(946,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'Afghanistan',NULL,51,250),(947,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'Afghanistan',NULL,52,250),(948,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'阿富汗',NULL,53,250),(949,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'Åland Islands',NULL,50,251),(950,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'Åland Islands',NULL,51,251),(951,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'Îles Åland',NULL,52,251),(952,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'奥兰群岛',NULL,53,251),(953,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'Albania',NULL,50,252),(954,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'Albania',NULL,51,252),(955,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'Albanie',NULL,52,252),(956,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'阿尔巴尼亚',NULL,53,252),(957,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'Algeria',NULL,50,253),(958,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'Algeria',NULL,51,253),(959,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'Algérie',NULL,52,253),(960,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'阿尔及利亚',NULL,53,253),(961,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'American Samoa',NULL,50,254),(962,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'American Samoa',NULL,51,254),(963,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'Samoa américaines',NULL,52,254),(964,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'美属萨摩亚',NULL,53,254),(965,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'Andorra',NULL,50,255),(966,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'Andorra',NULL,51,255),(967,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'Andorre',NULL,52,255),(968,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'安道尔',NULL,53,255),(969,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'Angola',NULL,50,256),(970,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'Angola',NULL,51,256),(971,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'Angola',NULL,52,256),(972,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'安哥拉',NULL,53,256),(973,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'Anguilla',NULL,50,257),(974,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'Anguilla',NULL,51,257),(975,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'Anguilla',NULL,52,257),(976,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,NULL,'安圭拉',NULL,53,257),(977,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'Antigua & Barbuda',NULL,50,258),(978,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'Antigua & Barbuda',NULL,51,258),(979,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'Antigua-et-Barbuda',NULL,52,258),(980,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'安提瓜和巴布达',NULL,53,258),(981,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'Argentina',NULL,50,259),(982,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'Argentina',NULL,51,259),(983,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'Argentine',NULL,52,259),(984,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'阿根廷',NULL,53,259),(985,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'Armenia',NULL,50,260),(986,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'Armenia',NULL,51,260),(987,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'Arménie',NULL,52,260),(988,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'亚美尼亚',NULL,53,260),(989,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'Aruba',NULL,50,261),(990,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'Aruba',NULL,51,261),(991,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'Aruba',NULL,52,261),(992,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'阿鲁巴',NULL,53,261),(993,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'Australia',NULL,50,262),(994,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'Australia',NULL,51,262),(995,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'Australie',NULL,52,262),(996,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'澳大利亚',NULL,53,262),(997,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'Austria',NULL,50,263),(998,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'Austria',NULL,51,263),(999,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'Autriche',NULL,52,263),(1000,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'奥地利',NULL,53,263),(1001,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'Azerbaijan',NULL,50,264),(1002,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'Azerbaijan',NULL,51,264),(1003,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'Azerbaïdjan',NULL,52,264),(1004,'2026-09-19 00:39:12','2026-09-19 00:39:12',NULL,NULL,'阿塞拜疆',NULL,53,264),(1005,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Bahamas',NULL,50,265),(1006,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Bahamas',NULL,51,265),(1007,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Bahamas',NULL,52,265),(1008,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'巴哈马',NULL,53,265),(1009,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Bahrain',NULL,50,266),(1010,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Bahrain',NULL,51,266),(1011,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Bahreïn',NULL,52,266),(1012,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'巴林',NULL,53,266),(1013,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Bangladesh',NULL,50,267),(1014,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Bangladesh',NULL,51,267),(1015,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Bangladesh',NULL,52,267),(1016,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'孟加拉国',NULL,53,267),(1017,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Barbados',NULL,50,268),(1018,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Barbados',NULL,51,268),(1019,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Barbade',NULL,52,268),(1020,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'巴巴多斯',NULL,53,268),(1021,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Belarus',NULL,50,269),(1022,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Belarus',NULL,51,269),(1023,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Biélorussie',NULL,52,269),(1024,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'白俄罗斯',NULL,53,269),(1025,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Belgium',NULL,50,270),(1026,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Belgium',NULL,51,270),(1027,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Belgique',NULL,52,270),(1028,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'比利时',NULL,53,270),(1029,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Belize',NULL,50,271),(1030,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Belize',NULL,51,271),(1031,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Belize',NULL,52,271),(1032,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'伯利兹',NULL,53,271),(1033,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Benin',NULL,50,272),(1034,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Benin',NULL,51,272),(1035,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Bénin',NULL,52,272),(1036,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'贝宁',NULL,53,272),(1037,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Bermuda',NULL,50,273),(1038,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Bermuda',NULL,51,273),(1039,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Bermudes',NULL,52,273),(1040,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'百慕大',NULL,53,273),(1041,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Bhutan',NULL,50,274),(1042,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Bhutan',NULL,51,274),(1043,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Bhoutan',NULL,52,274),(1044,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'不丹',NULL,53,274),(1045,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Bolivia',NULL,50,275),(1046,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Bolivia',NULL,51,275),(1047,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'Bolivie',NULL,52,275),(1048,'2026-09-19 00:39:13','2026-09-19 00:39:13',NULL,NULL,'玻利维亚',NULL,53,275),(1049,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'Bosnia & Herzegovina',NULL,50,276),(1050,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'Bosnia & Herzegovina',NULL,51,276),(1051,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'Bosnie-Herzégovine',NULL,52,276),(1052,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'波斯尼亚和黑塞哥维那',NULL,53,276),(1053,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'Botswana',NULL,50,277),(1054,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'Botswana',NULL,51,277),(1055,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'Botswana',NULL,52,277),(1056,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'博茨瓦纳',NULL,53,277),(1057,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'Brazil',NULL,50,278),(1058,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'Brazil',NULL,51,278),(1059,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'Brésil',NULL,52,278),(1060,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'巴西',NULL,53,278),(1061,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'British Indian Ocean Territory',NULL,50,279),(1062,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'British Indian Ocean Territory',NULL,51,279),(1063,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'Territoire britannique de l’océan Indien',NULL,52,279),(1064,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'英属印度洋领地',NULL,53,279),(1065,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'Brunei',NULL,50,280),(1066,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'Brunei',NULL,51,280),(1067,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'Brunéi Darussalam',NULL,52,280),(1068,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'文莱',NULL,53,280),(1069,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'Bulgaria',NULL,50,281),(1070,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'Bulgaria',NULL,51,281),(1071,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'Bulgarie',NULL,52,281),(1072,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'保加利亚',NULL,53,281),(1073,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'Burkina Faso',NULL,50,282),(1074,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'Burkina Faso',NULL,51,282),(1075,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'Burkina Faso',NULL,52,282),(1076,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'布基纳法索',NULL,53,282),(1077,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'Burundi',NULL,50,283),(1078,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'Burundi',NULL,51,283),(1079,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'Burundi',NULL,52,283),(1080,'2026-09-19 00:39:14','2026-09-19 00:39:14',NULL,NULL,'布隆迪',NULL,53,283),(1081,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Cambodia',NULL,50,284),(1082,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Cambodia',NULL,51,284),(1083,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Cambodge',NULL,52,284),(1084,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'柬埔寨',NULL,53,284),(1085,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Cameroon',NULL,50,285),(1086,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Cameroon',NULL,51,285),(1087,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Cameroun',NULL,52,285),(1088,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'喀麦隆',NULL,53,285),(1089,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Canada',NULL,50,286),(1090,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Canada',NULL,51,286),(1091,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Canada',NULL,52,286),(1092,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'加拿大',NULL,53,286),(1093,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Cape Verde',NULL,50,287),(1094,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Cape Verde',NULL,51,287),(1095,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Cap-Vert',NULL,52,287),(1096,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'佛得角',NULL,53,287),(1097,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Cayman Islands',NULL,50,288),(1098,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Cayman Islands',NULL,51,288),(1099,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Îles Caïmans',NULL,52,288),(1100,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'开曼群岛',NULL,53,288),(1101,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Central African Republic',NULL,50,289),(1102,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Central African Republic',NULL,51,289),(1103,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'République centrafricaine',NULL,52,289),(1104,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'中非共和国',NULL,53,289),(1105,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Chad',NULL,50,290),(1106,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Chad',NULL,51,290),(1107,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Tchad',NULL,52,290),(1108,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'乍得',NULL,53,290),(1109,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Chile',NULL,50,291),(1110,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Chile',NULL,51,291),(1111,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Chili',NULL,52,291),(1112,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'智利',NULL,53,291),(1113,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'China',NULL,50,292),(1114,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'China',NULL,51,292),(1115,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Chine',NULL,52,292),(1116,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'中国',NULL,53,292),(1117,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Christmas Island',NULL,50,293),(1118,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Christmas Island',NULL,51,293),(1119,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Île Christmas',NULL,52,293),(1120,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'圣诞岛',NULL,53,293),(1121,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Cocos (Keeling) Islands',NULL,50,294),(1122,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Cocos (Keeling) Islands',NULL,51,294),(1123,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'Îles Cocos',NULL,52,294),(1124,'2026-09-19 00:39:15','2026-09-19 00:39:15',NULL,NULL,'科科斯（基林）群岛',NULL,53,294),(1125,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Colombia',NULL,50,295),(1126,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Colombia',NULL,51,295),(1127,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Colombie',NULL,52,295),(1128,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'哥伦比亚',NULL,53,295),(1129,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Comoros',NULL,50,296),(1130,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Comoros',NULL,51,296),(1131,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Comores',NULL,52,296),(1132,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'科摩罗',NULL,53,296),(1133,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Congo - Brazzaville',NULL,50,297),(1134,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Congo - Brazzaville',NULL,51,297),(1135,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Congo-Brazzaville',NULL,52,297),(1136,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'刚果（布）',NULL,53,297),(1137,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Congo - Kinshasa',NULL,50,298),(1138,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Congo - Kinshasa',NULL,51,298),(1139,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Congo-Kinshasa',NULL,52,298),(1140,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'刚果（金）',NULL,53,298),(1141,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Cook Islands',NULL,50,299),(1142,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Cook Islands',NULL,51,299),(1143,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Îles Cook',NULL,52,299),(1144,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'库克群岛',NULL,53,299),(1145,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Costa Rica',NULL,50,300),(1146,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Costa Rica',NULL,51,300),(1147,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Costa Rica',NULL,52,300),(1148,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'哥斯达黎加',NULL,53,300),(1149,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Côte d’Ivoire',NULL,50,301),(1150,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Côte d’Ivoire',NULL,51,301),(1151,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Côte d’Ivoire',NULL,52,301),(1152,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'科特迪瓦',NULL,53,301),(1153,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Croatia',NULL,50,302),(1154,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Croatia',NULL,51,302),(1155,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Croatie',NULL,52,302),(1156,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'克罗地亚',NULL,53,302),(1157,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Cuba',NULL,50,303),(1158,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Cuba',NULL,51,303),(1159,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Cuba',NULL,52,303),(1160,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'古巴',NULL,53,303),(1161,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Cyprus',NULL,50,304),(1162,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Cyprus',NULL,51,304),(1163,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Chypre',NULL,52,304),(1164,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'塞浦路斯',NULL,53,304),(1165,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Czechia',NULL,50,305),(1166,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Czechia',NULL,51,305),(1167,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Tchéquie',NULL,52,305),(1168,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'捷克',NULL,53,305),(1169,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Denmark',NULL,50,306),(1170,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Denmark',NULL,51,306),(1171,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Danemark',NULL,52,306),(1172,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'丹麦',NULL,53,306),(1173,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Djibouti',NULL,50,307),(1174,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Djibouti',NULL,51,307),(1175,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Djibouti',NULL,52,307),(1176,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'吉布提',NULL,53,307),(1177,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Dominica',NULL,50,308),(1178,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Dominica',NULL,51,308),(1179,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Dominique',NULL,52,308),(1180,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'多米尼克',NULL,53,308),(1181,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Dominican Republic',NULL,50,309),(1182,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'Dominican Republic',NULL,51,309),(1183,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'République dominicaine',NULL,52,309),(1184,'2026-09-19 00:39:16','2026-09-19 00:39:16',NULL,NULL,'多米尼加共和国',NULL,53,309),(1185,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Ecuador',NULL,50,310),(1186,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Ecuador',NULL,51,310),(1187,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Équateur',NULL,52,310),(1188,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'厄瓜多尔',NULL,53,310),(1189,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Egypt',NULL,50,311),(1190,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Egypt',NULL,51,311),(1191,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Égypte',NULL,52,311),(1192,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'埃及',NULL,53,311),(1193,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'El Salvador',NULL,50,312),(1194,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'El Salvador',NULL,51,312),(1195,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Salvador',NULL,52,312),(1196,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'萨尔瓦多',NULL,53,312),(1197,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Equatorial Guinea',NULL,50,313),(1198,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Equatorial Guinea',NULL,51,313),(1199,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Guinée équatoriale',NULL,52,313),(1200,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'赤道几内亚',NULL,53,313),(1201,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Eritrea',NULL,50,314),(1202,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Eritrea',NULL,51,314),(1203,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Érythrée',NULL,52,314),(1204,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'厄立特里亚',NULL,53,314),(1205,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Estonia',NULL,50,315),(1206,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Estonia',NULL,51,315),(1207,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Estonie',NULL,52,315),(1208,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'爱沙尼亚',NULL,53,315),(1209,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Ethiopia',NULL,50,316),(1210,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Ethiopia',NULL,51,316),(1211,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Éthiopie',NULL,52,316),(1212,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'埃塞俄比亚',NULL,53,316),(1213,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Falkland Islands',NULL,50,317),(1214,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Falkland Islands',NULL,51,317),(1215,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Îles Malouines',NULL,52,317),(1216,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'福克兰群岛',NULL,53,317),(1217,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Faroe Islands',NULL,50,318),(1218,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Faroe Islands',NULL,51,318),(1219,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Îles Féroé',NULL,52,318),(1220,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'法罗群岛',NULL,53,318),(1221,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Fiji',NULL,50,319),(1222,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Fiji',NULL,51,319),(1223,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Fidji',NULL,52,319),(1224,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'斐济',NULL,53,319),(1225,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Finland',NULL,50,320),(1226,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Finland',NULL,51,320),(1227,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Finlande',NULL,52,320),(1228,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'芬兰',NULL,53,320),(1229,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'France',NULL,50,321),(1230,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'France',NULL,51,321),(1231,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'France',NULL,52,321),(1232,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'法国',NULL,53,321),(1233,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'French Guiana',NULL,50,322),(1234,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'French Guiana',NULL,51,322),(1235,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'Guyane française',NULL,52,322),(1236,'2026-09-19 00:39:17','2026-09-19 00:39:17',NULL,NULL,'法属圭亚那',NULL,53,322),(1237,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'French Polynesia',NULL,50,323),(1238,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'French Polynesia',NULL,51,323),(1239,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Polynésie française',NULL,52,323),(1240,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'法属波利尼西亚',NULL,53,323),(1241,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Gabon',NULL,50,324),(1242,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Gabon',NULL,51,324),(1243,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Gabon',NULL,52,324),(1244,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'加蓬',NULL,53,324),(1245,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Gambia',NULL,50,325),(1246,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Gambia',NULL,51,325),(1247,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Gambie',NULL,52,325),(1248,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'冈比亚',NULL,53,325),(1249,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Georgia',NULL,50,326),(1250,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Georgia',NULL,51,326),(1251,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Géorgie',NULL,52,326),(1252,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'格鲁吉亚',NULL,53,326),(1253,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Germany',NULL,50,327),(1254,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Germany',NULL,51,327),(1255,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Allemagne',NULL,52,327),(1256,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'德国',NULL,53,327),(1257,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Ghana',NULL,50,328),(1258,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Ghana',NULL,51,328),(1259,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Ghana',NULL,52,328),(1260,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'加纳',NULL,53,328),(1261,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Gibraltar',NULL,50,329),(1262,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Gibraltar',NULL,51,329),(1263,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Gibraltar',NULL,52,329),(1264,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'直布罗陀',NULL,53,329),(1265,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Greece',NULL,50,330),(1266,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Greece',NULL,51,330),(1267,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Grèce',NULL,52,330),(1268,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'希腊',NULL,53,330),(1269,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Greenland',NULL,50,331),(1270,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Greenland',NULL,51,331),(1271,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Groenland',NULL,52,331),(1272,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'格陵兰',NULL,53,331),(1273,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Grenada',NULL,50,332),(1274,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Grenada',NULL,51,332),(1275,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Grenade',NULL,52,332),(1276,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'格林纳达',NULL,53,332),(1277,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Guadeloupe',NULL,50,333),(1278,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Guadeloupe',NULL,51,333),(1279,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Guadeloupe',NULL,52,333),(1280,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'瓜德罗普',NULL,53,333),(1281,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Guam',NULL,50,334),(1282,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Guam',NULL,51,334),(1283,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Guam',NULL,52,334),(1284,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'关岛',NULL,53,334),(1285,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Guatemala',NULL,50,335),(1286,'2026-09-19 00:39:18','2026-09-19 00:39:18',NULL,NULL,'Guatemala',NULL,51,335),(1287,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Guatemala',NULL,52,335),(1288,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'危地马拉',NULL,53,335),(1289,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Guernsey',NULL,50,336),(1290,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Guernsey',NULL,51,336),(1291,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Guernesey',NULL,52,336),(1292,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'根西岛',NULL,53,336),(1293,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Guinea',NULL,50,337),(1294,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Guinea',NULL,51,337),(1295,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Guinée',NULL,52,337),(1296,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'几内亚',NULL,53,337),(1297,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Guinea-Bissau',NULL,50,338),(1298,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Guinea-Bissau',NULL,51,338),(1299,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Guinée-Bissau',NULL,52,338),(1300,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'几内亚比绍',NULL,53,338),(1301,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Guyana',NULL,50,339),(1302,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Guyana',NULL,51,339),(1303,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Guyana',NULL,52,339),(1304,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'圭亚那',NULL,53,339),(1305,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Haiti',NULL,50,340),(1306,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Haiti',NULL,51,340),(1307,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Haïti',NULL,52,340),(1308,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'海地',NULL,53,340),(1309,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Vatican City',NULL,50,341),(1310,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Vatican City',NULL,51,341),(1311,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'État de la Cité du Vatican',NULL,52,341),(1312,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'梵蒂冈',NULL,53,341),(1313,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Honduras',NULL,50,342),(1314,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Honduras',NULL,51,342),(1315,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Honduras',NULL,52,342),(1316,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'洪都拉斯',NULL,53,342),(1317,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Hong Kong SAR China',NULL,50,343),(1318,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Hong Kong SAR China',NULL,51,343),(1319,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'R.A.S. chinoise de Hong Kong',NULL,52,343),(1320,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'中国香港特别行政区',NULL,53,343),(1321,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Hungary',NULL,50,344),(1322,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Hungary',NULL,51,344),(1323,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Hongrie',NULL,52,344),(1324,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'匈牙利',NULL,53,344),(1325,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Iceland',NULL,50,345),(1326,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Iceland',NULL,51,345),(1327,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Islande',NULL,52,345),(1328,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'冰岛',NULL,53,345),(1329,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'India',NULL,50,346),(1330,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'India',NULL,51,346),(1331,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Inde',NULL,52,346),(1332,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'印度',NULL,53,346),(1333,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Indonesia',NULL,50,347),(1334,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Indonesia',NULL,51,347),(1335,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Indonésie',NULL,52,347),(1336,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'印度尼西亚',NULL,53,347),(1337,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Iran',NULL,50,348),(1338,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Iran',NULL,51,348),(1339,'2026-09-19 00:39:19','2026-09-19 00:39:19',NULL,NULL,'Iran',NULL,52,348),(1340,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'伊朗',NULL,53,348),(1341,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Iraq',NULL,50,349),(1342,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Iraq',NULL,51,349),(1343,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Irak',NULL,52,349),(1344,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'伊拉克',NULL,53,349),(1345,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Ireland',NULL,50,350),(1346,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Ireland',NULL,51,350),(1347,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Irlande',NULL,52,350),(1348,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'爱尔兰',NULL,53,350),(1349,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Isle of Man',NULL,50,351),(1350,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Isle of Man',NULL,51,351),(1351,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Île de Man',NULL,52,351),(1352,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'马恩岛',NULL,53,351),(1353,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Israel',NULL,50,352),(1354,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Israel',NULL,51,352),(1355,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Israël',NULL,52,352),(1356,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'以色列',NULL,53,352),(1357,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Italy',NULL,50,353),(1358,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Italy',NULL,51,353),(1359,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Italie',NULL,52,353),(1360,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'意大利',NULL,53,353),(1361,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Jamaica',NULL,50,354),(1362,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Jamaica',NULL,51,354),(1363,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Jamaïque',NULL,52,354),(1364,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'牙买加',NULL,53,354),(1365,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Japan',NULL,50,355),(1366,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Japan',NULL,51,355),(1367,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Japon',NULL,52,355),(1368,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'日本',NULL,53,355),(1369,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Jersey',NULL,50,356),(1370,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Jersey',NULL,51,356),(1371,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Jersey',NULL,52,356),(1372,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'泽西岛',NULL,53,356),(1373,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Jordan',NULL,50,357),(1374,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Jordan',NULL,51,357),(1375,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Jordanie',NULL,52,357),(1376,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'约旦',NULL,53,357),(1377,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Kazakhstan',NULL,50,358),(1378,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Kazakhstan',NULL,51,358),(1379,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Kazakhstan',NULL,52,358),(1380,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'哈萨克斯坦',NULL,53,358),(1381,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Kenya',NULL,50,359),(1382,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Kenya',NULL,51,359),(1383,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Kenya',NULL,52,359),(1384,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'肯尼亚',NULL,53,359),(1385,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Kiribati',NULL,50,360),(1386,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Kiribati',NULL,51,360),(1387,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Kiribati',NULL,52,360),(1388,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'基里巴斯',NULL,53,360),(1389,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'North Korea',NULL,50,361),(1390,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'North Korea',NULL,51,361),(1391,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'Corée du Nord',NULL,52,361),(1392,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'朝鲜',NULL,53,361),(1393,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'South Korea',NULL,50,362),(1394,'2026-09-19 00:39:20','2026-09-19 00:39:20',NULL,NULL,'South Korea',NULL,51,362),(1395,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Corée du Sud',NULL,52,362),(1396,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'韩国',NULL,53,362),(1397,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Kuwait',NULL,50,363),(1398,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Kuwait',NULL,51,363),(1399,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Koweït',NULL,52,363),(1400,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'科威特',NULL,53,363),(1401,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Kyrgyzstan',NULL,50,364),(1402,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Kyrgyzstan',NULL,51,364),(1403,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Kirghizistan',NULL,52,364),(1404,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'吉尔吉斯斯坦',NULL,53,364),(1405,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Laos',NULL,50,365),(1406,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Laos',NULL,51,365),(1407,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Laos',NULL,52,365),(1408,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'老挝',NULL,53,365),(1409,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Latvia',NULL,50,366),(1410,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Latvia',NULL,51,366),(1411,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Lettonie',NULL,52,366),(1412,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'拉脱维亚',NULL,53,366),(1413,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Lebanon',NULL,50,367),(1414,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Lebanon',NULL,51,367),(1415,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Liban',NULL,52,367),(1416,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'黎巴嫩',NULL,53,367),(1417,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Lesotho',NULL,50,368),(1418,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Lesotho',NULL,51,368),(1419,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Lesotho',NULL,52,368),(1420,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'莱索托',NULL,53,368),(1421,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Liberia',NULL,50,369),(1422,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Liberia',NULL,51,369),(1423,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Libéria',NULL,52,369),(1424,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'利比里亚',NULL,53,369),(1425,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Libya',NULL,50,370),(1426,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Libya',NULL,51,370),(1427,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Libye',NULL,52,370),(1428,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'利比亚',NULL,53,370),(1429,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Liechtenstein',NULL,50,371),(1430,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Liechtenstein',NULL,51,371),(1431,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Liechtenstein',NULL,52,371),(1432,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'列支敦士登',NULL,53,371),(1433,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Lithuania',NULL,50,372),(1434,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Lithuania',NULL,51,372),(1435,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Lituanie',NULL,52,372),(1436,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'立陶宛',NULL,53,372),(1437,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Luxembourg',NULL,50,373),(1438,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Luxembourg',NULL,51,373),(1439,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Luxembourg',NULL,52,373),(1440,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'卢森堡',NULL,53,373),(1441,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Macao SAR China',NULL,50,374),(1442,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Macau SAR China',NULL,51,374),(1443,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'R.A.S. chinoise de Macao',NULL,52,374),(1444,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'中国澳门特别行政区',NULL,53,374),(1445,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'North Macedonia',NULL,50,375),(1446,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Macedonia',NULL,51,375),(1447,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Macédoine',NULL,52,375),(1448,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'马其顿',NULL,53,375),(1449,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Madagascar',NULL,50,376),(1450,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Madagascar',NULL,51,376),(1451,'2026-09-19 00:39:21','2026-09-19 00:39:21',NULL,NULL,'Madagascar',NULL,52,376),(1452,'2026-09-19 00:39:22','2026-09-19 00:39:22',NULL,NULL,'马达加斯加',NULL,53,376),(1453,'2026-09-19 00:39:22','2026-09-19 00:39:22',NULL,NULL,'Malawi',NULL,50,377),(1454,'2026-09-19 00:39:22','2026-09-19 00:39:22',NULL,NULL,'Malawi',NULL,51,377),(1455,'2026-09-19 00:39:22','2026-09-19 00:39:22',NULL,NULL,'Malawi',NULL,52,377),(1456,'2026-09-19 00:39:22','2026-09-19 00:39:22',NULL,NULL,'马拉维',NULL,53,377),(1457,'2026-09-19 00:39:22','2026-09-19 00:39:22',NULL,NULL,'Malaysia',NULL,50,378),(1458,'2026-09-19 00:39:22','2026-09-19 00:39:22',NULL,NULL,'Malaysia',NULL,51,378),(1459,'2026-09-19 00:39:22','2026-09-19 00:39:22',NULL,NULL,'Malaisie',NULL,52,378),(1460,'2026-09-19 00:39:22','2026-09-19 00:39:22',NULL,NULL,'马来西亚',NULL,53,378),(1461,'2026-09-19 00:39:22','2026-09-19 00:39:22',NULL,NULL,'Mali',NULL,50,379),(1462,'2026-09-19 00:39:22','2026-09-19 00:39:22',NULL,NULL,'Mali',NULL,51,379),(1463,'2026-09-19 00:39:22','2026-09-19 00:39:22',NULL,NULL,'Mali',NULL,52,379),(1464,'2026-09-19 00:39:22','2026-09-19 00:39:22',NULL,NULL,'马里',NULL,53,379),(1465,'2026-09-19 00:39:22','2026-09-19 00:39:22',NULL,NULL,'Malta',NULL,50,380),(1466,'2026-09-19 00:39:22','2026-09-19 00:39:22',NULL,NULL,'Malta',NULL,51,380),(1467,'2026-09-19 00:39:22','2026-09-19 00:39:22',NULL,NULL,'Malte',NULL,52,380),(1468,'2026-09-19 00:39:22','2026-09-19 00:39:22',NULL,NULL,'马耳他',NULL,53,380),(1469,'2026-09-19 00:39:22','2026-09-19 00:39:22',NULL,NULL,'Marshall Islands',NULL,50,381),(1470,'2026-09-19 00:39:22','2026-09-19 00:39:22',NULL,NULL,'Marshall Islands',NULL,51,381),(1471,'2026-09-19 00:39:22','2026-09-19 00:39:22',NULL,NULL,'Îles Marshall',NULL,52,381),(1472,'2026-09-19 00:39:22','2026-09-19 00:39:22',NULL,NULL,'马绍尔群岛',NULL,53,381),(1473,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'Martinique',NULL,50,382),(1474,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'Martinique',NULL,51,382),(1475,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'Martinique',NULL,52,382),(1476,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'马提尼克',NULL,53,382),(1477,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'Mauritania',NULL,50,383),(1478,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'Mauritania',NULL,51,383),(1479,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'Mauritanie',NULL,52,383),(1480,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'毛里塔尼亚',NULL,53,383),(1481,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'Mauritius',NULL,50,384),(1482,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'Mauritius',NULL,51,384),(1483,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'Maurice',NULL,52,384),(1484,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'毛里求斯',NULL,53,384),(1485,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'Mayotte',NULL,50,385),(1486,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'Mayotte',NULL,51,385),(1487,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'Mayotte',NULL,52,385),(1488,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'马约特',NULL,53,385),(1489,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'Mexico',NULL,50,386),(1490,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'Mexico',NULL,51,386),(1491,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'Mexique',NULL,52,386),(1492,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'墨西哥',NULL,53,386),(1493,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'Micronesia',NULL,50,387),(1494,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'Micronesia',NULL,51,387),(1495,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'États fédérés de Micronésie',NULL,52,387),(1496,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'密克罗尼西亚',NULL,53,387),(1497,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'Moldova',NULL,50,388),(1498,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'Moldova',NULL,51,388),(1499,'2026-09-19 00:39:23','2026-09-19 00:39:23',NULL,NULL,'Moldavie',NULL,52,388),(1500,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'摩尔多瓦',NULL,53,388),(1501,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Monaco',NULL,50,389),(1502,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Monaco',NULL,51,389),(1503,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Monaco',NULL,52,389),(1504,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'摩纳哥',NULL,53,389),(1505,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Mongolia',NULL,50,390),(1506,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Mongolia',NULL,51,390),(1507,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Mongolie',NULL,52,390),(1508,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'蒙古',NULL,53,390),(1509,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Montenegro',NULL,50,391),(1510,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Montenegro',NULL,51,391),(1511,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Monténégro',NULL,52,391),(1512,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'黑山',NULL,53,391),(1513,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Montserrat',NULL,50,392),(1514,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Montserrat',NULL,51,392),(1515,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Montserrat',NULL,52,392),(1516,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'蒙特塞拉特',NULL,53,392),(1517,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Morocco',NULL,50,393),(1518,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Morocco',NULL,51,393),(1519,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Maroc',NULL,52,393),(1520,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'摩洛哥',NULL,53,393),(1521,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Mozambique',NULL,50,394),(1522,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Mozambique',NULL,51,394),(1523,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Mozambique',NULL,52,394),(1524,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'莫桑比克',NULL,53,394),(1525,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Myanmar (Burma)',NULL,50,395),(1526,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Myanmar (Burma)',NULL,51,395),(1527,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Myanmar (Birmanie)',NULL,52,395),(1528,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'缅甸',NULL,53,395),(1529,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Namibia',NULL,50,396),(1530,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Namibia',NULL,51,396),(1531,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Namibie',NULL,52,396),(1532,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'纳米比亚',NULL,53,396),(1533,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Nauru',NULL,50,397),(1534,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Nauru',NULL,51,397),(1535,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Nauru',NULL,52,397),(1536,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'瑙鲁',NULL,53,397),(1537,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Nepal',NULL,50,398),(1538,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Nepal',NULL,51,398),(1539,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Népal',NULL,52,398),(1540,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'尼泊尔',NULL,53,398),(1541,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Netherlands',NULL,50,399),(1542,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Netherlands',NULL,51,399),(1543,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Pays-Bas',NULL,52,399),(1544,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'荷兰',NULL,53,399),(1545,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'New Caledonia',NULL,50,400),(1546,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'New Caledonia',NULL,51,400),(1547,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Nouvelle-Calédonie',NULL,52,400),(1548,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'新喀里多尼亚',NULL,53,400),(1549,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'New Zealand',NULL,50,401),(1550,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'New Zealand',NULL,51,401),(1551,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'Nouvelle-Zélande',NULL,52,401),(1552,'2026-09-19 00:39:24','2026-09-19 00:39:24',NULL,NULL,'新西兰',NULL,53,401),(1553,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'Nicaragua',NULL,50,402),(1554,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'Nicaragua',NULL,51,402),(1555,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'Nicaragua',NULL,52,402),(1556,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'尼加拉瓜',NULL,53,402),(1557,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'Niger',NULL,50,403),(1558,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'Niger',NULL,51,403),(1559,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'Niger',NULL,52,403),(1560,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'尼日尔',NULL,53,403),(1561,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'Nigeria',NULL,50,404),(1562,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'Nigeria',NULL,51,404),(1563,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'Nigéria',NULL,52,404),(1564,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'尼日利亚',NULL,53,404),(1565,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'Niue',NULL,50,405),(1566,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'Niue',NULL,51,405),(1567,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'Niue',NULL,52,405),(1568,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'纽埃',NULL,53,405),(1569,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'Norfolk Island',NULL,50,406),(1570,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'Norfolk Island',NULL,51,406),(1571,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'Île Norfolk',NULL,52,406),(1572,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'诺福克岛',NULL,53,406),(1573,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'Northern Mariana Islands',NULL,50,407),(1574,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'Northern Mariana Islands',NULL,51,407),(1575,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'Îles Mariannes du Nord',NULL,52,407),(1576,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'北马里亚纳群岛',NULL,53,407),(1577,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'Norway',NULL,50,408),(1578,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'Norway',NULL,51,408),(1579,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'Norvège',NULL,52,408),(1580,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'挪威',NULL,53,408),(1581,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'Oman',NULL,50,409),(1582,'2026-09-19 00:39:25','2026-09-19 00:39:25',NULL,NULL,'Oman',NULL,51,409),(1583,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Oman',NULL,52,409),(1584,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'阿曼',NULL,53,409),(1585,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Pakistan',NULL,50,410),(1586,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Pakistan',NULL,51,410),(1587,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Pakistan',NULL,52,410),(1588,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'巴基斯坦',NULL,53,410),(1589,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Palau',NULL,50,411),(1590,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Palau',NULL,51,411),(1591,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Palaos',NULL,52,411),(1592,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'帕劳',NULL,53,411),(1593,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Palestinian Territories',NULL,50,412),(1594,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Palestinian Territories',NULL,51,412),(1595,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Territoires palestiniens',NULL,52,412),(1596,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'巴勒斯坦领土',NULL,53,412),(1597,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Panama',NULL,50,413),(1598,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Panama',NULL,51,413),(1599,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Panama',NULL,52,413),(1600,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'巴拿马',NULL,53,413),(1601,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Papua New Guinea',NULL,50,414),(1602,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Papua New Guinea',NULL,51,414),(1603,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Papouasie-Nouvelle-Guinée',NULL,52,414),(1604,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'巴布亚新几内亚',NULL,53,414),(1605,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Paraguay',NULL,50,415),(1606,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Paraguay',NULL,51,415),(1607,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Paraguay',NULL,52,415),(1608,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'巴拉圭',NULL,53,415),(1609,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Peru',NULL,50,416),(1610,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Peru',NULL,51,416),(1611,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Pérou',NULL,52,416),(1612,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'秘鲁',NULL,53,416),(1613,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Philippines',NULL,50,417),(1614,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Philippines',NULL,51,417),(1615,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Philippines',NULL,52,417),(1616,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'菲律宾',NULL,53,417),(1617,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Pitcairn Islands',NULL,50,418),(1618,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Pitcairn Islands',NULL,51,418),(1619,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Îles Pitcairn',NULL,52,418),(1620,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'皮特凯恩群岛',NULL,53,418),(1621,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Poland',NULL,50,419),(1622,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Poland',NULL,51,419),(1623,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Pologne',NULL,52,419),(1624,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'波兰',NULL,53,419),(1625,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Portugal',NULL,50,420),(1626,'2026-09-19 00:39:26','2026-09-19 00:39:26',NULL,NULL,'Portugal',NULL,51,420),(1627,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'Portugal',NULL,52,420),(1628,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'葡萄牙',NULL,53,420),(1629,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'Puerto Rico',NULL,50,421),(1630,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'Puerto Rico',NULL,51,421),(1631,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'Porto Rico',NULL,52,421),(1632,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'波多黎各',NULL,53,421),(1633,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'Qatar',NULL,50,422),(1634,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'Qatar',NULL,51,422),(1635,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'Qatar',NULL,52,422),(1636,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'卡塔尔',NULL,53,422),(1637,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'Réunion',NULL,50,423),(1638,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'Réunion',NULL,51,423),(1639,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'La Réunion',NULL,52,423),(1640,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'留尼汪',NULL,53,423),(1641,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'Romania',NULL,50,424),(1642,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'Romania',NULL,51,424),(1643,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'Roumanie',NULL,52,424),(1644,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'罗马尼亚',NULL,53,424),(1645,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'Russia',NULL,50,425),(1646,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'Russia',NULL,51,425),(1647,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'Russie',NULL,52,425),(1648,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'俄罗斯',NULL,53,425),(1649,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'Rwanda',NULL,50,426),(1650,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'Rwanda',NULL,51,426),(1651,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'Rwanda',NULL,52,426),(1652,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'卢旺达',NULL,53,426),(1653,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'St. Helena',NULL,50,427),(1654,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'St. Helena',NULL,51,427),(1655,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'Sainte-Hélène',NULL,52,427),(1656,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'圣赫勒拿',NULL,53,427),(1657,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'St. Kitts & Nevis',NULL,50,428),(1658,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'St. Kitts & Nevis',NULL,51,428),(1659,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'Saint-Christophe-et-Niévès',NULL,52,428),(1660,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'圣基茨和尼维斯',NULL,53,428),(1661,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'St. Lucia',NULL,50,429),(1662,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'St. Lucia',NULL,51,429),(1663,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'Sainte-Lucie',NULL,52,429),(1664,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'圣卢西亚',NULL,53,429),(1665,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'St. Pierre & Miquelon',NULL,50,430),(1666,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'St. Pierre & Miquelon',NULL,51,430),(1667,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'Saint-Pierre-et-Miquelon',NULL,52,430),(1668,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'圣皮埃尔和密克隆群岛',NULL,53,430),(1669,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'St. Vincent & Grenadines',NULL,50,431),(1670,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'St. Vincent & Grenadines',NULL,51,431),(1671,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'Saint-Vincent-et-les-Grenadines',NULL,52,431),(1672,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'圣文森特和格林纳丁斯',NULL,53,431),(1673,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'Samoa',NULL,50,432),(1674,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'Samoa',NULL,51,432),(1675,'2026-09-19 00:39:27','2026-09-19 00:39:27',NULL,NULL,'Samoa',NULL,52,432),(1676,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'萨摩亚',NULL,53,432),(1677,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'San Marino',NULL,50,433),(1678,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'San Marino',NULL,51,433),(1679,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'Saint-Marin',NULL,52,433),(1680,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'圣马力诺',NULL,53,433),(1681,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'São Tomé & Príncipe',NULL,50,434),(1682,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'São Tomé & Príncipe',NULL,51,434),(1683,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'Sao Tomé-et-Principe',NULL,52,434),(1684,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'圣多美和普林西比',NULL,53,434),(1685,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'Saudi Arabia',NULL,50,435),(1686,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'Saudi Arabia',NULL,51,435),(1687,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'Arabie saoudite',NULL,52,435),(1688,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'沙特阿拉伯',NULL,53,435),(1689,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'Senegal',NULL,50,436),(1690,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'Senegal',NULL,51,436),(1691,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'Sénégal',NULL,52,436),(1692,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'塞内加尔',NULL,53,436),(1693,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'Serbia',NULL,50,437),(1694,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'Serbia',NULL,51,437),(1695,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'Serbie',NULL,52,437),(1696,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'塞尔维亚',NULL,53,437),(1697,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'Seychelles',NULL,50,438),(1698,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'Seychelles',NULL,51,438),(1699,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'Seychelles',NULL,52,438),(1700,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'塞舌尔',NULL,53,438),(1701,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'Sierra Leone',NULL,50,439),(1702,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'Sierra Leone',NULL,51,439),(1703,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'Sierra Leone',NULL,52,439),(1704,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'塞拉利昂',NULL,53,439),(1705,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'Singapore',NULL,50,440),(1706,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'Singapore',NULL,51,440),(1707,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'Singapour',NULL,52,440),(1708,'2026-09-19 00:39:28','2026-09-19 00:39:28',NULL,NULL,'新加坡',NULL,53,440),(1709,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'Slovakia',NULL,50,441),(1710,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'Slovakia',NULL,51,441),(1711,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'Slovaquie',NULL,52,441),(1712,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'斯洛伐克',NULL,53,441),(1713,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'Slovenia',NULL,50,442),(1714,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'Slovenia',NULL,51,442),(1715,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'Slovénie',NULL,52,442),(1716,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'斯洛文尼亚',NULL,53,442),(1717,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'Solomon Islands',NULL,50,443),(1718,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'Solomon Islands',NULL,51,443),(1719,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'Îles Salomon',NULL,52,443),(1720,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'所罗门群岛',NULL,53,443),(1721,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'Somalia',NULL,50,444),(1722,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'Somalia',NULL,51,444),(1723,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'Somalie',NULL,52,444),(1724,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'索马里',NULL,53,444),(1725,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'South Africa',NULL,50,445),(1726,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'South Africa',NULL,51,445),(1727,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'Afrique du Sud',NULL,52,445),(1728,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'南非',NULL,53,445),(1729,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'Spain',NULL,50,446),(1730,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'Spain',NULL,51,446),(1731,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'Espagne',NULL,52,446),(1732,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'西班牙',NULL,53,446),(1733,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'Sri Lanka',NULL,50,447),(1734,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'Sri Lanka',NULL,51,447),(1735,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'Sri Lanka',NULL,52,447),(1736,'2026-09-19 00:39:29','2026-09-19 00:39:29',NULL,NULL,'斯里兰卡',NULL,53,447),(1737,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Sudan',NULL,50,448),(1738,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Sudan',NULL,51,448),(1739,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Soudan',NULL,52,448),(1740,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'苏丹',NULL,53,448),(1741,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Suriname',NULL,50,449),(1742,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Suriname',NULL,51,449),(1743,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Suriname',NULL,52,449),(1744,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'苏里南',NULL,53,449),(1745,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Svalbard & Jan Mayen',NULL,50,450),(1746,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Svalbard & Jan Mayen',NULL,51,450),(1747,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Svalbard et Jan Mayen',NULL,52,450),(1748,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'斯瓦尔巴和扬马延',NULL,53,450),(1749,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Eswatini',NULL,50,451),(1750,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Swaziland',NULL,51,451),(1751,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Swaziland',NULL,52,451),(1752,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'斯威士兰',NULL,53,451),(1753,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Sweden',NULL,50,452),(1754,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Sweden',NULL,51,452),(1755,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Suède',NULL,52,452),(1756,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'瑞典',NULL,53,452),(1757,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Switzerland',NULL,50,453),(1758,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Switzerland',NULL,51,453),(1759,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Suisse',NULL,52,453),(1760,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'瑞士',NULL,53,453),(1761,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Syria',NULL,50,454),(1762,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Syria',NULL,51,454),(1763,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Syrie',NULL,52,454),(1764,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'叙利亚',NULL,53,454),(1765,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Taiwan',NULL,50,455),(1766,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Taiwan',NULL,51,455),(1767,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Taïwan',NULL,52,455),(1768,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'台湾',NULL,53,455),(1769,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Tajikistan',NULL,50,456),(1770,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Tajikistan',NULL,51,456),(1771,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Tadjikistan',NULL,52,456),(1772,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'塔吉克斯坦',NULL,53,456),(1773,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Tanzania',NULL,50,457),(1774,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Tanzania',NULL,51,457),(1775,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Tanzanie',NULL,52,457),(1776,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'坦桑尼亚',NULL,53,457),(1777,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Thailand',NULL,50,458),(1778,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Thailand',NULL,51,458),(1779,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Thaïlande',NULL,52,458),(1780,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'泰国',NULL,53,458),(1781,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Timor-Leste',NULL,50,459),(1782,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Timor-Leste',NULL,51,459),(1783,'2026-09-19 00:39:30','2026-09-19 00:39:30',NULL,NULL,'Timor oriental',NULL,52,459),(1784,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'东帝汶',NULL,53,459),(1785,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Togo',NULL,50,460),(1786,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Togo',NULL,51,460),(1787,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Togo',NULL,52,460),(1788,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'多哥',NULL,53,460),(1789,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Tokelau',NULL,50,461),(1790,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Tokelau',NULL,51,461),(1791,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Tokélaou',NULL,52,461),(1792,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'托克劳',NULL,53,461),(1793,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Tonga',NULL,50,462),(1794,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Tonga',NULL,51,462),(1795,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Tonga',NULL,52,462),(1796,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'汤加',NULL,53,462),(1797,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Trinidad & Tobago',NULL,50,463),(1798,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Trinidad & Tobago',NULL,51,463),(1799,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Trinité-et-Tobago',NULL,52,463),(1800,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'特立尼达和多巴哥',NULL,53,463),(1801,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Tunisia',NULL,50,464),(1802,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Tunisia',NULL,51,464),(1803,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Tunisie',NULL,52,464),(1804,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'突尼斯',NULL,53,464),(1805,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Turkey',NULL,50,465),(1806,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Turkey',NULL,51,465),(1807,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Turquie',NULL,52,465),(1808,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'土耳其',NULL,53,465),(1809,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Turkmenistan',NULL,50,466),(1810,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Turkmenistan',NULL,51,466),(1811,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Turkménistan',NULL,52,466),(1812,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'土库曼斯坦',NULL,53,466),(1813,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Turks & Caicos Islands',NULL,50,467),(1814,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Turks & Caicos Islands',NULL,51,467),(1815,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Îles Turques-et-Caïques',NULL,52,467),(1816,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'特克斯和凯科斯群岛',NULL,53,467),(1817,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Tuvalu',NULL,50,468),(1818,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Tuvalu',NULL,51,468),(1819,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Tuvalu',NULL,52,468),(1820,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'图瓦卢',NULL,53,468),(1821,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Uganda',NULL,50,469),(1822,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Uganda',NULL,51,469),(1823,'2026-09-19 00:39:31','2026-09-19 00:39:31',NULL,NULL,'Ouganda',NULL,52,469),(1824,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'乌干达',NULL,53,469),(1825,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'Ukraine',NULL,50,470),(1826,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'Ukraine',NULL,51,470),(1827,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'Ukraine',NULL,52,470),(1828,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'乌克兰',NULL,53,470),(1829,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'United Arab Emirates',NULL,50,471),(1830,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'United Arab Emirates',NULL,51,471),(1831,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'Émirats arabes unis',NULL,52,471),(1832,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'阿拉伯联合酋长国',NULL,53,471),(1833,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'United Kingdom',NULL,50,472),(1834,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'United Kingdom',NULL,51,472),(1835,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'Royaume-Uni',NULL,52,472),(1836,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'英国',NULL,53,472),(1837,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'United States',NULL,50,473),(1838,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'United States',NULL,51,473),(1839,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'États-Unis',NULL,52,473),(1840,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'美国',NULL,53,473),(1841,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'U.S. Outlying Islands',NULL,50,474),(1842,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'U.S. Outlying Islands',NULL,51,474),(1843,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'Îles mineures éloignées des États-Unis',NULL,52,474),(1844,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'美国本土外小岛屿',NULL,53,474),(1845,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'Uruguay',NULL,50,475),(1846,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'Uruguay',NULL,51,475),(1847,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'Uruguay',NULL,52,475),(1848,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'乌拉圭',NULL,53,475),(1849,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'Uzbekistan',NULL,50,476),(1850,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'Uzbekistan',NULL,51,476),(1851,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'Ouzbékistan',NULL,52,476),(1852,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'乌兹别克斯坦',NULL,53,476),(1853,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'Vanuatu',NULL,50,477),(1854,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'Vanuatu',NULL,51,477),(1855,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'Vanuatu',NULL,52,477),(1856,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'瓦努阿图',NULL,53,477),(1857,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'Venezuela',NULL,50,478),(1858,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'Venezuela',NULL,51,478),(1859,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'Venezuela',NULL,52,478),(1860,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'委内瑞拉',NULL,53,478),(1861,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'Vietnam',NULL,50,479),(1862,'2026-09-19 00:39:32','2026-09-19 00:39:32',NULL,NULL,'Vietnam',NULL,51,479),(1863,'2026-09-19 00:39:33','2026-09-19 00:39:33',NULL,NULL,'Vietnam',NULL,52,479),(1864,'2026-09-19 00:39:33','2026-09-19 00:39:33',NULL,NULL,'越南',NULL,53,479),(1865,'2026-09-19 00:39:33','2026-09-19 00:39:33',NULL,NULL,'British Virgin Islands',NULL,50,480),(1866,'2026-09-19 00:39:33','2026-09-19 00:39:33',NULL,NULL,'British Virgin Islands',NULL,51,480),(1867,'2026-09-19 00:39:33','2026-09-19 00:39:33',NULL,NULL,'Îles Vierges britanniques',NULL,52,480),(1868,'2026-09-19 00:39:33','2026-09-19 00:39:33',NULL,NULL,'英属维尔京群岛',NULL,53,480),(1869,'2026-09-19 00:39:33','2026-09-19 00:39:33',NULL,NULL,'U.S. Virgin Islands',NULL,50,481),(1870,'2026-09-19 00:39:33','2026-09-19 00:39:33',NULL,NULL,'U.S. Virgin Islands',NULL,51,481),(1871,'2026-09-19 00:39:33','2026-09-19 00:39:33',NULL,NULL,'Îles Vierges des États-Unis',NULL,52,481),(1872,'2026-09-19 00:39:33','2026-09-19 00:39:33',NULL,NULL,'美属维尔京群岛',NULL,53,481),(1873,'2026-09-19 00:39:33','2026-09-19 00:39:33',NULL,NULL,'Wallis & Futuna',NULL,50,482),(1874,'2026-09-19 00:39:33','2026-09-19 00:39:33',NULL,NULL,'Wallis & Futuna',NULL,51,482),(1875,'2026-09-19 00:39:33','2026-09-19 00:39:33',NULL,NULL,'Wallis-et-Futuna',NULL,52,482),(1876,'2026-09-19 00:39:33','2026-09-19 00:39:33',NULL,NULL,'瓦利斯和富图纳',NULL,53,482),(1877,'2026-09-19 00:39:33','2026-09-19 00:39:33',NULL,NULL,'Western Sahara',NULL,50,483),(1878,'2026-09-19 00:39:33','2026-09-19 00:39:33',NULL,NULL,'Western Sahara',NULL,51,483),(1879,'2026-09-19 00:39:33','2026-09-19 00:39:33',NULL,NULL,'Sahara occidental',NULL,52,483),(1880,'2026-09-19 00:39:33','2026-09-19 00:39:33',NULL,NULL,'西撒哈拉',NULL,53,483),(1881,'2026-09-19 00:39:33','2026-09-19 00:39:33',NULL,NULL,'Yemen',NULL,50,484),(1882,'2026-09-19 00:39:33','2026-09-19 00:39:33',NULL,NULL,'Yemen',NULL,51,484),(1883,'2026-09-19 00:39:33','2026-09-19 00:39:33',NULL,NULL,'Yémen',NULL,52,484),(1884,'2026-09-19 00:39:33','2026-09-19 00:39:33',NULL,NULL,'也门',NULL,53,484),(1885,'2026-09-19 00:39:33','2026-09-19 00:39:33',NULL,NULL,'Zambia',NULL,50,485),(1886,'2026-09-19 00:39:34','2026-09-19 00:39:34',NULL,NULL,'Zambia',NULL,51,485),(1887,'2026-09-19 00:39:34','2026-09-19 00:39:34',NULL,NULL,'Zambie',NULL,52,485),(1888,'2026-09-19 00:39:34','2026-09-19 00:39:34',NULL,NULL,'赞比亚',NULL,53,485),(1889,'2026-09-19 00:39:34','2026-09-19 00:39:34',NULL,NULL,'Zimbabwe',NULL,50,486),(1890,'2026-09-19 00:39:34','2026-09-19 00:39:34',NULL,NULL,'Zimbabwe',NULL,51,486),(1891,'2026-09-19 00:39:34','2026-09-19 00:39:34',NULL,NULL,'Zimbabwe',NULL,52,486),(1892,'2026-09-19 00:39:34','2026-09-19 00:39:34',NULL,NULL,'津巴布韦',NULL,53,486);
/*!40000 ALTER TABLE `COUNTRY_DESCRIPTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CURRENCY`
--

DROP TABLE IF EXISTS `CURRENCY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CURRENCY` (
  `CURRENCY_ID` bigint NOT NULL,
  `CURRENCY_CODE` varchar(255) DEFAULT NULL,
  `CURRENCY_CURRENCY_CODE` varchar(255) NOT NULL,
  `CURRENCY_NAME` varchar(255) DEFAULT NULL,
  `CURRENCY_SUPPORTED` bit(1) DEFAULT NULL,
  PRIMARY KEY (`CURRENCY_ID`),
  UNIQUE KEY `UK_m7ku15ekud52vp67ry73a36te` (`CURRENCY_CURRENCY_CODE`),
  UNIQUE KEY `UK_1ubr7n96hjajamtggqp090a4x` (`CURRENCY_CODE`),
  UNIQUE KEY `UK_7r1k69cbk5giewqr5c9r4v6f` (`CURRENCY_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CURRENCY`
--

LOCK TABLES `CURRENCY` WRITE;
/*!40000 ALTER TABLE `CURRENCY` DISABLE KEYS */;
INSERT INTO `CURRENCY` VALUES (1,'FJD','FJD','FJD',_binary ''),(2,'MXN','MXN','MXN',_binary ''),(3,'STD','STD','STD',_binary ''),(4,'LVL','LVL','LVL',_binary ''),(5,'SCR','SCR','SCR',_binary ''),(6,'CDF','CDF','CDF',_binary ''),(7,'BBD','BBD','BBD',_binary ''),(8,'GTQ','GTQ','GTQ',_binary ''),(9,'CLP','CLP','CLP',_binary ''),(10,'HNL','HNL','HNL',_binary ''),(11,'UGX','UGX','UGX',_binary ''),(12,'ZAR','ZAR','ZAR',_binary ''),(13,'MXV','MXV','MXV',_binary ''),(14,'TND','TND','TND',_binary ''),(15,'BSD','BSD','BSD',_binary ''),(16,'SLL','SLL','SLL',_binary ''),(17,'SDG','SDG','SDG',_binary ''),(18,'IQD','IQD','IQD',_binary ''),(19,'CUP','CUP','CUP',_binary ''),(20,'GMD','GMD','GMD',_binary ''),(21,'TWD','TWD','TWD',_binary ''),(22,'RSD','RSD','RSD',_binary ''),(23,'DOP','DOP','DOP',_binary ''),(24,'KMF','KMF','KMF',_binary ''),(25,'MYR','MYR','MYR',_binary ''),(26,'FKP','FKP','FKP',_binary ''),(27,'XOF','XOF','XOF',_binary ''),(28,'GEL','GEL','GEL',_binary ''),(29,'UYU','UYU','UYU',_binary ''),(30,'MAD','MAD','MAD',_binary ''),(31,'CVE','CVE','CVE',_binary ''),(32,'AZN','AZN','AZN',_binary ''),(33,'OMR','OMR','OMR',_binary ''),(34,'PGK','PGK','PGK',_binary ''),(35,'KES','KES','KES',_binary ''),(36,'SEK','SEK','SEK',_binary ''),(37,'BTN','BTN','BTN',_binary ''),(38,'UAH','UAH','UAH',_binary ''),(39,'GNF','GNF','GNF',_binary ''),(40,'ERN','ERN','ERN',_binary ''),(41,'MZN','MZN','MZN',_binary ''),(42,'SVC','SVC','SVC',_binary ''),(43,'ARS','ARS','ARS',_binary ''),(44,'QAR','QAR','QAR',_binary ''),(45,'IRR','IRR','IRR',_binary ''),(46,'MRO','MRO','MRO',_binary ''),(47,'CNY','CNY','CNY',_binary ''),(48,'XPF','XPF','XPF',_binary ''),(49,'THB','THB','THB',_binary ''),(50,'UZS','UZS','UZS',_binary ''),(51,'BDT','BDT','BDT',_binary ''),(52,'LYD','LYD','LYD',_binary ''),(53,'BMD','BMD','BMD',_binary ''),(54,'KWD','KWD','KWD',_binary ''),(55,'PHP','PHP','PHP',_binary ''),(56,'RUB','RUB','RUB',_binary ''),(57,'PYG','PYG','PYG',_binary ''),(58,'ISK','ISK','ISK',_binary ''),(59,'JMD','JMD','JMD',_binary ''),(60,'COP','COP','COP',_binary ''),(61,'USD','USD','USD',_binary ''),(62,'MKD','MKD','MKD',_binary ''),(63,'DZD','DZD','DZD',_binary ''),(64,'PAB','PAB','PAB',_binary ''),(65,'SGD','SGD','SGD',_binary ''),(66,'ETB','ETB','ETB',_binary ''),(67,'KGS','KGS','KGS',_binary ''),(68,'SOS','SOS','SOS',_binary ''),(69,'VUV','VUV','VUV',_binary ''),(70,'VEF','VEF','VEF',_binary ''),(71,'LAK','LAK','LAK',_binary ''),(72,'BND','BND','BND',_binary ''),(73,'ZMK','ZMK','ZMK',_binary ''),(74,'XAF','XAF','XAF',_binary ''),(75,'LRD','LRD','LRD',_binary ''),(76,'HRK','HRK','HRK',_binary ''),(77,'CHF','CHF','CHF',_binary ''),(78,'ALL','ALL','ALL',_binary ''),(79,'DJF','DJF','DJF',_binary ''),(80,'TZS','TZS','TZS',_binary ''),(81,'VND','VND','VND',_binary ''),(82,'AUD','AUD','AUD',_binary ''),(83,'ILS','ILS','ILS',_binary ''),(84,'GHS','GHS','GHS',_binary ''),(85,'GYD','GYD','GYD',_binary ''),(86,'KPW','KPW','KPW',_binary ''),(87,'BOB','BOB','BOB',_binary ''),(88,'KHR','KHR','KHR',_binary ''),(89,'MDL','MDL','MDL',_binary ''),(90,'IDR','IDR','IDR',_binary ''),(91,'KYD','KYD','KYD',_binary ''),(92,'AMD','AMD','AMD',_binary ''),(93,'BWP','BWP','BWP',_binary ''),(94,'SHP','SHP','SHP',_binary ''),(95,'TRY','TRY','TRY',_binary ''),(96,'LBP','LBP','LBP',_binary ''),(97,'TJS','TJS','TJS',_binary ''),(98,'JOD','JOD','JOD',_binary ''),(99,'HKD','HKD','HKD',_binary ''),(100,'RWF','RWF','RWF',_binary ''),(101,'AED','AED','AED',_binary ''),(102,'EUR','EUR','EUR',_binary ''),(103,'LSL','LSL','LSL',_binary ''),(104,'DKK','DKK','DKK',_binary ''),(105,'CAD','CAD','CAD',_binary ''),(106,'BOV','BOV','BOV',_binary ''),(107,'BGN','BGN','BGN',_binary ''),(108,'MMK','MMK','MMK',_binary ''),(109,'NOK','NOK','NOK',_binary ''),(110,'MUR','MUR','MUR',_binary ''),(111,'SYP','SYP','SYP',_binary ''),(112,'GIP','GIP','GIP',_binary ''),(113,'RON','RON','RON',_binary ''),(114,'LKR','LKR','LKR',_binary ''),(115,'NGN','NGN','NGN',_binary ''),(116,'CRC','CRC','CRC',_binary ''),(117,'CZK','CZK','CZK',_binary ''),(118,'PKR','PKR','PKR',_binary ''),(119,'XCD','XCD','XCD',_binary ''),(120,'ANG','ANG','ANG',_binary ''),(121,'HTG','HTG','HTG',_binary ''),(122,'BHD','BHD','BHD',_binary ''),(123,'KZT','KZT','KZT',_binary ''),(124,'SRD','SRD','SRD',_binary ''),(125,'SZL','SZL','SZL',_binary ''),(126,'LTL','LTL','LTL',_binary ''),(127,'SAR','SAR','SAR',_binary ''),(128,'TTD','TTD','TTD',_binary ''),(129,'YER','YER','YER',_binary ''),(130,'MVR','MVR','MVR',_binary ''),(131,'AFN','AFN','AFN',_binary ''),(132,'INR','INR','INR',_binary ''),(133,'AWG','AWG','AWG',_binary ''),(134,'KRW','KRW','KRW',_binary ''),(135,'NPR','NPR','NPR',_binary ''),(136,'JPY','JPY','JPY',_binary ''),(137,'MNT','MNT','MNT',_binary ''),(138,'AOA','AOA','AOA',_binary ''),(139,'PLN','PLN','PLN',_binary ''),(140,'GBP','GBP','GBP',_binary ''),(141,'SBD','SBD','SBD',_binary ''),(142,'HUF','HUF','HUF',_binary ''),(143,'BYR','BYR','BYR',_binary ''),(144,'BIF','BIF','BIF',_binary ''),(145,'MWK','MWK','MWK',_binary ''),(146,'MGA','MGA','MGA',_binary ''),(147,'XDR','XDR','XDR',_binary ''),(148,'BZD','BZD','BZD',_binary ''),(149,'BAM','BAM','BAM',_binary ''),(150,'EGP','EGP','EGP',_binary ''),(151,'MOP','MOP','MOP',_binary ''),(152,'NAD','NAD','NAD',_binary ''),(153,'NIO','NIO','NIO',_binary ''),(154,'PEN','PEN','PEN',_binary ''),(155,'NZD','NZD','NZD',_binary ''),(156,'WST','WST','WST',_binary ''),(157,'CLF','CLF','CLF',_binary ''),(158,'BRL','BRL','BRL',_binary '');
/*!40000 ALTER TABLE `CURRENCY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CUSTOMER`
--

DROP TABLE IF EXISTS `CUSTOMER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CUSTOMER` (
  `CUSTOMER_ID` bigint NOT NULL,
  `CUSTOMER_ANONYMOUS` bit(1) DEFAULT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `BILLING_STREET_ADDRESS` varchar(256) DEFAULT NULL,
  `BILLING_CITY` varchar(100) DEFAULT NULL,
  `BILLING_COMPANY` varchar(100) DEFAULT NULL,
  `BILLING_FIRST_NAME` varchar(64) NOT NULL,
  `BILLING_LAST_NAME` varchar(64) NOT NULL,
  `LATITUDE` varchar(100) DEFAULT NULL,
  `LONGITUDE` varchar(100) DEFAULT NULL,
  `BILLING_POSTCODE` varchar(20) DEFAULT NULL,
  `BILLING_STATE` varchar(100) DEFAULT NULL,
  `BILLING_TELEPHONE` varchar(32) DEFAULT NULL,
  `CUSTOMER_COMPANY` varchar(100) DEFAULT NULL,
  `RESET_CREDENTIALS_REQ` varchar(256) DEFAULT NULL,
  `RESET_CREDENTIALS_EXP` date DEFAULT NULL,
  `REVIEW_AVG` decimal(19,2) DEFAULT NULL,
  `REVIEW_COUNT` int DEFAULT NULL,
  `CUSTOMER_DOB` datetime DEFAULT NULL,
  `DELIVERY_STREET_ADDRESS` varchar(256) DEFAULT NULL,
  `DELIVERY_CITY` varchar(100) DEFAULT NULL,
  `DELIVERY_COMPANY` varchar(100) DEFAULT NULL,
  `DELIVERY_FIRST_NAME` varchar(64) DEFAULT NULL,
  `DELIVERY_LAST_NAME` varchar(64) DEFAULT NULL,
  `DELIVERY_POSTCODE` varchar(20) DEFAULT NULL,
  `DELIVERY_STATE` varchar(100) DEFAULT NULL,
  `DELIVERY_TELEPHONE` varchar(32) DEFAULT NULL,
  `CUSTOMER_EMAIL_ADDRESS` varchar(96) NOT NULL,
  `CUSTOMER_GENDER` varchar(1) DEFAULT NULL,
  `CUSTOMER_NICK` varchar(96) DEFAULT NULL,
  `CUSTOMER_PASSWORD` varchar(60) DEFAULT NULL,
  `PROVIDER` varchar(255) DEFAULT NULL,
  `BILLING_COUNTRY_ID` int NOT NULL,
  `BILLING_ZONE_ID` bigint DEFAULT NULL,
  `LANGUAGE_ID` int NOT NULL,
  `DELIVERY_COUNTRY_ID` int DEFAULT NULL,
  `DELIVERY_ZONE_ID` bigint DEFAULT NULL,
  `MERCHANT_ID` int NOT NULL,
  PRIMARY KEY (`CUSTOMER_ID`),
  UNIQUE KEY `UK6v48av32rli7qu9m3ksb32art` (`MERCHANT_ID`,`CUSTOMER_NICK`),
  KEY `FK5pas8t9mknk4kkin55t4v300l` (`BILLING_COUNTRY_ID`),
  KEY `FKp0xcpa3i2mgdr0kq43xiibx40` (`BILLING_ZONE_ID`),
  KEY `FKdgjqmj04qt89gmfloo4ofojcw` (`LANGUAGE_ID`),
  KEY `FKbxyooiceli2ko29bupdye6jgn` (`DELIVERY_COUNTRY_ID`),
  KEY `FK3k21jw28bbx043c2mnhevg9w4` (`DELIVERY_ZONE_ID`),
  CONSTRAINT `FK3k21jw28bbx043c2mnhevg9w4` FOREIGN KEY (`DELIVERY_ZONE_ID`) REFERENCES `ZONE` (`ZONE_ID`),
  CONSTRAINT `FK5pas8t9mknk4kkin55t4v300l` FOREIGN KEY (`BILLING_COUNTRY_ID`) REFERENCES `COUNTRY` (`COUNTRY_ID`),
  CONSTRAINT `FK8122nrpakxu3umk1od4v0xxoa` FOREIGN KEY (`MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`),
  CONSTRAINT `FKbxyooiceli2ko29bupdye6jgn` FOREIGN KEY (`DELIVERY_COUNTRY_ID`) REFERENCES `COUNTRY` (`COUNTRY_ID`),
  CONSTRAINT `FKdgjqmj04qt89gmfloo4ofojcw` FOREIGN KEY (`LANGUAGE_ID`) REFERENCES `LANGUAGE` (`LANGUAGE_ID`),
  CONSTRAINT `FKp0xcpa3i2mgdr0kq43xiibx40` FOREIGN KEY (`BILLING_ZONE_ID`) REFERENCES `ZONE` (`ZONE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CUSTOMER`
--

LOCK TABLES `CUSTOMER` WRITE;
/*!40000 ALTER TABLE `CUSTOMER` DISABLE KEYS */;
INSERT INTO `CUSTOMER` VALUES (1,_binary '\0',NULL,'2026-09-20 01:23:02',NULL,'số 4 đường Chùa am','Trảng Bàng','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,NULL,NULL,NULL,NULL,NULL,'số 4 đường Chùa am','Trảng Bàng','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','levatienamakhe@gmail.com','M','thanhduc1','$2a$10$aSdtkFnI5V4VHIQLBeKI0O1kJG2tNeQV5a.3pSw/dYHfU0vJRqKni',NULL,479,NULL,50,479,NULL,1);
/*!40000 ALTER TABLE `CUSTOMER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CUSTOMER_ATTRIBUTE`
--

DROP TABLE IF EXISTS `CUSTOMER_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CUSTOMER_ATTRIBUTE` (
  `CUSTOMER_ATTRIBUTE_ID` bigint NOT NULL,
  `CUSTOMER_ATTR_TXT_VAL` varchar(255) DEFAULT NULL,
  `CUSTOMER_ID` bigint NOT NULL,
  `OPTION_ID` bigint NOT NULL,
  `OPTION_VALUE_ID` bigint NOT NULL,
  PRIMARY KEY (`CUSTOMER_ATTRIBUTE_ID`),
  UNIQUE KEY `UK46kbpre88yh963gewm3kmdni1` (`OPTION_ID`,`CUSTOMER_ID`),
  KEY `FKc3318o13i2bpxkci1bh52we5a` (`CUSTOMER_ID`),
  KEY `FK9fl7iexvdeeeoch9fh35o5vw4` (`OPTION_VALUE_ID`),
  CONSTRAINT `FK4xugs9yd9w4o3sw11fisb8tj5` FOREIGN KEY (`OPTION_ID`) REFERENCES `CUSTOMER_OPTION` (`CUSTOMER_OPTION_ID`),
  CONSTRAINT `FK9fl7iexvdeeeoch9fh35o5vw4` FOREIGN KEY (`OPTION_VALUE_ID`) REFERENCES `CUSTOMER_OPTION_VALUE` (`CUSTOMER_OPTION_VALUE_ID`),
  CONSTRAINT `FKc3318o13i2bpxkci1bh52we5a` FOREIGN KEY (`CUSTOMER_ID`) REFERENCES `CUSTOMER` (`CUSTOMER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CUSTOMER_ATTRIBUTE`
--

LOCK TABLES `CUSTOMER_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `CUSTOMER_ATTRIBUTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `CUSTOMER_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CUSTOMER_GROUP`
--

DROP TABLE IF EXISTS `CUSTOMER_GROUP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CUSTOMER_GROUP` (
  `CUSTOMER_ID` bigint NOT NULL,
  `GROUP_ID` int NOT NULL,
  KEY `FKgrr5v89l1m9sl2qol62bbctq4` (`GROUP_ID`),
  KEY `FK257h3e27f4ujw08doqtq46hho` (`CUSTOMER_ID`),
  CONSTRAINT `FK257h3e27f4ujw08doqtq46hho` FOREIGN KEY (`CUSTOMER_ID`) REFERENCES `CUSTOMER` (`CUSTOMER_ID`),
  CONSTRAINT `FKgrr5v89l1m9sl2qol62bbctq4` FOREIGN KEY (`GROUP_ID`) REFERENCES `SM_GROUP` (`GROUP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CUSTOMER_GROUP`
--

LOCK TABLES `CUSTOMER_GROUP` WRITE;
/*!40000 ALTER TABLE `CUSTOMER_GROUP` DISABLE KEYS */;
INSERT INTO `CUSTOMER_GROUP` VALUES (1,57);
/*!40000 ALTER TABLE `CUSTOMER_GROUP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CUSTOMER_OPTIN`
--

DROP TABLE IF EXISTS `CUSTOMER_OPTIN`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CUSTOMER_OPTIN` (
  `CUSTOMER_OPTIN_ID` bigint NOT NULL,
  `EMAIL` varchar(255) NOT NULL,
  `FIRST` varchar(255) DEFAULT NULL,
  `LAST` varchar(255) DEFAULT NULL,
  `OPTIN_DATE` datetime DEFAULT NULL,
  `VALUE` longtext,
  `MERCHANT_ID` int NOT NULL,
  `OPTIN_ID` bigint DEFAULT NULL,
  PRIMARY KEY (`CUSTOMER_OPTIN_ID`),
  UNIQUE KEY `UKc4fnyu0pvxxtrbko10rm1jqyw` (`EMAIL`,`OPTIN_ID`),
  KEY `FKk5v94dvhsgibaw89hv4m8o5yw` (`MERCHANT_ID`),
  KEY `FK7qym878m07cwvs4foe68lvqjt` (`OPTIN_ID`),
  CONSTRAINT `FK7qym878m07cwvs4foe68lvqjt` FOREIGN KEY (`OPTIN_ID`) REFERENCES `OPTIN` (`OPTIN_ID`),
  CONSTRAINT `FKk5v94dvhsgibaw89hv4m8o5yw` FOREIGN KEY (`MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CUSTOMER_OPTIN`
--

LOCK TABLES `CUSTOMER_OPTIN` WRITE;
/*!40000 ALTER TABLE `CUSTOMER_OPTIN` DISABLE KEYS */;
/*!40000 ALTER TABLE `CUSTOMER_OPTIN` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CUSTOMER_OPTION`
--

DROP TABLE IF EXISTS `CUSTOMER_OPTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CUSTOMER_OPTION` (
  `CUSTOMER_OPTION_ID` bigint NOT NULL,
  `CUSTOMER_OPT_ACTIVE` bit(1) DEFAULT NULL,
  `CUSTOMER_OPT_CODE` varchar(255) DEFAULT NULL,
  `CUSTOMER_OPTION_TYPE` varchar(10) DEFAULT NULL,
  `CUSTOMER_OPT_PUBLIC` bit(1) DEFAULT NULL,
  `SORT_ORDER` int DEFAULT NULL,
  `MERCHANT_ID` int NOT NULL,
  PRIMARY KEY (`CUSTOMER_OPTION_ID`),
  UNIQUE KEY `UKrov34a6g4dhhiqukvhp1ggm0u` (`MERCHANT_ID`,`CUSTOMER_OPT_CODE`),
  KEY `CUST_OPT_CODE_IDX` (`CUSTOMER_OPT_CODE`),
  CONSTRAINT `FKcmqnh0rn2hukdfowean5tdy8k` FOREIGN KEY (`MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CUSTOMER_OPTION`
--

LOCK TABLES `CUSTOMER_OPTION` WRITE;
/*!40000 ALTER TABLE `CUSTOMER_OPTION` DISABLE KEYS */;
/*!40000 ALTER TABLE `CUSTOMER_OPTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CUSTOMER_OPTION_DESC`
--

DROP TABLE IF EXISTS `CUSTOMER_OPTION_DESC`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CUSTOMER_OPTION_DESC` (
  `DESCRIPTION_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `DESCRIPTION` longtext,
  `NAME` varchar(120) NOT NULL,
  `TITLE` varchar(100) DEFAULT NULL,
  `CUSTOMER_OPTION_COMMENT` varchar(4000) DEFAULT NULL,
  `LANGUAGE_ID` int NOT NULL,
  `CUSTOMER_OPTION_ID` bigint NOT NULL,
  PRIMARY KEY (`DESCRIPTION_ID`),
  UNIQUE KEY `UK6ovl4t1ciag1wubtcebaoo7vi` (`CUSTOMER_OPTION_ID`,`LANGUAGE_ID`),
  KEY `FKm4iu7v9db17wk2a03xqbqdlfa` (`LANGUAGE_ID`),
  CONSTRAINT `FKc2yiucjbw0wjha8ww7a01qfeo` FOREIGN KEY (`CUSTOMER_OPTION_ID`) REFERENCES `CUSTOMER_OPTION` (`CUSTOMER_OPTION_ID`),
  CONSTRAINT `FKm4iu7v9db17wk2a03xqbqdlfa` FOREIGN KEY (`LANGUAGE_ID`) REFERENCES `LANGUAGE` (`LANGUAGE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CUSTOMER_OPTION_DESC`
--

LOCK TABLES `CUSTOMER_OPTION_DESC` WRITE;
/*!40000 ALTER TABLE `CUSTOMER_OPTION_DESC` DISABLE KEYS */;
/*!40000 ALTER TABLE `CUSTOMER_OPTION_DESC` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CUSTOMER_OPTION_SET`
--

DROP TABLE IF EXISTS `CUSTOMER_OPTION_SET`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CUSTOMER_OPTION_SET` (
  `CUSTOMER_OPTIONSET_ID` bigint NOT NULL,
  `SORT_ORDER` int DEFAULT NULL,
  `CUSTOMER_OPTION_ID` bigint NOT NULL,
  `CUSTOMER_OPTION_VALUE_ID` bigint NOT NULL,
  PRIMARY KEY (`CUSTOMER_OPTIONSET_ID`),
  UNIQUE KEY `UK4peli2ritnnq2xqpyq188srm6` (`CUSTOMER_OPTION_ID`,`CUSTOMER_OPTION_VALUE_ID`),
  KEY `FKj9vnvyh6hhhftjbcsymgiodm9` (`CUSTOMER_OPTION_VALUE_ID`),
  CONSTRAINT `FK1y5qtsuabhpwft3dyhqrgmtb4` FOREIGN KEY (`CUSTOMER_OPTION_ID`) REFERENCES `CUSTOMER_OPTION` (`CUSTOMER_OPTION_ID`),
  CONSTRAINT `FKj9vnvyh6hhhftjbcsymgiodm9` FOREIGN KEY (`CUSTOMER_OPTION_VALUE_ID`) REFERENCES `CUSTOMER_OPTION_VALUE` (`CUSTOMER_OPTION_VALUE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CUSTOMER_OPTION_SET`
--

LOCK TABLES `CUSTOMER_OPTION_SET` WRITE;
/*!40000 ALTER TABLE `CUSTOMER_OPTION_SET` DISABLE KEYS */;
/*!40000 ALTER TABLE `CUSTOMER_OPTION_SET` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CUSTOMER_OPTION_VALUE`
--

DROP TABLE IF EXISTS `CUSTOMER_OPTION_VALUE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CUSTOMER_OPTION_VALUE` (
  `CUSTOMER_OPTION_VALUE_ID` bigint NOT NULL,
  `CUSTOMER_OPT_VAL_CODE` varchar(255) DEFAULT NULL,
  `CUSTOMER_OPT_VAL_IMAGE` varchar(255) DEFAULT NULL,
  `SORT_ORDER` int DEFAULT NULL,
  `MERCHANT_ID` int NOT NULL,
  PRIMARY KEY (`CUSTOMER_OPTION_VALUE_ID`),
  UNIQUE KEY `UKcb1fmv71nrx7m1rlx1ff5qvdt` (`MERCHANT_ID`,`CUSTOMER_OPT_VAL_CODE`),
  KEY `CUST_OPT_VAL_CODE_IDX` (`CUSTOMER_OPT_VAL_CODE`),
  CONSTRAINT `FKho87ssg5rnvwauj3y690a96g6` FOREIGN KEY (`MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CUSTOMER_OPTION_VALUE`
--

LOCK TABLES `CUSTOMER_OPTION_VALUE` WRITE;
/*!40000 ALTER TABLE `CUSTOMER_OPTION_VALUE` DISABLE KEYS */;
/*!40000 ALTER TABLE `CUSTOMER_OPTION_VALUE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CUSTOMER_OPT_VAL_DESCRIPTION`
--

DROP TABLE IF EXISTS `CUSTOMER_OPT_VAL_DESCRIPTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CUSTOMER_OPT_VAL_DESCRIPTION` (
  `DESCRIPTION_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `DESCRIPTION` longtext,
  `NAME` varchar(120) NOT NULL,
  `TITLE` varchar(100) DEFAULT NULL,
  `LANGUAGE_ID` int NOT NULL,
  `CUSTOMER_OPT_VAL_ID` bigint DEFAULT NULL,
  PRIMARY KEY (`DESCRIPTION_ID`),
  UNIQUE KEY `UKge7f2t1d31r87wnk09h9u1tnv` (`CUSTOMER_OPT_VAL_ID`,`LANGUAGE_ID`),
  KEY `FK6rfssi3qfx4pswicxrfb18c1` (`LANGUAGE_ID`),
  CONSTRAINT `FK6rfssi3qfx4pswicxrfb18c1` FOREIGN KEY (`LANGUAGE_ID`) REFERENCES `LANGUAGE` (`LANGUAGE_ID`),
  CONSTRAINT `FKhwrs6fyqk6vh11yvcflu42yef` FOREIGN KEY (`CUSTOMER_OPT_VAL_ID`) REFERENCES `CUSTOMER_OPTION_VALUE` (`CUSTOMER_OPTION_VALUE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CUSTOMER_OPT_VAL_DESCRIPTION`
--

LOCK TABLES `CUSTOMER_OPT_VAL_DESCRIPTION` WRITE;
/*!40000 ALTER TABLE `CUSTOMER_OPT_VAL_DESCRIPTION` DISABLE KEYS */;
/*!40000 ALTER TABLE `CUSTOMER_OPT_VAL_DESCRIPTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CUSTOMER_REVIEW`
--

DROP TABLE IF EXISTS `CUSTOMER_REVIEW`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CUSTOMER_REVIEW` (
  `CUSTOMER_REVIEW_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `REVIEW_DATE` datetime DEFAULT NULL,
  `REVIEWS_RATING` double DEFAULT NULL,
  `REVIEWS_READ` bigint DEFAULT NULL,
  `STATUS` int DEFAULT NULL,
  `CUSTOMERS_ID` bigint DEFAULT NULL,
  `REVIEWED_CUSTOMER_ID` bigint DEFAULT NULL,
  PRIMARY KEY (`CUSTOMER_REVIEW_ID`),
  UNIQUE KEY `UK2momthbfrtgico2yyod8w18pk` (`CUSTOMERS_ID`,`REVIEWED_CUSTOMER_ID`),
  KEY `FK7pmqdk9od2af7cl6alx82fkek` (`REVIEWED_CUSTOMER_ID`),
  CONSTRAINT `FK7pmqdk9od2af7cl6alx82fkek` FOREIGN KEY (`REVIEWED_CUSTOMER_ID`) REFERENCES `CUSTOMER` (`CUSTOMER_ID`),
  CONSTRAINT `FKayt6tbxp7d4g1qyg8crw2n73p` FOREIGN KEY (`CUSTOMERS_ID`) REFERENCES `CUSTOMER` (`CUSTOMER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CUSTOMER_REVIEW`
--

LOCK TABLES `CUSTOMER_REVIEW` WRITE;
/*!40000 ALTER TABLE `CUSTOMER_REVIEW` DISABLE KEYS */;
/*!40000 ALTER TABLE `CUSTOMER_REVIEW` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CUSTOMER_REVIEW_DESCRIPTION`
--

DROP TABLE IF EXISTS `CUSTOMER_REVIEW_DESCRIPTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CUSTOMER_REVIEW_DESCRIPTION` (
  `DESCRIPTION_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `DESCRIPTION` longtext,
  `NAME` varchar(120) NOT NULL,
  `TITLE` varchar(100) DEFAULT NULL,
  `LANGUAGE_ID` int NOT NULL,
  `CUSTOMER_REVIEW_ID` bigint DEFAULT NULL,
  PRIMARY KEY (`DESCRIPTION_ID`),
  UNIQUE KEY `UK1va9q0nhoe3wli25ktpmouvyh` (`CUSTOMER_REVIEW_ID`,`LANGUAGE_ID`),
  KEY `FK5pkgrlk32uqaxkrbve5mws1hj` (`LANGUAGE_ID`),
  CONSTRAINT `FK5pkgrlk32uqaxkrbve5mws1hj` FOREIGN KEY (`LANGUAGE_ID`) REFERENCES `LANGUAGE` (`LANGUAGE_ID`),
  CONSTRAINT `FKhf88oagf6t62k28afn8uaijc7` FOREIGN KEY (`CUSTOMER_REVIEW_ID`) REFERENCES `CUSTOMER_REVIEW` (`CUSTOMER_REVIEW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CUSTOMER_REVIEW_DESCRIPTION`
--

LOCK TABLES `CUSTOMER_REVIEW_DESCRIPTION` WRITE;
/*!40000 ALTER TABLE `CUSTOMER_REVIEW_DESCRIPTION` DISABLE KEYS */;
/*!40000 ALTER TABLE `CUSTOMER_REVIEW_DESCRIPTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FILE_HISTORY`
--

DROP TABLE IF EXISTS `FILE_HISTORY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FILE_HISTORY` (
  `FILE_HISTORY_ID` bigint NOT NULL,
  `ACCOUNTED_DATE` datetime DEFAULT NULL,
  `DATE_ADDED` datetime NOT NULL,
  `DATE_DELETED` datetime DEFAULT NULL,
  `DOWNLOAD_COUNT` int NOT NULL,
  `FILE_ID` bigint DEFAULT NULL,
  `FILESIZE` int NOT NULL,
  `MERCHANT_ID` int NOT NULL,
  PRIMARY KEY (`FILE_HISTORY_ID`),
  UNIQUE KEY `UKav35sb3v4nxq8v1n1rkxufir` (`MERCHANT_ID`,`FILE_ID`),
  CONSTRAINT `FK2k8h4penkjlbtc23vamwyek2g` FOREIGN KEY (`MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FILE_HISTORY`
--

LOCK TABLES `FILE_HISTORY` WRITE;
/*!40000 ALTER TABLE `FILE_HISTORY` DISABLE KEYS */;
/*!40000 ALTER TABLE `FILE_HISTORY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GEOZONE`
--

DROP TABLE IF EXISTS `GEOZONE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GEOZONE` (
  `GEOZONE_ID` bigint NOT NULL,
  `GEOZONE_CODE` varchar(255) DEFAULT NULL,
  `GEOZONE_NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`GEOZONE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GEOZONE`
--

LOCK TABLES `GEOZONE` WRITE;
/*!40000 ALTER TABLE `GEOZONE` DISABLE KEYS */;
/*!40000 ALTER TABLE `GEOZONE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GEOZONE_DESCRIPTION`
--

DROP TABLE IF EXISTS `GEOZONE_DESCRIPTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GEOZONE_DESCRIPTION` (
  `DESCRIPTION_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `DESCRIPTION` longtext,
  `NAME` varchar(120) NOT NULL,
  `TITLE` varchar(100) DEFAULT NULL,
  `LANGUAGE_ID` int NOT NULL,
  `GEOZONE_ID` bigint DEFAULT NULL,
  PRIMARY KEY (`DESCRIPTION_ID`),
  UNIQUE KEY `UKsoq8o99w3c8ys3ntamt5i4mat` (`GEOZONE_ID`,`LANGUAGE_ID`),
  KEY `FK1t2hp628edebe5d6co2whbla9` (`LANGUAGE_ID`),
  CONSTRAINT `FK1t2hp628edebe5d6co2whbla9` FOREIGN KEY (`LANGUAGE_ID`) REFERENCES `LANGUAGE` (`LANGUAGE_ID`),
  CONSTRAINT `FKn82te2yb2st4hk2qlhl8ileb9` FOREIGN KEY (`GEOZONE_ID`) REFERENCES `GEOZONE` (`GEOZONE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GEOZONE_DESCRIPTION`
--

LOCK TABLES `GEOZONE_DESCRIPTION` WRITE;
/*!40000 ALTER TABLE `GEOZONE_DESCRIPTION` DISABLE KEYS */;
/*!40000 ALTER TABLE `GEOZONE_DESCRIPTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LANGUAGE`
--

DROP TABLE IF EXISTS `LANGUAGE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LANGUAGE` (
  `LANGUAGE_ID` int NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `CODE` varchar(255) NOT NULL,
  `SORT_ORDER` int DEFAULT NULL,
  PRIMARY KEY (`LANGUAGE_ID`),
  KEY `CODE_IDX2` (`CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LANGUAGE`
--

LOCK TABLES `LANGUAGE` WRITE;
/*!40000 ALTER TABLE `LANGUAGE` DISABLE KEYS */;
INSERT INTO `LANGUAGE` VALUES (50,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,'vn',NULL),(51,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,'en',NULL),(52,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,'fr',NULL),(53,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,'zh',NULL);
/*!40000 ALTER TABLE `LANGUAGE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MANUFACTURER`
--

DROP TABLE IF EXISTS `MANUFACTURER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MANUFACTURER` (
  `MANUFACTURER_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `CODE` varchar(100) NOT NULL,
  `MANUFACTURER_IMAGE` varchar(255) DEFAULT NULL,
  `SORT_ORDER` int DEFAULT NULL,
  `MERCHANT_ID` int NOT NULL,
  PRIMARY KEY (`MANUFACTURER_ID`),
  UNIQUE KEY `UK6brqfdkga7jc78n8dh3v595y3` (`MERCHANT_ID`,`CODE`),
  CONSTRAINT `FKhswph4nthrqwffjekccudsrt2` FOREIGN KEY (`MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MANUFACTURER`
--

LOCK TABLES `MANUFACTURER` WRITE;
/*!40000 ALTER TABLE `MANUFACTURER` DISABLE KEYS */;
INSERT INTO `MANUFACTURER` VALUES (1,'2026-09-19 00:40:04','2026-09-19 00:40:04',NULL,'DEFAULT',NULL,0,1);
/*!40000 ALTER TABLE `MANUFACTURER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MANUFACTURER_DESCRIPTION`
--

DROP TABLE IF EXISTS `MANUFACTURER_DESCRIPTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MANUFACTURER_DESCRIPTION` (
  `DESCRIPTION_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `DESCRIPTION` longtext,
  `NAME` varchar(120) NOT NULL,
  `TITLE` varchar(100) DEFAULT NULL,
  `DATE_LAST_CLICK` datetime DEFAULT NULL,
  `MANUFACTURERS_URL` varchar(255) DEFAULT NULL,
  `URL_CLICKED` int DEFAULT NULL,
  `LANGUAGE_ID` int NOT NULL,
  `MANUFACTURER_ID` bigint NOT NULL,
  PRIMARY KEY (`DESCRIPTION_ID`),
  UNIQUE KEY `UKlpv09p83sc887clxe04nroup6` (`MANUFACTURER_ID`,`LANGUAGE_ID`),
  KEY `FK20t33wr4tp1kt1uyw7s8a3afl` (`LANGUAGE_ID`),
  CONSTRAINT `FK20t33wr4tp1kt1uyw7s8a3afl` FOREIGN KEY (`LANGUAGE_ID`) REFERENCES `LANGUAGE` (`LANGUAGE_ID`),
  CONSTRAINT `FKre4iys57n5cfbgpg3qqgewtrh` FOREIGN KEY (`MANUFACTURER_ID`) REFERENCES `MANUFACTURER` (`MANUFACTURER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MANUFACTURER_DESCRIPTION`
--

LOCK TABLES `MANUFACTURER_DESCRIPTION` WRITE;
/*!40000 ALTER TABLE `MANUFACTURER_DESCRIPTION` DISABLE KEYS */;
INSERT INTO `MANUFACTURER_DESCRIPTION` VALUES (1,'2026-09-19 00:40:04','2026-09-19 00:40:04',NULL,'DEFAULT','DEFAULT',NULL,NULL,NULL,NULL,51,1);
/*!40000 ALTER TABLE `MANUFACTURER_DESCRIPTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MERCHANT_CONFIGURATION`
--

DROP TABLE IF EXISTS `MERCHANT_CONFIGURATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MERCHANT_CONFIGURATION` (
  `MERCHANT_CONFIG_ID` bigint NOT NULL,
  `ACTIVE` bit(1) DEFAULT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `CONFIG_KEY` varchar(255) DEFAULT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  `VALUE` longtext,
  `MERCHANT_ID` int DEFAULT NULL,
  PRIMARY KEY (`MERCHANT_CONFIG_ID`),
  UNIQUE KEY `UKj0c3h8onw3m6hjcr3yylst9fb` (`MERCHANT_ID`,`CONFIG_KEY`),
  CONSTRAINT `FKf9bkgf0ysbp5fo9j69shm0pri` FOREIGN KEY (`MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MERCHANT_CONFIGURATION`
--

LOCK TABLES `MERCHANT_CONFIGURATION` WRITE;
/*!40000 ALTER TABLE `MERCHANT_CONFIGURATION` DISABLE KEYS */;
INSERT INTO `MERCHANT_CONFIGURATION` VALUES (1,_binary '\0','2026-09-19 00:40:05','2026-09-19 06:28:38',NULL,'CONFIG','CONFIG','{\"allowPurchaseItems\":true,\"displayContactUs\":true,\"displayCustomerAgreement\":false,\"defaultSearchConfigPath\":{},\"displayCustomerSection\":true,\"displayAddToCartOnFeaturedItems\":true,\"displayPagesMenu\":true,\"testMode\":false,\"displayStoreAddress\":true,\"displaySearchBox\":true,\"debugMode\":false,\"useDefaultSearchConfig\":{\"vn\":true,\"en\":true,\"fr\":true,\"zh\":true}}',1),(50,_binary '\0','2026-09-19 01:44:36','2026-09-19 01:49:32',NULL,'SHIPPING','INTEGRATION','df02614ab6600db0eb4d78e2c4df5574aa0324c2285e18aba55dd89532de92917f50c7b91baa22d4e56e17c3f3b473f6d80047d42d75bcd9e221b2c489dcd65c9d998bd97fba4d3aadad01998bc3e72cc4e7b51a9ea9c74602afdd79a3df43d441665c27b70e3d8d9a78bbf536b32b27a606a5385dc85e02c66b5c54a4afdd75ca8fbf954553b7ae2407dc393e43e01d85e3dc82d4fa8f3ab9bb62a829f573e4c75f27f56a20d1255dc3c60c3e0b04c90741f8bb633f1706be8aeba2488fc5869d3497c52919c0a9943e7383840158fdb09617e6fa2c1f7d599722bd6c4da967bdd96c02596ca624af12dc980a42e4db20e53240238c4a129e6c057f4757f7d3c270acf00d493984e4d15ac87cb4d47309b7f80e518f25cebe9dfef2d99a369801b652f29981c804c7c03d91df55d6657f08120653a4eeae0a8e2ddc0d269207818a1cf44c01290a7b37e084f461ac7592b8acb42da4be6b4506b951b54e73f14eec58e7c409f458add4240202d3519b49fdea67f308ec6843b4bd83a1e7e18ab2789e7c923bf44f8e2987fb0fc884134f67d9cd7c5982dc00fa2269403f1eae89f7964129af3f67fea320e894d7d1d0130e11925907dab227c70edef6d28b8770602afd7e0d1fdb4095865da43976e20a118fe6c69336171e7a99464c99d37981f568e2152be3df344a7595cb005f60b4c8735a2a6aa1603590925e01fd05ac',1),(51,_binary '\0','2026-09-19 01:49:32','2026-09-19 01:49:32',NULL,'weightBased','INTEGRATION','{\"moduleCode\":\"weightBased\",\"active\":true}',1),(52,_binary '\0','2026-09-19 01:50:32','2026-09-19 09:07:48',NULL,'PAYMENT','INTEGRATION','df02614ab6600db0eb4d78e2c4df5574f9ba1903c78f9da01dded48dcbe5fa1395559a2eb8160dd8615b22e900932a7bac035d6eaa57b1ec05f4cedf94c2d8054819918ba0b244669d6987678949825eee5e06278ad1acdb473840b69721531c51e62999ba70c79fdd7257895873ce0e7e03154a720bde2e18c21a3fff3c9db8bc404934ea72f42c946e22774853134774925b57b5f58f1759bdb9f46458484bc278409b61fc181c3fbcf1dd00db9e54ac62209071318c67fe4e948018c4a76440eaee97e04bff199938c61f4bfcf8eb45c5a8a2f5aa73000f6e54205e78bc0963f8fba0eb191627178ee5ef6063cc840e424b91276b0197551c9bb0c5c10f19a55d087e59e4ff305f489f65a425c9372306c1f2f908c3781b267bfc01665b2867d8b94cd3ab64b9a7eaa1e80e1561fee34bd5a3ae3626e1bcf42dbae68268fa475c70705ca662ea6282cf45538d1f232de22dc0d6796152c48c073ff2db4299e5f39d8d6b63a180a4571fc2ec5afd58b56d0a858cf043eafda7a45223c27ec98bd0f6f4a21cec8b979f49babd7aad3e46930db172e24eb76a90cebe215bc251fef8fb7fe3676c6a9e362095b844be9742d28d3d18ed95a1e3fb5258e1e870cefea5cf46af90f0879997585097d7eb49',1),(53,_binary '\0','2026-09-19 01:59:48','2026-09-19 01:59:48',NULL,'EMAIL_CONFIG','INTEGRATION','{\"protocol\":\"smtp\",\"password\":\"iksiovmcvhubpgfr\",\"smtpAuth\":true,\"starttls\":true,\"port\":\"587\",\"host\":\"smtp.gmail.com\",\"username\":\"anlacduyen01@gmail.com\"}',1),(100,_binary '\0','2026-09-19 02:53:13','2026-09-19 02:59:31',NULL,'SUPPORTED_CNTR','INTEGRATION','[\"VN\",\"US\",\"CN\",\"CA\",\"LA\",\"KH\",\"HK\",\"AU\",\"DK\",\"FR\",\"IN\",\"PH\",\"GB\",\"QA\",\"AE\"]',1),(101,_binary '\0','2026-09-19 02:58:34','2026-09-19 02:58:34',NULL,'SHIPPING_CONFIG','INTEGRATION','{\"boxLength\":0,\"orderTotalFreeShipping\":null,\"shipBaseType\":\"SHIPPING\",\"shipOptionPriceType\":\"ALL\",\"maxWeight\":0.0,\"boxHeight\":0,\"packages\":[],\"taxOnShipping\":false,\"shipPackageType\":\"ITEM\",\"freeShippingEnabled\":false,\"boxWeight\":0.0,\"shipType\":\"INTERNATIONAL\",\"boxWidth\":0,\"handlingFees\":null,\"shipDescription\":\"SHORT_DESCRIPTION\"}',1);
/*!40000 ALTER TABLE `MERCHANT_CONFIGURATION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MERCHANT_LANGUAGE`
--

DROP TABLE IF EXISTS `MERCHANT_LANGUAGE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MERCHANT_LANGUAGE` (
  `stores_MERCHANT_ID` int NOT NULL,
  `languages_LANGUAGE_ID` int NOT NULL,
  KEY `FKjwy0pjijh1qmcoivq50o2jgec` (`languages_LANGUAGE_ID`),
  KEY `FKiisj0tmoujv6n3iqmytvo39kn` (`stores_MERCHANT_ID`),
  CONSTRAINT `FKiisj0tmoujv6n3iqmytvo39kn` FOREIGN KEY (`stores_MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`),
  CONSTRAINT `FKjwy0pjijh1qmcoivq50o2jgec` FOREIGN KEY (`languages_LANGUAGE_ID`) REFERENCES `LANGUAGE` (`LANGUAGE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MERCHANT_LANGUAGE`
--

LOCK TABLES `MERCHANT_LANGUAGE` WRITE;
/*!40000 ALTER TABLE `MERCHANT_LANGUAGE` DISABLE KEYS */;
INSERT INTO `MERCHANT_LANGUAGE` VALUES (1,50),(1,51),(1,52),(1,53);
/*!40000 ALTER TABLE `MERCHANT_LANGUAGE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MERCHANT_LOG`
--

DROP TABLE IF EXISTS `MERCHANT_LOG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MERCHANT_LOG` (
  `MERCHANT_LOG_ID` bigint NOT NULL,
  `LOG` longtext,
  `MODULE` varchar(25) DEFAULT NULL,
  `MERCHANT_ID` int NOT NULL,
  PRIMARY KEY (`MERCHANT_LOG_ID`),
  KEY `FKto727b9r68qrtn2vvdqdvd4ic` (`MERCHANT_ID`),
  CONSTRAINT `FKto727b9r68qrtn2vvdqdvd4ic` FOREIGN KEY (`MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MERCHANT_LOG`
--

LOCK TABLES `MERCHANT_LOG` WRITE;
/*!40000 ALTER TABLE `MERCHANT_LOG` DISABLE KEYS */;
/*!40000 ALTER TABLE `MERCHANT_LOG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MERCHANT_STORE`
--

DROP TABLE IF EXISTS `MERCHANT_STORE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MERCHANT_STORE` (
  `MERCHANT_ID` int NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `STORE_CODE` varchar(100) NOT NULL,
  `CONTINUESHOPPINGURL` varchar(150) DEFAULT NULL,
  `CURRENCY_FORMAT_NATIONAL` bit(1) DEFAULT NULL,
  `DOMAIN_NAME` varchar(80) DEFAULT NULL,
  `IN_BUSINESS_SINCE` date DEFAULT NULL,
  `INVOICE_TEMPLATE` varchar(25) DEFAULT NULL,
  `IS_RETAILER` bit(1) DEFAULT NULL,
  `SEIZEUNITCODE` varchar(5) DEFAULT NULL,
  `STORE_EMAIL` varchar(60) NOT NULL,
  `STORE_LOGO` varchar(100) DEFAULT NULL,
  `STORE_TEMPLATE` varchar(25) DEFAULT NULL,
  `STORE_ADDRESS` varchar(255) DEFAULT NULL,
  `STORE_CITY` varchar(100) DEFAULT NULL,
  `STORE_NAME` varchar(100) NOT NULL,
  `STORE_PHONE` varchar(50) DEFAULT NULL,
  `STORE_POSTAL_CODE` varchar(15) DEFAULT NULL,
  `STORE_STATE_PROV` varchar(100) DEFAULT NULL,
  `USE_CACHE` bit(1) DEFAULT NULL,
  `WEIGHTUNITCODE` varchar(5) DEFAULT NULL,
  `COUNTRY_ID` int NOT NULL,
  `CURRENCY_ID` bigint NOT NULL,
  `LANGUAGE_ID` int NOT NULL,
  `PARENT_ID` int DEFAULT NULL,
  `ZONE_ID` bigint DEFAULT NULL,
  PRIMARY KEY (`MERCHANT_ID`),
  UNIQUE KEY `UK_4pvtsnqv4nlao8725n9ldpguf` (`STORE_CODE`),
  KEY `FK2gn7vpkd9x832urw7c6jlawnn` (`COUNTRY_ID`),
  KEY `FK63hlw9wp1k1x3f5tke7t2us7s` (`CURRENCY_ID`),
  KEY `FKdnemo9tl8tjhkxko83psvkv19` (`LANGUAGE_ID`),
  KEY `FKgkoele515h76u39b9defibkm9` (`PARENT_ID`),
  KEY `FK5o24aky9161jyofyxmg0g53vv` (`ZONE_ID`),
  CONSTRAINT `FK2gn7vpkd9x832urw7c6jlawnn` FOREIGN KEY (`COUNTRY_ID`) REFERENCES `COUNTRY` (`COUNTRY_ID`),
  CONSTRAINT `FK5o24aky9161jyofyxmg0g53vv` FOREIGN KEY (`ZONE_ID`) REFERENCES `ZONE` (`ZONE_ID`),
  CONSTRAINT `FK63hlw9wp1k1x3f5tke7t2us7s` FOREIGN KEY (`CURRENCY_ID`) REFERENCES `CURRENCY` (`CURRENCY_ID`),
  CONSTRAINT `FKdnemo9tl8tjhkxko83psvkv19` FOREIGN KEY (`LANGUAGE_ID`) REFERENCES `LANGUAGE` (`LANGUAGE_ID`),
  CONSTRAINT `FKgkoele515h76u39b9defibkm9` FOREIGN KEY (`PARENT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MERCHANT_STORE`
--

LOCK TABLES `MERCHANT_STORE` WRITE;
/*!40000 ALTER TABLE `MERCHANT_STORE` DISABLE KEYS */;
INSERT INTO `MERCHANT_STORE` VALUES (1,NULL,NULL,NULL,'DEFAULT',NULL,_binary '\0','','2026-09-19',NULL,_binary '\0','IN','anlacduyen01@gmail.com','logo.jpg','exoticamobilia','đường phố đêm xứ Trảng','Trảng Bàng','Bách Hóa An Lạc Duyên','0949777111','80000','',_binary '\0','LB',479,81,50,NULL,74);
/*!40000 ALTER TABLE `MERCHANT_STORE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MODULE_CONFIGURATION`
--

DROP TABLE IF EXISTS `MODULE_CONFIGURATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MODULE_CONFIGURATION` (
  `MODULE_CONF_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `CODE` varchar(255) NOT NULL,
  `DETAILS` longtext,
  `CONFIGURATION` varchar(4000) DEFAULT NULL,
  `CUSTOM_IND` bit(1) DEFAULT NULL,
  `IMAGE` varchar(255) DEFAULT NULL,
  `MODULE` varchar(255) DEFAULT NULL,
  `REGIONS` varchar(255) DEFAULT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`MODULE_CONF_ID`),
  KEY `MODULE_CONFIGURATION_MODULE` (`MODULE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MODULE_CONFIGURATION`
--

LOCK TABLES `MODULE_CONFIGURATION` WRITE;
/*!40000 ALTER TABLE `MODULE_CONFIGURATION` DISABLE KEYS */;
INSERT INTO `MODULE_CONFIGURATION` VALUES (1,'2026-09-19 00:40:04','2026-09-19 00:40:04',NULL,'usps',NULL,'[{\"scheme\":\"http\",\"host\":\"testing.shippingapis.com\",\"port\":\"80\",\"uri\":\"/ShippingAPI.dll\",\"env\":\"TEST\",\"config1\":null,\"config2\":null},{\"scheme\":\"http\",\"host\":\"production.shippingapis.com\",\"port\":\"80\",\"uri\":\"/ShippingAPI.dll\",\"env\":\"PROD\",\"config1\":null,\"config2\":null}]',_binary '\0','usps.jpg','SHIPPING','[\"US\"]',NULL),(2,'2026-09-19 00:40:04','2026-09-19 00:40:04',NULL,'canadapost',NULL,'[{\"scheme\":\"https\",\"host\":\"ct.soa-gw.canadapost.ca\",\"port\":\"443\",\"uri\":\"/rs/ship/price\",\"env\":\"TEST\",\"config1\":null,\"config2\":null},{\"scheme\":\"https\",\"host\":\"soa-gw.canadapost.ca\",\"port\":\"443\",\"uri\":\"/rs/ship/price\",\"env\":\"PROD\",\"config1\":null,\"config2\":null}]',_binary '\0','canadapost.jpg','SHIPPING','[\"CA\"]',NULL),(3,'2026-09-19 00:40:04','2026-09-19 00:40:04',NULL,'ups','{\"01\":\"UPS Next Day Air\",\"02\":\"UPS Second Day Air\",\"03\":\"UPS Ground\",\"07\":\"UPS Worldwide Express\",\"08\":\"UPS Worldwide Expedited\",\"11\":\"UPS Standard\",\"12\":\"UPS Three-Day Select\",\"13\":\"UPS Next Day Air Saver\",\"14\":\"UPS Next Day Air Early A.M.\",\"54\":\"UPS Worldwide Express Plus\",\"59\":\"UPS Second Day Air A.M.\",\"69\":\"UPS Saver\"}','[{\"scheme\":\"https\",\"host\":\"wwwcie.ups.com\",\"port\":\"443\",\"uri\":\"/ups.app/xml/Rate\",\"env\":\"TEST\",\"config1\":null,\"config2\":null},{\"scheme\":\"https\",\"host\":\"onlinetools.ups.com\",\"port\":\"443\",\"uri\":\"/xml/Rate\",\"env\":\"PROD\",\"config1\":null,\"config2\":null}]',_binary '\0','ups.jpg','SHIPPING','[\"US\",\"CA\",\"FR\",\"GB\"]',NULL),(4,'2026-09-19 00:40:04','2026-09-19 00:40:04',NULL,'weightBased',NULL,NULL,_binary '',NULL,'SHIPPING','[\"*\"]',NULL),(5,'2026-09-19 00:40:04','2026-09-19 00:40:04',NULL,'customQuotesRules',NULL,NULL,_binary '\0',NULL,'SHIPPING','[\"*\"]',NULL),(6,'2026-09-19 00:40:04','2026-09-19 00:40:04',NULL,'priceByDistance',NULL,NULL,_binary '\0',NULL,'SHIPPING','[\"*\"]',NULL),(7,'2026-09-19 00:40:04','2026-09-19 00:40:04',NULL,'storePickUp',NULL,NULL,_binary '\0',NULL,'SHIPPING','[\"*\"]',NULL),(8,'2026-09-19 00:40:04','2026-09-19 00:40:04',NULL,'moneyorder',NULL,NULL,_binary '\0','moneyorder.gif','PAYMENT','[\"*\"]','moneyorder'),(9,'2026-09-19 00:40:04','2026-09-19 00:40:04',NULL,'paypal-express-checkout',NULL,'[{\"scheme\":\"\",\"host\":\"\",\"port\":\"\",\"uri\":\"\",\"env\":\"TEST\",\"config1\":\"https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=\",\"config2\":null},{\"scheme\":\"\",\"host\":\"\",\"port\":\"\",\"uri\":\"\",\"env\":\"PROD\",\"config1\":\"https://www.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=\",\"config2\":null}]',_binary '\0','icon-paypal.png','PAYMENT','[\"*\"]','paypal'),(10,'2026-09-19 00:40:04','2026-09-19 00:40:04',NULL,'beanstream',NULL,'[{\"scheme\":\"https\",\"host\":\"www.beanstream.com\",\"port\":\"443\",\"uri\":\"/scripts/process_transaction.asp\",\"env\":\"TEST\",\"config1\":null,\"config2\":null},{\"scheme\":\"https\",\"host\":\"www.beanstream.com\",\"port\":\"443\",\"uri\":\"/scripts/process_transaction.asp\",\"env\":\"PROD\",\"config1\":null,\"config2\":null}]',_binary '\0','beanstream.gif','PAYMENT','[\"US\",\"CA\",\"GB\"]','creditcard'),(11,'2026-09-19 00:40:04','2026-09-19 00:40:04',NULL,'stripe',NULL,'[{\"scheme\":\"https\",\"host\":\"www.stripe.com\",\"port\":\"443\",\"uri\":\"/\",\"env\":\"TEST\",\"config1\":null,\"config2\":null},{\"scheme\":\"https\",\"host\":\"www.stripe.com\",\"port\":\"443\",\"uri\":\"/\",\"env\":\"PROD\",\"config1\":null,\"config2\":null}]',_binary '\0','stripe.png','PAYMENT','[\"US\",\"CA\",\"GB\",\"AU\",\"FI\",\"DK\",\"IE\",\"NO\",\"SE\",\"ES\",\"PT\"]','creditcard'),(12,'2026-09-19 00:40:04','2026-09-19 00:40:04',NULL,'stripe3',NULL,'[{\"scheme\":\"https\",\"host\":\"www.stripe.com\",\"port\":\"443\",\"uri\":\"/\",\"env\":\"TEST\",\"config1\":null,\"config2\":null},{\"scheme\":\"https\",\"host\":\"www.stripe.com\",\"port\":\"443\",\"uri\":\"/\",\"env\":\"PROD\",\"config1\":null,\"config2\":null}]',_binary '\0','stripe.png','PAYMENT','[\"US\",\"CA\",\"GB\",\"AU\",\"FI\",\"DK\",\"IE\",\"NO\",\"SE\",\"ES\",\"PT\"]','creditcard'),(13,'2026-09-19 00:40:04','2026-09-19 00:40:04',NULL,'braintree',NULL,'[{\"scheme\":\"https\",\"host\":\"NOTREQUIRED\",\"port\":\"NOTREQUIRED\",\"uri\":\"NOTREQUIRED\",\"env\":\"TEST\",\"config1\":null,\"config2\":null},{\"scheme\":\"https\",\"host\":\"NOTREQUIRED\",\"port\":\"NOTREQUIRED\",\"uri\":\"NOTREQUIRED\",\"env\":\"PROD\",\"config1\":null,\"config2\":null}]',_binary '\0','braintree.jpg','PAYMENT','[\"US\",\"CA\",\"GB\",\"AU\",\"FI\",\"DK\",\"IE\",\"NO\",\"SE\",\"AL\",\"AD\",\"AT\",\"BY\",\"BE\",\"BG\",\"HY\",\"CY\",\"CZ\",\"FR\",\"GR\",\"IS\",\"IE\",\"IM\",\"IT\",\"PL\",\"LU\",\"CH\",\"RS\",\"SG\",\"MY\",\"HK\",\"NZ\"]','creditcard');
/*!40000 ALTER TABLE `MODULE_CONFIGURATION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OPTIN`
--

DROP TABLE IF EXISTS `OPTIN`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OPTIN` (
  `OPTIN_ID` bigint NOT NULL,
  `CODE` varchar(255) NOT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `END_DATE` datetime DEFAULT NULL,
  `TYPE` varchar(255) NOT NULL,
  `START_DATE` datetime DEFAULT NULL,
  `MERCHANT_ID` int DEFAULT NULL,
  PRIMARY KEY (`OPTIN_ID`),
  UNIQUE KEY `UKmanlx6siq6ddf14cud40k8gw6` (`MERCHANT_ID`,`CODE`),
  CONSTRAINT `FK37xvfo4the20avv7f1e1771fh` FOREIGN KEY (`MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OPTIN`
--

LOCK TABLES `OPTIN` WRITE;
/*!40000 ALTER TABLE `OPTIN` DISABLE KEYS */;
INSERT INTO `OPTIN` VALUES (1,'NEWSLETTER',NULL,NULL,'NEWSLETTER',NULL,1);
/*!40000 ALTER TABLE `OPTIN` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ORDERS`
--

DROP TABLE IF EXISTS `ORDERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ORDERS` (
  `ORDER_ID` bigint NOT NULL,
  `BILLING_STREET_ADDRESS` varchar(256) DEFAULT NULL,
  `BILLING_CITY` varchar(100) DEFAULT NULL,
  `BILLING_COMPANY` varchar(100) DEFAULT NULL,
  `BILLING_FIRST_NAME` varchar(64) NOT NULL,
  `BILLING_LAST_NAME` varchar(64) NOT NULL,
  `LATITUDE` varchar(100) DEFAULT NULL,
  `LONGITUDE` varchar(100) DEFAULT NULL,
  `BILLING_POSTCODE` varchar(20) DEFAULT NULL,
  `BILLING_STATE` varchar(100) DEFAULT NULL,
  `BILLING_TELEPHONE` varchar(32) DEFAULT NULL,
  `CHANNEL` varchar(255) DEFAULT NULL,
  `CONFIRMED_ADDRESS` bit(1) DEFAULT NULL,
  `CARD_TYPE` varchar(255) DEFAULT NULL,
  `CC_CVV` varchar(255) DEFAULT NULL,
  `CC_EXPIRES` varchar(255) DEFAULT NULL,
  `CC_NUMBER` varchar(255) DEFAULT NULL,
  `CC_OWNER` varchar(255) DEFAULT NULL,
  `CURRENCY_VALUE` decimal(19,2) DEFAULT NULL,
  `CUSTOMER_AGREED` bit(1) DEFAULT NULL,
  `CUSTOMER_EMAIL_ADDRESS` varchar(50) NOT NULL,
  `CUSTOMER_ID` bigint DEFAULT NULL,
  `DATE_PURCHASED` date DEFAULT NULL,
  `DELIVERY_STREET_ADDRESS` varchar(256) DEFAULT NULL,
  `DELIVERY_CITY` varchar(100) DEFAULT NULL,
  `DELIVERY_COMPANY` varchar(100) DEFAULT NULL,
  `DELIVERY_FIRST_NAME` varchar(64) DEFAULT NULL,
  `DELIVERY_LAST_NAME` varchar(64) DEFAULT NULL,
  `DELIVERY_POSTCODE` varchar(20) DEFAULT NULL,
  `DELIVERY_STATE` varchar(100) DEFAULT NULL,
  `DELIVERY_TELEPHONE` varchar(32) DEFAULT NULL,
  `IP_ADDRESS` varchar(255) DEFAULT NULL,
  `LAST_MODIFIED` datetime DEFAULT NULL,
  `LOCALE` varchar(255) DEFAULT NULL,
  `ORDER_DATE_FINISHED` datetime DEFAULT NULL,
  `ORDER_TYPE` varchar(255) DEFAULT NULL,
  `PAYMENT_MODULE_CODE` varchar(255) DEFAULT NULL,
  `PAYMENT_TYPE` varchar(255) DEFAULT NULL,
  `SHIPPING_MODULE_CODE` varchar(255) DEFAULT NULL,
  `CART_CODE` varchar(255) DEFAULT NULL,
  `ORDER_STATUS` varchar(255) DEFAULT NULL,
  `ORDER_TOTAL` decimal(19,2) DEFAULT NULL,
  `BILLING_COUNTRY_ID` int NOT NULL,
  `BILLING_ZONE_ID` bigint DEFAULT NULL,
  `CURRENCY_ID` bigint DEFAULT NULL,
  `DELIVERY_COUNTRY_ID` int DEFAULT NULL,
  `DELIVERY_ZONE_ID` bigint DEFAULT NULL,
  `MERCHANTID` int DEFAULT NULL,
  PRIMARY KEY (`ORDER_ID`),
  KEY `FKipesu5tupnriahutgle6xu9ed` (`BILLING_COUNTRY_ID`),
  KEY `FKit6ti99mv5uvuxqskhurv3y59` (`BILLING_ZONE_ID`),
  KEY `FKfusivmw6q3gjxnmp47n9s74qi` (`CURRENCY_ID`),
  KEY `FKnlx97vjyorunxglhy5bird06c` (`DELIVERY_COUNTRY_ID`),
  KEY `FKn9uvjl8105fsly4doo8rqnv5b` (`DELIVERY_ZONE_ID`),
  KEY `FKaodv5ffayq8x50q311o2y8m1` (`MERCHANTID`),
  CONSTRAINT `FKaodv5ffayq8x50q311o2y8m1` FOREIGN KEY (`MERCHANTID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`),
  CONSTRAINT `FKfusivmw6q3gjxnmp47n9s74qi` FOREIGN KEY (`CURRENCY_ID`) REFERENCES `CURRENCY` (`CURRENCY_ID`),
  CONSTRAINT `FKipesu5tupnriahutgle6xu9ed` FOREIGN KEY (`BILLING_COUNTRY_ID`) REFERENCES `COUNTRY` (`COUNTRY_ID`),
  CONSTRAINT `FKit6ti99mv5uvuxqskhurv3y59` FOREIGN KEY (`BILLING_ZONE_ID`) REFERENCES `ZONE` (`ZONE_ID`),
  CONSTRAINT `FKn9uvjl8105fsly4doo8rqnv5b` FOREIGN KEY (`DELIVERY_ZONE_ID`) REFERENCES `ZONE` (`ZONE_ID`),
  CONSTRAINT `FKnlx97vjyorunxglhy5bird06c` FOREIGN KEY (`DELIVERY_COUNTRY_ID`) REFERENCES `COUNTRY` (`COUNTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ORDERS`
--

LOCK TABLES `ORDERS` WRITE;
/*!40000 ALTER TABLE `ORDERS` DISABLE KEYS */;
INSERT INTO `ORDERS` VALUES (1,'số 4 đường Chùa am','Trảng Bàng','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '','levatienamakhe@gmail.com',1,'2026-09-19','số 4 đường Chùa am','Trảng Bàng','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','fb8d4645731f4fdc8e60ba9e3f53a8b9','ORDERED',600140.00,479,NULL,81,479,NULL,1),(50,'số 4 đường Chùa am','Trảng Bàng','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '','levatienamakhe@gmail.com',1,'2026-09-19','số 4 đường Chùa am','Trảng Bàng','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','ffe2bb26abbb4e4b956e6284de152688','ORDERED',200140.00,479,74,81,479,74,1),(51,'số 4 đường Chùa am','Trảng Bàng','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '','levatienamakhe@gmail.com',1,'2026-09-19','số 4 đường Chùa am','Trảng Bàng','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','8b674fd47bff44979eef765ed1947da6','ORDERED',200140.00,479,NULL,81,479,NULL,1),(100,'số 4 đường Chùa am','Trảng Bàng','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '','levatienamakhe@gmail.com',1,'2026-09-19','số 4 đường Chùa am','Trảng Bàng','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','a266994c0a444518bec17f48b30f618f','ORDERED',200140.00,479,NULL,81,479,NULL,1),(150,'số 4 đường Chùa am','Trảng Bàng','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','levatienamakhe@gmail.com',1,'2026-09-19','số 4 đường Chùa am','Trảng Bàng','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','b4587a87705f44be844570300e5da0ec','ORDERED',200140.00,479,NULL,81,479,NULL,1),(200,'số 4 đường Chùa am','Trảng Bàng','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','levatienamakhe@gmail.com',1,'2026-09-19','số 4 đường Chùa am','Trảng Bàng','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','72345145184a401da66c022352682871','ORDERED',200140.00,479,NULL,81,479,NULL,1),(250,'số 4 đường Chùa am','Trảng Bàng','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','levatienamakhe@gmail.com',1,'2026-09-19','số 4 đường Chùa am','Trảng Bàng','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','7829036ac0ea47e9af398cbf23f457c3','ORDERED',200140.00,479,NULL,81,479,NULL,1),(251,'số 4 đường Chùa am','Trảng Bàng','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','levatienamakhe@gmail.com',1,'2026-09-19','số 4 đường Chùa am','Trảng Bàng','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','storePickUp','8e5579adbc194c0fa47b0bd300344c56','ORDERED',200000.00,479,NULL,81,479,NULL,1),(300,'số 4 đường Chùa am','Trảng Bàng','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','levatienamakhe@gmail.com',1,'2026-09-20','số 4 đường Chùa am','Trảng Bàng','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'vi',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','86afcc6958f94ea1b98313dc25f413c8','ORDERED',250140.00,479,NULL,81,479,NULL,1),(350,'số 4 đường Chùa am','Trảng Bàng','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','levatienamakhe@gmail.com',1,'2026-09-20','số 4 đường Chùa am','Trảng Bàng','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','3e00f7b02dc84e8db5375d6923c2a10d','ORDERED',250140.00,479,NULL,81,479,NULL,1);
/*!40000 ALTER TABLE `ORDERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ORDER_ACCOUNT`
--

DROP TABLE IF EXISTS `ORDER_ACCOUNT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ORDER_ACCOUNT` (
  `ORDER_ACCOUNT_ID` bigint NOT NULL,
  `ORDER_ACCOUNT_BILL_DAY` int NOT NULL,
  `ORDER_ACCOUNT_END_DATE` date DEFAULT NULL,
  `ORDER_ACCOUNT_START_DATE` date NOT NULL,
  `ORDER_ID` bigint NOT NULL,
  PRIMARY KEY (`ORDER_ACCOUNT_ID`),
  KEY `FKi6l5isodh81m5hy8ua06hx73n` (`ORDER_ID`),
  CONSTRAINT `FKi6l5isodh81m5hy8ua06hx73n` FOREIGN KEY (`ORDER_ID`) REFERENCES `ORDERS` (`ORDER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ORDER_ACCOUNT`
--

LOCK TABLES `ORDER_ACCOUNT` WRITE;
/*!40000 ALTER TABLE `ORDER_ACCOUNT` DISABLE KEYS */;
/*!40000 ALTER TABLE `ORDER_ACCOUNT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ORDER_ACCOUNT_PRODUCT`
--

DROP TABLE IF EXISTS `ORDER_ACCOUNT_PRODUCT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ORDER_ACCOUNT_PRODUCT` (
  `ORDER_ACCOUNT_PRODUCT_ID` bigint NOT NULL,
  `ORDER_ACCOUNT_PRODUCT_ACCNT_DT` date DEFAULT NULL,
  `ORDER_ACCOUNT_PRODUCT_END_DT` date DEFAULT NULL,
  `ORDER_ACCOUNT_PRODUCT_EOT` datetime DEFAULT NULL,
  `ORDER_ACCOUNT_PRODUCT_L_ST_DT` datetime DEFAULT NULL,
  `ORDER_ACCOUNT_PRODUCT_L_TRX_ST` int NOT NULL,
  `ORDER_ACCOUNT_PRODUCT_PM_FR_TY` int NOT NULL,
  `ORDER_ACCOUNT_PRODUCT_ST_DT` date NOT NULL,
  `ORDER_ACCOUNT_PRODUCT_STATUS` int NOT NULL,
  `ORDER_ACCOUNT_ID` bigint NOT NULL,
  `ORDER_PRODUCT_ID` bigint NOT NULL,
  PRIMARY KEY (`ORDER_ACCOUNT_PRODUCT_ID`),
  KEY `FK7oxc8ygov7vd2ajt185jhiwts` (`ORDER_ACCOUNT_ID`),
  KEY `FK5kiyyb8ekqi9bfowytww8atcx` (`ORDER_PRODUCT_ID`),
  CONSTRAINT `FK5kiyyb8ekqi9bfowytww8atcx` FOREIGN KEY (`ORDER_PRODUCT_ID`) REFERENCES `ORDER_PRODUCT` (`ORDER_PRODUCT_ID`),
  CONSTRAINT `FK7oxc8ygov7vd2ajt185jhiwts` FOREIGN KEY (`ORDER_ACCOUNT_ID`) REFERENCES `ORDER_ACCOUNT` (`ORDER_ACCOUNT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ORDER_ACCOUNT_PRODUCT`
--

LOCK TABLES `ORDER_ACCOUNT_PRODUCT` WRITE;
/*!40000 ALTER TABLE `ORDER_ACCOUNT_PRODUCT` DISABLE KEYS */;
/*!40000 ALTER TABLE `ORDER_ACCOUNT_PRODUCT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ORDER_ATTRIBUTE`
--

DROP TABLE IF EXISTS `ORDER_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ORDER_ATTRIBUTE` (
  `ORDER_ATTRIBUTE_ID` bigint NOT NULL,
  `IDENTIFIER` varchar(255) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  `ORDER_ID` bigint NOT NULL,
  PRIMARY KEY (`ORDER_ATTRIBUTE_ID`),
  KEY `FK4nw5yrtgb4in6leve76bmdnua` (`ORDER_ID`),
  CONSTRAINT `FK4nw5yrtgb4in6leve76bmdnua` FOREIGN KEY (`ORDER_ID`) REFERENCES `ORDERS` (`ORDER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ORDER_ATTRIBUTE`
--

LOCK TABLES `ORDER_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `ORDER_ATTRIBUTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `ORDER_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ORDER_PRODUCT`
--

DROP TABLE IF EXISTS `ORDER_PRODUCT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ORDER_PRODUCT` (
  `ORDER_PRODUCT_ID` bigint NOT NULL,
  `ONETIME_CHARGE` decimal(19,2) NOT NULL,
  `PRODUCT_NAME` varchar(64) NOT NULL,
  `PRODUCT_QUANTITY` int DEFAULT NULL,
  `PRODUCT_SKU` varchar(255) DEFAULT NULL,
  `ORDER_ID` bigint NOT NULL,
  PRIMARY KEY (`ORDER_PRODUCT_ID`),
  KEY `FKf0sghmn59s14cxrjtrvkvi5yk` (`ORDER_ID`),
  CONSTRAINT `FKf0sghmn59s14cxrjtrvkvi5yk` FOREIGN KEY (`ORDER_ID`) REFERENCES `ORDERS` (`ORDER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ORDER_PRODUCT`
--

LOCK TABLES `ORDER_PRODUCT` WRITE;
/*!40000 ALTER TABLE `ORDER_PRODUCT` DISABLE KEYS */;
INSERT INTO `ORDER_PRODUCT` VALUES (1,200000.00,'ST25',2,'SP1',1),(2,200000.00,'ST25',1,'SP1',1),(50,200000.00,'ST25',1,'SP1',50),(51,200000.00,'ST25',1,'SP1',51),(100,200000.00,'ST25',1,'SP1',100),(150,200000.00,'ST25',1,'SP1',150),(200,200000.00,'ST25',1,'SP1',200),(250,200000.00,'ST25',1,'SP1',250),(251,200000.00,'ST25',1,'SP1',251),(300,250000.00,'ST25',1,'SP1',300),(350,250000.00,'ST25',1,'SP1',350);
/*!40000 ALTER TABLE `ORDER_PRODUCT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ORDER_PRODUCT_ATTRIBUTE`
--

DROP TABLE IF EXISTS `ORDER_PRODUCT_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ORDER_PRODUCT_ATTRIBUTE` (
  `ORDER_PRODUCT_ATTRIBUTE_ID` bigint NOT NULL,
  `PRODUCT_ATTRIBUTE_IS_FREE` bit(1) NOT NULL,
  `PRODUCT_ATTRIBUTE_NAME` varchar(255) DEFAULT NULL,
  `PRODUCT_ATTRIBUTE_PRICE` decimal(15,4) NOT NULL,
  `PRODUCT_ATTRIBUTE_VAL_NAME` varchar(255) DEFAULT NULL,
  `PRODUCT_ATTRIBUTE_WEIGHT` decimal(15,4) DEFAULT NULL,
  `PRODUCT_OPTION_ID` bigint NOT NULL,
  `PRODUCT_OPTION_VALUE_ID` bigint NOT NULL,
  `ORDER_PRODUCT_ID` bigint NOT NULL,
  PRIMARY KEY (`ORDER_PRODUCT_ATTRIBUTE_ID`),
  KEY `FK7j86rvwaysbok1nuofrnmhmkx` (`ORDER_PRODUCT_ID`),
  CONSTRAINT `FK7j86rvwaysbok1nuofrnmhmkx` FOREIGN KEY (`ORDER_PRODUCT_ID`) REFERENCES `ORDER_PRODUCT` (`ORDER_PRODUCT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ORDER_PRODUCT_ATTRIBUTE`
--

LOCK TABLES `ORDER_PRODUCT_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `ORDER_PRODUCT_ATTRIBUTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `ORDER_PRODUCT_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ORDER_PRODUCT_DOWNLOAD`
--

DROP TABLE IF EXISTS `ORDER_PRODUCT_DOWNLOAD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ORDER_PRODUCT_DOWNLOAD` (
  `ORDER_PRODUCT_DOWNLOAD_ID` bigint NOT NULL,
  `DOWNLOAD_COUNT` int NOT NULL,
  `DOWNLOAD_MAXDAYS` int NOT NULL,
  `ORDER_PRODUCT_FILENAME` varchar(255) NOT NULL,
  `ORDER_PRODUCT_ID` bigint NOT NULL,
  PRIMARY KEY (`ORDER_PRODUCT_DOWNLOAD_ID`),
  KEY `FKstrda0eweharld63j8pxa2o2r` (`ORDER_PRODUCT_ID`),
  CONSTRAINT `FKstrda0eweharld63j8pxa2o2r` FOREIGN KEY (`ORDER_PRODUCT_ID`) REFERENCES `ORDER_PRODUCT` (`ORDER_PRODUCT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ORDER_PRODUCT_DOWNLOAD`
--

LOCK TABLES `ORDER_PRODUCT_DOWNLOAD` WRITE;
/*!40000 ALTER TABLE `ORDER_PRODUCT_DOWNLOAD` DISABLE KEYS */;
/*!40000 ALTER TABLE `ORDER_PRODUCT_DOWNLOAD` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ORDER_PRODUCT_PRICE`
--

DROP TABLE IF EXISTS `ORDER_PRODUCT_PRICE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ORDER_PRODUCT_PRICE` (
  `ORDER_PRODUCT_PRICE_ID` bigint NOT NULL,
  `DEFAULT_PRICE` bit(1) NOT NULL,
  `PRODUCT_PRICE` decimal(19,2) NOT NULL,
  `PRODUCT_PRICE_CODE` varchar(64) NOT NULL,
  `PRODUCT_PRICE_NAME` varchar(255) DEFAULT NULL,
  `PRODUCT_PRICE_SPECIAL` decimal(19,2) DEFAULT NULL,
  `PRD_PRICE_SPECIAL_END_DT` datetime DEFAULT NULL,
  `PRD_PRICE_SPECIAL_ST_DT` datetime DEFAULT NULL,
  `ORDER_PRODUCT_ID` bigint NOT NULL,
  PRIMARY KEY (`ORDER_PRODUCT_PRICE_ID`),
  KEY `FKnkukiqxrieonyulercgnh857s` (`ORDER_PRODUCT_ID`),
  CONSTRAINT `FKnkukiqxrieonyulercgnh857s` FOREIGN KEY (`ORDER_PRODUCT_ID`) REFERENCES `ORDER_PRODUCT` (`ORDER_PRODUCT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ORDER_PRODUCT_PRICE`
--

LOCK TABLES `ORDER_PRODUCT_PRICE` WRITE;
/*!40000 ALTER TABLE `ORDER_PRODUCT_PRICE` DISABLE KEYS */;
INSERT INTO `ORDER_PRODUCT_PRICE` VALUES (1,_binary '',200000.00,'base','ST25',200000.00,'2026-09-19 17:00:00','2026-09-18 17:00:00',1),(2,_binary '',200000.00,'base','ST25',200000.00,'2026-09-19 17:00:00','2026-09-18 17:00:00',2),(50,_binary '',200000.00,'base','ST25',200000.00,'2026-09-19 17:00:00','2026-09-18 17:00:00',50),(51,_binary '',200000.00,'base','ST25',200000.00,'2026-09-19 17:00:00','2026-09-18 17:00:00',51),(100,_binary '',200000.00,'base','ST25',200000.00,'2026-09-19 17:00:00','2026-09-18 17:00:00',100),(150,_binary '',200000.00,'base','ST25',200000.00,'2026-09-19 17:00:00','2026-09-18 17:00:00',150),(200,_binary '',200000.00,'base','ST25',200000.00,'2026-09-19 17:00:00','2026-09-18 17:00:00',200),(250,_binary '',200000.00,'base','ST25',200000.00,'2026-09-19 17:00:00','2026-09-18 17:00:00',250),(251,_binary '',200000.00,'base','ST25',200000.00,'2026-09-19 17:00:00','2026-09-18 17:00:00',251),(300,_binary '',250000.00,'base','ST25',NULL,NULL,NULL,300),(350,_binary '',250000.00,'base','ST25',NULL,NULL,NULL,350);
/*!40000 ALTER TABLE `ORDER_PRODUCT_PRICE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ORDER_STATUS_HISTORY`
--

DROP TABLE IF EXISTS `ORDER_STATUS_HISTORY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ORDER_STATUS_HISTORY` (
  `ORDER_STATUS_HISTORY_ID` bigint NOT NULL,
  `COMMENTS` longtext,
  `CUSTOMER_NOTIFIED` int DEFAULT NULL,
  `DATE_ADDED` datetime NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `ORDER_ID` bigint NOT NULL,
  PRIMARY KEY (`ORDER_STATUS_HISTORY_ID`),
  KEY `FKmhghgf1xy3o0npsp8xkj6wyvq` (`ORDER_ID`),
  CONSTRAINT `FKmhghgf1xy3o0npsp8xkj6wyvq` FOREIGN KEY (`ORDER_ID`) REFERENCES `ORDERS` (`ORDER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ORDER_STATUS_HISTORY`
--

LOCK TABLES `ORDER_STATUS_HISTORY` WRITE;
/*!40000 ALTER TABLE `ORDER_STATUS_HISTORY` DISABLE KEYS */;
INSERT INTO `ORDER_STATUS_HISTORY` VALUES (1,NULL,NULL,'2026-09-19 02:01:44','ORDERED',1),(50,NULL,NULL,'2026-09-19 03:03:12','ORDERED',50),(51,NULL,NULL,'2026-09-19 03:10:27','ORDERED',51),(100,NULL,NULL,'2026-09-19 03:25:36','ORDERED',100),(150,NULL,NULL,'2026-09-19 08:59:06','ORDERED',150),(200,NULL,NULL,'2026-09-19 09:08:33','ORDERED',200),(250,NULL,NULL,'2026-09-19 09:29:19','ORDERED',250),(251,NULL,NULL,'2026-09-19 09:30:41','ORDERED',251),(300,NULL,NULL,'2026-09-20 01:10:12','ORDERED',300),(350,NULL,NULL,'2026-09-20 01:23:02','ORDERED',350);
/*!40000 ALTER TABLE `ORDER_STATUS_HISTORY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ORDER_TOTAL`
--

DROP TABLE IF EXISTS `ORDER_TOTAL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ORDER_TOTAL` (
  `ORDER_ACCOUNT_ID` bigint NOT NULL,
  `MODULE` varchar(60) DEFAULT NULL,
  `CODE` varchar(255) NOT NULL,
  `ORDER_TOTAL_TYPE` varchar(255) DEFAULT NULL,
  `ORDER_VALUE_TYPE` varchar(255) DEFAULT NULL,
  `SORT_ORDER` int NOT NULL,
  `TEXT` longtext,
  `TITLE` varchar(255) DEFAULT NULL,
  `VALUE` decimal(15,4) NOT NULL,
  `ORDER_ID` bigint NOT NULL,
  PRIMARY KEY (`ORDER_ACCOUNT_ID`),
  KEY `FK1tfvgk5smm80efdcc8uop4he3` (`ORDER_ID`),
  CONSTRAINT `FK1tfvgk5smm80efdcc8uop4he3` FOREIGN KEY (`ORDER_ID`) REFERENCES `ORDERS` (`ORDER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ORDER_TOTAL`
--

LOCK TABLES `ORDER_TOTAL` WRITE;
/*!40000 ALTER TABLE `ORDER_TOTAL` DISABLE KEYS */;
INSERT INTO `ORDER_TOTAL` VALUES (1,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',600000.0000,1),(2,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,1),(3,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',600140.0000,1),(50,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,50),(51,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,50),(52,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,50),(53,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,51),(54,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,51),(55,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,51),(100,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,100),(101,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,100),(102,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,100),(150,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,150),(151,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,150),(152,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,150),(200,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,200),(201,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,200),(202,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,200),(250,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,250),(251,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,250),(252,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,250),(253,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,251),(254,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',0.0000,251),(255,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200000.0000,251),(300,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',250000.0000,300),(301,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,300),(302,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',250140.0000,300),(350,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',250000.0000,350),(351,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,350),(352,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',250140.0000,350);
/*!40000 ALTER TABLE `ORDER_TOTAL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PERMISSION`
--

DROP TABLE IF EXISTS `PERMISSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PERMISSION` (
  `PERMISSION_ID` int NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `PERMISSION_NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`PERMISSION_ID`),
  UNIQUE KEY `UK_ss26hgwetkj8ms5y5jn2co4j3` (`PERMISSION_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PERMISSION`
--

LOCK TABLES `PERMISSION` WRITE;
/*!40000 ALTER TABLE `PERMISSION` DISABLE KEYS */;
INSERT INTO `PERMISSION` VALUES (50,'2026-09-19 00:39:10','2026-09-19 00:39:10',NULL,'AUTH'),(51,'2026-09-19 00:39:10','2026-09-19 00:39:10',NULL,'SUPERADMIN'),(52,'2026-09-19 00:39:10','2026-09-19 00:39:10',NULL,'ADMIN'),(53,'2026-09-19 00:39:10','2026-09-19 00:39:10',NULL,'PRODUCTS'),(54,'2026-09-19 00:39:10','2026-09-19 00:39:10',NULL,'ORDER'),(55,'2026-09-19 00:39:10','2026-09-19 00:39:10',NULL,'CONTENT'),(56,'2026-09-19 00:39:10','2026-09-19 00:39:10',NULL,'STORE'),(57,'2026-09-19 00:39:10','2026-09-19 00:39:10',NULL,'TAX'),(58,'2026-09-19 00:39:10','2026-09-19 00:39:10',NULL,'PAYMENT'),(59,'2026-09-19 00:39:10','2026-09-19 00:39:10',NULL,'CUSTOMER'),(60,'2026-09-19 00:39:10','2026-09-19 00:39:10',NULL,'SHIPPING'),(61,'2026-09-19 00:39:10','2026-09-19 00:39:10',NULL,'AUTH_CUSTOMER');
/*!40000 ALTER TABLE `PERMISSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PERMISSION_GROUP`
--

DROP TABLE IF EXISTS `PERMISSION_GROUP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PERMISSION_GROUP` (
  `GROUP_ID` int NOT NULL,
  `PERMISSION_ID` int NOT NULL,
  PRIMARY KEY (`GROUP_ID`,`PERMISSION_ID`),
  KEY `FK77ly3khyuu40odly02d351s84` (`PERMISSION_ID`),
  CONSTRAINT `FK77ly3khyuu40odly02d351s84` FOREIGN KEY (`PERMISSION_ID`) REFERENCES `PERMISSION` (`PERMISSION_ID`),
  CONSTRAINT `FKr7ylutdgqp1nrlbhjwit6y17g` FOREIGN KEY (`GROUP_ID`) REFERENCES `SM_GROUP` (`GROUP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PERMISSION_GROUP`
--

LOCK TABLES `PERMISSION_GROUP` WRITE;
/*!40000 ALTER TABLE `PERMISSION_GROUP` DISABLE KEYS */;
INSERT INTO `PERMISSION_GROUP` VALUES (50,50),(51,50),(52,50),(53,50),(54,50),(55,50),(56,50),(57,50),(50,51),(50,52),(51,52),(52,52),(50,53),(51,53),(52,53),(54,53),(50,54),(51,54),(52,54),(55,54),(50,55),(51,55),(52,55),(53,55),(56,55),(50,56),(51,56),(52,56),(53,56),(50,57),(51,57),(52,57),(53,57),(50,58),(51,58),(52,58),(53,58),(50,59),(51,59),(52,59),(53,59),(50,60),(51,60),(52,60),(53,60),(57,61);
/*!40000 ALTER TABLE `PERMISSION_GROUP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT`
--

DROP TABLE IF EXISTS `PRODUCT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT` (
  `PRODUCT_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `AVAILABLE` bit(1) DEFAULT NULL,
  `COND` int DEFAULT NULL,
  `DATE_AVAILABLE` datetime DEFAULT NULL,
  `PREORDER` bit(1) DEFAULT NULL,
  `PRODUCT_HEIGHT` decimal(19,2) DEFAULT NULL,
  `PRODUCT_FREE` bit(1) DEFAULT NULL,
  `PRODUCT_LENGTH` decimal(19,2) DEFAULT NULL,
  `QUANTITY_ORDERED` int DEFAULT NULL,
  `REVIEW_AVG` decimal(19,2) DEFAULT NULL,
  `REVIEW_COUNT` int DEFAULT NULL,
  `PRODUCT_SHIP` bit(1) DEFAULT NULL,
  `PRODUCT_VIRTUAL` bit(1) DEFAULT NULL,
  `PRODUCT_WEIGHT` decimal(19,2) DEFAULT NULL,
  `PRODUCT_WIDTH` decimal(19,2) DEFAULT NULL,
  `REF_SKU` varchar(255) DEFAULT NULL,
  `RENTAL_DURATION` int DEFAULT NULL,
  `RENTAL_PERIOD` int DEFAULT NULL,
  `RENTAL_STATUS` int DEFAULT NULL,
  `SKU` varchar(255) DEFAULT NULL,
  `SORT_ORDER` int DEFAULT NULL,
  `MANUFACTURER_ID` bigint DEFAULT NULL,
  `MERCHANT_ID` int NOT NULL,
  `CUSTOMER_ID` bigint DEFAULT NULL,
  `TAX_CLASS_ID` bigint DEFAULT NULL,
  `PRODUCT_TYPE_ID` bigint DEFAULT NULL,
  PRIMARY KEY (`PRODUCT_ID`),
  UNIQUE KEY `UKs8ofsn9pehdrstjg52j5qabxh` (`MERCHANT_ID`,`SKU`),
  KEY `FKra5mmrdxn3ci86hod7q1u3vu9` (`MANUFACTURER_ID`),
  KEY `FKqtt5f0aht5h7ough5rbkkcb33` (`CUSTOMER_ID`),
  KEY `FKb8oqtc3j8sqo0t8xdrne7pg69` (`TAX_CLASS_ID`),
  KEY `FKeiirvj8eu40h103fth8es1mt0` (`PRODUCT_TYPE_ID`),
  CONSTRAINT `FKb8oqtc3j8sqo0t8xdrne7pg69` FOREIGN KEY (`TAX_CLASS_ID`) REFERENCES `TAX_CLASS` (`TAX_CLASS_ID`),
  CONSTRAINT `FKeiirvj8eu40h103fth8es1mt0` FOREIGN KEY (`PRODUCT_TYPE_ID`) REFERENCES `PRODUCT_TYPE` (`PRODUCT_TYPE_ID`),
  CONSTRAINT `FKhhoq1nd9e0i4m7rt8gkh7d67h` FOREIGN KEY (`MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`),
  CONSTRAINT `FKqtt5f0aht5h7ough5rbkkcb33` FOREIGN KEY (`CUSTOMER_ID`) REFERENCES `CUSTOMER` (`CUSTOMER_ID`),
  CONSTRAINT `FKra5mmrdxn3ci86hod7q1u3vu9` FOREIGN KEY (`MANUFACTURER_ID`) REFERENCES `MANUFACTURER` (`MANUFACTURER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT`
--

LOCK TABLES `PRODUCT` WRITE;
/*!40000 ALTER TABLE `PRODUCT` DISABLE KEYS */;
INSERT INTO `PRODUCT` VALUES (1,'2026-09-19 00:58:46','2026-09-20 01:22:51',NULL,_binary '',NULL,'2026-09-18 17:00:00',_binary '',NULL,_binary '\0',NULL,NULL,NULL,NULL,_binary '',_binary '\0',NULL,NULL,'SP1',NULL,NULL,NULL,'SP1',0,NULL,1,NULL,1,1);
/*!40000 ALTER TABLE `PRODUCT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT_ATTRIBUTE`
--

DROP TABLE IF EXISTS `PRODUCT_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT_ATTRIBUTE` (
  `PRODUCT_ATTRIBUTE_ID` bigint NOT NULL,
  `PRODUCT_ATTRIBUTE_DEFAULT` bit(1) DEFAULT NULL,
  `PRODUCT_ATTRIBUTE_DISCOUNTED` bit(1) DEFAULT NULL,
  `PRODUCT_ATTRIBUTE_FOR_DISP` bit(1) DEFAULT NULL,
  `PRODUCT_ATTRIBUTE_REQUIRED` bit(1) DEFAULT NULL,
  `PRODUCT_ATTRIBUTE_FREE` bit(1) DEFAULT NULL,
  `PRODUCT_ATRIBUTE_PRICE` decimal(19,2) DEFAULT NULL,
  `PRODUCT_ATTRIBUTE_WEIGHT` decimal(19,2) DEFAULT NULL,
  `PRODUCT_ATTRIBUTE_SORT_ORD` int DEFAULT NULL,
  `PRODUCT_ID` bigint NOT NULL,
  `OPTION_ID` bigint NOT NULL,
  `OPTION_VALUE_ID` bigint NOT NULL,
  PRIMARY KEY (`PRODUCT_ATTRIBUTE_ID`),
  UNIQUE KEY `UKo0c6cfxcfejwfa2877gfgpuco` (`OPTION_ID`,`OPTION_VALUE_ID`,`PRODUCT_ID`),
  KEY `FKml3nvemdjya159a7669qt1gjd` (`PRODUCT_ID`),
  KEY `FK3rleultg9fn2dxruefbb18d5t` (`OPTION_VALUE_ID`),
  CONSTRAINT `FK2st60u9twmvvaowwn88mt3lrx` FOREIGN KEY (`OPTION_ID`) REFERENCES `PRODUCT_OPTION` (`PRODUCT_OPTION_ID`),
  CONSTRAINT `FK3rleultg9fn2dxruefbb18d5t` FOREIGN KEY (`OPTION_VALUE_ID`) REFERENCES `PRODUCT_OPTION_VALUE` (`PRODUCT_OPTION_VALUE_ID`),
  CONSTRAINT `FKml3nvemdjya159a7669qt1gjd` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `PRODUCT` (`PRODUCT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT_ATTRIBUTE`
--

LOCK TABLES `PRODUCT_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `PRODUCT_ATTRIBUTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `PRODUCT_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT_AVAILABILITY`
--

DROP TABLE IF EXISTS `PRODUCT_AVAILABILITY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT_AVAILABILITY` (
  `PRODUCT_AVAIL_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `AVAILABLE` bit(1) DEFAULT NULL,
  `HEIGHT` decimal(19,2) DEFAULT NULL,
  `LENGTH` decimal(19,2) DEFAULT NULL,
  `WEIGHT` decimal(19,2) DEFAULT NULL,
  `WIDTH` decimal(19,2) DEFAULT NULL,
  `OWNER` varchar(255) DEFAULT NULL,
  `DATE_AVAILABLE` date DEFAULT NULL,
  `FREE_SHIPPING` bit(1) DEFAULT NULL,
  `QUANTITY` int DEFAULT NULL,
  `QUANTITY_ORD_MAX` int DEFAULT NULL,
  `QUANTITY_ORD_MIN` int DEFAULT NULL,
  `STATUS` bit(1) DEFAULT NULL,
  `REGION` varchar(255) DEFAULT NULL,
  `REGION_VARIANT` varchar(255) DEFAULT NULL,
  `SKU` varchar(255) DEFAULT NULL,
  `MERCHANT_ID` int DEFAULT NULL,
  `PRODUCT_ID` bigint NOT NULL,
  PRIMARY KEY (`PRODUCT_AVAIL_ID`),
  KEY `FKmjs1xqdsgji88j5uduj83bntl` (`MERCHANT_ID`),
  KEY `FK5sbh4dx25pmjcqx958hr9ys8h` (`PRODUCT_ID`),
  CONSTRAINT `FK5sbh4dx25pmjcqx958hr9ys8h` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `PRODUCT` (`PRODUCT_ID`),
  CONSTRAINT `FKmjs1xqdsgji88j5uduj83bntl` FOREIGN KEY (`MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT_AVAILABILITY`
--

LOCK TABLES `PRODUCT_AVAILABILITY` WRITE;
/*!40000 ALTER TABLE `PRODUCT_AVAILABILITY` DISABLE KEYS */;
INSERT INTO `PRODUCT_AVAILABILITY` VALUES (1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,_binary '\0',288,200,1,_binary '','*',NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `PRODUCT_AVAILABILITY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT_CATEGORY`
--

DROP TABLE IF EXISTS `PRODUCT_CATEGORY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT_CATEGORY` (
  `PRODUCT_ID` bigint NOT NULL,
  `CATEGORY_ID` bigint NOT NULL,
  PRIMARY KEY (`PRODUCT_ID`,`CATEGORY_ID`),
  KEY `FK3xw1sbaa29r534jvedimdd7md` (`CATEGORY_ID`),
  CONSTRAINT `FK3xw1sbaa29r534jvedimdd7md` FOREIGN KEY (`CATEGORY_ID`) REFERENCES `CATEGORY` (`CATEGORY_ID`),
  CONSTRAINT `FKa7245ly271mb0crlhxwhhppsq` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `PRODUCT` (`PRODUCT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT_CATEGORY`
--

LOCK TABLES `PRODUCT_CATEGORY` WRITE;
/*!40000 ALTER TABLE `PRODUCT_CATEGORY` DISABLE KEYS */;
INSERT INTO `PRODUCT_CATEGORY` VALUES (1,1);
/*!40000 ALTER TABLE `PRODUCT_CATEGORY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT_DESCRIPTION`
--

DROP TABLE IF EXISTS `PRODUCT_DESCRIPTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT_DESCRIPTION` (
  `DESCRIPTION_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `DESCRIPTION` longtext,
  `NAME` varchar(120) NOT NULL,
  `TITLE` varchar(100) DEFAULT NULL,
  `META_DESCRIPTION` varchar(255) DEFAULT NULL,
  `META_KEYWORDS` varchar(255) DEFAULT NULL,
  `META_TITLE` varchar(255) DEFAULT NULL,
  `DOWNLOAD_LNK` varchar(255) DEFAULT NULL,
  `PRODUCT_HIGHLIGHT` varchar(255) DEFAULT NULL,
  `SEF_URL` varchar(255) DEFAULT NULL,
  `LANGUAGE_ID` int NOT NULL,
  `PRODUCT_ID` bigint NOT NULL,
  PRIMARY KEY (`DESCRIPTION_ID`),
  UNIQUE KEY `UKq4dnkx5b776ayqas2h4rr2d8q` (`PRODUCT_ID`,`LANGUAGE_ID`),
  KEY `PRODUCT_DESCRIPTION_SEF_URL` (`SEF_URL`),
  KEY `FK6esjdaa6vu2t5vjin788a8og6` (`LANGUAGE_ID`),
  CONSTRAINT `FK6esjdaa6vu2t5vjin788a8og6` FOREIGN KEY (`LANGUAGE_ID`) REFERENCES `LANGUAGE` (`LANGUAGE_ID`),
  CONSTRAINT `FKm46yjcu59q79qrokgglwq2ove` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `PRODUCT` (`PRODUCT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT_DESCRIPTION`
--

LOCK TABLES `PRODUCT_DESCRIPTION` WRITE;
/*!40000 ALTER TABLE `PRODUCT_DESCRIPTION` DISABLE KEYS */;
INSERT INTO `PRODUCT_DESCRIPTION` VALUES (1,'2026-09-19 01:38:37','2026-09-19 01:38:37',NULL,'<p>\n  <strong>越南 ST25 香米</strong></p>\n','ST25',NULL,'','ST 25,ST25,','','','ST5','st25',53,1),(2,'2026-09-19 01:38:37','2026-09-19 01:38:37',NULL,'<p>  ST25</p>\n','ST25',NULL,'ST25','rice,ST 25,st25,','ST25','','ST25','st25',51,1),(3,'2026-09-19 01:38:37','2026-09-19 01:38:37',NULL,'<p>  ST25</p>\n','ST25',NULL,'','st25,ST 25,','ST25','','ST25','st25',52,1),(4,'2026-09-19 01:38:37','2026-09-19 01:38:37',NULL,'<p>  ST25</p>\n','ST25',NULL,'ST25','st25,ST 25,gạo ngon nhất thế giới,rice,','ST25','','','st25',50,1);
/*!40000 ALTER TABLE `PRODUCT_DESCRIPTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT_DIGITAL`
--

DROP TABLE IF EXISTS `PRODUCT_DIGITAL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT_DIGITAL` (
  `PRODUCT_DIGITAL_ID` bigint NOT NULL,
  `FILE_NAME` varchar(255) NOT NULL,
  `PRODUCT_ID` bigint NOT NULL,
  PRIMARY KEY (`PRODUCT_DIGITAL_ID`),
  UNIQUE KEY `UKjuk1qgkh9v5w7ghvb18krwo8v` (`PRODUCT_ID`,`FILE_NAME`),
  CONSTRAINT `FK47fmb5cg68pws7k26txyl1il6` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `PRODUCT` (`PRODUCT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT_DIGITAL`
--

LOCK TABLES `PRODUCT_DIGITAL` WRITE;
/*!40000 ALTER TABLE `PRODUCT_DIGITAL` DISABLE KEYS */;
/*!40000 ALTER TABLE `PRODUCT_DIGITAL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT_IMAGE`
--

DROP TABLE IF EXISTS `PRODUCT_IMAGE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT_IMAGE` (
  `PRODUCT_IMAGE_ID` bigint NOT NULL,
  `DEFAULT_IMAGE` bit(1) DEFAULT NULL,
  `IMAGE_CROP` bit(1) DEFAULT NULL,
  `IMAGE_TYPE` int DEFAULT NULL,
  `PRODUCT_IMAGE` varchar(255) DEFAULT NULL,
  `PRODUCT_IMAGE_URL` varchar(255) DEFAULT NULL,
  `PRODUCT_ID` bigint NOT NULL,
  PRIMARY KEY (`PRODUCT_IMAGE_ID`),
  KEY `FKgab836d8rxqg8vv55nm02r65i` (`PRODUCT_ID`),
  CONSTRAINT `FKgab836d8rxqg8vv55nm02r65i` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `PRODUCT` (`PRODUCT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT_IMAGE`
--

LOCK TABLES `PRODUCT_IMAGE` WRITE;
/*!40000 ALTER TABLE `PRODUCT_IMAGE` DISABLE KEYS */;
INSERT INTO `PRODUCT_IMAGE` VALUES (1,_binary '',_binary '\0',0,'image8.gif',NULL,1),(2,_binary '\0',_binary '\0',0,'bag-picture-text.avif',NULL,1),(3,_binary '\0',_binary '\0',0,'logo.jpg',NULL,1),(4,_binary '\0',_binary '\0',0,'Vintage-Bags.avif',NULL,1),(5,_binary '\0',_binary '\0',0,'banner-resized.avif',NULL,1);
/*!40000 ALTER TABLE `PRODUCT_IMAGE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT_IMAGE_DESCRIPTION`
--

DROP TABLE IF EXISTS `PRODUCT_IMAGE_DESCRIPTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT_IMAGE_DESCRIPTION` (
  `DESCRIPTION_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `DESCRIPTION` longtext,
  `NAME` varchar(120) NOT NULL,
  `TITLE` varchar(100) DEFAULT NULL,
  `ALT_TAG` varchar(100) DEFAULT NULL,
  `LANGUAGE_ID` int NOT NULL,
  `PRODUCT_IMAGE_ID` bigint NOT NULL,
  PRIMARY KEY (`DESCRIPTION_ID`),
  UNIQUE KEY `UKn7yhdj6ccydgf201gibb882cd` (`PRODUCT_IMAGE_ID`,`LANGUAGE_ID`),
  KEY `FKlhdnpki4sf98wev0pcj2bvnih` (`LANGUAGE_ID`),
  CONSTRAINT `FK1dhldo18nj9l2y6qympgucynq` FOREIGN KEY (`PRODUCT_IMAGE_ID`) REFERENCES `PRODUCT_IMAGE` (`PRODUCT_IMAGE_ID`),
  CONSTRAINT `FKlhdnpki4sf98wev0pcj2bvnih` FOREIGN KEY (`LANGUAGE_ID`) REFERENCES `LANGUAGE` (`LANGUAGE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT_IMAGE_DESCRIPTION`
--

LOCK TABLES `PRODUCT_IMAGE_DESCRIPTION` WRITE;
/*!40000 ALTER TABLE `PRODUCT_IMAGE_DESCRIPTION` DISABLE KEYS */;
INSERT INTO `PRODUCT_IMAGE_DESCRIPTION` VALUES (1,'2026-09-19 00:58:47','2026-09-19 00:58:47',NULL,NULL,'image8.gif',NULL,NULL,50,1),(2,'2026-09-19 00:58:47','2026-09-19 00:58:47',NULL,NULL,'image8.gif',NULL,NULL,51,1),(3,'2026-09-19 00:58:47','2026-09-19 00:58:47',NULL,NULL,'image8.gif',NULL,NULL,52,1),(4,'2026-09-19 00:58:47','2026-09-19 00:58:47',NULL,NULL,'image8.gif',NULL,NULL,53,1);
/*!40000 ALTER TABLE `PRODUCT_IMAGE_DESCRIPTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT_OPTION`
--

DROP TABLE IF EXISTS `PRODUCT_OPTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT_OPTION` (
  `PRODUCT_OPTION_ID` bigint NOT NULL,
  `PRODUCT_OPTION_CODE` varchar(255) DEFAULT NULL,
  `PRODUCT_OPTION_SORT_ORD` int DEFAULT NULL,
  `PRODUCT_OPTION_TYPE` varchar(10) DEFAULT NULL,
  `PRODUCT_OPTION_READ` bit(1) DEFAULT NULL,
  `MERCHANT_ID` int NOT NULL,
  PRIMARY KEY (`PRODUCT_OPTION_ID`),
  UNIQUE KEY `UKhfcw5oi9ulljlog1b7ns1r9tu` (`MERCHANT_ID`,`PRODUCT_OPTION_CODE`),
  KEY `PRD_OPTION_CODE_IDX` (`PRODUCT_OPTION_CODE`),
  CONSTRAINT `FKp8cski5t5f5m4et4fw0uilcgu` FOREIGN KEY (`MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT_OPTION`
--

LOCK TABLES `PRODUCT_OPTION` WRITE;
/*!40000 ALTER TABLE `PRODUCT_OPTION` DISABLE KEYS */;
/*!40000 ALTER TABLE `PRODUCT_OPTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT_OPTION_DESC`
--

DROP TABLE IF EXISTS `PRODUCT_OPTION_DESC`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT_OPTION_DESC` (
  `DESCRIPTION_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `DESCRIPTION` longtext,
  `NAME` varchar(120) NOT NULL,
  `TITLE` varchar(100) DEFAULT NULL,
  `PRODUCT_OPTION_COMMENT` varchar(4000) DEFAULT NULL,
  `LANGUAGE_ID` int NOT NULL,
  `PRODUCT_OPTION_ID` bigint NOT NULL,
  PRIMARY KEY (`DESCRIPTION_ID`),
  UNIQUE KEY `UKmkcm8isyyyqbjd1yyb8mrpkuw` (`PRODUCT_OPTION_ID`,`LANGUAGE_ID`),
  KEY `FK8fiwk5o1gbn2r2u8529yaf9xt` (`LANGUAGE_ID`),
  CONSTRAINT `FK8fiwk5o1gbn2r2u8529yaf9xt` FOREIGN KEY (`LANGUAGE_ID`) REFERENCES `LANGUAGE` (`LANGUAGE_ID`),
  CONSTRAINT `FKgjqmfofile4hwv867irsnvuc0` FOREIGN KEY (`PRODUCT_OPTION_ID`) REFERENCES `PRODUCT_OPTION` (`PRODUCT_OPTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT_OPTION_DESC`
--

LOCK TABLES `PRODUCT_OPTION_DESC` WRITE;
/*!40000 ALTER TABLE `PRODUCT_OPTION_DESC` DISABLE KEYS */;
/*!40000 ALTER TABLE `PRODUCT_OPTION_DESC` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT_OPTION_SET`
--

DROP TABLE IF EXISTS `PRODUCT_OPTION_SET`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT_OPTION_SET` (
  `PRODUCT_OPTION_SET_ID` bigint NOT NULL,
  `PRODUCT_OPTION_SET_CODE` varchar(255) DEFAULT NULL,
  `PRODUCT_OPTION_SET_DISP` bit(1) DEFAULT NULL,
  `PRODUCT_OPTION_ID` bigint NOT NULL,
  `MERCHANT_ID` int NOT NULL,
  PRIMARY KEY (`PRODUCT_OPTION_SET_ID`),
  UNIQUE KEY `UKk1qq8j685uj17bylgnkra1n5f` (`MERCHANT_ID`,`PRODUCT_OPTION_SET_CODE`),
  KEY `FK4njy17416fn86muojmtbav1d0` (`PRODUCT_OPTION_ID`),
  CONSTRAINT `FK4njy17416fn86muojmtbav1d0` FOREIGN KEY (`PRODUCT_OPTION_ID`) REFERENCES `PRODUCT_OPTION` (`PRODUCT_OPTION_ID`),
  CONSTRAINT `FK8d5vylmhvmckmframdehgwqau` FOREIGN KEY (`MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT_OPTION_SET`
--

LOCK TABLES `PRODUCT_OPTION_SET` WRITE;
/*!40000 ALTER TABLE `PRODUCT_OPTION_SET` DISABLE KEYS */;
/*!40000 ALTER TABLE `PRODUCT_OPTION_SET` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT_OPTION_VALUE`
--

DROP TABLE IF EXISTS `PRODUCT_OPTION_VALUE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT_OPTION_VALUE` (
  `PRODUCT_OPTION_VALUE_ID` bigint NOT NULL,
  `PRODUCT_OPTION_VAL_CODE` varchar(255) DEFAULT NULL,
  `PRODUCT_OPT_FOR_DISP` bit(1) DEFAULT NULL,
  `PRODUCT_OPT_VAL_IMAGE` varchar(255) DEFAULT NULL,
  `PRODUCT_OPT_VAL_SORT_ORD` int DEFAULT NULL,
  `MERCHANT_ID` int NOT NULL,
  PRIMARY KEY (`PRODUCT_OPTION_VALUE_ID`),
  UNIQUE KEY `UKixbpi4hxrhljh935c3xfvnvsh` (`MERCHANT_ID`,`PRODUCT_OPTION_VAL_CODE`),
  KEY `PRD_OPTION_VAL_CODE_IDX` (`PRODUCT_OPTION_VAL_CODE`),
  CONSTRAINT `FKnd3nw0mamlk8bkxo8ad5m85pq` FOREIGN KEY (`MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT_OPTION_VALUE`
--

LOCK TABLES `PRODUCT_OPTION_VALUE` WRITE;
/*!40000 ALTER TABLE `PRODUCT_OPTION_VALUE` DISABLE KEYS */;
/*!40000 ALTER TABLE `PRODUCT_OPTION_VALUE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT_OPTION_VALUE_DESCRIPTION`
--

DROP TABLE IF EXISTS `PRODUCT_OPTION_VALUE_DESCRIPTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT_OPTION_VALUE_DESCRIPTION` (
  `DESCRIPTION_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `DESCRIPTION` longtext,
  `NAME` varchar(120) NOT NULL,
  `TITLE` varchar(100) DEFAULT NULL,
  `LANGUAGE_ID` int NOT NULL,
  `PRODUCT_OPTION_VALUE_ID` bigint DEFAULT NULL,
  PRIMARY KEY (`DESCRIPTION_ID`),
  UNIQUE KEY `UKasgc60ot1wy0uho96n0j8429p` (`PRODUCT_OPTION_VALUE_ID`,`LANGUAGE_ID`),
  KEY `FK19mnby7atlt85exlypxdxhacx` (`LANGUAGE_ID`),
  CONSTRAINT `FK19mnby7atlt85exlypxdxhacx` FOREIGN KEY (`LANGUAGE_ID`) REFERENCES `LANGUAGE` (`LANGUAGE_ID`),
  CONSTRAINT `FKqttc6b79yp2s1hyrhg4thag6s` FOREIGN KEY (`PRODUCT_OPTION_VALUE_ID`) REFERENCES `PRODUCT_OPTION_VALUE` (`PRODUCT_OPTION_VALUE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT_OPTION_VALUE_DESCRIPTION`
--

LOCK TABLES `PRODUCT_OPTION_VALUE_DESCRIPTION` WRITE;
/*!40000 ALTER TABLE `PRODUCT_OPTION_VALUE_DESCRIPTION` DISABLE KEYS */;
/*!40000 ALTER TABLE `PRODUCT_OPTION_VALUE_DESCRIPTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT_OPT_SET_OPT_VALUE`
--

DROP TABLE IF EXISTS `PRODUCT_OPT_SET_OPT_VALUE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT_OPT_SET_OPT_VALUE` (
  `ProductOptionSet_PRODUCT_OPTION_SET_ID` bigint NOT NULL,
  `values_PRODUCT_OPTION_VALUE_ID` bigint NOT NULL,
  KEY `FK9dwatblxwc64a5la3bb7qnwd8` (`values_PRODUCT_OPTION_VALUE_ID`),
  KEY `FK3u6iyag8x8w9tkt7sqcoibjq6` (`ProductOptionSet_PRODUCT_OPTION_SET_ID`),
  CONSTRAINT `FK3u6iyag8x8w9tkt7sqcoibjq6` FOREIGN KEY (`ProductOptionSet_PRODUCT_OPTION_SET_ID`) REFERENCES `PRODUCT_OPTION_SET` (`PRODUCT_OPTION_SET_ID`),
  CONSTRAINT `FK9dwatblxwc64a5la3bb7qnwd8` FOREIGN KEY (`values_PRODUCT_OPTION_VALUE_ID`) REFERENCES `PRODUCT_OPTION_VALUE` (`PRODUCT_OPTION_VALUE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT_OPT_SET_OPT_VALUE`
--

LOCK TABLES `PRODUCT_OPT_SET_OPT_VALUE` WRITE;
/*!40000 ALTER TABLE `PRODUCT_OPT_SET_OPT_VALUE` DISABLE KEYS */;
/*!40000 ALTER TABLE `PRODUCT_OPT_SET_OPT_VALUE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT_OPT_SET_PRD_TYPE`
--

DROP TABLE IF EXISTS `PRODUCT_OPT_SET_PRD_TYPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT_OPT_SET_PRD_TYPE` (
  `ProductOptionSet_PRODUCT_OPTION_SET_ID` bigint NOT NULL,
  `productTypes_PRODUCT_TYPE_ID` bigint NOT NULL,
  PRIMARY KEY (`ProductOptionSet_PRODUCT_OPTION_SET_ID`,`productTypes_PRODUCT_TYPE_ID`),
  KEY `FKiem30u1enm0p25i7t53jganf4` (`productTypes_PRODUCT_TYPE_ID`),
  CONSTRAINT `FK4655h91s0eiinonako9n4h9ha` FOREIGN KEY (`ProductOptionSet_PRODUCT_OPTION_SET_ID`) REFERENCES `PRODUCT_OPTION_SET` (`PRODUCT_OPTION_SET_ID`),
  CONSTRAINT `FKiem30u1enm0p25i7t53jganf4` FOREIGN KEY (`productTypes_PRODUCT_TYPE_ID`) REFERENCES `PRODUCT_TYPE` (`PRODUCT_TYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT_OPT_SET_PRD_TYPE`
--

LOCK TABLES `PRODUCT_OPT_SET_PRD_TYPE` WRITE;
/*!40000 ALTER TABLE `PRODUCT_OPT_SET_PRD_TYPE` DISABLE KEYS */;
/*!40000 ALTER TABLE `PRODUCT_OPT_SET_PRD_TYPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT_PRICE`
--

DROP TABLE IF EXISTS `PRODUCT_PRICE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT_PRICE` (
  `PRODUCT_PRICE_ID` bigint NOT NULL,
  `PRODUCT_PRICE_CODE` varchar(255) NOT NULL,
  `DEFAULT_PRICE` bit(1) DEFAULT NULL,
  `PRODUCT_PRICE_AMOUNT` decimal(19,2) NOT NULL,
  `PRODUCT_PRICE_SPECIAL_AMOUNT` decimal(19,2) DEFAULT NULL,
  `PRODUCT_PRICE_SPECIAL_END_DATE` date DEFAULT NULL,
  `PRODUCT_PRICE_SPECIAL_ST_DATE` date DEFAULT NULL,
  `PRODUCT_PRICE_TYPE` varchar(20) DEFAULT NULL,
  `PRODUCT_AVAIL_ID` bigint NOT NULL,
  PRIMARY KEY (`PRODUCT_PRICE_ID`),
  KEY `FK1dic7jnnk1qikgvwcrf4dw12r` (`PRODUCT_AVAIL_ID`),
  CONSTRAINT `FK1dic7jnnk1qikgvwcrf4dw12r` FOREIGN KEY (`PRODUCT_AVAIL_ID`) REFERENCES `PRODUCT_AVAILABILITY` (`PRODUCT_AVAIL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT_PRICE`
--

LOCK TABLES `PRODUCT_PRICE` WRITE;
/*!40000 ALTER TABLE `PRODUCT_PRICE` DISABLE KEYS */;
INSERT INTO `PRODUCT_PRICE` VALUES (1,'base',_binary '',250000.00,200000.00,'2026-09-20','2026-09-19','ONE_TIME',1);
/*!40000 ALTER TABLE `PRODUCT_PRICE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT_PRICE_DESCRIPTION`
--

DROP TABLE IF EXISTS `PRODUCT_PRICE_DESCRIPTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT_PRICE_DESCRIPTION` (
  `DESCRIPTION_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `DESCRIPTION` longtext,
  `NAME` varchar(120) NOT NULL,
  `TITLE` varchar(100) DEFAULT NULL,
  `PRICE_APPENDER` varchar(255) DEFAULT NULL,
  `LANGUAGE_ID` int NOT NULL,
  `PRODUCT_PRICE_ID` bigint NOT NULL,
  PRIMARY KEY (`DESCRIPTION_ID`),
  UNIQUE KEY `UKfrsw8d41sxxogvxxoyd8nwaxu` (`PRODUCT_PRICE_ID`,`LANGUAGE_ID`),
  KEY `FK7bmbrjr8ar5icwdpt8myj6gei` (`LANGUAGE_ID`),
  CONSTRAINT `FK7bmbrjr8ar5icwdpt8myj6gei` FOREIGN KEY (`LANGUAGE_ID`) REFERENCES `LANGUAGE` (`LANGUAGE_ID`),
  CONSTRAINT `FKbwxw861ipjsct606j3dagdjsf` FOREIGN KEY (`PRODUCT_PRICE_ID`) REFERENCES `PRODUCT_PRICE` (`PRODUCT_PRICE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT_PRICE_DESCRIPTION`
--

LOCK TABLES `PRODUCT_PRICE_DESCRIPTION` WRITE;
/*!40000 ALTER TABLE `PRODUCT_PRICE_DESCRIPTION` DISABLE KEYS */;
INSERT INTO `PRODUCT_PRICE_DESCRIPTION` VALUES (1,'2026-09-19 01:00:33','2026-09-19 01:00:33',NULL,NULL,'ST25',NULL,'250000',51,1),(2,'2026-09-19 01:00:33','2026-09-19 01:00:33',NULL,NULL,'ST25',NULL,'250000',50,1),(3,'2026-09-19 01:00:33','2026-09-19 01:00:33',NULL,NULL,'ST25',NULL,'250000',52,1),(4,'2026-09-19 01:00:33','2026-09-19 01:00:33',NULL,NULL,'ST25',NULL,'250000',53,1);
/*!40000 ALTER TABLE `PRODUCT_PRICE_DESCRIPTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT_RELATIONSHIP`
--

DROP TABLE IF EXISTS `PRODUCT_RELATIONSHIP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT_RELATIONSHIP` (
  `PRODUCT_RELATIONSHIP_ID` bigint NOT NULL,
  `ACTIVE` bit(1) DEFAULT NULL,
  `CODE` varchar(255) DEFAULT NULL,
  `PRODUCT_ID` bigint DEFAULT NULL,
  `RELATED_PRODUCT_ID` bigint DEFAULT NULL,
  `MERCHANT_ID` int NOT NULL,
  PRIMARY KEY (`PRODUCT_RELATIONSHIP_ID`),
  KEY `FKso3cvinykac5wdwu1tjgfotor` (`PRODUCT_ID`),
  KEY `FKfskwtawyt85g9h6761fa69ya5` (`RELATED_PRODUCT_ID`),
  KEY `FKnprvswtbgrm6bjfq3cbdl3qsm` (`MERCHANT_ID`),
  CONSTRAINT `FKfskwtawyt85g9h6761fa69ya5` FOREIGN KEY (`RELATED_PRODUCT_ID`) REFERENCES `PRODUCT` (`PRODUCT_ID`),
  CONSTRAINT `FKnprvswtbgrm6bjfq3cbdl3qsm` FOREIGN KEY (`MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`),
  CONSTRAINT `FKso3cvinykac5wdwu1tjgfotor` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `PRODUCT` (`PRODUCT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT_RELATIONSHIP`
--

LOCK TABLES `PRODUCT_RELATIONSHIP` WRITE;
/*!40000 ALTER TABLE `PRODUCT_RELATIONSHIP` DISABLE KEYS */;
INSERT INTO `PRODUCT_RELATIONSHIP` VALUES (1,_binary '','RELATED_ITEM',1,1,1),(100,_binary '','FEATURED_ITEM',NULL,1,1),(150,_binary '','Bag / Handbag',NULL,NULL,1),(151,_binary '','Rice VietNam',NULL,NULL,1),(152,_binary '','Rice VietNam',NULL,1,1);
/*!40000 ALTER TABLE `PRODUCT_RELATIONSHIP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT_REVIEW`
--

DROP TABLE IF EXISTS `PRODUCT_REVIEW`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT_REVIEW` (
  `PRODUCT_REVIEW_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `REVIEW_DATE` datetime DEFAULT NULL,
  `REVIEWS_RATING` double DEFAULT NULL,
  `REVIEWS_READ` bigint DEFAULT NULL,
  `STATUS` int DEFAULT NULL,
  `CUSTOMERS_ID` bigint DEFAULT NULL,
  `PRODUCT_ID` bigint DEFAULT NULL,
  PRIMARY KEY (`PRODUCT_REVIEW_ID`),
  UNIQUE KEY `UK9ew5idgdbk8a77534hbnhd4yb` (`CUSTOMERS_ID`,`PRODUCT_ID`),
  KEY `FKbfi8de7kxultg1vevq6jc1hn7` (`PRODUCT_ID`),
  CONSTRAINT `FK7tm0jrt0hiugo3ep49t3subou` FOREIGN KEY (`CUSTOMERS_ID`) REFERENCES `CUSTOMER` (`CUSTOMER_ID`),
  CONSTRAINT `FKbfi8de7kxultg1vevq6jc1hn7` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `PRODUCT` (`PRODUCT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT_REVIEW`
--

LOCK TABLES `PRODUCT_REVIEW` WRITE;
/*!40000 ALTER TABLE `PRODUCT_REVIEW` DISABLE KEYS */;
/*!40000 ALTER TABLE `PRODUCT_REVIEW` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT_REVIEW_DESCRIPTION`
--

DROP TABLE IF EXISTS `PRODUCT_REVIEW_DESCRIPTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT_REVIEW_DESCRIPTION` (
  `DESCRIPTION_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `DESCRIPTION` longtext,
  `NAME` varchar(120) NOT NULL,
  `TITLE` varchar(100) DEFAULT NULL,
  `LANGUAGE_ID` int NOT NULL,
  `PRODUCT_REVIEW_ID` bigint DEFAULT NULL,
  PRIMARY KEY (`DESCRIPTION_ID`),
  UNIQUE KEY `UKqno5wjdtcj8pm3ykkkh7t4rxj` (`PRODUCT_REVIEW_ID`,`LANGUAGE_ID`),
  KEY `FK7byc5jsf5bm4lk674ac44e50m` (`LANGUAGE_ID`),
  CONSTRAINT `FK7byc5jsf5bm4lk674ac44e50m` FOREIGN KEY (`LANGUAGE_ID`) REFERENCES `LANGUAGE` (`LANGUAGE_ID`),
  CONSTRAINT `FKmjivhigdcxmytndlpjuhf4o25` FOREIGN KEY (`PRODUCT_REVIEW_ID`) REFERENCES `PRODUCT_REVIEW` (`PRODUCT_REVIEW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT_REVIEW_DESCRIPTION`
--

LOCK TABLES `PRODUCT_REVIEW_DESCRIPTION` WRITE;
/*!40000 ALTER TABLE `PRODUCT_REVIEW_DESCRIPTION` DISABLE KEYS */;
/*!40000 ALTER TABLE `PRODUCT_REVIEW_DESCRIPTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT_TYPE`
--

DROP TABLE IF EXISTS `PRODUCT_TYPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT_TYPE` (
  `PRODUCT_TYPE_ID` bigint NOT NULL,
  `PRD_TYPE_ADD_TO_CART` bit(1) DEFAULT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `PRD_TYPE_CODE` varchar(255) DEFAULT NULL,
  `PRD_TYPE_VISIBLE` bit(1) DEFAULT NULL,
  `MERCHANT_ID` int DEFAULT NULL,
  PRIMARY KEY (`PRODUCT_TYPE_ID`),
  KEY `FKswkvtaq4om2di6x8cd4m22ofn` (`MERCHANT_ID`),
  CONSTRAINT `FKswkvtaq4om2di6x8cd4m22ofn` FOREIGN KEY (`MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT_TYPE`
--

LOCK TABLES `PRODUCT_TYPE` WRITE;
/*!40000 ALTER TABLE `PRODUCT_TYPE` DISABLE KEYS */;
INSERT INTO `PRODUCT_TYPE` VALUES (1,NULL,'2026-09-19 00:40:04','2026-09-19 00:40:04',NULL,'GENERAL',NULL,NULL);
/*!40000 ALTER TABLE `PRODUCT_TYPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT_TYPE_DESCRIPTION`
--

DROP TABLE IF EXISTS `PRODUCT_TYPE_DESCRIPTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT_TYPE_DESCRIPTION` (
  `DESCRIPTION_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `DESCRIPTION` longtext,
  `NAME` varchar(120) NOT NULL,
  `TITLE` varchar(100) DEFAULT NULL,
  `LANGUAGE_ID` int NOT NULL,
  `PRODUCT_TYPE_ID` bigint NOT NULL,
  PRIMARY KEY (`DESCRIPTION_ID`),
  UNIQUE KEY `UKbnra4lwqjkju4yh04824sw6be` (`PRODUCT_TYPE_ID`,`LANGUAGE_ID`),
  KEY `FK81q74whco5y9fd51aa330hlc0` (`LANGUAGE_ID`),
  CONSTRAINT `FK81q74whco5y9fd51aa330hlc0` FOREIGN KEY (`LANGUAGE_ID`) REFERENCES `LANGUAGE` (`LANGUAGE_ID`),
  CONSTRAINT `FKpwc89ulk7c9asbp2nfy2t4x2j` FOREIGN KEY (`PRODUCT_TYPE_ID`) REFERENCES `PRODUCT_TYPE` (`PRODUCT_TYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT_TYPE_DESCRIPTION`
--

LOCK TABLES `PRODUCT_TYPE_DESCRIPTION` WRITE;
/*!40000 ALTER TABLE `PRODUCT_TYPE_DESCRIPTION` DISABLE KEYS */;
/*!40000 ALTER TABLE `PRODUCT_TYPE_DESCRIPTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT_VARIANT`
--

DROP TABLE IF EXISTS `PRODUCT_VARIANT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT_VARIANT` (
  `PRODUCT_VARIANT_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `PRODUCT_AQUANTITY` int DEFAULT NULL,
  `PRODUCT_ATTRIBUTE_ID` bigint NOT NULL,
  PRIMARY KEY (`PRODUCT_VARIANT_ID`),
  KEY `FKb1p1mgaa76xdqmx029cabgc1s` (`PRODUCT_ATTRIBUTE_ID`),
  CONSTRAINT `FKb1p1mgaa76xdqmx029cabgc1s` FOREIGN KEY (`PRODUCT_ATTRIBUTE_ID`) REFERENCES `PRODUCT_ATTRIBUTE` (`PRODUCT_ATTRIBUTE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT_VARIANT`
--

LOCK TABLES `PRODUCT_VARIANT` WRITE;
/*!40000 ALTER TABLE `PRODUCT_VARIANT` DISABLE KEYS */;
/*!40000 ALTER TABLE `PRODUCT_VARIANT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT_VARIATION`
--

DROP TABLE IF EXISTS `PRODUCT_VARIATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT_VARIATION` (
  `PRODUCT_VARIANTION_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `CODE` varchar(100) NOT NULL,
  `MERCHANT_ID` int NOT NULL,
  `PRODUCT_OPTION_ID` bigint NOT NULL,
  `OPTION_VALUE_ID` bigint NOT NULL,
  PRIMARY KEY (`PRODUCT_VARIANTION_ID`),
  UNIQUE KEY `UKi8sa74fv4io0sigmgvqxypp0d` (`MERCHANT_ID`,`PRODUCT_OPTION_ID`,`OPTION_VALUE_ID`),
  KEY `FK5jr2rc6t2p27nwdo5eqwa7658` (`PRODUCT_OPTION_ID`),
  KEY `FKy6gamyvrpds502pdcqq4voyg` (`OPTION_VALUE_ID`),
  CONSTRAINT `FK5jr2rc6t2p27nwdo5eqwa7658` FOREIGN KEY (`PRODUCT_OPTION_ID`) REFERENCES `PRODUCT_OPTION` (`PRODUCT_OPTION_ID`),
  CONSTRAINT `FKqlm3c2178neue84l5kx51ovoq` FOREIGN KEY (`MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`),
  CONSTRAINT `FKy6gamyvrpds502pdcqq4voyg` FOREIGN KEY (`OPTION_VALUE_ID`) REFERENCES `PRODUCT_OPTION_VALUE` (`PRODUCT_OPTION_VALUE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT_VARIATION`
--

LOCK TABLES `PRODUCT_VARIATION` WRITE;
/*!40000 ALTER TABLE `PRODUCT_VARIATION` DISABLE KEYS */;
/*!40000 ALTER TABLE `PRODUCT_VARIATION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT_VAR_IMAGE`
--

DROP TABLE IF EXISTS `PRODUCT_VAR_IMAGE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT_VAR_IMAGE` (
  `PRODUCT_VAR_IMAGE_ID` bigint NOT NULL,
  `DEFAULT_IMAGE` bit(1) DEFAULT NULL,
  `PRODUCT_IMAGE` varchar(255) DEFAULT NULL,
  `PRODUCT_AVAIL_ID` bigint NOT NULL,
  PRIMARY KEY (`PRODUCT_VAR_IMAGE_ID`),
  KEY `FKggbbys5mewflr88rsos56yc2k` (`PRODUCT_AVAIL_ID`),
  CONSTRAINT `FKggbbys5mewflr88rsos56yc2k` FOREIGN KEY (`PRODUCT_AVAIL_ID`) REFERENCES `PRODUCT_AVAILABILITY` (`PRODUCT_AVAIL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT_VAR_IMAGE`
--

LOCK TABLES `PRODUCT_VAR_IMAGE` WRITE;
/*!40000 ALTER TABLE `PRODUCT_VAR_IMAGE` DISABLE KEYS */;
/*!40000 ALTER TABLE `PRODUCT_VAR_IMAGE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SHIPING_ORIGIN`
--

DROP TABLE IF EXISTS `SHIPING_ORIGIN`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SHIPING_ORIGIN` (
  `SHIP_ORIGIN_ID` bigint NOT NULL,
  `ACTIVE` bit(1) DEFAULT NULL,
  `STREET_ADDRESS` varchar(256) DEFAULT NULL,
  `CITY` varchar(100) DEFAULT NULL,
  `POSTCODE` varchar(20) DEFAULT NULL,
  `STATE` varchar(100) DEFAULT NULL,
  `COUNTRY_ID` int DEFAULT NULL,
  `MERCHANT_ID` int NOT NULL,
  `ZONE_ID` bigint DEFAULT NULL,
  PRIMARY KEY (`SHIP_ORIGIN_ID`),
  KEY `FKpqig59usqvs9h0dw4lm8rv7yy` (`COUNTRY_ID`),
  KEY `FKp0dbwsv3sdsp57ex7j5k9b0oq` (`MERCHANT_ID`),
  KEY `FK6k73f1n18kr7mqp708aiwq047` (`ZONE_ID`),
  CONSTRAINT `FK6k73f1n18kr7mqp708aiwq047` FOREIGN KEY (`ZONE_ID`) REFERENCES `ZONE` (`ZONE_ID`),
  CONSTRAINT `FKp0dbwsv3sdsp57ex7j5k9b0oq` FOREIGN KEY (`MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`),
  CONSTRAINT `FKpqig59usqvs9h0dw4lm8rv7yy` FOREIGN KEY (`COUNTRY_ID`) REFERENCES `COUNTRY` (`COUNTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SHIPING_ORIGIN`
--

LOCK TABLES `SHIPING_ORIGIN` WRITE;
/*!40000 ALTER TABLE `SHIPING_ORIGIN` DISABLE KEYS */;
INSERT INTO `SHIPING_ORIGIN` VALUES (1,_binary '','kh phố Mai Anh','Trảng Bàng','80000','',479,1,74);
/*!40000 ALTER TABLE `SHIPING_ORIGIN` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SHIPPING_QUOTE`
--

DROP TABLE IF EXISTS `SHIPPING_QUOTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SHIPPING_QUOTE` (
  `SHIPPING_QUOTE_ID` bigint NOT NULL,
  `CART_ID` bigint DEFAULT NULL,
  `CUSTOMER_ID` bigint DEFAULT NULL,
  `DELIVERY_STREET_ADDRESS` varchar(256) DEFAULT NULL,
  `DELIVERY_CITY` varchar(100) DEFAULT NULL,
  `DELIVERY_COMPANY` varchar(100) DEFAULT NULL,
  `DELIVERY_FIRST_NAME` varchar(64) DEFAULT NULL,
  `DELIVERY_LAST_NAME` varchar(64) DEFAULT NULL,
  `DELIVERY_POSTCODE` varchar(20) DEFAULT NULL,
  `DELIVERY_STATE` varchar(100) DEFAULT NULL,
  `DELIVERY_TELEPHONE` varchar(32) DEFAULT NULL,
  `SHIPPING_NUMBER_DAYS` int DEFAULT NULL,
  `FREE_SHIPPING` bit(1) DEFAULT NULL,
  `QUOTE_HANDLING` decimal(19,2) DEFAULT NULL,
  `IP_ADDRESS` varchar(255) DEFAULT NULL,
  `MODULE` varchar(255) NOT NULL,
  `OPTION_CODE` varchar(255) DEFAULT NULL,
  `OPTION_DELIVERY_DATE` datetime DEFAULT NULL,
  `OPTION_NAME` varchar(255) DEFAULT NULL,
  `OPTION_SHIPPING_DATE` datetime DEFAULT NULL,
  `ORDER_ID` bigint DEFAULT NULL,
  `QUOTE_PRICE` decimal(19,2) DEFAULT NULL,
  `QUOTE_DATE` datetime DEFAULT NULL,
  `DELIVERY_COUNTRY_ID` int DEFAULT NULL,
  `DELIVERY_ZONE_ID` bigint DEFAULT NULL,
  PRIMARY KEY (`SHIPPING_QUOTE_ID`),
  KEY `FK9vb7tbjl8ivygdiqw883fewx7` (`DELIVERY_COUNTRY_ID`),
  KEY `FKiioesp0vl6x4om1jeajj4uy1t` (`DELIVERY_ZONE_ID`),
  CONSTRAINT `FK9vb7tbjl8ivygdiqw883fewx7` FOREIGN KEY (`DELIVERY_COUNTRY_ID`) REFERENCES `COUNTRY` (`COUNTRY_ID`),
  CONSTRAINT `FKiioesp0vl6x4om1jeajj4uy1t` FOREIGN KEY (`DELIVERY_ZONE_ID`) REFERENCES `ZONE` (`ZONE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SHIPPING_QUOTE`
--

LOCK TABLES `SHIPPING_QUOTE` WRITE;
/*!40000 ALTER TABLE `SHIPPING_QUOTE` DISABLE KEYS */;
INSERT INTO `SHIPPING_QUOTE` VALUES (1,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 02:00:21',NULL,0.00,'2026-09-19 02:00:21',479,74),(2,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 02:00:33',NULL,0.00,'2026-09-19 02:00:33',479,74),(3,1,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-19 02:00:48',NULL,140.00,'2026-09-19 02:00:48',479,NULL),(4,1,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-19 02:00:48',NULL,140.00,'2026-09-19 02:00:48',479,NULL),(5,1,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 02:00:48',NULL,0.00,'2026-09-19 02:00:48',479,NULL),(6,1,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 02:00:48',NULL,0.00,'2026-09-19 02:00:48',479,NULL),(7,1,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-19 02:01:43',NULL,140.00,'2026-09-19 02:01:43',479,NULL),(8,1,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 02:01:43',NULL,0.00,'2026-09-19 02:01:43',479,NULL),(50,50,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-19 03:01:15',NULL,140.00,'2026-09-19 03:01:15',479,NULL),(51,50,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 03:01:15',NULL,0.00,'2026-09-19 03:01:15',479,NULL),(52,50,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'China','2026-09-19 03:02:01',NULL,140.00,'2026-09-19 03:02:01',292,NULL),(53,50,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 03:02:01',NULL,0.00,'2026-09-19 03:02:01',292,NULL),(54,50,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-19 03:02:10',NULL,140.00,'2026-09-19 03:02:10',479,2),(55,50,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 03:02:10',NULL,0.00,'2026-09-19 03:02:10',479,2),(56,50,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-19 03:02:32',NULL,140.00,'2026-09-19 03:02:32',479,74),(57,50,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 03:02:32',NULL,0.00,'2026-09-19 03:02:32',479,74),(58,50,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-19 03:03:12',NULL,140.00,'2026-09-19 03:03:12',479,74),(59,50,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 03:03:12',NULL,0.00,'2026-09-19 03:03:12',479,74),(60,51,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'越南','2026-09-19 03:10:05',NULL,140.00,'2026-09-19 03:10:05',479,NULL),(61,51,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 03:10:05',NULL,0.00,'2026-09-19 03:10:05',479,NULL),(62,51,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'越南','2026-09-19 03:10:27',NULL,140.00,'2026-09-19 03:10:27',479,NULL),(63,51,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 03:10:27',NULL,0.00,'2026-09-19 03:10:27',479,NULL),(100,100,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-19 03:25:21',NULL,140.00,'2026-09-19 03:25:21',479,NULL),(101,100,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 03:25:21',NULL,0.00,'2026-09-19 03:25:21',479,NULL),(102,100,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-19 03:25:36',NULL,140.00,'2026-09-19 03:25:36',479,NULL),(103,100,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 03:25:36',NULL,0.00,'2026-09-19 03:25:36',479,NULL),(104,101,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-19 06:27:42',NULL,140.00,'2026-09-19 06:27:42',479,NULL),(105,101,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 06:27:42',NULL,0.00,'2026-09-19 06:27:42',479,NULL),(150,101,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 06:38:08',NULL,0.00,'2026-09-19 06:38:08',479,74),(151,101,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-19 06:41:03',NULL,140.00,'2026-09-19 06:41:03',479,NULL),(152,101,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 06:41:03',NULL,0.00,'2026-09-19 06:41:03',479,NULL),(153,101,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 06:42:56',NULL,0.00,'2026-09-19 06:42:56',479,74),(154,101,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-19 06:43:04',NULL,140.00,'2026-09-19 06:43:04',479,NULL),(155,101,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 06:43:04',NULL,0.00,'2026-09-19 06:43:04',479,NULL),(200,101,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-19 07:16:15',NULL,140.00,'2026-09-19 07:16:15',479,NULL),(201,101,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 07:16:15',NULL,0.00,'2026-09-19 07:16:15',479,NULL),(250,101,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-19 08:58:37',NULL,140.00,'2026-09-19 08:58:37',479,NULL),(251,101,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 08:58:38',NULL,0.00,'2026-09-19 08:58:38',479,NULL),(252,101,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-19 08:59:05',NULL,140.00,'2026-09-19 08:59:05',479,NULL),(253,101,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 08:59:05',NULL,0.00,'2026-09-19 08:59:05',479,NULL),(300,150,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 09:07:30',NULL,0.00,'2026-09-19 09:07:30',479,74),(301,150,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 09:08:13',NULL,0.00,'2026-09-19 09:08:13',479,74),(302,150,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-19 09:08:20',NULL,140.00,'2026-09-19 09:08:20',479,NULL),(303,150,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 09:08:20',NULL,0.00,'2026-09-19 09:08:20',479,NULL),(304,150,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-19 09:08:33',NULL,140.00,'2026-09-19 09:08:33',479,NULL),(305,150,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 09:08:33',NULL,0.00,'2026-09-19 09:08:33',479,NULL),(350,200,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'越南','2026-09-19 09:28:55',NULL,140.00,'2026-09-19 09:28:55',479,NULL),(351,200,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 09:28:55',NULL,0.00,'2026-09-19 09:28:55',479,NULL),(352,200,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'越南','2026-09-19 09:29:18',NULL,140.00,'2026-09-19 09:29:18',479,NULL),(353,200,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 09:29:18',NULL,0.00,'2026-09-19 09:29:18',479,NULL),(354,201,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-19 09:30:32',NULL,140.00,'2026-09-19 09:30:32',479,NULL),(355,201,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 09:30:32',NULL,0.00,'2026-09-19 09:30:32',479,NULL),(356,201,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-19 09:30:41',NULL,140.00,'2026-09-19 09:30:41',479,NULL),(357,201,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-19 09:30:41',NULL,0.00,'2026-09-19 09:30:41',479,NULL),(400,250,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-20 01:09:33',NULL,140.00,'2026-09-20 01:09:33',479,NULL),(401,250,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-20 01:09:34',NULL,0.00,'2026-09-20 01:09:34',479,NULL),(402,250,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-20 01:10:12',NULL,140.00,'2026-09-20 01:10:12',479,NULL),(403,250,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-20 01:10:12',NULL,0.00,'2026-09-20 01:10:12',479,NULL),(450,300,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-20 01:22:50',NULL,140.00,'2026-09-20 01:22:50',479,NULL),(451,300,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-20 01:22:50',NULL,0.00,'2026-09-20 01:22:50',479,NULL),(452,300,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-20 01:23:02',NULL,140.00,'2026-09-20 01:23:02',479,NULL),(453,300,NULL,'số 4 đường Chùa am','Trảng Bàng','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-20 01:23:02',NULL,0.00,'2026-09-20 01:23:02',479,NULL);
/*!40000 ALTER TABLE `SHIPPING_QUOTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SHOPPING_CART`
--

DROP TABLE IF EXISTS `SHOPPING_CART`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SHOPPING_CART` (
  `SHP_CART_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `CUSTOMER_ID` bigint DEFAULT NULL,
  `IP_ADDRESS` varchar(255) DEFAULT NULL,
  `ORDER_ID` bigint DEFAULT NULL,
  `PROMO_ADDED` datetime DEFAULT NULL,
  `PROMO_CODE` varchar(255) DEFAULT NULL,
  `SHP_CART_CODE` varchar(255) NOT NULL,
  `MERCHANT_ID` int NOT NULL,
  PRIMARY KEY (`SHP_CART_ID`),
  UNIQUE KEY `UK_8ld8p40fwrjobi7t3n95pna35` (`SHP_CART_CODE`),
  KEY `SHP_CART_CODE_IDX` (`SHP_CART_CODE`),
  KEY `SHP_CART_CUSTOMER_IDX` (`CUSTOMER_ID`),
  KEY `FKqvghr5rmjefe3lw9mcolk30a0` (`MERCHANT_ID`),
  CONSTRAINT `FKqvghr5rmjefe3lw9mcolk30a0` FOREIGN KEY (`MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SHOPPING_CART`
--

LOCK TABLES `SHOPPING_CART` WRITE;
/*!40000 ALTER TABLE `SHOPPING_CART` DISABLE KEYS */;
INSERT INTO `SHOPPING_CART` VALUES (1,'2026-09-19 01:39:17','2026-09-19 02:01:44',NULL,1,'0:0:0:0:0:0:0:1',1,'2026-09-19 01:41:07','','fb8d4645731f4fdc8e60ba9e3f53a8b9',1),(50,'2026-09-19 03:00:53','2026-09-19 03:03:12',NULL,1,'0:0:0:0:0:0:0:1',50,NULL,NULL,'ffe2bb26abbb4e4b956e6284de152688',1),(51,'2026-09-19 03:09:01','2026-09-19 03:10:27',NULL,1,'0:0:0:0:0:0:0:1',51,NULL,NULL,'8b674fd47bff44979eef765ed1947da6',1),(100,'2026-09-19 03:24:57','2026-09-19 03:25:36',NULL,1,'0:0:0:0:0:0:0:1',100,NULL,NULL,'a266994c0a444518bec17f48b30f618f',1),(101,'2026-09-19 06:27:33','2026-09-19 08:59:06',NULL,1,'0:0:0:0:0:0:0:1',150,NULL,NULL,'b4587a87705f44be844570300e5da0ec',1),(150,'2026-09-19 09:07:21','2026-09-19 09:08:33',NULL,1,'0:0:0:0:0:0:0:1',200,NULL,NULL,'72345145184a401da66c022352682871',1),(200,'2026-09-19 09:27:54','2026-09-19 09:29:19',NULL,1,'0:0:0:0:0:0:0:1',250,NULL,NULL,'7829036ac0ea47e9af398cbf23f457c3',1),(201,'2026-09-19 09:30:27','2026-09-19 09:30:41',NULL,1,'0:0:0:0:0:0:0:1',251,NULL,NULL,'8e5579adbc194c0fa47b0bd300344c56',1),(250,'2026-09-20 01:09:21','2026-09-20 01:10:13',NULL,1,'0:0:0:0:0:0:0:1',300,NULL,NULL,'86afcc6958f94ea1b98313dc25f413c8',1),(300,'2026-09-20 01:22:35','2026-09-20 01:23:03',NULL,1,'0:0:0:0:0:0:0:1',350,NULL,NULL,'3e00f7b02dc84e8db5375d6923c2a10d',1);
/*!40000 ALTER TABLE `SHOPPING_CART` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SHOPPING_CART_ATTR_ITEM`
--

DROP TABLE IF EXISTS `SHOPPING_CART_ATTR_ITEM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SHOPPING_CART_ATTR_ITEM` (
  `SHP_CART_ATTR_ITEM_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `PRODUCT_ATTR_ID` bigint NOT NULL,
  `SHP_CART_ITEM_ID` bigint NOT NULL,
  PRIMARY KEY (`SHP_CART_ATTR_ITEM_ID`),
  KEY `FKp42tpa623hyo9ww69v0ohb3er` (`SHP_CART_ITEM_ID`),
  CONSTRAINT `FKp42tpa623hyo9ww69v0ohb3er` FOREIGN KEY (`SHP_CART_ITEM_ID`) REFERENCES `SHOPPING_CART_ITEM` (`SHP_CART_ITEM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SHOPPING_CART_ATTR_ITEM`
--

LOCK TABLES `SHOPPING_CART_ATTR_ITEM` WRITE;
/*!40000 ALTER TABLE `SHOPPING_CART_ATTR_ITEM` DISABLE KEYS */;
/*!40000 ALTER TABLE `SHOPPING_CART_ATTR_ITEM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SHOPPING_CART_ITEM`
--

DROP TABLE IF EXISTS `SHOPPING_CART_ITEM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SHOPPING_CART_ITEM` (
  `SHP_CART_ITEM_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `PRODUCT_ID` bigint NOT NULL,
  `QUANTITY` int DEFAULT NULL,
  `SHP_CART_ID` bigint NOT NULL,
  PRIMARY KEY (`SHP_CART_ITEM_ID`),
  KEY `FK2gbimdwe9uysd5xadnfl0xq83` (`SHP_CART_ID`),
  CONSTRAINT `FK2gbimdwe9uysd5xadnfl0xq83` FOREIGN KEY (`SHP_CART_ID`) REFERENCES `SHOPPING_CART` (`SHP_CART_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SHOPPING_CART_ITEM`
--

LOCK TABLES `SHOPPING_CART_ITEM` WRITE;
/*!40000 ALTER TABLE `SHOPPING_CART_ITEM` DISABLE KEYS */;
INSERT INTO `SHOPPING_CART_ITEM` VALUES (1,'2026-09-19 01:39:17','2026-09-19 02:01:43',NULL,1,2,1),(3,'2026-09-19 02:00:32','2026-09-19 02:00:32',NULL,1,1,1),(50,'2026-09-19 03:00:53','2026-09-19 03:00:53',NULL,1,1,50),(51,'2026-09-19 03:09:01','2026-09-19 03:09:01',NULL,1,1,51),(100,'2026-09-19 03:24:57','2026-09-19 03:24:57',NULL,1,1,100),(101,'2026-09-19 06:27:33','2026-09-19 06:27:33',NULL,1,1,101),(150,'2026-09-19 09:07:21','2026-09-19 09:07:21',NULL,1,1,150),(200,'2026-09-19 09:27:55','2026-09-19 09:27:55',NULL,1,1,200),(201,'2026-09-19 09:30:28','2026-09-19 09:30:28',NULL,1,1,201),(250,'2026-09-20 01:09:21','2026-09-20 01:09:21',NULL,1,1,250),(300,'2026-09-20 01:22:35','2026-09-20 01:22:35',NULL,1,1,300);
/*!40000 ALTER TABLE `SHOPPING_CART_ITEM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SM_GROUP`
--

DROP TABLE IF EXISTS `SM_GROUP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SM_GROUP` (
  `GROUP_ID` int NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `GROUP_NAME` varchar(255) DEFAULT NULL,
  `GROUP_TYPE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`GROUP_ID`),
  UNIQUE KEY `UK_t83rjsoml3o785oj37lpqpyko` (`GROUP_NAME`),
  KEY `SM_GROUP_GROUP_TYPE` (`GROUP_TYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SM_GROUP`
--

LOCK TABLES `SM_GROUP` WRITE;
/*!40000 ALTER TABLE `SM_GROUP` DISABLE KEYS */;
INSERT INTO `SM_GROUP` VALUES (50,'2026-09-19 00:39:10','2026-09-19 00:39:10',NULL,'SUPERADMIN','ADMIN'),(51,'2026-09-19 00:39:10','2026-09-19 00:39:10',NULL,'ADMIN','ADMIN'),(52,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,'ADMIN_RETAILER','ADMIN'),(53,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,'ADMIN_STORE','ADMIN'),(54,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,'ADMIN_CATALOGUE','ADMIN'),(55,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,'ADMIN_ORDER','ADMIN'),(56,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,'ADMIN_CONTENT','ADMIN'),(57,'2026-09-19 00:39:11','2026-09-19 00:39:11',NULL,'CUSTOMER','CUSTOMER');
/*!40000 ALTER TABLE `SM_GROUP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SM_SEQUENCER`
--

DROP TABLE IF EXISTS `SM_SEQUENCER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SM_SEQUENCER` (
  `SEQ_NAME` varchar(255) NOT NULL,
  `SEQ_COUNT` bigint DEFAULT NULL,
  PRIMARY KEY (`SEQ_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SM_SEQUENCER`
--

LOCK TABLES `SM_SEQUENCER` WRITE;
/*!40000 ALTER TABLE `SM_SEQUENCER` DISABLE KEYS */;
INSERT INTO `SM_SEQUENCER` VALUES ('category_description_seq',9),('CATEGORY_SEQ_NEXT_VAL',2),('content_description_seq',5),('CONTENT_SEQ_NEXT_VAL',1),('country_description_seq',1893),('COUNTRY_SEQ_NEXT_VAL',10),('CURRENCY_SEQ_NEXT_VAL',4),('CUSTOMER_SEQ_NEXT_VAL',1),('GROUP_SEQ_NEXT_VAL',2),('LANG_SEQ_NEXT_VAL',2),('MANUFACT_SEQ_NEXT_VAL',1),('manufacturer_description_seq',2),('MERCH_CONF_SEQ_NEXT_VAL',3),('MOD_CONF_SEQ_NEXT_VAL',1),('OPTIN_SEQ_NEXT_VAL',1),('ORDER_ID_SEQ_NEXT_VAL',8),('ORDER_PRD_PRICE_ID_NEXT_VAL',8),('ORDER_PRODUCT_ID_NEXT_VALUE',8),('ORDER_TOTAL_ID_NEXT_VALUE',8),('PERMISSION_SEQ_NEXT_VAL',2),('PRD_TYPE_SEQ_NEXT_VAL',1),('PRODUCT_AVAIL_SEQ_NEXT_VAL',1),('product_description_seq',5),('product_image_description_seq',5),('PRODUCT_IMG_SEQ_NEXT_VAL',1),('product_price_description_seq',5),('PRODUCT_PRICE_SEQ_NEXT_VAL',1),('PRODUCT_RELATION_SEQ_NEXT_VAL',4),('PRODUCT_SEQ_NEXT_VAL',1),('SHIP_QUOTE_ID_NEXT_VALUE',10),('SHP_CRT_ITM_SEQ_NEXT_VAL',7),('SHP_CRT_SEQ_NEXT_VAL',7),('SHP_ORIG_SEQ_NEXT_VAL',1),('STATUS_HIST_ID_NEXT_VALUE',8),('STORE_SEQ_NEXT_VAL',1),('TRANSACT_SEQ_NEXT_VAL',8),('TX_CLASS_SEQ_NEXT_VAL',1),('USER_SEQ_NEXT_VAL',3),('zone_description_seq',799),('ZONE_SEQ_NEXT_VAL',6);
/*!40000 ALTER TABLE `SM_SEQUENCER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SM_TRANSACTION`
--

DROP TABLE IF EXISTS `SM_TRANSACTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SM_TRANSACTION` (
  `TRANSACTION_ID` bigint NOT NULL,
  `AMOUNT` decimal(19,2) DEFAULT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `DETAILS` longtext,
  `PAYMENT_TYPE` varchar(255) DEFAULT NULL,
  `TRANSACTION_DATE` datetime DEFAULT NULL,
  `TRANSACTION_TYPE` varchar(255) DEFAULT NULL,
  `ORDER_ID` bigint DEFAULT NULL,
  PRIMARY KEY (`TRANSACTION_ID`),
  KEY `FK7j0s1gqh2tue1fyh5nyj5kwkp` (`ORDER_ID`),
  CONSTRAINT `FK7j0s1gqh2tue1fyh5nyj5kwkp` FOREIGN KEY (`ORDER_ID`) REFERENCES `ORDERS` (`ORDER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SM_TRANSACTION`
--

LOCK TABLES `SM_TRANSACTION` WRITE;
/*!40000 ALTER TABLE `SM_TRANSACTION` DISABLE KEYS */;
INSERT INTO `SM_TRANSACTION` VALUES (1,600140.00,'2026-09-19 02:01:44','2026-09-19 02:01:44',NULL,NULL,'MONEYORDER','2026-09-19 02:01:44','AUTHORIZECAPTURE',1),(50,200140.00,'2026-09-19 03:03:12','2026-09-19 03:03:12',NULL,NULL,'MONEYORDER','2026-09-19 03:03:12','AUTHORIZECAPTURE',50),(51,200140.00,'2026-09-19 03:10:27','2026-09-19 03:10:27',NULL,NULL,'MONEYORDER','2026-09-19 03:10:27','AUTHORIZECAPTURE',51),(100,200140.00,'2026-09-19 03:25:36','2026-09-19 03:25:36',NULL,NULL,'MONEYORDER','2026-09-19 03:25:36','AUTHORIZECAPTURE',100),(150,200140.00,'2026-09-19 08:59:06','2026-09-19 08:59:06',NULL,NULL,'MONEYORDER','2026-09-19 08:59:06','AUTHORIZECAPTURE',150),(200,200140.00,'2026-09-19 09:08:33','2026-09-19 09:08:33',NULL,NULL,'MONEYORDER','2026-09-19 09:08:33','AUTHORIZECAPTURE',200),(250,200140.00,'2026-09-19 09:29:19','2026-09-19 09:29:19',NULL,NULL,'MONEYORDER','2026-09-19 09:29:19','AUTHORIZECAPTURE',250),(251,200000.00,'2026-09-19 09:30:41','2026-09-19 09:30:41',NULL,NULL,'MONEYORDER','2026-09-19 09:30:41','AUTHORIZECAPTURE',251),(300,250140.00,'2026-09-20 01:10:12','2026-09-20 01:10:12',NULL,NULL,'MONEYORDER','2026-09-20 01:10:12','AUTHORIZECAPTURE',300),(350,250140.00,'2026-09-20 01:23:02','2026-09-20 01:23:02',NULL,NULL,'MONEYORDER','2026-09-20 01:23:02','AUTHORIZECAPTURE',350);
/*!40000 ALTER TABLE `SM_TRANSACTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SYSTEM_CONFIGURATION`
--

DROP TABLE IF EXISTS `SYSTEM_CONFIGURATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SYSTEM_CONFIGURATION` (
  `SYSTEM_CONFIG_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `CONFIG_KEY` varchar(255) DEFAULT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`SYSTEM_CONFIG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SYSTEM_CONFIGURATION`
--

LOCK TABLES `SYSTEM_CONFIGURATION` WRITE;
/*!40000 ALTER TABLE `SYSTEM_CONFIGURATION` DISABLE KEYS */;
/*!40000 ALTER TABLE `SYSTEM_CONFIGURATION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SYSTEM_NOTIFICATION`
--

DROP TABLE IF EXISTS `SYSTEM_NOTIFICATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SYSTEM_NOTIFICATION` (
  `SYSTEM_NOTIF_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `END_DATE` date DEFAULT NULL,
  `CONFIG_KEY` varchar(255) DEFAULT NULL,
  `START_DATE` date DEFAULT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `MERCHANT_ID` int DEFAULT NULL,
  `USER_ID` bigint DEFAULT NULL,
  PRIMARY KEY (`SYSTEM_NOTIF_ID`),
  UNIQUE KEY `UKnpdnlc390vgr2mhepib1mtrmr` (`MERCHANT_ID`,`CONFIG_KEY`),
  KEY `FK3dykr9pm9ln1uektuw18blb6m` (`USER_ID`),
  CONSTRAINT `FK3dykr9pm9ln1uektuw18blb6m` FOREIGN KEY (`USER_ID`) REFERENCES `USERS` (`USER_ID`),
  CONSTRAINT `FKs6qk7l06e0s6m9n04momedgt7` FOREIGN KEY (`MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SYSTEM_NOTIFICATION`
--

LOCK TABLES `SYSTEM_NOTIFICATION` WRITE;
/*!40000 ALTER TABLE `SYSTEM_NOTIFICATION` DISABLE KEYS */;
/*!40000 ALTER TABLE `SYSTEM_NOTIFICATION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TAX_CLASS`
--

DROP TABLE IF EXISTS `TAX_CLASS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TAX_CLASS` (
  `TAX_CLASS_ID` bigint NOT NULL,
  `TAX_CLASS_CODE` varchar(10) NOT NULL,
  `TAX_CLASS_TITLE` varchar(32) NOT NULL,
  `MERCHANT_ID` int DEFAULT NULL,
  PRIMARY KEY (`TAX_CLASS_ID`),
  UNIQUE KEY `UKa4q5q57a8oeh2ojeo8dhr935k` (`MERCHANT_ID`,`TAX_CLASS_CODE`),
  KEY `TAX_CLASS_CODE_IDX` (`TAX_CLASS_CODE`),
  CONSTRAINT `FK82i8puujghcv7fc82qwsgjg8w` FOREIGN KEY (`MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TAX_CLASS`
--

LOCK TABLES `TAX_CLASS` WRITE;
/*!40000 ALTER TABLE `TAX_CLASS` DISABLE KEYS */;
INSERT INTO `TAX_CLASS` VALUES (1,'DEFAULT','DEFAULT',1);
/*!40000 ALTER TABLE `TAX_CLASS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TAX_RATE`
--

DROP TABLE IF EXISTS `TAX_RATE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TAX_RATE` (
  `TAX_RATE_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `TAX_CODE` varchar(255) DEFAULT NULL,
  `PIGGYBACK` bit(1) DEFAULT NULL,
  `STORE_STATE_PROV` varchar(100) DEFAULT NULL,
  `TAX_PRIORITY` int DEFAULT NULL,
  `TAX_RATE` decimal(7,4) NOT NULL,
  `COUNTRY_ID` int NOT NULL,
  `MERCHANT_ID` int NOT NULL,
  `PARENT_ID` bigint DEFAULT NULL,
  `TAX_CLASS_ID` bigint NOT NULL,
  `ZONE_ID` bigint DEFAULT NULL,
  PRIMARY KEY (`TAX_RATE_ID`),
  UNIQUE KEY `UK8gh6l9n0xq03b91sglp62oelu` (`TAX_CODE`,`MERCHANT_ID`),
  KEY `FK6wm34jcwoembe1qsmle2wtwnv` (`COUNTRY_ID`),
  KEY `FKfwp6yka2qps9jna473e6c6yc1` (`MERCHANT_ID`),
  KEY `FKt8isen27i3ioa0tw3bl8qlvdh` (`PARENT_ID`),
  KEY `FK7bpa9pbl1gnj5y3xbgs3wc0eg` (`TAX_CLASS_ID`),
  KEY `FKm9snpf6o1nb4j1t80nas8d1ix` (`ZONE_ID`),
  CONSTRAINT `FK6wm34jcwoembe1qsmle2wtwnv` FOREIGN KEY (`COUNTRY_ID`) REFERENCES `COUNTRY` (`COUNTRY_ID`),
  CONSTRAINT `FK7bpa9pbl1gnj5y3xbgs3wc0eg` FOREIGN KEY (`TAX_CLASS_ID`) REFERENCES `TAX_CLASS` (`TAX_CLASS_ID`),
  CONSTRAINT `FKfwp6yka2qps9jna473e6c6yc1` FOREIGN KEY (`MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`),
  CONSTRAINT `FKm9snpf6o1nb4j1t80nas8d1ix` FOREIGN KEY (`ZONE_ID`) REFERENCES `ZONE` (`ZONE_ID`),
  CONSTRAINT `FKt8isen27i3ioa0tw3bl8qlvdh` FOREIGN KEY (`PARENT_ID`) REFERENCES `TAX_RATE` (`TAX_RATE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TAX_RATE`
--

LOCK TABLES `TAX_RATE` WRITE;
/*!40000 ALTER TABLE `TAX_RATE` DISABLE KEYS */;
/*!40000 ALTER TABLE `TAX_RATE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TAX_RATE_DESCRIPTION`
--

DROP TABLE IF EXISTS `TAX_RATE_DESCRIPTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TAX_RATE_DESCRIPTION` (
  `DESCRIPTION_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `DESCRIPTION` longtext,
  `NAME` varchar(120) NOT NULL,
  `TITLE` varchar(100) DEFAULT NULL,
  `LANGUAGE_ID` int NOT NULL,
  `TAX_RATE_ID` bigint DEFAULT NULL,
  PRIMARY KEY (`DESCRIPTION_ID`),
  UNIQUE KEY `UKt3xg8pl88yacdxg49nb46effg` (`TAX_RATE_ID`,`LANGUAGE_ID`),
  KEY `FKsicb2ydx42o04pvlnxw2mlx0w` (`LANGUAGE_ID`),
  CONSTRAINT `FK65c2lqslk5kx25dpkem2r0vxq` FOREIGN KEY (`TAX_RATE_ID`) REFERENCES `TAX_RATE` (`TAX_RATE_ID`),
  CONSTRAINT `FKsicb2ydx42o04pvlnxw2mlx0w` FOREIGN KEY (`LANGUAGE_ID`) REFERENCES `LANGUAGE` (`LANGUAGE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TAX_RATE_DESCRIPTION`
--

LOCK TABLES `TAX_RATE_DESCRIPTION` WRITE;
/*!40000 ALTER TABLE `TAX_RATE_DESCRIPTION` DISABLE KEYS */;
/*!40000 ALTER TABLE `TAX_RATE_DESCRIPTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USERS`
--

DROP TABLE IF EXISTS `USERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USERS` (
  `USER_ID` bigint NOT NULL,
  `ACTIVE` bit(1) DEFAULT NULL,
  `ADMIN_EMAIL` varchar(255) DEFAULT NULL,
  `ADMIN_NAME` varchar(100) DEFAULT NULL,
  `ADMIN_PASSWORD` varchar(60) DEFAULT NULL,
  `ADMIN_A1` varchar(255) DEFAULT NULL,
  `ADMIN_A2` varchar(255) DEFAULT NULL,
  `ADMIN_A3` varchar(255) DEFAULT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `RESET_CREDENTIALS_REQ` varchar(256) DEFAULT NULL,
  `RESET_CREDENTIALS_EXP` date DEFAULT NULL,
  `ADMIN_FIRST_NAME` varchar(255) DEFAULT NULL,
  `LAST_ACCESS` datetime DEFAULT NULL,
  `ADMIN_LAST_NAME` varchar(255) DEFAULT NULL,
  `LOGIN_ACCESS` datetime DEFAULT NULL,
  `ADMIN_Q1` varchar(255) DEFAULT NULL,
  `ADMIN_Q2` varchar(255) DEFAULT NULL,
  `ADMIN_Q3` varchar(255) DEFAULT NULL,
  `LANGUAGE_ID` int DEFAULT NULL,
  `MERCHANT_ID` int NOT NULL,
  PRIMARY KEY (`USER_ID`),
  UNIQUE KEY `UK7cwrowcnjlfxpxpdd1op9ymab` (`MERCHANT_ID`,`ADMIN_NAME`),
  KEY `FK4yb3ho4yxvcjniqg09opbm7ja` (`LANGUAGE_ID`),
  CONSTRAINT `FK4yb3ho4yxvcjniqg09opbm7ja` FOREIGN KEY (`LANGUAGE_ID`) REFERENCES `LANGUAGE` (`LANGUAGE_ID`),
  CONSTRAINT `FKtpio656e5t0cja7kx7p79rkh6` FOREIGN KEY (`MERCHANT_ID`) REFERENCES `MERCHANT_STORE` (`MERCHANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USERS`
--

LOCK TABLES `USERS` WRITE;
/*!40000 ALTER TABLE `USERS` DISABLE KEYS */;
INSERT INTO `USERS` VALUES (1,_binary '','admin@shopizer.com','admin@shopizer.com','$2a$10$iXRndXzt40HcTyPfF9fDQuv3g3c0/OWeKbbDkaGXU5wQ.VVmiQ08G',NULL,NULL,NULL,'2026-09-19 00:40:04','2026-09-20 07:10:22',NULL,NULL,NULL,'Administrator','2026-09-20 01:23:26','User','2026-09-20 07:10:22',NULL,NULL,NULL,NULL,1),(50,_binary '','anlacduyen01@gmail.com','anlacduyen','$2a$10$.ityo3Cg8tTb2FVLlJ8ctel006lMiTgY4j8ZIfUTlu7HY93CHlC3.','Trắng','Lâm Đồng','kiki','2026-09-19 09:26:18','2026-09-20 00:05:32',NULL,NULL,NULL,'Duyên','2026-09-20 00:05:09','An Lạc','2026-09-20 00:05:32','Bạn sinh ra ở thành phố nào?','Tên thú cưng đầu tiên của bạn là gì?','Thể loại âm nhạc yêu thích của bạn là gì?',50,1),(100,_binary '','thanhduc0@gmail.com','thanhduc0','$2a$10$QSgdeSlMg2/MUeQG/Xy6VeiNhfZjWtuNRmAr1ZU4YMrhZPgMLs51i','Trắng','Lâm Đồng','kiki','2026-09-19 10:22:58','2026-09-19 10:29:40',NULL,NULL,NULL,'Thanh Đức','2026-09-19 10:23:16','Thích','2026-09-19 10:29:40','Xe ô tô đầu tiên của bạn màu gì?','Bạn sinh ra ở thành phố nào?','Tên thú cưng đầu tiên của bạn là gì?',50,1),(101,_binary '','thanhduc1@gmail.com','thanhduc1','$2a$10$acusA.IUxFdf51TTHH4KuurS6uWZIDYJB.ThDa/.CIIwg2cXh82iy','Trắng','Lâm Đồng','kiki','2026-09-19 10:25:25','2026-09-19 10:29:25',NULL,NULL,NULL,'Thanh Đức','2026-09-19 10:25:44','Thích','2026-09-19 10:29:25','Xe ô tô đầu tiên của bạn màu gì?','Bạn sinh ra ở thành phố nào?','Tên thú cưng đầu tiên của bạn là gì?',50,1),(102,_binary '','thanhduc2@gmail.com','thanhduc2','$2a$10$kJ3j4Du84pFuTyk6s1RGoOWOqRgYjjJM9H0dnJywoYq0mB3B1/eI.','Trắng','Lâm Đồng','kiki','2026-09-19 10:27:47','2026-09-19 15:19:05',NULL,NULL,NULL,'Thanh Đức','2026-09-19 10:29:08','Thích','2026-09-19 15:19:05','Xe ô tô đầu tiên của bạn màu gì?','Bạn sinh ra ở thành phố nào?','Tên thú cưng đầu tiên của bạn là gì?',50,1),(103,_binary '','thanhduc3@gmail.com','thanhduc3','$2a$10$8lew17/OSKZP.3h6KBjicOh9CcZNEaG0IxQBvcgPdikAb2QBiaGZG','Trắng','Lâm Đồng','kiki','2026-09-19 10:28:35','2026-09-19 15:19:17',NULL,NULL,NULL,'Thanh Đức','2026-09-19 10:28:48','Thích','2026-09-19 15:19:17','Xe ô tô đầu tiên của bạn màu gì?','Bạn sinh ra ở thành phố nào?','Tên thú cưng đầu tiên của bạn là gì?',50,1);
/*!40000 ALTER TABLE `USERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_GROUP`
--

DROP TABLE IF EXISTS `USER_GROUP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_GROUP` (
  `USER_ID` bigint NOT NULL,
  `GROUP_ID` int NOT NULL,
  KEY `FK75kainrhn4kh8j3sw2xbe7v61` (`GROUP_ID`),
  KEY `FK9op4wv63nonsby8y9myjhtho` (`USER_ID`),
  CONSTRAINT `FK75kainrhn4kh8j3sw2xbe7v61` FOREIGN KEY (`GROUP_ID`) REFERENCES `SM_GROUP` (`GROUP_ID`),
  CONSTRAINT `FK9op4wv63nonsby8y9myjhtho` FOREIGN KEY (`USER_ID`) REFERENCES `USERS` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_GROUP`
--

LOCK TABLES `USER_GROUP` WRITE;
/*!40000 ALTER TABLE `USER_GROUP` DISABLE KEYS */;
INSERT INTO `USER_GROUP` VALUES (1,50),(1,51),(50,54),(100,52),(101,53),(102,55),(103,56);
/*!40000 ALTER TABLE `USER_GROUP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserConnection`
--

DROP TABLE IF EXISTS `UserConnection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserConnection` (
  `providerId` varchar(255) NOT NULL,
  `providerUserId` varchar(255) NOT NULL,
  `userId` varchar(255) NOT NULL,
  `accessToken` varchar(255) DEFAULT NULL,
  `displayName` varchar(255) DEFAULT NULL,
  `expireTime` bigint DEFAULT NULL,
  `imageUrl` varchar(255) DEFAULT NULL,
  `profileUrl` varchar(255) DEFAULT NULL,
  `refreshToken` varchar(255) DEFAULT NULL,
  `secret` varchar(255) DEFAULT NULL,
  `userRank` int NOT NULL,
  PRIMARY KEY (`providerId`,`providerUserId`,`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserConnection`
--

LOCK TABLES `UserConnection` WRITE;
/*!40000 ALTER TABLE `UserConnection` DISABLE KEYS */;
/*!40000 ALTER TABLE `UserConnection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ZONE`
--

DROP TABLE IF EXISTS `ZONE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ZONE` (
  `ZONE_ID` bigint NOT NULL,
  `ZONE_CODE` varchar(255) NOT NULL,
  `COUNTRY_ID` int NOT NULL,
  PRIMARY KEY (`ZONE_ID`),
  UNIQUE KEY `UK_4tq3p5w8k4h4easyf5t3n1jdr` (`ZONE_CODE`),
  KEY `FKhn2c1w3e1twhjg7tiwv7vuk67` (`COUNTRY_ID`),
  CONSTRAINT `FKhn2c1w3e1twhjg7tiwv7vuk67` FOREIGN KEY (`COUNTRY_ID`) REFERENCES `COUNTRY` (`COUNTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ZONE`
--

LOCK TABLES `ZONE` WRITE;
/*!40000 ALTER TABLE `ZONE` DISABLE KEYS */;
INSERT INTO `ZONE` VALUES (1,'Guipuzcoa',446),(2,'01',479),(3,'PR',473),(4,'04',479),(5,'05',479),(6,'Zamora',446),(7,'06',479),(8,'07',479),(9,'09',479),(10,'Lleida',446),(11,'QC',286),(12,'QH',292),(13,'ACorua',446),(14,'Castellon',446),(15,'LasPalmas',446),(16,'AA',473),(17,'AB',286),(18,'AC',473),(19,'13',479),(20,'AE',473),(21,'AF',473),(22,'AG',453),(23,'18',479),(24,'AH',292),(25,'AI',453),(26,'AK',473),(27,'Caceres',446),(28,'Segovia',446),(29,'AL',473),(30,'AM',473),(31,'Malaga',446),(32,'CEN',415),(33,'AP',473),(34,'Melilla',446),(35,'AR',473),(36,'AS',473),(37,'RI',473),(38,'AZ',473),(39,'Ceuta',446),(40,'21',479),(41,'22',479),(42,'BC',286),(43,'23',479),(44,'24',479),(45,'BE',453),(46,'26',479),(47,'29',479),(48,'ARCH',453),(49,'BJ',292),(50,'BL',453),(51,'SA',262),(52,'SB',263),(53,'SC',473),(54,'THE',327),(55,'SD',473),(56,'BS',453),(57,'Cordoba',446),(58,'Tarragona',446),(59,'Valladolid',446),(60,'SG',453),(61,'SH',453),(62,'WAAU',262),(63,'SK',286),(64,'SN',292),(65,'SO',453),(66,'30',479),(67,'CA',473),(68,'NTAU',262),(69,'33',479),(70,'ST',263),(71,'35',479),(72,'Jaen',446),(73,'ASU',415),(74,'37',479),(75,'SX',292),(76,'CiudadReal',446),(77,'39',479),(78,'SZ',453),(79,'CO',473),(80,'BER',327),(81,'CQ',292),(82,'CT',473),(83,'ACT',262),(84,'TG',453),(85,'HAM',327),(86,'TI',453),(87,'Lugo',446),(88,'TJ',292),(89,'NECH',453),(90,'TN',473),(91,'DC',473),(92,'Palencia',446),(93,'DE',473),(94,'46',479),(95,'TX',473),(96,'49',479),(97,'Burgos',446),(98,'Cadiz',446),(99,'DN',479),(100,'Guadalajara',446),(101,'UR',453),(102,'UT',473),(103,'56',479),(104,'59',479),(105,'Barcelona',446),(106,'VA',473),(107,'VB',263),(108,'Cuenca',446),(109,'WIAT',263),(110,'VD',453),(111,'VI',473),(112,'Zaragoza',446),(113,'VS',453),(114,'VT',473),(115,'68',479),(116,'FJ',292),(117,'FL',473),(118,'FM',473),(119,'WA',473),(120,'Granada',446),(121,'FR',453),(122,'RHE',327),(123,'Ourense',446),(124,'WI',473),(125,'GA',473),(126,'Murcia',446),(127,'71',479),(128,'GD',292),(129,'GE',453),(130,'WV',473),(131,'WY',473),(132,'Avila',446),(133,'GL',453),(134,'GR',453),(135,'GS',292),(136,'GU',473),(137,'GX',292),(138,'XJ',292),(139,'GZ',292),(140,'HES',327),(141,'HA',292),(142,'HB',292),(143,'HE',292),(144,'HI',473),(145,'89',479),(146,'XZ',292),(147,'HK',292),(148,'HL',292),(149,'HN',479),(150,'Vizcaya',446),(151,'HP',479),(152,'OTR',415),(153,'Albacete',446),(154,'NRW',327),(155,'YN',292),(156,'IA',473),(157,'ID',473),(158,'YT',286),(159,'Leon',446),(160,'Pontevedra',446),(161,'Teruel',446),(162,'IL',473),(163,'IN',473),(164,'A Corua',446),(165,'ZG',453),(166,'ZH',453),(167,'LaRioja',446),(168,'ZJ',292),(169,'NSW',262),(170,'Madrid',446),(171,'Huelva',446),(172,'JL',292),(173,'Huesca',446),(174,'JS',292),(175,'JU',453),(176,'Asturias',446),(177,'JX',292),(178,'TIAT',263),(179,'NDS',327),(180,'KN',263),(181,'Alava',446),(182,'KS',473),(183,'KY',473),(184,'LA',473),(185,'Toledo',446),(186,'LN',292),(187,'TAS',262),(188,'QLD',262),(189,'LU',453),(190,'SantaCruzdeTenerife',446),(191,'MA',473),(192,'MB',286),(193,'MD',473),(194,'Girona',446),(195,'ME',473),(196,'Alicante',446),(197,'Cantabria',446),(198,'MH',473),(199,'MI',473),(200,'MN',473),(201,'MO',473),(202,'MP',473),(203,'MS',473),(204,'MT',473),(205,'Badajoz',446),(206,'MEC',327),(207,'Sevilla',446),(208,'NB',286),(209,'SAC',327),(210,'NC',473),(211,'ND',473),(212,'NE',473),(213,'NF',286),(214,'NH',473),(215,'NJ',473),(216,'NM',473),(217,'NO',263),(218,'SAS',327),(219,'NS',286),(220,'SAR',327),(221,'NT',286),(222,'NU',286),(223,'NV',473),(224,'NW',453),(225,'NX',292),(226,'NY',473),(227,'Soria',446),(228,'OH',473),(229,'OK',473),(230,'ON',286),(231,'OO',263),(232,'BLAT',263),(233,'OR',473),(234,'Salamanca',446),(235,'Baleares',446),(236,'OW',453),(237,'PA',473),(238,'VIC',262),(239,'BRE',327),(240,'PE',286),(241,'BRG',327),(242,'Almeria',446),(243,'BAW',327),(244,'BAY',327),(245,'Navarra',446),(246,'Valencia',446),(247,'SCN',327),(248,'AndhraPradesh',346),(249,'ArunachalPradesh',346),(250,'Assam',346),(251,'Bihar',346),(252,'Chhattisgarh',346),(253,'Goa',346),(254,'Gujarat',346),(255,'Haryana',346),(256,'HimachalPradesh',346),(257,'Jharkhand',346),(258,'Karnataka',346),(259,'Kerala',346),(260,'MadhyaPradesh',346),(261,'Maharashtra',346),(262,'Manipur',346),(263,'Meghalaya',346),(264,'Mizoram',346),(265,'Nagaland',346),(266,'Odisha',346),(267,'Punjab',346),(268,'Rajasthan',346),(269,'Sikkim',346),(270,'TamilNadu',346),(271,'Telangana',346),(272,'Tripura',346),(273,'Uttarakhand',346),(274,'WestBengal',346);
/*!40000 ALTER TABLE `ZONE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ZONE_DESCRIPTION`
--

DROP TABLE IF EXISTS `ZONE_DESCRIPTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ZONE_DESCRIPTION` (
  `DESCRIPTION_ID` bigint NOT NULL,
  `DATE_CREATED` datetime DEFAULT NULL,
  `DATE_MODIFIED` datetime DEFAULT NULL,
  `UPDT_ID` varchar(60) DEFAULT NULL,
  `DESCRIPTION` longtext,
  `NAME` varchar(120) NOT NULL,
  `TITLE` varchar(100) DEFAULT NULL,
  `LANGUAGE_ID` int NOT NULL,
  `ZONE_ID` bigint NOT NULL,
  PRIMARY KEY (`DESCRIPTION_ID`),
  UNIQUE KEY `UKm64laxgrv9fxm6io232ap4su9` (`ZONE_ID`,`LANGUAGE_ID`),
  KEY `FK69ybu7r3bgpcq65c77ji1udh3` (`LANGUAGE_ID`),
  CONSTRAINT `FK69ybu7r3bgpcq65c77ji1udh3` FOREIGN KEY (`LANGUAGE_ID`) REFERENCES `LANGUAGE` (`LANGUAGE_ID`),
  CONSTRAINT `FKpv4elin6w3b03756obqvk447f` FOREIGN KEY (`ZONE_ID`) REFERENCES `ZONE` (`ZONE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ZONE_DESCRIPTION`
--

LOCK TABLES `ZONE_DESCRIPTION` WRITE;
/*!40000 ALTER TABLE `ZONE_DESCRIPTION` DISABLE KEYS */;
INSERT INTO `ZONE_DESCRIPTION` VALUES (1,'2026-09-19 00:39:34','2026-09-19 00:39:34',NULL,NULL,'Guipuzcoa',NULL,50,1),(2,'2026-09-19 00:39:34','2026-09-19 00:39:34',NULL,NULL,'Guipuzcoa',NULL,51,1),(3,'2026-09-19 00:39:34','2026-09-19 00:39:34',NULL,NULL,'Guipuzcoa',NULL,52,1),(4,'2026-09-19 00:39:34','2026-09-19 00:39:34',NULL,NULL,'Lai Châu',NULL,50,2),(5,'2026-09-19 00:39:34','2026-09-19 00:39:34',NULL,NULL,'Lai Châu',NULL,51,2),(6,'2026-09-19 00:39:34','2026-09-19 00:39:34',NULL,NULL,'Lai Châu',NULL,52,2),(7,'2026-09-19 00:39:34','2026-09-19 00:39:34',NULL,NULL,'Puerto Rico',NULL,50,3),(8,'2026-09-19 00:39:34','2026-09-19 00:39:34',NULL,NULL,'Puerto Rico',NULL,51,3),(9,'2026-09-19 00:39:34','2026-09-19 00:39:34',NULL,NULL,'Puerto Rico',NULL,52,3),(10,'2026-09-19 00:39:34','2026-09-19 00:39:34',NULL,NULL,'Cao Bằng',NULL,50,4),(11,'2026-09-19 00:39:34','2026-09-19 00:39:34',NULL,NULL,'Cao Bằng',NULL,51,4),(12,'2026-09-19 00:39:34','2026-09-19 00:39:34',NULL,NULL,'Cao Bằng',NULL,52,4),(13,'2026-09-19 00:39:34','2026-09-19 00:39:34',NULL,NULL,'Sơn La',NULL,50,5),(14,'2026-09-19 00:39:34','2026-09-19 00:39:34',NULL,NULL,'Sơn La',NULL,51,5),(15,'2026-09-19 00:39:34','2026-09-19 00:39:34',NULL,NULL,'Sơn La',NULL,52,5),(16,'2026-09-19 00:39:35','2026-09-19 00:39:35',NULL,NULL,'Zamora',NULL,50,6),(17,'2026-09-19 00:39:35','2026-09-19 00:39:35',NULL,NULL,'Zamora',NULL,51,6),(18,'2026-09-19 00:39:35','2026-09-19 00:39:35',NULL,NULL,'Zamora',NULL,52,6),(19,'2026-09-19 00:39:35','2026-09-19 00:39:35',NULL,NULL,'Yên Bái',NULL,50,7),(20,'2026-09-19 00:39:35','2026-09-19 00:39:35',NULL,NULL,'Yên Bái',NULL,51,7),(21,'2026-09-19 00:39:35','2026-09-19 00:39:35',NULL,NULL,'Yên Bái',NULL,52,7),(22,'2026-09-19 00:39:35','2026-09-19 00:39:35',NULL,NULL,'Tuyên Quang',NULL,50,8),(23,'2026-09-19 00:39:35','2026-09-19 00:39:35',NULL,NULL,'Tuyên Quang',NULL,51,8),(24,'2026-09-19 00:39:35','2026-09-19 00:39:35',NULL,NULL,'Tuyên Quang',NULL,52,8),(25,'2026-09-19 00:39:35','2026-09-19 00:39:35',NULL,NULL,'Lạng Sơn',NULL,50,9),(26,'2026-09-19 00:39:35','2026-09-19 00:39:35',NULL,NULL,'Lạng Sơn',NULL,51,9),(27,'2026-09-19 00:39:35','2026-09-19 00:39:35',NULL,NULL,'Lạng Sơn',NULL,52,9),(28,'2026-09-19 00:39:35','2026-09-19 00:39:35',NULL,NULL,'Lleida',NULL,50,10),(29,'2026-09-19 00:39:35','2026-09-19 00:39:35',NULL,NULL,'Lleida',NULL,51,10),(30,'2026-09-19 00:39:35','2026-09-19 00:39:35',NULL,NULL,'Lleida',NULL,52,10),(31,'2026-09-19 00:39:35','2026-09-19 00:39:35',NULL,NULL,'Quebec',NULL,50,11),(32,'2026-09-19 00:39:35','2026-09-19 00:39:35',NULL,NULL,'Quebec',NULL,51,11),(33,'2026-09-19 00:39:35','2026-09-19 00:39:35',NULL,NULL,'Québec',NULL,52,11),(34,'2026-09-19 00:39:36','2026-09-19 00:39:36',NULL,NULL,'青海',NULL,53,12),(35,'2026-09-19 00:39:36','2026-09-19 00:39:36',NULL,NULL,'A Corua',NULL,50,13),(36,'2026-09-19 00:39:36','2026-09-19 00:39:36',NULL,NULL,'A Corua',NULL,51,13),(37,'2026-09-19 00:39:36','2026-09-19 00:39:36',NULL,NULL,'Castellon',NULL,50,14),(38,'2026-09-19 00:39:36','2026-09-19 00:39:36',NULL,NULL,'Castellon',NULL,51,14),(39,'2026-09-19 00:39:36','2026-09-19 00:39:36',NULL,NULL,'Castellon',NULL,52,14),(40,'2026-09-19 00:39:36','2026-09-19 00:39:36',NULL,NULL,'Las Palmas',NULL,50,15),(41,'2026-09-19 00:39:36','2026-09-19 00:39:36',NULL,NULL,'Las Palmas',NULL,51,15),(42,'2026-09-19 00:39:36','2026-09-19 00:39:36',NULL,NULL,'Las Palmas',NULL,52,15),(43,'2026-09-19 00:39:36','2026-09-19 00:39:36',NULL,NULL,'Armed Forces Americas',NULL,50,16),(44,'2026-09-19 00:39:36','2026-09-19 00:39:36',NULL,NULL,'Armed Forces Americas',NULL,51,16),(45,'2026-09-19 00:39:36','2026-09-19 00:39:36',NULL,NULL,'Armed Forces Americas',NULL,52,16),(46,'2026-09-19 00:39:36','2026-09-19 00:39:36',NULL,NULL,'Alberta',NULL,50,17),(47,'2026-09-19 00:39:36','2026-09-19 00:39:36',NULL,NULL,'Alberta',NULL,51,17),(48,'2026-09-19 00:39:36','2026-09-19 00:39:36',NULL,NULL,'Alberta',NULL,52,17),(49,'2026-09-19 00:39:36','2026-09-19 00:39:36',NULL,NULL,'Armed Forces Canada',NULL,50,18),(50,'2026-09-19 00:39:36','2026-09-19 00:39:36',NULL,NULL,'Armed Forces Canada',NULL,51,18),(51,'2026-09-19 00:39:36','2026-09-19 00:39:36',NULL,NULL,'Armed Forces Canada',NULL,52,18),(52,'2026-09-19 00:39:36','2026-09-19 00:39:36',NULL,NULL,'Quảng Ninh',NULL,50,19),(53,'2026-09-19 00:39:36','2026-09-19 00:39:36',NULL,NULL,'Quảng Ninh',NULL,51,19),(54,'2026-09-19 00:39:36','2026-09-19 00:39:36',NULL,NULL,'Quảng Ninh',NULL,52,19),(55,'2026-09-19 00:39:36','2026-09-19 00:39:36',NULL,NULL,'Armed Forces Europe',NULL,50,20),(56,'2026-09-19 00:39:36','2026-09-19 00:39:36',NULL,NULL,'Armed Forces Europe',NULL,51,20),(57,'2026-09-19 00:39:36','2026-09-19 00:39:36',NULL,NULL,'Armed Forces Europe',NULL,52,20),(58,'2026-09-19 00:39:37','2026-09-19 00:39:37',NULL,NULL,'Armed Forces Africa',NULL,50,21),(59,'2026-09-19 00:39:37','2026-09-19 00:39:37',NULL,NULL,'Armed Forces Africa',NULL,51,21),(60,'2026-09-19 00:39:37','2026-09-19 00:39:37',NULL,NULL,'Armed Forces Africa',NULL,52,21),(61,'2026-09-19 00:39:37','2026-09-19 00:39:37',NULL,NULL,'Aargau',NULL,50,22),(62,'2026-09-19 00:39:37','2026-09-19 00:39:37',NULL,NULL,'Aargau',NULL,51,22),(63,'2026-09-19 00:39:37','2026-09-19 00:39:37',NULL,NULL,'Aargau',NULL,52,22),(64,'2026-09-19 00:39:37','2026-09-19 00:39:37',NULL,NULL,'Ninh Bình',NULL,50,23),(65,'2026-09-19 00:39:37','2026-09-19 00:39:37',NULL,NULL,'Ninh Bình',NULL,51,23),(66,'2026-09-19 00:39:37','2026-09-19 00:39:37',NULL,NULL,'Ninh Bình',NULL,52,23),(67,'2026-09-19 00:39:37','2026-09-19 00:39:37',NULL,NULL,'安徽',NULL,53,24),(68,'2026-09-19 00:39:37','2026-09-19 00:39:37',NULL,NULL,'Appenzell Innerrhoden',NULL,50,25),(69,'2026-09-19 00:39:37','2026-09-19 00:39:37',NULL,NULL,'Appenzell Innerrhoden',NULL,51,25),(70,'2026-09-19 00:39:37','2026-09-19 00:39:37',NULL,NULL,'Appenzell Innerrhoden',NULL,52,25),(71,'2026-09-19 00:39:37','2026-09-19 00:39:37',NULL,NULL,'Alaska',NULL,50,26),(72,'2026-09-19 00:39:37','2026-09-19 00:39:37',NULL,NULL,'Alaska',NULL,51,26),(73,'2026-09-19 00:39:37','2026-09-19 00:39:37',NULL,NULL,'Alaska',NULL,52,26),(74,'2026-09-19 00:39:37','2026-09-19 00:39:37',NULL,NULL,'Caceres',NULL,50,27),(75,'2026-09-19 00:39:37','2026-09-19 00:39:37',NULL,NULL,'Caceres',NULL,51,27),(76,'2026-09-19 00:39:37','2026-09-19 00:39:37',NULL,NULL,'Caceres',NULL,52,27),(77,'2026-09-19 00:39:37','2026-09-19 00:39:37',NULL,NULL,'Segovia',NULL,50,28),(78,'2026-09-19 00:39:37','2026-09-19 00:39:37',NULL,NULL,'Segovia',NULL,51,28),(79,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Segovia',NULL,52,28),(80,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Alabama',NULL,50,29),(81,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Alabama',NULL,51,29),(82,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Alabama',NULL,52,29),(83,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Armed Forces Middle East',NULL,50,30),(84,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Armed Forces Middle East',NULL,51,30),(85,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Armed Forces Middle East',NULL,52,30),(86,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Malaga',NULL,50,31),(87,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Malaga',NULL,51,31),(88,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Malaga',NULL,52,31),(89,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Central',NULL,50,32),(90,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Central',NULL,51,32),(91,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Armed Forces Pacific',NULL,50,33),(92,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Armed Forces Pacific',NULL,51,33),(93,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Armed Forces Pacific',NULL,52,33),(94,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Melilla',NULL,50,34),(95,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Melilla',NULL,51,34),(96,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Melilla',NULL,52,34),(97,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Arkansas',NULL,50,35),(98,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Arkansas',NULL,51,35),(99,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Arkansas',NULL,52,35),(100,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'American Samoa',NULL,50,36),(101,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'American Samoa',NULL,51,36),(102,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'American Samoa',NULL,52,36),(103,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Rhode Island',NULL,50,37),(104,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Rhode Island',NULL,51,37),(105,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Rhode Island',NULL,52,37),(106,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Arizona',NULL,50,38),(107,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Arizona',NULL,51,38),(108,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Arizona',NULL,52,38),(109,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Ceuta',NULL,50,39),(110,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Ceuta',NULL,51,39),(111,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Ceuta',NULL,52,39),(112,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Thanh Hóa',NULL,50,40),(113,'2026-09-19 00:39:38','2026-09-19 00:39:38',NULL,NULL,'Thanh Hóa',NULL,51,40),(114,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Thanh Hóa',NULL,52,40),(115,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Nghệ An',NULL,50,41),(116,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Nghệ An',NULL,51,41),(117,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Nghệ An',NULL,52,41),(118,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'British Columbia',NULL,50,42),(119,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'British Columbia',NULL,51,42),(120,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Colombie Britanique',NULL,52,42),(121,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Hà Tĩnh',NULL,50,43),(122,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Hà Tĩnh',NULL,51,43),(123,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Hà Tĩnh',NULL,52,43),(124,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Quảng Bình',NULL,50,44),(125,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Quảng Bình',NULL,51,44),(126,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Quảng Bình',NULL,52,44),(127,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Bern',NULL,50,45),(128,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Bern',NULL,51,45),(129,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Bern',NULL,52,45),(130,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Thừa Thiên Huế',NULL,50,46),(131,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Thừa Thiên Huế',NULL,51,46),(132,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Thừa Thiên Huế',NULL,52,46),(133,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Quảng Ngãi',NULL,50,47),(134,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Quảng Ngãi',NULL,51,47),(135,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Quảng Ngãi',NULL,52,47),(136,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Appenzell Ausserrhoden',NULL,50,48),(137,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Appenzell Ausserrhoden',NULL,51,48),(138,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Appenzell Ausserrhoden',NULL,52,48),(139,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'北京',NULL,53,49),(140,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Basel-Landschaft',NULL,50,50),(141,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Basel-Landschaft',NULL,51,50),(142,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Basel-Landschaft',NULL,52,50),(143,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'South Australia',NULL,50,51),(144,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'South Australia',NULL,51,51),(145,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Australie-Mridionale',NULL,52,51),(146,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Salzburg',NULL,50,52),(147,'2026-09-19 00:39:39','2026-09-19 00:39:39',NULL,NULL,'Salzburg',NULL,51,52),(148,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'Salzburg',NULL,52,52),(149,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'South Carolina',NULL,50,53),(150,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'South Carolina',NULL,51,53),(151,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'Caroline du Sud',NULL,52,53),(152,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'四川',NULL,53,53),(153,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'Thringen',NULL,50,54),(154,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'Thringen',NULL,51,54),(155,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'Thringen',NULL,52,54),(156,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'South Dakota',NULL,50,55),(157,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'South Dakota',NULL,51,55),(158,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'Dakota du Sud',NULL,52,55),(159,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'山东',NULL,53,55),(160,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'Basel-Stadt',NULL,50,56),(161,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'Basel-Stadt',NULL,51,56),(162,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'Basel-Stadt',NULL,52,56),(163,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'Cordoba',NULL,50,57),(164,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'Cordoba',NULL,51,57),(165,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'Cordoba',NULL,52,57),(166,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'Tarragona',NULL,50,58),(167,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'Tarragona',NULL,51,58),(168,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'Tarragona',NULL,52,58),(169,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'Valladolid',NULL,50,59),(170,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'Valladolid',NULL,51,59),(171,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'Valladolid',NULL,52,59),(172,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'St. Gallen',NULL,50,60),(173,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'St. Gallen',NULL,51,60),(174,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'St. Gallen',NULL,52,60),(175,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'Schaffhausen',NULL,50,61),(176,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'Schaffhausen',NULL,51,61),(177,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'Schaffhausen',NULL,52,61),(178,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'上海',NULL,53,61),(179,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'Western Australia',NULL,50,62),(180,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'Western Australia',NULL,51,62),(181,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'Australie-Occidentale',NULL,52,62),(182,'2026-09-19 00:39:40','2026-09-19 00:39:40',NULL,NULL,'Saskatchewan',NULL,50,63),(183,'2026-09-19 00:39:41','2026-09-19 00:39:41',NULL,NULL,'Saskatchewan',NULL,51,63),(184,'2026-09-19 00:39:41','2026-09-19 00:39:41',NULL,NULL,'Saskatchewan',NULL,52,63),(185,'2026-09-19 00:39:41','2026-09-19 00:39:41',NULL,NULL,'陕西',NULL,53,64),(186,'2026-09-19 00:39:41','2026-09-19 00:39:41',NULL,NULL,'Solothurn',NULL,50,65),(187,'2026-09-19 00:39:41','2026-09-19 00:39:41',NULL,NULL,'Solothurn',NULL,51,65),(188,'2026-09-19 00:39:41','2026-09-19 00:39:41',NULL,NULL,'Solothurn',NULL,52,65),(189,'2026-09-19 00:39:41','2026-09-19 00:39:41',NULL,NULL,'Gia Lai',NULL,50,66),(190,'2026-09-19 00:39:41','2026-09-19 00:39:41',NULL,NULL,'Gia Lai',NULL,51,66),(191,'2026-09-19 00:39:41','2026-09-19 00:39:41',NULL,NULL,'Gia Lai',NULL,52,66),(192,'2026-09-19 00:39:41','2026-09-19 00:39:41',NULL,NULL,'California',NULL,50,67),(193,'2026-09-19 00:39:41','2026-09-19 00:39:41',NULL,NULL,'California',NULL,51,67),(194,'2026-09-19 00:39:41','2026-09-19 00:39:41',NULL,NULL,'Californie',NULL,52,67),(195,'2026-09-19 00:39:41','2026-09-19 00:39:41',NULL,NULL,'Northern Territory',NULL,50,68),(196,'2026-09-19 00:39:41','2026-09-19 00:39:41',NULL,NULL,'Northern Territory',NULL,51,68),(197,'2026-09-19 00:39:41','2026-09-19 00:39:41',NULL,NULL,'Territoire du Nord',NULL,52,68),(198,'2026-09-19 00:39:41','2026-09-19 00:39:41',NULL,NULL,'Đắk lăk',NULL,50,69),(199,'2026-09-19 00:39:41','2026-09-19 00:39:41',NULL,NULL,'Đắk lăk',NULL,51,69),(200,'2026-09-19 00:39:41','2026-09-19 00:39:41',NULL,NULL,'Đắk lăk',NULL,52,69),(201,'2026-09-19 00:39:41','2026-09-19 00:39:41',NULL,NULL,'Steiermark',NULL,50,70),(202,'2026-09-19 00:39:41','2026-09-19 00:39:41',NULL,NULL,'Steiermark',NULL,51,70),(203,'2026-09-19 00:39:41','2026-09-19 00:39:41',NULL,NULL,'Steiermark',NULL,52,70),(204,'2026-09-19 00:39:42','2026-09-19 00:39:42',NULL,NULL,'Lâm Đồng',NULL,50,71),(205,'2026-09-19 00:39:42','2026-09-19 00:39:42',NULL,NULL,'Lâm Đồng',NULL,51,71),(206,'2026-09-19 00:39:42','2026-09-19 00:39:42',NULL,NULL,'Lâm Đồng',NULL,52,71),(207,'2026-09-19 00:39:42','2026-09-19 00:39:42',NULL,NULL,'Jaen',NULL,50,72),(208,'2026-09-19 00:39:42','2026-09-19 00:39:42',NULL,NULL,'Jaen',NULL,51,72),(209,'2026-09-19 00:39:42','2026-09-19 00:39:42',NULL,NULL,'Jaen',NULL,52,72),(210,'2026-09-19 00:39:42','2026-09-19 00:39:42',NULL,NULL,'Asunción',NULL,50,73),(211,'2026-09-19 00:39:42','2026-09-19 00:39:42',NULL,NULL,'Asuncion',NULL,51,73),(212,'2026-09-19 00:39:42','2026-09-19 00:39:42',NULL,NULL,'Tây Ninh',NULL,50,74),(213,'2026-09-19 00:39:42','2026-09-19 00:39:42',NULL,NULL,'Tây Ninh',NULL,51,74),(214,'2026-09-19 00:39:42','2026-09-19 00:39:42',NULL,NULL,'Tây Ninh',NULL,52,74),(215,'2026-09-19 00:39:42','2026-09-19 00:39:42',NULL,NULL,'山西',NULL,53,75),(216,'2026-09-19 00:39:42','2026-09-19 00:39:42',NULL,NULL,'Ciudad Real',NULL,50,76),(217,'2026-09-19 00:39:42','2026-09-19 00:39:42',NULL,NULL,'Ciudad Real',NULL,51,76),(218,'2026-09-19 00:39:42','2026-09-19 00:39:42',NULL,NULL,'Ciudad Real',NULL,52,76),(219,'2026-09-19 00:39:42','2026-09-19 00:39:42',NULL,NULL,'Đồng Nai',NULL,50,77),(220,'2026-09-19 00:39:42','2026-09-19 00:39:42',NULL,NULL,'Đồng Nai',NULL,51,77),(221,'2026-09-19 00:39:42','2026-09-19 00:39:42',NULL,NULL,'Đồng Nai',NULL,52,77),(222,'2026-09-19 00:39:42','2026-09-19 00:39:42',NULL,NULL,'Schwyz',NULL,50,78),(223,'2026-09-19 00:39:42','2026-09-19 00:39:42',NULL,NULL,'Schwyz',NULL,51,78),(224,'2026-09-19 00:39:42','2026-09-19 00:39:42',NULL,NULL,'Schwyz',NULL,52,78),(225,'2026-09-19 00:39:42','2026-09-19 00:39:42',NULL,NULL,'Colorado',NULL,50,79),(226,'2026-09-19 00:39:42','2026-09-19 00:39:42',NULL,NULL,'Colorado',NULL,51,79),(227,'2026-09-19 00:39:42','2026-09-19 00:39:42',NULL,NULL,'Colorado',NULL,52,79),(228,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'Berlin',NULL,50,80),(229,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'Berlin',NULL,51,80),(230,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'Berlin',NULL,52,80),(231,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'重庆',NULL,53,81),(232,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'Connecticut',NULL,50,82),(233,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'Connecticut',NULL,51,82),(234,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'Connecticut',NULL,52,82),(235,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'Australian Capital Territory',NULL,50,83),(236,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'Australian Capital Territory',NULL,51,83),(237,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'Territoire de la capitale australienne',NULL,52,83),(238,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'Thurgau',NULL,50,84),(239,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'Thurgau',NULL,51,84),(240,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'Thurgau',NULL,52,84),(241,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'Hamburg',NULL,50,85),(242,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'Hamburg',NULL,51,85),(243,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'Hamburg',NULL,52,85),(244,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'Tessin',NULL,50,86),(245,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'Tessin',NULL,51,86),(246,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'Tessin',NULL,52,86),(247,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'Lugo',NULL,50,87),(248,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'Lugo',NULL,51,87),(249,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'Lugo',NULL,52,87),(250,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'天津',NULL,53,88),(251,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'Neuenburg',NULL,50,89),(252,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'Neuenburg',NULL,51,89),(253,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'Neuenburg',NULL,52,89),(254,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'Tennessee',NULL,50,90),(255,'2026-09-19 00:39:43','2026-09-19 00:39:43',NULL,NULL,'Tennessee',NULL,51,90),(256,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Tennessee',NULL,52,90),(257,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'District of Columbia',NULL,50,91),(258,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'District of Columbia',NULL,51,91),(259,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'District de Columbia',NULL,52,91),(260,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Palencia',NULL,50,92),(261,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Palencia',NULL,51,92),(262,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Palencia',NULL,52,92),(263,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Delaware',NULL,50,93),(264,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Delaware',NULL,51,93),(265,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Delaware',NULL,52,93),(266,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Tiền Giang',NULL,50,94),(267,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Tiền Giang',NULL,51,94),(268,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Tiền Giang',NULL,52,94),(269,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Texas',NULL,50,95),(270,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Texas',NULL,51,95),(271,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Texas',NULL,52,95),(272,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Vĩnh Long',NULL,50,96),(273,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Vĩnh Long',NULL,51,96),(274,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Vĩnh Long',NULL,52,96),(275,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Burgos',NULL,50,97),(276,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Burgos',NULL,51,97),(277,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Burgos',NULL,52,97),(278,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Cadiz',NULL,50,98),(279,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Cadiz',NULL,51,98),(280,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Cadiz',NULL,52,98),(281,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Đà Nẵng',NULL,50,99),(282,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Đà Nẵng',NULL,51,99),(283,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Đà Nẵng',NULL,52,99),(284,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Guadalajara',NULL,50,100),(285,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Guadalajara',NULL,51,100),(286,'2026-09-19 00:39:44','2026-09-19 00:39:44',NULL,NULL,'Guadalajara',NULL,52,100),(287,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Uri',NULL,50,101),(288,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Uri',NULL,51,101),(289,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Uri',NULL,52,101),(290,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Utah',NULL,50,102),(291,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Utah',NULL,51,102),(292,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Utah',NULL,52,102),(293,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Bắc Ninh',NULL,50,103),(294,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Bắc Ninh',NULL,51,103),(295,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Bắc Ninh',NULL,52,103),(296,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Cà Mau',NULL,50,104),(297,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Cà Mau',NULL,51,104),(298,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Cà Mau',NULL,52,104),(299,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Barcelona',NULL,50,105),(300,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Barcelona',NULL,51,105),(301,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Barcelona',NULL,52,105),(302,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Virginia',NULL,50,106),(303,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Virginia',NULL,51,106),(304,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Virginie',NULL,52,106),(305,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Voralberg',NULL,50,107),(306,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Voralberg',NULL,51,107),(307,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Voralberg',NULL,52,107),(308,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Cuenca',NULL,50,108),(309,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Cuenca',NULL,51,108),(310,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Cuenca',NULL,52,108),(311,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Wien',NULL,50,109),(312,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Wien',NULL,51,109),(313,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Wien',NULL,52,109),(314,'2026-09-19 00:39:45','2026-09-19 00:39:45',NULL,NULL,'Waadt',NULL,50,110),(315,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Waadt',NULL,51,110),(316,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Waadt',NULL,52,110),(317,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Virgin Islands',NULL,50,111),(318,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Virgin Islands',NULL,51,111),(319,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Virgin Islands',NULL,52,111),(320,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Zaragoza',NULL,50,112),(321,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Zaragoza',NULL,51,112),(322,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Zaragoza',NULL,52,112),(323,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Wallis',NULL,50,113),(324,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Wallis',NULL,51,113),(325,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Wallis',NULL,52,113),(326,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Vermont',NULL,50,114),(327,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Vermont',NULL,51,114),(328,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Vermont',NULL,52,114),(329,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Phú Thọ',NULL,50,115),(330,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Phú Thọ',NULL,51,115),(331,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Phú Thọ',NULL,52,115),(332,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'福建',NULL,53,116),(333,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Florida',NULL,50,117),(334,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Florida',NULL,51,117),(335,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Floride',NULL,52,117),(336,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Federated States Of Micronesia',NULL,50,118),(337,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Federated States Of Micronesia',NULL,51,118),(338,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Federated States Of Micronesia',NULL,52,118),(339,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Washington',NULL,50,119),(340,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Washington',NULL,51,119),(341,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Washington',NULL,52,119),(342,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Granada',NULL,50,120),(343,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Granada',NULL,51,120),(344,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Granada',NULL,52,120),(345,'2026-09-19 00:39:46','2026-09-19 00:39:46',NULL,NULL,'Freiburg',NULL,50,121),(346,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'Freiburg',NULL,51,121),(347,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'Freiburg',NULL,52,121),(348,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'Rheinland-Pfalz',NULL,50,122),(349,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'Rheinland-Pfalz',NULL,51,122),(350,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'Rheinland-Pfalz',NULL,52,122),(351,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'Ourense',NULL,50,123),(352,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'Ourense',NULL,51,123),(353,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'Ourense',NULL,52,123),(354,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'Wisconsin',NULL,50,124),(355,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'Wisconsin',NULL,51,124),(356,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'Wisconsin',NULL,52,124),(357,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'Georgia',NULL,50,125),(358,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'Georgia',NULL,51,125),(359,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'Georgie',NULL,52,125),(360,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'Murcia',NULL,50,126),(361,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'Murcia',NULL,51,126),(362,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'Murcia',NULL,52,126),(363,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'Điện Biên',NULL,50,127),(364,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'Điện Biên',NULL,51,127),(365,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'Điện Biên',NULL,52,127),(366,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'广东',NULL,53,128),(367,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'Genf',NULL,50,129),(368,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'Genf',NULL,51,129),(369,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'Genf',NULL,52,129),(370,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'West Virginia',NULL,50,130),(371,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'West Virginia',NULL,51,130),(372,'2026-09-19 00:39:47','2026-09-19 00:39:47',NULL,NULL,'West Virginia',NULL,52,130),(373,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'Wyoming',NULL,50,131),(374,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'Wyoming',NULL,51,131),(375,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'Wyoming',NULL,52,131),(376,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'Avila',NULL,50,132),(377,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'Avila',NULL,51,132),(378,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'Avila',NULL,52,132),(379,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'Glarus',NULL,50,133),(380,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'Glarus',NULL,51,133),(381,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'Glarus',NULL,52,133),(382,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'Graubnden',NULL,50,134),(383,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'Graubnden',NULL,51,134),(384,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'Graubnden',NULL,52,134),(385,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'甘肃',NULL,53,135),(386,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'Guam',NULL,50,136),(387,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'Guam',NULL,51,136),(388,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'Guam',NULL,52,136),(389,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'广西',NULL,53,137),(390,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'新疆',NULL,53,138),(391,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'贵州',NULL,53,139),(392,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'Hessen',NULL,50,140),(393,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'Hessen',NULL,51,140),(394,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'Hessen',NULL,52,140),(395,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'河南',NULL,53,141),(396,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'湖北',NULL,53,142),(397,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'河北',NULL,53,143),(398,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'Hawaii',NULL,50,144),(399,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'Hawaii',NULL,51,144),(400,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'Hawaii',NULL,52,144),(401,'2026-09-19 00:39:48','2026-09-19 00:39:48',NULL,NULL,'海南',NULL,53,144),(402,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'An Giang',NULL,50,145),(403,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'An Giang',NULL,51,145),(404,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'An Giang',NULL,52,145),(405,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'西藏',NULL,53,146),(406,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'香港',NULL,53,147),(407,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'黑龙江',NULL,53,148),(408,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'Hà Nội',NULL,50,149),(409,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'Hà Nội',NULL,51,149),(410,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'Hà Nội',NULL,52,149),(411,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'湖南',NULL,53,149),(412,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'Vizcaya',NULL,50,150),(413,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'Vizcaya',NULL,51,150),(414,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'Vizcaya',NULL,52,150),(415,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'Hải Phòng',NULL,50,151),(416,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'Hải Phòng',NULL,51,151),(417,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'Hải Phòng',NULL,52,151),(418,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'Otro',NULL,50,152),(419,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'Other',NULL,51,152),(420,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'Albacete',NULL,50,153),(421,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'Albacete',NULL,51,153),(422,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'Albacete',NULL,52,153),(423,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'Nordrhein-Westfalen',NULL,50,154),(424,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'Nordrhein-Westfalen',NULL,51,154),(425,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'Nordrhein-Westfalen',NULL,52,154),(426,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'云南',NULL,53,155),(427,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'Iowa',NULL,50,156),(428,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'Iowa',NULL,51,156),(429,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'Iowa',NULL,52,156),(430,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'Idaho',NULL,50,157),(431,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'Idaho',NULL,51,157),(432,'2026-09-19 00:39:49','2026-09-19 00:39:49',NULL,NULL,'Idaho',NULL,52,157),(433,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Yukon Territory',NULL,50,158),(434,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Yukon Territory',NULL,51,158),(435,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Yukon',NULL,52,158),(436,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Leon',NULL,50,159),(437,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Leon',NULL,51,159),(438,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Leon',NULL,52,159),(439,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Pontevedra',NULL,50,160),(440,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Pontevedra',NULL,51,160),(441,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Pontevedra',NULL,52,160),(442,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Teruel',NULL,50,161),(443,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Teruel',NULL,51,161),(444,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Teruel',NULL,52,161),(445,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Illinois',NULL,50,162),(446,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Illinois',NULL,51,162),(447,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Illinois',NULL,52,162),(448,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Indiana',NULL,50,163),(449,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Indiana',NULL,51,163),(450,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Indiana',NULL,52,163),(451,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'A Corua',NULL,52,164),(452,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Zug',NULL,50,165),(453,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Zug',NULL,51,165),(454,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Zug',NULL,52,165),(455,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Zrich',NULL,50,166),(456,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Zrich',NULL,51,166),(457,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Zrich',NULL,52,166),(458,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'La Rioja',NULL,50,167),(459,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'La Rioja',NULL,51,167),(460,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'La Rioja',NULL,52,167),(461,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'浙江',NULL,53,168),(462,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'New South Wales',NULL,50,169),(463,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'New South Wales',NULL,51,169),(464,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Nouvelle-Galles du Sud',NULL,52,169),(465,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Madrid',NULL,50,170),(466,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Madrid',NULL,51,170),(467,'2026-09-19 00:39:50','2026-09-19 00:39:50',NULL,NULL,'Madrid',NULL,52,170),(468,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Huelva',NULL,50,171),(469,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Huelva',NULL,51,171),(470,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Huelva',NULL,52,171),(471,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'吉林',NULL,53,172),(472,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Huesca',NULL,50,173),(473,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Huesca',NULL,51,173),(474,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Huesca',NULL,52,173),(475,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'江苏',NULL,53,174),(476,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Jura',NULL,50,175),(477,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Jura',NULL,51,175),(478,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Jura',NULL,52,175),(479,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Asturias',NULL,50,176),(480,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Asturias',NULL,51,176),(481,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Asturias',NULL,52,176),(482,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'江西',NULL,53,177),(483,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Tirol',NULL,50,178),(484,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Tirol',NULL,51,178),(485,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Tirol',NULL,52,178),(486,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Niedersachsen',NULL,50,179),(487,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Niedersachsen',NULL,51,179),(488,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Niedersachsen',NULL,52,179),(489,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Katen',NULL,50,180),(490,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Katen',NULL,51,180),(491,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Karten',NULL,52,180),(492,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Alava',NULL,50,181),(493,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Alava',NULL,51,181),(494,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Alava',NULL,52,181),(495,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Kansas',NULL,50,182),(496,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Kansas',NULL,51,182),(497,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Kansas',NULL,52,182),(498,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Kentucky',NULL,50,183),(499,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Kentucky',NULL,51,183),(500,'2026-09-19 00:39:51','2026-09-19 00:39:51',NULL,NULL,'Kentucky',NULL,52,183),(501,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'Louisiana',NULL,50,184),(502,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'Louisiana',NULL,51,184),(503,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'Louisiane',NULL,52,184),(504,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'Toledo',NULL,50,185),(505,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'Toledo',NULL,51,185),(506,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'Toledo',NULL,52,185),(507,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'辽宁',NULL,53,186),(508,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'Tasmania',NULL,50,187),(509,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'Tasmania',NULL,51,187),(510,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'Tasmanie',NULL,52,187),(511,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'Queensland',NULL,50,188),(512,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'Queensland',NULL,51,188),(513,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'Queensland',NULL,52,188),(514,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'Luzern',NULL,50,189),(515,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'Luzern',NULL,51,189),(516,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'Luzern',NULL,52,189),(517,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'Santa Cruz de Tenerife',NULL,50,190),(518,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'Santa Cruz de Tenerife',NULL,51,190),(519,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'Santa Cruz de Tenerife',NULL,52,190),(520,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'Massachusetts',NULL,50,191),(521,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'Massachusetts',NULL,51,191),(522,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'Massachusetts',NULL,52,191),(523,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'Manitoba',NULL,50,192),(524,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'Manitoba',NULL,51,192),(525,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'Manitoba',NULL,52,192),(526,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'Maryland',NULL,50,193),(527,'2026-09-19 00:39:52','2026-09-19 00:39:52',NULL,NULL,'Maryland',NULL,51,193),(528,'2026-09-19 00:39:53','2026-09-19 00:39:53',NULL,NULL,'Maryland',NULL,52,193),(529,'2026-09-19 00:39:53','2026-09-19 00:39:53',NULL,NULL,'Girona',NULL,50,194),(530,'2026-09-19 00:39:53','2026-09-19 00:39:53',NULL,NULL,'Girona',NULL,51,194),(531,'2026-09-19 00:39:53','2026-09-19 00:39:53',NULL,NULL,'Girona',NULL,52,194),(532,'2026-09-19 00:39:53','2026-09-19 00:39:53',NULL,NULL,'Maine',NULL,50,195),(533,'2026-09-19 00:39:53','2026-09-19 00:39:53',NULL,NULL,'Maine',NULL,51,195),(534,'2026-09-19 00:39:53','2026-09-19 00:39:53',NULL,NULL,'Maine',NULL,52,195),(535,'2026-09-19 00:39:53','2026-09-19 00:39:53',NULL,NULL,'Alicante',NULL,50,196),(536,'2026-09-19 00:39:53','2026-09-19 00:39:53',NULL,NULL,'Alicante',NULL,51,196),(537,'2026-09-19 00:39:53','2026-09-19 00:39:53',NULL,NULL,'Alicante',NULL,52,196),(538,'2026-09-19 00:39:53','2026-09-19 00:39:53',NULL,NULL,'Cantabria',NULL,50,197),(539,'2026-09-19 00:39:53','2026-09-19 00:39:53',NULL,NULL,'Cantabria',NULL,51,197),(540,'2026-09-19 00:39:53','2026-09-19 00:39:53',NULL,NULL,'Cantabria',NULL,52,197),(541,'2026-09-19 00:39:53','2026-09-19 00:39:53',NULL,NULL,'Marshall Islands',NULL,50,198),(542,'2026-09-19 00:39:53','2026-09-19 00:39:53',NULL,NULL,'Marshall Islands',NULL,51,198),(543,'2026-09-19 00:39:53','2026-09-19 00:39:53',NULL,NULL,'Marshall Islands',NULL,52,198),(544,'2026-09-19 00:39:53','2026-09-19 00:39:53',NULL,NULL,'Michigan',NULL,50,199),(545,'2026-09-19 00:39:53','2026-09-19 00:39:53',NULL,NULL,'Michigan',NULL,51,199),(546,'2026-09-19 00:39:53','2026-09-19 00:39:53',NULL,NULL,'Michigan',NULL,52,199),(547,'2026-09-19 00:39:53','2026-09-19 00:39:53',NULL,NULL,'Minnesota',NULL,50,200),(548,'2026-09-19 00:39:53','2026-09-19 00:39:53',NULL,NULL,'Minnesota',NULL,51,200),(549,'2026-09-19 00:39:53','2026-09-19 00:39:53',NULL,NULL,'Minnesota',NULL,52,200),(550,'2026-09-19 00:39:53','2026-09-19 00:39:53',NULL,NULL,'Missouri',NULL,50,201),(551,'2026-09-19 00:39:53','2026-09-19 00:39:53',NULL,NULL,'Missouri',NULL,51,201),(552,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'Missouri',NULL,52,201),(553,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'澳门',NULL,53,201),(554,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'Northern Mariana Islands',NULL,50,202),(555,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'Northern Mariana Islands',NULL,51,202),(556,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'Northern Mariana Islands',NULL,52,202),(557,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'Mississippi',NULL,50,203),(558,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'Mississippi',NULL,51,203),(559,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'Mississippi',NULL,52,203),(560,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'Montana',NULL,50,204),(561,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'Montana',NULL,51,204),(562,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'Montana',NULL,52,204),(563,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'Badajoz',NULL,50,205),(564,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'Badajoz',NULL,51,205),(565,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'Badajoz',NULL,52,205),(566,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'Mecklenburg-Vorpommern',NULL,50,206),(567,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'Mecklenburg-Vorpommern',NULL,51,206),(568,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'Mecklenburg-Vorpommern',NULL,52,206),(569,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'Sevilla',NULL,50,207),(570,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'Sevilla',NULL,51,207),(571,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'Sevilla',NULL,52,207),(572,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'New Brunswick',NULL,50,208),(573,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'New Brunswick',NULL,51,208),(574,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'Nouveau Brunswick',NULL,52,208),(575,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'Sachsen-Anhalt',NULL,50,209),(576,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'Sachsen-Anhalt',NULL,51,209),(577,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'Sachsen-Anhalt',NULL,52,209),(578,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'North Carolina',NULL,50,210),(579,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'North Carolina',NULL,51,210),(580,'2026-09-19 00:39:54','2026-09-19 00:39:54',NULL,NULL,'Caroline du Nord',NULL,52,210),(581,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'North Dakota',NULL,50,211),(582,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'North Dakota',NULL,51,211),(583,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'Dakota du Nord',NULL,52,211),(584,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'Nebraska',NULL,50,212),(585,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'Nebraska',NULL,51,212),(586,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'Nebraska',NULL,52,212),(587,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'Newfoundland - Labrador',NULL,50,213),(588,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'Newfoundland - Labrador',NULL,51,213),(589,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'Terre-Neuve - Labrador',NULL,52,213),(590,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'New Hampshire',NULL,50,214),(591,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'New Hampshire',NULL,51,214),(592,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'Nouveau Hampshire',NULL,52,214),(593,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'New Jersey',NULL,50,215),(594,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'New Jersey',NULL,51,215),(595,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'New Jersey',NULL,52,215),(596,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'New Mexico',NULL,50,216),(597,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'New Mexico',NULL,51,216),(598,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'Nouveau Mexique',NULL,52,216),(599,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'内蒙古',NULL,53,216),(600,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'Niederosterreich',NULL,50,217),(601,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'Niederosterreich',NULL,51,217),(602,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'Niederosterreich',NULL,52,217),(603,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'Sachsen',NULL,50,218),(604,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'Sachsen',NULL,51,218),(605,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'Sachsen',NULL,52,218),(606,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'Nova Scotia',NULL,50,219),(607,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'Nova Scotia',NULL,51,219),(608,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'Nouvelle Écosse',NULL,52,219),(609,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'Saarland',NULL,50,220),(610,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'Saarland',NULL,51,220),(611,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'Saarland',NULL,52,220),(612,'2026-09-19 00:39:55','2026-09-19 00:39:55',NULL,NULL,'Northwest Territories',NULL,50,221),(613,'2026-09-19 00:39:56','2026-09-19 00:39:56',NULL,NULL,'Northwest Territories',NULL,51,221),(614,'2026-09-19 00:39:56','2026-09-19 00:39:56',NULL,NULL,'Territores du Nord-Ouest',NULL,52,221),(615,'2026-09-19 00:39:56','2026-09-19 00:39:56',NULL,NULL,'Nunavut',NULL,50,222),(616,'2026-09-19 00:39:56','2026-09-19 00:39:56',NULL,NULL,'Nunavut',NULL,51,222),(617,'2026-09-19 00:39:56','2026-09-19 00:39:56',NULL,NULL,'Nunavut',NULL,52,222),(618,'2026-09-19 00:39:56','2026-09-19 00:39:56',NULL,NULL,'Nevada',NULL,50,223),(619,'2026-09-19 00:39:56','2026-09-19 00:39:56',NULL,NULL,'Nevada',NULL,51,223),(620,'2026-09-19 00:39:56','2026-09-19 00:39:56',NULL,NULL,'Nevada',NULL,52,223),(621,'2026-09-19 00:39:56','2026-09-19 00:39:56',NULL,NULL,'Nidwalden',NULL,50,224),(622,'2026-09-19 00:39:56','2026-09-19 00:39:56',NULL,NULL,'Nidwalden',NULL,51,224),(623,'2026-09-19 00:39:56','2026-09-19 00:39:56',NULL,NULL,'Nidwalden',NULL,52,224),(624,'2026-09-19 00:39:56','2026-09-19 00:39:56',NULL,NULL,'宁夏',NULL,53,225),(625,'2026-09-19 00:39:56','2026-09-19 00:39:56',NULL,NULL,'New York',NULL,50,226),(626,'2026-09-19 00:39:56','2026-09-19 00:39:56',NULL,NULL,'New York',NULL,51,226),(627,'2026-09-19 00:39:56','2026-09-19 00:39:56',NULL,NULL,'New York',NULL,52,226),(628,'2026-09-19 00:39:56','2026-09-19 00:39:56',NULL,NULL,'Soria',NULL,50,227),(629,'2026-09-19 00:39:56','2026-09-19 00:39:56',NULL,NULL,'Soria',NULL,51,227),(630,'2026-09-19 00:39:56','2026-09-19 00:39:56',NULL,NULL,'Soria',NULL,52,227),(631,'2026-09-19 00:39:56','2026-09-19 00:39:56',NULL,NULL,'Ohio',NULL,50,228),(632,'2026-09-19 00:39:56','2026-09-19 00:39:56',NULL,NULL,'Ohio',NULL,51,228),(633,'2026-09-19 00:39:56','2026-09-19 00:39:56',NULL,NULL,'Ohio',NULL,52,228),(634,'2026-09-19 00:39:56','2026-09-19 00:39:56',NULL,NULL,'Oklahoma',NULL,50,229),(635,'2026-09-19 00:39:56','2026-09-19 00:39:56',NULL,NULL,'Oklahoma',NULL,51,229),(636,'2026-09-19 00:39:56','2026-09-19 00:39:56',NULL,NULL,'Oklahoma',NULL,52,229),(637,'2026-09-19 00:39:56','2026-09-19 00:39:56',NULL,NULL,'Ontario',NULL,50,230),(638,'2026-09-19 00:39:57','2026-09-19 00:39:57',NULL,NULL,'Ontario',NULL,51,230),(639,'2026-09-19 00:39:57','2026-09-19 00:39:57',NULL,NULL,'Ontario',NULL,52,230),(640,'2026-09-19 00:39:57','2026-09-19 00:39:57',NULL,NULL,'Oberosterreich',NULL,50,231),(641,'2026-09-19 00:39:57','2026-09-19 00:39:57',NULL,NULL,'Oberosterreich',NULL,51,231),(642,'2026-09-19 00:39:57','2026-09-19 00:39:57',NULL,NULL,'Oberosterreich',NULL,52,231),(643,'2026-09-19 00:39:57','2026-09-19 00:39:57',NULL,NULL,'Burgenland',NULL,50,232),(644,'2026-09-19 00:39:57','2026-09-19 00:39:57',NULL,NULL,'Burgenland',NULL,51,232),(645,'2026-09-19 00:39:57','2026-09-19 00:39:57',NULL,NULL,'Burgenland',NULL,52,232),(646,'2026-09-19 00:39:57','2026-09-19 00:39:57',NULL,NULL,'Oregon',NULL,50,233),(647,'2026-09-19 00:39:57','2026-09-19 00:39:57',NULL,NULL,'Oregon',NULL,51,233),(648,'2026-09-19 00:39:57','2026-09-19 00:39:57',NULL,NULL,'Oregon',NULL,52,233),(649,'2026-09-19 00:39:57','2026-09-19 00:39:57',NULL,NULL,'Salamanca',NULL,50,234),(650,'2026-09-19 00:39:57','2026-09-19 00:39:57',NULL,NULL,'Salamanca',NULL,51,234),(651,'2026-09-19 00:39:57','2026-09-19 00:39:57',NULL,NULL,'Salamanca',NULL,52,234),(652,'2026-09-19 00:39:57','2026-09-19 00:39:57',NULL,NULL,'Baleares',NULL,50,235),(653,'2026-09-19 00:39:57','2026-09-19 00:39:57',NULL,NULL,'Baleares',NULL,51,235),(654,'2026-09-19 00:39:57','2026-09-19 00:39:57',NULL,NULL,'Baleares',NULL,52,235),(655,'2026-09-19 00:39:57','2026-09-19 00:39:57',NULL,NULL,'Obwalden',NULL,50,236),(656,'2026-09-19 00:39:57','2026-09-19 00:39:57',NULL,NULL,'Obwalden',NULL,51,236),(657,'2026-09-19 00:39:57','2026-09-19 00:39:57',NULL,NULL,'Obwalden',NULL,52,236),(658,'2026-09-19 00:39:57','2026-09-19 00:39:57',NULL,NULL,'Pennsylvania',NULL,50,237),(659,'2026-09-19 00:39:57','2026-09-19 00:39:57',NULL,NULL,'Pennsylvania',NULL,51,237),(660,'2026-09-19 00:39:57','2026-09-19 00:39:57',NULL,NULL,'Pennsylvanie',NULL,52,237),(661,'2026-09-19 00:39:57','2026-09-19 00:39:57',NULL,NULL,'Victoria',NULL,50,238),(662,'2026-09-19 00:39:58','2026-09-19 00:39:58',NULL,NULL,'Victoria',NULL,51,238),(663,'2026-09-19 00:39:58','2026-09-19 00:39:58',NULL,NULL,'Victoria',NULL,52,238),(664,'2026-09-19 00:39:58','2026-09-19 00:39:58',NULL,NULL,'Bremen',NULL,50,239),(665,'2026-09-19 00:39:58','2026-09-19 00:39:58',NULL,NULL,'Bremen',NULL,51,239),(666,'2026-09-19 00:39:58','2026-09-19 00:39:58',NULL,NULL,'Bremen',NULL,52,239),(667,'2026-09-19 00:39:58','2026-09-19 00:39:58',NULL,NULL,'Prince Edward Island',NULL,50,240),(668,'2026-09-19 00:39:58','2026-09-19 00:39:58',NULL,NULL,'Prince Edward Island',NULL,51,240),(669,'2026-09-19 00:39:58','2026-09-19 00:39:58',NULL,NULL,'Île-du-Prince-Édouard',NULL,52,240),(670,'2026-09-19 00:39:58','2026-09-19 00:39:58',NULL,NULL,'Brandenburg',NULL,50,241),(671,'2026-09-19 00:39:58','2026-09-19 00:39:58',NULL,NULL,'Brandenburg',NULL,51,241),(672,'2026-09-19 00:39:58','2026-09-19 00:39:58',NULL,NULL,'Brandenburg',NULL,52,241),(673,'2026-09-19 00:39:58','2026-09-19 00:39:58',NULL,NULL,'Almeria',NULL,50,242),(674,'2026-09-19 00:39:58','2026-09-19 00:39:58',NULL,NULL,'Almeria',NULL,51,242),(675,'2026-09-19 00:39:58','2026-09-19 00:39:58',NULL,NULL,'Almeria',NULL,52,242),(676,'2026-09-19 00:39:58','2026-09-19 00:39:58',NULL,NULL,'Baden-Wrttemberg',NULL,50,243),(677,'2026-09-19 00:39:58','2026-09-19 00:39:58',NULL,NULL,'Baden-Wrttemberg',NULL,51,243),(678,'2026-09-19 00:39:58','2026-09-19 00:39:58',NULL,NULL,'Baden-Wrttemberg',NULL,52,243),(679,'2026-09-19 00:39:58','2026-09-19 00:39:58',NULL,NULL,'Bayern',NULL,50,244),(680,'2026-09-19 00:39:58','2026-09-19 00:39:58',NULL,NULL,'Bayern',NULL,51,244),(681,'2026-09-19 00:39:58','2026-09-19 00:39:58',NULL,NULL,'Bayern',NULL,52,244),(682,'2026-09-19 00:39:58','2026-09-19 00:39:58',NULL,NULL,'Navarra',NULL,50,245),(683,'2026-09-19 00:39:58','2026-09-19 00:39:58',NULL,NULL,'Navarra',NULL,51,245),(684,'2026-09-19 00:39:58','2026-09-19 00:39:58',NULL,NULL,'Navarra',NULL,52,245),(685,'2026-09-19 00:39:58','2026-09-19 00:39:58',NULL,NULL,'Valencia',NULL,50,246),(686,'2026-09-19 00:39:58','2026-09-19 00:39:58',NULL,NULL,'Valencia',NULL,51,246),(687,'2026-09-19 00:39:59','2026-09-19 00:39:59',NULL,NULL,'Valencia',NULL,52,246),(688,'2026-09-19 00:39:59','2026-09-19 00:39:59',NULL,NULL,'Schleswig-Holstein',NULL,50,247),(689,'2026-09-19 00:39:59','2026-09-19 00:39:59',NULL,NULL,'Schleswig-Holstein',NULL,51,247),(690,'2026-09-19 00:39:59','2026-09-19 00:39:59',NULL,NULL,'Schleswig-Holstein',NULL,52,247),(691,'2026-09-19 00:39:59','2026-09-19 00:39:59',NULL,NULL,'Andhra Pradesh',NULL,50,248),(692,'2026-09-19 00:39:59','2026-09-19 00:39:59',NULL,NULL,'Andhra Pradesh',NULL,51,248),(693,'2026-09-19 00:39:59','2026-09-19 00:39:59',NULL,NULL,'Andhra Pradesh',NULL,52,248),(694,'2026-09-19 00:39:59','2026-09-19 00:39:59',NULL,NULL,'Andhra Pradesh',NULL,53,248),(695,'2026-09-19 00:39:59','2026-09-19 00:39:59',NULL,NULL,'Arunachal Pradesh',NULL,50,249),(696,'2026-09-19 00:39:59','2026-09-19 00:39:59',NULL,NULL,'Arunachal Pradesh',NULL,51,249),(697,'2026-09-19 00:39:59','2026-09-19 00:39:59',NULL,NULL,'Arunachal Pradesh',NULL,52,249),(698,'2026-09-19 00:39:59','2026-09-19 00:39:59',NULL,NULL,'Arunachal Pradesh',NULL,53,249),(699,'2026-09-19 00:39:59','2026-09-19 00:39:59',NULL,NULL,'Assam',NULL,50,250),(700,'2026-09-19 00:39:59','2026-09-19 00:39:59',NULL,NULL,'Assam',NULL,51,250),(701,'2026-09-19 00:39:59','2026-09-19 00:39:59',NULL,NULL,'Assam',NULL,52,250),(702,'2026-09-19 00:39:59','2026-09-19 00:39:59',NULL,NULL,'Assam',NULL,53,250),(703,'2026-09-19 00:39:59','2026-09-19 00:39:59',NULL,NULL,'Bihar',NULL,50,251),(704,'2026-09-19 00:39:59','2026-09-19 00:39:59',NULL,NULL,'Bihar',NULL,51,251),(705,'2026-09-19 00:39:59','2026-09-19 00:39:59',NULL,NULL,'Bihar',NULL,52,251),(706,'2026-09-19 00:39:59','2026-09-19 00:39:59',NULL,NULL,'Bihar',NULL,53,251),(707,'2026-09-19 00:39:59','2026-09-19 00:39:59',NULL,NULL,'Chhattisgarh',NULL,50,252),(708,'2026-09-19 00:39:59','2026-09-19 00:39:59',NULL,NULL,'Chhattisgarh',NULL,51,252),(709,'2026-09-19 00:39:59','2026-09-19 00:39:59',NULL,NULL,'Chhattisgarh',NULL,52,252),(710,'2026-09-19 00:39:59','2026-09-19 00:39:59',NULL,NULL,'Chhattisgarh',NULL,53,252),(711,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Goa',NULL,50,253),(712,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Goa',NULL,51,253),(713,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Goa',NULL,52,253),(714,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Goa',NULL,53,253),(715,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Gujarat',NULL,50,254),(716,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Gujarat',NULL,51,254),(717,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Gujarat',NULL,52,254),(718,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Gujarat',NULL,53,254),(719,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Haryana',NULL,50,255),(720,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Haryana',NULL,51,255),(721,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Haryana',NULL,52,255),(722,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Haryana',NULL,53,255),(723,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Himachal Pradesh',NULL,50,256),(724,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Himachal Pradesh',NULL,51,256),(725,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Himachal Pradesh',NULL,52,256),(726,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Himachal Pradesh',NULL,53,256),(727,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Jharkhand',NULL,50,257),(728,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Jharkhand',NULL,51,257),(729,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Jharkhand',NULL,52,257),(730,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Jharkhand',NULL,53,257),(731,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Karnataka',NULL,50,258),(732,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Karnataka',NULL,51,258),(733,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Karnataka',NULL,52,258),(734,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Karnataka',NULL,53,258),(735,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Kerala',NULL,50,259),(736,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Kerala',NULL,51,259),(737,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Kerala',NULL,52,259),(738,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Kerala',NULL,53,259),(739,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Madhya Pradesh',NULL,50,260),(740,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Madhya Pradesh',NULL,51,260),(741,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Madhya Pradesh',NULL,52,260),(742,'2026-09-19 00:40:00','2026-09-19 00:40:00',NULL,NULL,'Madhya Pradesh',NULL,53,260),(743,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Maharashtra',NULL,50,261),(744,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Maharashtra',NULL,51,261),(745,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Maharashtra',NULL,52,261),(746,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Maharashtra',NULL,53,261),(747,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Manipur',NULL,50,262),(748,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Manipur',NULL,51,262),(749,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Manipur',NULL,52,262),(750,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Manipur',NULL,53,262),(751,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Meghalaya',NULL,50,263),(752,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Meghalaya',NULL,51,263),(753,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Meghalaya',NULL,52,263),(754,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Meghalaya',NULL,53,263),(755,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Mizoram',NULL,50,264),(756,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Mizoram',NULL,51,264),(757,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Mizoram',NULL,52,264),(758,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Mizoram',NULL,53,264),(759,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Nagaland',NULL,50,265),(760,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Nagaland',NULL,51,265),(761,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Nagaland',NULL,52,265),(762,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Nagaland',NULL,53,265),(763,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Odisha',NULL,50,266),(764,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Odisha',NULL,51,266),(765,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Odisha',NULL,52,266),(766,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Odisha',NULL,53,266),(767,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Punjab',NULL,50,267),(768,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Punjab',NULL,51,267),(769,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Punjab',NULL,52,267),(770,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Punjab',NULL,53,267),(771,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Rajasthan',NULL,50,268),(772,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Rajasthan',NULL,51,268),(773,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Rajasthan',NULL,52,268),(774,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Rajasthan',NULL,53,268),(775,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Sikkim',NULL,50,269),(776,'2026-09-19 00:40:01','2026-09-19 00:40:01',NULL,NULL,'Sikkim',NULL,51,269),(777,'2026-09-19 00:40:02','2026-09-19 00:40:02',NULL,NULL,'Sikkim',NULL,52,269),(778,'2026-09-19 00:40:02','2026-09-19 00:40:02',NULL,NULL,'Sikkim',NULL,53,269),(779,'2026-09-19 00:40:02','2026-09-19 00:40:02',NULL,NULL,'Tamil Nadu',NULL,50,270),(780,'2026-09-19 00:40:02','2026-09-19 00:40:02',NULL,NULL,'Tamil Nadu',NULL,51,270),(781,'2026-09-19 00:40:02','2026-09-19 00:40:02',NULL,NULL,'Tamil Nadu',NULL,52,270),(782,'2026-09-19 00:40:02','2026-09-19 00:40:02',NULL,NULL,'Tamil Nadu',NULL,53,270),(783,'2026-09-19 00:40:02','2026-09-19 00:40:02',NULL,NULL,'Telangana',NULL,50,271),(784,'2026-09-19 00:40:02','2026-09-19 00:40:02',NULL,NULL,'Telangana',NULL,51,271),(785,'2026-09-19 00:40:02','2026-09-19 00:40:02',NULL,NULL,'Telangana',NULL,52,271),(786,'2026-09-19 00:40:02','2026-09-19 00:40:02',NULL,NULL,'Telangana',NULL,53,271),(787,'2026-09-19 00:40:02','2026-09-19 00:40:02',NULL,NULL,'Tripura',NULL,50,272),(788,'2026-09-19 00:40:02','2026-09-19 00:40:02',NULL,NULL,'Tripura',NULL,51,272),(789,'2026-09-19 00:40:02','2026-09-19 00:40:02',NULL,NULL,'Tripura',NULL,52,272),(790,'2026-09-19 00:40:02','2026-09-19 00:40:02',NULL,NULL,'Tripura',NULL,53,272),(791,'2026-09-19 00:40:02','2026-09-19 00:40:02',NULL,NULL,'Uttarakhand',NULL,50,273),(792,'2026-09-19 00:40:02','2026-09-19 00:40:02',NULL,NULL,'Uttarakhand',NULL,51,273),(793,'2026-09-19 00:40:02','2026-09-19 00:40:02',NULL,NULL,'Uttarakhand',NULL,52,273),(794,'2026-09-19 00:40:02','2026-09-19 00:40:02',NULL,NULL,'Uttarakhand',NULL,53,273),(795,'2026-09-19 00:40:02','2026-09-19 00:40:02',NULL,NULL,'West Bengal',NULL,50,274),(796,'2026-09-19 00:40:02','2026-09-19 00:40:02',NULL,NULL,'West Bengal',NULL,51,274),(797,'2026-09-19 00:40:02','2026-09-19 00:40:02',NULL,NULL,'West Bengal',NULL,52,274),(798,'2026-09-19 00:40:02','2026-09-19 00:40:02',NULL,NULL,'West Bengal',NULL,53,274);
/*!40000 ALTER TABLE `ZONE_DESCRIPTION` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-20 11:40:15
