Enter password: 
-- MySQL dump 10.13  Distrib 26.7.0, for Linux (x86_64)
--
-- Host: localhost    Database: SALESMANAGER
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
INSERT INTO `CATEGORY` VALUES (1,'2026-09-18 06:41:53','2026-09-18 06:41:53','admin@shopizer.com',NULL,_binary '\0','ST1',0,_binary '\0','/1/',1,_binary '',1,NULL),(50,'2026-09-15 09:41:32','2026-09-15 09:41:32','admin@shopizer.com',NULL,_binary '\0','ST3',0,_binary '','/50/',10,_binary '',1,NULL),(51,'2026-09-15 09:41:16','2026-09-15 09:41:16','admin@shopizer.com',NULL,_binary '\0','CN1',1,_binary '\0','/50//51/',50,_binary '',1,50),(100,'2026-09-15 09:42:33','2026-09-15 09:42:33','admin@shopizer.com',NULL,_binary '\0','News',0,_binary '\0','/100/',100,_binary '',1,NULL);
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
INSERT INTO `CATEGORY_DESCRIPTION` VALUES (1,'2026-09-18 06:41:53','2026-09-18 06:41:53',NULL,'','rice Viet Nam',NULL,'Gạo','','','','rice-viet-nam',1,1),(2,'2026-09-18 06:41:53','2026-09-18 06:41:53',NULL,'<p>  các sản phẩm từ gạo</p>\n','Gạo Việt Nam',NULL,'Gạo','','','gạo Việt Nam','go-viet-nam',3,1),(3,'2026-09-15 09:41:32','2026-09-15 09:41:32',NULL,'','Nước Ngọt',NULL,'Nước Ngọt','Nuoc Ngot','Nuoc Ngot','Nuoc Ngot','nuoc-ngot',1,50),(4,'2026-09-15 09:41:32','2026-09-15 09:41:32',NULL,'','Nước Ngọt',NULL,'Nước Ngọt','','','','nuoc-ngot',3,50),(5,'2026-09-15 09:41:16','2026-09-15 09:41:16',NULL,'','Nước Uống Chơn Như',NULL,'Nước Uống Chơn Như','','','','nuoc-uong-chon-nhu',3,51),(6,'2026-09-15 09:41:16','2026-09-15 09:41:16',NULL,'','Nước Uống Chơn Như',NULL,'Nước Uống Chơn Như','Nước Uống Chơn Như','Nước Uống Chơn Như','Nước Uống Chơn Như','nuoc-uong-chon-nhu',1,51),(7,'2026-09-15 09:41:16','2026-09-15 09:41:16',NULL,'','Nước Uống Chơn Như',NULL,'Nước Uống Chơn Như','','','','nc-ung-chn-nh',2,51),(10,'2026-09-15 09:42:33','2026-09-15 09:42:33',NULL,'<p>\n  <span>\n    <img alt=\"\" src=\"/static/files/DEFAULT/IMAGE/logo.jpg\" />Bây giờ các\n    con thấy – người ta dạy rất sai! Câu chuyện Mục Liên Thanh Đề ở\n    trong bản kinh Vu Lan Bồn – mấy con thấy sai không? Dạy người ta\n    ngày báo hiếu, mà báo hiếu như vậy sao? Báo hiếu bằng cách lo lót!</span></p>\n<p>  Nghĩa là Phật tử phải lo lót cho quý thầy, cho Phật rồi mới được\n  cứu độ! Như vậy có đúng không?</p>\n<p>  Các con nghe câu chuyện khi mà ông Mục Kiền Liên tu đắc Lục thông –\n  mẹ ông chết, ông mới đi tìm mẹ ông ở dưới địa ngục; ông mới thấy mẹ\n  ông ngồi ở trong địa ngục Ngạ quỷ, đói khát, khổ sở; ông mới bưng bát\n  cơm cho mẹ ông ăn; mẹ ông vừa bốc cơm ăn thì lửa cháy – ăn, nuốt không\n  được. Cái cảnh quá khổ!</p>\n<p>  Cho nên, ông cũng không đủ sức của mình để cứu mẹ. Cho nên ông về\n  xin Phật dạy cho ông cách nào để cứu mẹ ông thoát khỏi địa ngục Ngạ\n  quỷ này.</p>\n<p>  Đức Phật nói: <em>“Ông hãy về sắm tứ sự…​”.</em></p>\n<p>  Rồi sắm tứ sự rồi thì để làm gì? Các con hiểu – khi đó phải đem đến\n  cúng Phật và cúng chư Thánh Tăng – nhờ công đức tu hành của họ, sau 3\n  tháng an cư kiết hạ, tức là rằm tháng Bảy là người ta giải hạ ra, cho\n  nên ngày đó gọi là ngày báo hiếu.</p>\n<p>  Vì vậy cho nên lấy cái câu chuyện Mục Liên Thanh Đề để làm ngày báo\n  hiếu. Bây giờ chúng ta có cái ngày rằm tháng Bảy là ngày báo hiếu, do\n  đó chúng ta lấy cái tích lịch sử của Mục Kiền Liên.</p>\n<p>  Mà thử hỏi, bây giờ phải cúng dường trai Tăng cho chúng Tăng và\n  Phật, rồi nhờ công đức của các Ngài đó mới cứu độ bà Thanh Đề thoát\n  khỏi địa ngục. Như vậy trước khi cứu độ là ông Mục Kiền Liên có phạm\n  cái tội lo lót! Đứng trên pháp luật mà! Đại thừa dạy chúng ta có sự lo\n  lót rõ ràng!</p>\n<p>  Vậy kinh sách đúng không? – Không đúng! Dạy chúng ta làm điều sai –\n  đâu phải dạy chúng ta làm điều đúng!</p>\n<p>  Bà Thanh Đề tạo tội thì bà phải trả cái tội đó cho đến khi bà trả\n  hết tội đó. Thí dụ như bây giờ mình làm cái tội mà mình ở tù 10 năm,\n  thì phải ở tù 10 năm thì Nhà nước sẽ thả mình ra.</p>\n<p>   </p>\n','News',NULL,'News','News','News','News','news',1,100),(11,'2026-09-15 09:42:33','2026-09-15 09:42:33',NULL,'<p>\n  <span>\n    <img alt=\"\" src=\"/static/files/DEFAULT/IMAGE/logo.jpg\" />Bây giờ các\n    con thấy – người ta dạy rất sai! Câu chuyện Mục Liên Thanh Đề ở\n    trong bản kinh Vu Lan Bồn – mấy con thấy sai không? Dạy người ta\n    ngày báo hiếu, mà báo hiếu như vậy sao? Báo hiếu bằng cách lo lót!</span></p>\n<p>  Nghĩa là Phật tử phải lo lót cho quý thầy, cho Phật rồi mới được\n  cứu độ! Như vậy có đúng không?</p>\n<p>  Các con nghe câu chuyện khi mà ông Mục Kiền Liên tu đắc Lục thông –\n  mẹ ông chết, ông mới đi tìm mẹ ông ở dưới địa ngục; ông mới thấy mẹ\n  ông ngồi ở trong địa ngục Ngạ quỷ, đói khát, khổ sở; ông mới bưng bát\n  cơm cho mẹ ông ăn; mẹ ông vừa bốc cơm ăn thì lửa cháy – ăn, nuốt không\n  được. Cái cảnh quá khổ!</p>\n<p>  Cho nên, ông cũng không đủ sức của mình để cứu mẹ. Cho nên ông về\n  xin Phật dạy cho ông cách nào để cứu mẹ ông thoát khỏi địa ngục Ngạ\n  quỷ này.</p>\n<p>  Đức Phật nói: <em>“Ông hãy về sắm tứ sự…​”.</em></p>\n<p>  Rồi sắm tứ sự rồi thì để làm gì? Các con hiểu – khi đó phải đem đến\n  cúng Phật và cúng chư Thánh Tăng – nhờ công đức tu hành của họ, sau 3\n  tháng an cư kiết hạ, tức là rằm tháng Bảy là người ta giải hạ ra, cho\n  nên ngày đó gọi là ngày báo hiếu.</p>\n<p>  Vì vậy cho nên lấy cái câu chuyện Mục Liên Thanh Đề để làm ngày báo\n  hiếu. Bây giờ chúng ta có cái ngày rằm tháng Bảy là ngày báo hiếu, do\n  đó chúng ta lấy cái tích lịch sử của Mục Kiền Liên.</p>\n<p>  Mà thử hỏi, bây giờ phải cúng dường trai Tăng cho chúng Tăng và\n  Phật, rồi nhờ công đức của các Ngài đó mới cứu độ bà Thanh Đề thoát\n  khỏi địa ngục. Như vậy trước khi cứu độ là ông Mục Kiền Liên có phạm\n  cái tội lo lót! Đứng trên pháp luật mà! Đại thừa dạy chúng ta có sự lo\n  lót rõ ràng!</p>\n<p>  Vậy kinh sách đúng không? – Không đúng! Dạy chúng ta làm điều sai –\n  đâu phải dạy chúng ta làm điều đúng!</p>\n<p>  Bà Thanh Đề tạo tội thì bà phải trả cái tội đó cho đến khi bà trả\n  hết tội đó. Thí dụ như bây giờ mình làm cái tội mà mình ở tù 10 năm,\n  thì phải ở tù 10 năm thì Nhà nước sẽ thả mình ra.</p>\n<p>   </p>\n','Tin Tức',NULL,'Tin Tức','','','Tin Tức','tin-tuc',3,100),(12,'2026-09-15 09:41:16','2026-09-15 09:41:16',NULL,'','',NULL,'','','','','',4,51),(17,'2026-09-15 09:42:33','2026-09-15 09:42:33',NULL,'','news',NULL,'','','','','news',2,100),(18,'2026-09-15 09:42:33','2026-09-15 09:42:33',NULL,'','news',NULL,'','','','','news',4,100),(19,'2026-09-15 09:41:32','2026-09-15 09:41:32',NULL,'','',NULL,'','','','','',2,50),(20,'2026-09-15 09:41:32','2026-09-15 09:41:32',NULL,'','',NULL,'','','','','',4,50),(21,'2026-09-18 06:41:53','2026-09-18 06:41:53',NULL,'','越南大米',NULL,'','','','','rice-vn',4,1),(22,'2026-09-18 06:41:53','2026-09-18 06:41:53',NULL,'','Riz vietnamien',NULL,'','','','','riz-vietnamien',2,1);
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
INSERT INTO `CONTENT` VALUES (1,NULL,NULL,NULL,'page1',NULL,'PAGE',_binary '\0',',',0,_binary '',1),(3,NULL,NULL,NULL,'bannerImage','RIGHT','BOX',_binary '',NULL,0,_binary '',1),(50,NULL,NULL,NULL,'LANDING_PAGE',NULL,'SECTION',_binary '\0',NULL,0,_binary '',1),(100,NULL,NULL,NULL,'footerImage','RIGHT','BOX',_binary '\0',NULL,0,_binary '',1),(150,NULL,NULL,NULL,'page2',NULL,'PAGE',_binary '',',',0,_binary '',1),(200,NULL,NULL,NULL,'page 3',NULL,'PAGE',_binary '\0',',,,',0,_binary '',1);
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
INSERT INTO `CONTENT_DESCRIPTION` VALUES (1,'2026-09-13 12:25:56','2026-09-13 12:25:56',NULL,'<p>\n  <img alt=\"\" src=\"/static/files/DEFAULT/IMAGE/image8.gif\" />\n  <img alt=\"\" src=\"/static/files/DEFAULT/IMAGE/image8.gif\" />\n  <img alt=\"\" src=\"/static/files/DEFAULT/IMAGE/Vintage-Bags.avif\" /></p>\n<p>  Túi rất là đẹp không thể bỏ lỡ</p>\n','banner',NULL,'','','','banner',1,1),(2,'2026-09-13 12:25:56','2026-09-13 12:25:56',NULL,'<p>\n  <img alt=\"\" src=\"/static/files/DEFAULT/IMAGE/image8.gif\" />\n  <img alt=\"\" src=\"/static/files/DEFAULT/IMAGE/image8.gif\" />\n  <img alt=\"\" src=\"/static/files/DEFAULT/IMAGE/Vintage-Bags.avif\" /></p>\n<p>  Túi rất là đẹp không thể bỏ lỡ</p>\n','banner',NULL,'','','','banner',3,1),(5,'2026-09-13 13:54:34','2026-09-13 13:54:34',NULL,'<p>\n  <img alt=\"\" src=\"/static/files/DEFAULT/IMAGE/banner-resized.jpg\" /></p>\n','bannerImage',NULL,NULL,NULL,NULL,NULL,1,3),(6,'2026-09-13 13:54:34','2026-09-13 13:54:34',NULL,'<p>\n  <img alt=\"\" src=\"/static/files/DEFAULT/IMAGE/banner-resized.jpg\" /></p>\n','bannerImage',NULL,NULL,NULL,NULL,NULL,3,3),(7,'2026-09-13 00:44:24','2026-09-18 06:43:01',NULL,'','Karmic Condition of Peace and Bliss','Karmic Condition of Peace and Bliss','','',NULL,NULL,1,50),(8,'2026-09-13 00:44:24','2026-09-18 06:43:01',NULL,'','Condition de paix et de félicité','Condition de paix et de félicité','','',NULL,NULL,2,50),(9,'2026-09-13 00:44:24','2026-09-18 06:43:01',NULL,'','An Lạc Duyên','An Lạc Duyên','','',NULL,NULL,3,50),(10,'2026-09-13 12:21:55','2026-09-13 12:21:55',NULL,'<p>\n  <img alt=\"\" src=\"/static/files/DEFAULT/IMAGE/logo.jpg\" /></p>\n','footerImage',NULL,NULL,NULL,NULL,NULL,1,100),(11,'2026-09-13 12:21:55','2026-09-13 12:21:55',NULL,'<p>\n  <img alt=\"\" src=\"/static/files/DEFAULT/IMAGE/logo.jpg\" /></p>\n','footerImage',NULL,NULL,NULL,NULL,NULL,2,100),(12,'2026-09-13 12:21:55','2026-09-13 12:21:55',NULL,'<p>\n  <img alt=\"\" src=\"/static/files/DEFAULT/IMAGE/logo.jpg\" /></p>\n','footerImage',NULL,NULL,NULL,NULL,NULL,3,100),(13,'2026-09-14 14:44:20','2026-09-14 14:44:20',NULL,'<h1>\n  <span class=\"post-title\">Đại Thừa Dạy Lo Lót Phi Nhân Quả, Nuôi Dưỡng\n    Dục Thế Gian Làm Hư Hoại Phật Giáo!</span></h1>\n<p>\n  <span class=\"post-title\">\n    <img alt=\"\" src=\"/static/files/DEFAULT/IMAGE/logo.jpg\" style=\"float: left;margin: 10.0px 20.0px;border-width: 10.0px;border-style: solid;\" /></span></p>\n<p>\n  <a href=\"https://youtu.be/PsrzF2_SGXc?si=9CjwgZqbCWzQYLAi\">https://youtu.be/PsrzF2_SGXc?si=9CjwgZqbCWzQYLAi</a></p>\n<p>  Bây giờ các con thấy – người ta dạy rất sai! Câu chuyện Mục Liên\n  Thanh Đề ở trong bản kinh Vu Lan Bồn – mấy con thấy sai không? Dạy\n  người ta ngày báo hiếu, mà báo hiếu như vậy sao? Báo hiếu bằng cách lo lót!</p>\n<p>  Nghĩa là Phật tử phải lo lót cho quý thầy, cho Phật rồi mới được\n  cứu độ! Như vậy có đúng không?</p>\n<p>  Các con nghe câu chuyện khi mà ông Mục Kiền Liên tu đắc Lục thông –\n  mẹ ông chết, ông mới đi tìm mẹ ông ở dưới địa ngục; ông mới thấy mẹ\n  ông ngồi ở trong địa ngục Ngạ quỷ, đói khát, khổ sở; ông mới bưng bát\n  cơm cho mẹ ông ăn; mẹ ông vừa bốc cơm ăn thì lửa cháy – ăn, nuốt không\n  được. Cái cảnh quá khổ!</p>\n<p>  Cho nên, ông cũng không đủ sức của mình để cứu mẹ. Cho nên ông về\n  xin Phật dạy cho ông cách nào để cứu mẹ ông thoát khỏi địa ngục Ngạ\n  quỷ này.</p>\n<p>  Đức Phật nói: <em>“Ông hãy về sắm tứ sự…​”.</em></p>\n<p>  Rồi sắm tứ sự rồi thì để làm gì? Các con hiểu – khi đó phải đem đến\n  cúng Phật và cúng chư Thánh Tăng – nhờ công đức tu hành của họ, sau 3\n  tháng an cư kiết hạ, tức là rằm tháng Bảy là người ta giải hạ ra, cho\n  nên ngày đó gọi là ngày báo hiếu.</p>\n<p>  Vì vậy cho nên lấy cái câu chuyện Mục Liên Thanh Đề để làm ngày báo\n  hiếu. Bây giờ chúng ta có cái ngày rằm tháng Bảy là ngày báo hiếu, do\n  đó chúng ta lấy cái tích lịch sử của Mục Kiền Liên.</p>\n<p>  Mà thử hỏi, bây giờ phải cúng dường trai Tăng cho chúng Tăng và\n  Phật, rồi nhờ công đức của các Ngài đó mới cứu độ bà Thanh Đề thoát\n  khỏi địa ngục. Như vậy trước khi cứu độ là ông Mục Kiền Liên có phạm\n  cái tội lo lót! Đứng trên pháp luật mà! Đại thừa dạy chúng ta có sự lo\n  lót rõ ràng!</p>\n<p>  Vậy kinh sách đúng không? – Không đúng! Dạy chúng ta làm điều sai –\n  đâu phải dạy chúng ta làm điều đúng!</p>\n<p>  Bà Thanh Đề tạo tội thì bà phải trả cái tội đó cho đến khi bà trả\n  hết tội đó. Thí dụ như bây giờ mình làm cái tội mà mình ở tù 10 năm,\n  thì phải ở tù 10 năm thì Nhà nước sẽ thả mình ra.</p>\n<p>  Còn bà Thanh Đề làm tội thì bà phải ở tù bao nhiêu năm, chịu khổ đó\n  bao nhiêu để trả cái tội của bà – cớ sao lại làm cái chuyện phi đạo\n  đức như vậy? Rồi Phật và chư Thánh Tăng lại ăn lo hối lộ – nhận của đó\n  mới cứu.</p>\n<p>  Vậy thì trong địa ngục Ngạ quỷ này đâu phải có 1 mình bà Thanh Đề,\n  có nhiều bà Thanh Đề chứ không phải 1 bà Thanh Đề! Không lẽ mở địa\n  ngục ra chỉ có nhận bà Thanh Đề, còn bao nhiêu những người không làm ác?</p>\n<p>  Vậy thì ở địa ngục đó rất nhiều người – đức Phật là 1 người công\n  bằng chứ, đạo lý chứ! Bà Thanh Đề khổ thì những người khác cũng khổ y\n  chứ! Tại sao không cứu độ? Các con có nghe chưa? Mình có công đức cứu\n  được mà tại sao không cứu hết những người này, lại chỉ có cứu bà này thôi?</p>\n<p>  Tại vì cái lý do là những người kia không có lo lót! Có phải không?\n  Nếu mà lo lót như ông Mục Kiền Liên thì chắc chắn là phải cứu hết chứ gì?</p>\n<p>  Thôi, như vậy là các thầy Thánh Tăng trong lúc đó với Phật – chắc\n  là tiền của chất đâu cho hết! Bởi vì đụng ai cũng ăn lo lót hết thì\n  phải giàu chứ sao? Bây giờ mới cất villa – biệt thự mà ở.</p>\n<p>  Như vậy hiện giờ chúng ta thấy villa – biệt thự của các chùa như\n  thế nào mấy con thấy không? Cái sự ăn lo đó bây giờ chúng ta thấy chùa\n  hàng tỷ bạc! Chùa nào mà cất dưới tỷ bao giờ đâu? Cái cửa cổng họ vô,\n  Thầy thấy trời ơi nó sang còn hơn!</p>\n<p>  Lấy số tiền đó mà cho đồng bào, cho những người bất hạnh trong xã\n  hội – nội cái cửa cổng của họ thôi, thì Thầy thấy cũng đem lại hạnh\n  phúc cho biết bao nhiêu người. Có đúng không? Mấy con thấy chưa?</p>\n<p>\n  <span>\n    <em>Những điều dạy phi đạo đức vậy mà chúng ta cho kinh sách Đại\n      thừa là đúng sao? Các con cứ suy ngẫm đi!</em></span></p>\n<p>  Bây giờ Thầy nói về vấn đề Tịnh Độ: các con thấy Đại thừa dạy chúng\n  ta tu tập Tịnh Độ chứ gì? Nghĩa là người nào mà Niệm Phật để cầu về\n  Cực Lạc – dễ dàng quá! Như 48 lời nguyện của đức Phật Di Đà, mấy con\n  có nghe không? <em>“Thiện nam tín nữ các người chí thành tưởng Phật\n    niệm mười tiếng ra. Ta không rước ở nước ta, thệ không làm Phật,\n    chắc đà không sai”.</em></p>\n<p>  Các con có nghe cái lời nguyện của đức Phật Di Đà không? Mấy con\n  chỉ cần niệm 10 tiếng thôi, đừng có niệm nhiều, cũng đủ rồi. Vậy thì\n  mấy con niệm 10 tiếng quá dễ rồi chứ gì?</p>\n<p>  Cho nên bây giờ, tôi niệm cả ngàn tiếng chứ tôi không niệm 10 tiếng\n  đâu! Chắc chắn là Phật Di Đà sẽ sắp xếp cho tôi có cái nhà đâu ở trển\n  rồi đó, mà tôi vừa tắt thở là mang tôi về trển rồi. Vì có 10 tiếng mà\n  ông còn rước, mà bây giờ tôi niệm cả ngàn tiếng rồi, thì chắc ăn rồi\n  chứ còn gì! Các con thấy đúng không? Như vậy quá đúng rồi! Cho nên mọi\n  người đều cùng nhau mà cố gắng niệm Phật.</p>\n<p>  Nhưng thử hỏi, khi mà tâm mấy con còn tham, sân, si, giận hờn mà\n  ông Phật Di Đà mà ông rước về nước ông – chắc chắn mấy con sẽ đánh lộn\n  trên đó hết! Có đúng không?</p>\n<p>  Thì bây giờ ông Phật Di Đà mới thành lập cái tòa án – nước người ta\n  thuở giờ hoàn toàn không có người tham sân si; mà bây giờ rước cái\n  chúng sanh ở dưới thế gian này lên, bây giờ nó có tham, sân, si rồi;\n  cho nên đất thì lát vàng – Thầy nghe trong kinh Di Đà nói mà, đất lát\n  vàng, hàng rào thì âm nhạc; lúc bây giờ chúng ta nghe hát hay quá\n  chúng ta ra nhổ hàng rào đem vô nhà cất hết, bởi vì chúng ta muốn sử\n  dụng mà! Thì các con thấy cái đó có đúng không?</p>\n<p>  Rồi vàng mà lót ở dưới đất như vậy đó, các con thấy vàng ở thế gian\n  này đắt quá; cho nên vì vậy mình cạy, mình cất để mai mốt mình trở về\n  thế gian mình đem bán; thì bây giờ vàng lên quá cao, cho nên mình sẽ\n  giàu sang.</p>\n<p>  1 lần mà đi lên trên đó về, mình ước ao trở về thế gian chứ:\n    <em>“Đặng tôi còn đem bán cái này chứ! Để ở trên tôi đi gom góp, tôi\n    về tôi bán!”.</em> Thì như vậy mấy con thấy cái đó đúng không mấy con?</p>\n<p>  Con người chúng ta phải dọn sạch – tâm chúng ta hết tham, sân, si\n  thì chúng ta sẽ được về đó. Mà tâm chúng ta còn tham, sân, si thì\n  chúng ta về đó sao được mấy con? Làm sao ai chứng cho mình được về đó!\n  Cho nên đâu có dễ dàng được! Mấy con biết các thầy vật lộn với tham,\n  sân, si của mình dường nào không?</p>\n<p>  Các con cứ thử nghĩ cái tâm si của chúng ta nó hiện ra cái tướng\n  hôn trầm, thùy miên, buồn ngủ – mấy con thức 10 giờ, 11 – 12 giờ;\n  chừng mấy con dậy 1 – 2 giờ, mấy con dậy nổi không? Hay là nó lăn qua\n  lộn lại, nó lười biếng, nó nằm đó để nó ráng ngủ thêm? Các con thấy\n  cái si ghê gớm – cái si là tướng lười biếng!</p>\n<p>  Mà ở đây chúng Tăng và quý cư sĩ ở đây tu tập gay go với nó lắm mới\n  thắng nổi! Vậy mà thắng nổi nhưng chưa hẳn đúng pháp thì chưa hẳn nó\n  dứt cơn đâu – nó còn đó, hở ra 1 chút là nó đánh nhẹp liền tức khắc!\n  Tức là chúng ta bị hôn trầm, thùy miên. Các con thấy chưa?</p>\n<p>  Như vậy chúng ta biết rằng kinh sách Nguyên Thủy đúng hay là kinh\n  sách Đại thừa đúng? Đức Phật dạy: <em>“Ngăn ác, Diệt ác – Sanh thiện\n    Tăng trưởng thiện”</em> – sống trong giới luật nghiêm chỉnh thì mới\n  ly dục, ly ác pháp được; mà sống ngoài giới luật thì làm sao ly dục,\n  ly ác pháp được!</p>\n<p>  Mà bây giờ chúng ta sống trong dục lạc, nghe cõi Cực Lạc quá đẹp đẽ\n  – ham mê, thì chúng ta mong chúng ta về đó! Nhưng lòng tham chúng ta\n  hết không – mà không hết thì thử hỏi làm sao chúng ta sống được?</p>\n<p>  Thầy nói thẳng, nói thật thì sẽ mích lòng nhưng phải nói thẳng, nói\n  thật! Dựng lại Phật giáo mà không dám nói thẳng, nói thật thì người ta\n  vẫn cho đó là đúng; mà cho nó là đúng thì người ta sẽ đi theo cái sai.</p>\n<p>  Cho nên Thầy nói như vậy các con sẽ suy ngẫm, tự suy ngẫm; đúng thì\n  mấy con theo – Thầy không ép buộc; được thì mấy con hữu duyên, mà\n  không được thì mấy con chịu chứ không phải riêng Thầy.</p>\n<p>  Còn ở đây Thầy khuyên các thầy nên tu tập đúng theo Thầy hướng dẫn;\n  mà tu tập sai theo kiến giải, tưởng giải của quý thầy thì quý thầy\n  chịu trách nhiệm cái sai của quý thầy.</p>\n<p>  Các Thầy phải hiểu Thầy là 1 người đã kinh nghiệm đi qua trên con\n  đường này, làm chủ được sự sống chết của mình, mà bây giờ đem truyền\n  dạy lại cho quý vị làm chủ sự sống chết cho quý vị. Thì quý vị phải\n  hiểu biết người có kinh nghiệm như vậy, dạy mình sẽ không sai!</p>\n<p>  Cho nên trong kinh sách Phật dạy, bảo mình tìm thiện hữu tri thức –\n  người đó phải hết tham, sân, si; người đó phải chứng đạt được chân lý\n  – đó là Thầy của mình! Người đó phải sống đúng giới luật – giới luật\n  còn là Phật giáo còn, giới luật mất là Phật giáo mất.</p>\n<p>\n  <span>\n    <em>Cho nên chúng ta tìm 1 vị thầy mà giới luật nghiêm chỉnh, không\n      hề vi phạm 1 lỗi nhỏ nhặt nào thì đó là Phật giáo còn. Còn nếu tìm\n      không được thì đương nhiên – dù có trăm ngàn danh từ nói Phật giáo\n      thì Phật giáo đó vẫn sai! Vị thầy chúng ta phạm giới, phá giới mà\n      chúng ta theo tu tập thì chúng ta chẳng làm chủ sanh tử luân hồi.\n      Tại sao vậy? Tại vì tâm không ly dục, ly ác pháp cho nên mới phạm\n      giới. Còn tâm ly dục ly ác pháp thì không bao giờ phạm giới!</em></span></p>\n<p>  (21:36) Cho nên quý Phật tử cũng như các thầy nghe Thiền tông nói:\n  Tự tại vô ngại, đói ăn, khát uống, mệt đi ngủ; rồi thõng tay vào chợ,\n  nào là xách cá quải thịt, nào là uống rượu đủ thứ hết! Cho những vị đó\n  là tự tại rồi, sống vô ngại rồi, không có còn chướng ngại nữa, gọi là\n  giải thoát. Thực sự tu hành rồi mà trở lại sống còn hơn 1 người bê bối\n  – rượu chè say sưa. Sống như vậy có đúng không?</p>\n<p>  1 người tu phải có hạnh của người tu! Người tu gì mà lại rượu chè\n  say sưa – gọi là tự tại; muốn ăn, muốn ngủ hồi nào cũng được hết sao?\n  Giống như người phàm phu – người phàm phu họ cũng muốn ăn, muốn ngủ\n  hồi nào cũng được, có gì đâu!</p>\n<p>  Cho nên ở đây, cái danh từ mà gọi là <em>“tự tại vô ngại”</em> thì\n  Thầy thấy thật sự không phải áp dụng cho người tu sĩ của đạo Phật mà\n  áp dụng cho cái người vào cái sự sống hiện sinh của họ, sống trong cái\n  dục lạc của họ để họ thỏa mãn trong đời sống của họ – họ nói chết là\n  hết rồi, chỉ có đời nay thôi, mình hưởng cho hết dục lạc trên thế gian\n  này, chết thì người nào cũng chết hết. Đó là cái hiểu biết không đúng,\n  cạn cợt, không đúng – chết chưa phải là hết!</p>\n<p>  Và sống không phải có nghĩa là chúng ta sống mà không tái sanh luân\n  hồi. Do học bài đạo đức nhân quả vừa rồi đã xác định cho mấy con thấy\n  1 hành động của chúng ta là sẽ tái sanh làm 1 con vật hoặc là làm con người.</p>\n<p>  Quý vị nhớ kỹ những bài học nhân quả này mà khắc ghi trong lòng để\n  thực hiện đạo đức nhân bản – nhân quả, sống không làm khổ mình, khổ\n  người; tất cả những hành động ác – chúng ta không làm nữa!</p>\n<p>  Cho nên đức Phật nói: <em>“Ngăn ác, Diệt ác – Sanh thiện, Tăng\n    trưởng thiện”</em> hoặc là <em>“Chư ác mạc tác, chúng thiện phụng\n  hành”.</em> Lời nói của đức Phật dạy như vậy, chúng ta hãy cố gắng mà\n  tu tập!</p>\n<p>  Đến đây Thầy xin chấm dứt. Và buổi học hôm nay, mấy con có hỏi gì\n  thì giờ này cứ hỏi, Thầy sẽ trả lời. Bây giờ ai có thắc mắc những gì\n  thì hỏi, mà không thắc mắc thì chúng ta về, vì giờ chúng ta sắp sửa đi\n  khất thực.</p>\n<p>\n  <em>(Trích </em>\n  <a href=\"https://thuvienchonnhu.net/phap-am/LCK-028\">LCK 028D (CHUNG)\n    – HỌC TẬP ĐẠO ĐỨC NHÂN BẢN NHÂN QUẢ – ĐỪNG THEO KIẾN GIẢI ĐẠI THỪA –\n    VẤN ĐẠO LÀM CHỦ NHÂN QUẢ</a>\n  <em>)</em></p>\n','Đại Thừa Dạy Lo Lót Phi Nhân Quả',NULL,'Đại Thừa Dạy Lo Lót Phi Nhân Quả','Đại Thừa Dạy Lo Lót Phi Nhân Quả','Đại Thừa Dạy Lo Lót Phi Nhân Quả','i-tha-dy-lo-lt-phi-nhn-qu',1,150),(14,'2026-09-14 14:44:20','2026-09-14 14:44:20',NULL,'<h1>\n  <span class=\"post-title\">Đại Thừa Dạy Lo Lót Phi Nhân Quả, Nuôi Dưỡng\n    Dục Thế Gian Làm Hư Hoại Phật Giáo!</span></h1>\n<p>\n  <img src=\"http://localhost:8080/static/files/DEFAULT/IMAGE/logo.jpg\" style=\"float: right;margin: 10.0px 20.0px;border-width: 15.0px;border-style: solid;\" /></p>\n<p>\n  <a href=\"https://youtu.be/PsrzF2_SGXc?si=9CjwgZqbCWzQYLAi\">https://youtu.be/PsrzF2_SGXc?si=9CjwgZqbCWzQYLAi</a></p>\n<p>  Bây giờ các con thấy – người ta dạy rất sai! Câu chuyện Mục Liên\n  Thanh Đề ở trong bản kinh Vu Lan Bồn – mấy con thấy sai không? Dạy\n  người ta ngày báo hiếu, mà báo hiếu như vậy sao? Báo hiếu bằng cách lo lót!</p>\n<p>  Nghĩa là Phật tử phải lo lót cho quý thầy, cho Phật rồi mới được\n  cứu độ! Như vậy có đúng không?</p>\n<h1>\n  <span class=\"post-title\">Đại Thừa Dạy Lo Lót Phi Nhân Quả, Nuôi Dưỡng\n    Dục Thế Gian Làm Hư Hoại Phật Giáo!</span></h1>\n<p>  Các con nghe câu chuyện khi mà ông Mục Kiền Liên tu đắc Lục thông –\n  mẹ ông chết, ông mới đi tìm mẹ ông ở dưới địa ngục; ông mới thấy mẹ\n  ông ngồi ở trong địa ngục Ngạ quỷ, đói khát, khổ sở; ông mới bưng bát\n  cơm cho mẹ ông ăn; mẹ ông vừa bốc cơm ăn thì lửa cháy – ăn, nuốt không\n  được. Cái cảnh quá khổ!</p>\n<p>  Cho nên, ông cũng không đủ sức của mình để cứu mẹ. Cho nên ông về\n  xin Phật dạy cho ông cách nào để cứu mẹ ông thoát khỏi địa ngục Ngạ\n  quỷ này.</p>\n<p>  Đức Phật nói: <em>“Ông hãy về sắm tứ sự…​”.</em></p>\n<p>  Rồi sắm tứ sự rồi thì để làm gì? Các con hiểu – khi đó phải đem đến\n  cúng Phật và cúng chư Thánh Tăng – nhờ công đức tu hành của họ, sau 3\n  tháng an cư kiết hạ, tức là rằm tháng Bảy là người ta giải hạ ra, cho\n  nên ngày đó gọi là ngày báo hiếu.</p>\n<p>  Vì vậy cho nên lấy cái câu chuyện Mục Liên Thanh Đề để làm ngày báo\n  hiếu. Bây giờ chúng ta có cái ngày rằm tháng Bảy là ngày báo hiếu, do\n  đó chúng ta lấy cái tích lịch sử của Mục Kiền Liên.</p>\n<p>  Mà thử hỏi, bây giờ phải cúng dường trai Tăng cho chúng Tăng và\n  Phật, rồi nhờ công đức của các Ngài đó mới cứu độ bà Thanh Đề thoát\n  khỏi địa ngục. Như vậy trước khi cứu độ là ông Mục Kiền Liên có phạm\n  cái tội lo lót! Đứng trên pháp luật mà! Đại thừa dạy chúng ta có sự lo\n  lót rõ ràng!</p>\n<p>  Vậy kinh sách đúng không? – Không đúng! Dạy chúng ta làm điều sai –\n  đâu phải dạy chúng ta làm điều đúng!</p>\n<p>  Bà Thanh Đề tạo tội thì bà phải trả cái tội đó cho đến khi bà trả\n  hết tội đó. Thí dụ như bây giờ mình làm cái tội mà mình ở tù 10 năm,\n  thì phải ở tù 10 năm thì Nhà nước sẽ thả mình ra.</p>\n<p>  Còn bà Thanh Đề làm tội thì bà phải ở tù bao nhiêu năm, chịu khổ đó\n  bao nhiêu để trả cái tội của bà – cớ sao lại làm cái chuyện phi đạo\n  đức như vậy? Rồi Phật và chư Thánh Tăng lại ăn lo hối lộ – nhận của đó\n  mới cứu.</p>\n<p>  Vậy thì trong địa ngục Ngạ quỷ này đâu phải có 1 mình bà Thanh Đề,\n  có nhiều bà Thanh Đề chứ không phải 1 bà Thanh Đề! Không lẽ mở địa\n  ngục ra chỉ có nhận bà Thanh Đề, còn bao nhiêu những người không làm ác?</p>\n<p>  Vậy thì ở địa ngục đó rất nhiều người – đức Phật là 1 người công\n  bằng chứ, đạo lý chứ! Bà Thanh Đề khổ thì những người khác cũng khổ y\n  chứ! Tại sao không cứu độ? Các con có nghe chưa? Mình có công đức cứu\n  được mà tại sao không cứu hết những người này, lại chỉ có cứu bà này thôi?</p>\n<p>  Tại vì cái lý do là những người kia không có lo lót! Có phải không?\n  Nếu mà lo lót như ông Mục Kiền Liên thì chắc chắn là phải cứu hết chứ gì?</p>\n<p>  Thôi, như vậy là các thầy Thánh Tăng trong lúc đó với Phật – chắc\n  là tiền của chất đâu cho hết! Bởi vì đụng ai cũng ăn lo lót hết thì\n  phải giàu chứ sao? Bây giờ mới cất villa – biệt thự mà ở.</p>\n<p>  Như vậy hiện giờ chúng ta thấy villa – biệt thự của các chùa như\n  thế nào mấy con thấy không? Cái sự ăn lo đó bây giờ chúng ta thấy chùa\n  hàng tỷ bạc! Chùa nào mà cất dưới tỷ bao giờ đâu? Cái cửa cổng họ vô,\n  Thầy thấy trời ơi nó sang còn hơn!</p>\n<p>  Lấy số tiền đó mà cho đồng bào, cho những người bất hạnh trong xã\n  hội – nội cái cửa cổng của họ thôi, thì Thầy thấy cũng đem lại hạnh\n  phúc cho biết bao nhiêu người. Có đúng không? Mấy con thấy chưa?</p>\n<p>\n  <span>\n    <em>Những điều dạy phi đạo đức vậy mà chúng ta cho kinh sách Đại\n      thừa là đúng sao? Các con cứ suy ngẫm đi!</em></span></p>\n<p>  Bây giờ Thầy nói về vấn đề Tịnh Độ: các con thấy Đại thừa dạy chúng\n  ta tu tập Tịnh Độ chứ gì? Nghĩa là người nào mà Niệm Phật để cầu về\n  Cực Lạc – dễ dàng quá! Như 48 lời nguyện của đức Phật Di Đà, mấy con\n  có nghe không? <em>“Thiện nam tín nữ các người chí thành tưởng Phật\n    niệm mười tiếng ra. Ta không rước ở nước ta, thệ không làm Phật,\n    chắc đà không sai”.</em></p>\n<p>  Các con có nghe cái lời nguyện của đức Phật Di Đà không? Mấy con\n  chỉ cần niệm 10 tiếng thôi, đừng có niệm nhiều, cũng đủ rồi. Vậy thì\n  mấy con niệm 10 tiếng quá dễ rồi chứ gì?</p>\n<p>  Cho nên bây giờ, tôi niệm cả ngàn tiếng chứ tôi không niệm 10 tiếng\n  đâu! Chắc chắn là Phật Di Đà sẽ sắp xếp cho tôi có cái nhà đâu ở trển\n  rồi đó, mà tôi vừa tắt thở là mang tôi về trển rồi. Vì có 10 tiếng mà\n  ông còn rước, mà bây giờ tôi niệm cả ngàn tiếng rồi, thì chắc ăn rồi\n  chứ còn gì! Các con thấy đúng không? Như vậy quá đúng rồi! Cho nên mọi\n  người đều cùng nhau mà cố gắng niệm Phật.</p>\n<p>  Nhưng thử hỏi, khi mà tâm mấy con còn tham, sân, si, giận hờn mà\n  ông Phật Di Đà mà ông rước về nước ông – chắc chắn mấy con sẽ đánh lộn\n  trên đó hết! Có đúng không?</p>\n<p>  Thì bây giờ ông Phật Di Đà mới thành lập cái tòa án – nước người ta\n  thuở giờ hoàn toàn không có người tham sân si; mà bây giờ rước cái\n  chúng sanh ở dưới thế gian này lên, bây giờ nó có tham, sân, si rồi;\n  cho nên đất thì lát vàng – Thầy nghe trong kinh Di Đà nói mà, đất lát\n  vàng, hàng rào thì âm nhạc; lúc bây giờ chúng ta nghe hát hay quá\n  chúng ta ra nhổ hàng rào đem vô nhà cất hết, bởi vì chúng ta muốn sử\n  dụng mà! Thì các con thấy cái đó có đúng không?</p>\n<p>  Rồi vàng mà lót ở dưới đất như vậy đó, các con thấy vàng ở thế gian\n  này đắt quá; cho nên vì vậy mình cạy, mình cất để mai mốt mình trở về\n  thế gian mình đem bán; thì bây giờ vàng lên quá cao, cho nên mình sẽ\n  giàu sang.</p>\n<p>  1 lần mà đi lên trên đó về, mình ước ao trở về thế gian chứ:\n    <em>“Đặng tôi còn đem bán cái này chứ! Để ở trên tôi đi gom góp, tôi\n    về tôi bán!”.</em> Thì như vậy mấy con thấy cái đó đúng không mấy con?</p>\n<p>  Con người chúng ta phải dọn sạch – tâm chúng ta hết tham, sân, si\n  thì chúng ta sẽ được về đó. Mà tâm chúng ta còn tham, sân, si thì\n  chúng ta về đó sao được mấy con? Làm sao ai chứng cho mình được về đó!\n  Cho nên đâu có dễ dàng được! Mấy con biết các thầy vật lộn với tham,\n  sân, si của mình dường nào không?</p>\n<p>  Các con cứ thử nghĩ cái tâm si của chúng ta nó hiện ra cái tướng\n  hôn trầm, thùy miên, buồn ngủ – mấy con thức 10 giờ, 11 – 12 giờ;\n  chừng mấy con dậy 1 – 2 giờ, mấy con dậy nổi không? Hay là nó lăn qua\n  lộn lại, nó lười biếng, nó nằm đó để nó ráng ngủ thêm? Các con thấy\n  cái si ghê gớm – cái si là tướng lười biếng!</p>\n<p>  Mà ở đây chúng Tăng và quý cư sĩ ở đây tu tập gay go với nó lắm mới\n  thắng nổi! Vậy mà thắng nổi nhưng chưa hẳn đúng pháp thì chưa hẳn nó\n  dứt cơn đâu – nó còn đó, hở ra 1 chút là nó đánh nhẹp liền tức khắc!\n  Tức là chúng ta bị hôn trầm, thùy miên. Các con thấy chưa?</p>\n<p>  Như vậy chúng ta biết rằng kinh sách Nguyên Thủy đúng hay là kinh\n  sách Đại thừa đúng? Đức Phật dạy: <em>“Ngăn ác, Diệt ác – Sanh thiện\n    Tăng trưởng thiện”</em> – sống trong giới luật nghiêm chỉnh thì mới\n  ly dục, ly ác pháp được; mà sống ngoài giới luật thì làm sao ly dục,\n  ly ác pháp được!</p>\n<p>  Mà bây giờ chúng ta sống trong dục lạc, nghe cõi Cực Lạc quá đẹp đẽ\n  – ham mê, thì chúng ta mong chúng ta về đó! Nhưng lòng tham chúng ta\n  hết không – mà không hết thì thử hỏi làm sao chúng ta sống được?</p>\n<p>  Thầy nói thẳng, nói thật thì sẽ mích lòng nhưng phải nói thẳng, nói\n  thật! Dựng lại Phật giáo mà không dám nói thẳng, nói thật thì người ta\n  vẫn cho đó là đúng; mà cho nó là đúng thì người ta sẽ đi theo cái sai.</p>\n<p>  Cho nên Thầy nói như vậy các con sẽ suy ngẫm, tự suy ngẫm; đúng thì\n  mấy con theo – Thầy không ép buộc; được thì mấy con hữu duyên, mà\n  không được thì mấy con chịu chứ không phải riêng Thầy.</p>\n<p>  Còn ở đây Thầy khuyên các thầy nên tu tập đúng theo Thầy hướng dẫn;\n  mà tu tập sai theo kiến giải, tưởng giải của quý thầy thì quý thầy\n  chịu trách nhiệm cái sai của quý thầy.</p>\n<p>  Các Thầy phải hiểu Thầy là 1 người đã kinh nghiệm đi qua trên con\n  đường này, làm chủ được sự sống chết của mình, mà bây giờ đem truyền\n  dạy lại cho quý vị làm chủ sự sống chết cho quý vị. Thì quý vị phải\n  hiểu biết người có kinh nghiệm như vậy, dạy mình sẽ không sai!</p>\n<p>  Cho nên trong kinh sách Phật dạy, bảo mình tìm thiện hữu tri thức –\n  người đó phải hết tham, sân, si; người đó phải chứng đạt được chân lý\n  – đó là Thầy của mình! Người đó phải sống đúng giới luật – giới luật\n  còn là Phật giáo còn, giới luật mất là Phật giáo mất.</p>\n<p>\n  <span>\n    <em>Cho nên chúng ta tìm 1 vị thầy mà giới luật nghiêm chỉnh, không\n      hề vi phạm 1 lỗi nhỏ nhặt nào thì đó là Phật giáo còn. Còn nếu tìm\n      không được thì đương nhiên – dù có trăm ngàn danh từ nói Phật giáo\n      thì Phật giáo đó vẫn sai! Vị thầy chúng ta phạm giới, phá giới mà\n      chúng ta theo tu tập thì chúng ta chẳng làm chủ sanh tử luân hồi.\n      Tại sao vậy? Tại vì tâm không ly dục, ly ác pháp cho nên mới phạm\n      giới. Còn tâm ly dục ly ác pháp thì không bao giờ phạm giới!</em></span></p>\n<p>  (21:36) Cho nên quý Phật tử cũng như các thầy nghe Thiền tông nói:\n  Tự tại vô ngại, đói ăn, khát uống, mệt đi ngủ; rồi thõng tay vào chợ,\n  nào là xách cá quải thịt, nào là uống rượu đủ thứ hết! Cho những vị đó\n  là tự tại rồi, sống vô ngại rồi, không có còn chướng ngại nữa, gọi là\n  giải thoát. Thực sự tu hành rồi mà trở lại sống còn hơn 1 người bê bối\n  – rượu chè say sưa. Sống như vậy có đúng không?</p>\n<p>  1 người tu phải có hạnh của người tu! Người tu gì mà lại rượu chè\n  say sưa – gọi là tự tại; muốn ăn, muốn ngủ hồi nào cũng được hết sao?\n  Giống như người phàm phu – người phàm phu họ cũng muốn ăn, muốn ngủ\n  hồi nào cũng được, có gì đâu!</p>\n<p>  Cho nên ở đây, cái danh từ mà gọi là <em>“tự tại vô ngại”</em> thì\n  Thầy thấy thật sự không phải áp dụng cho người tu sĩ của đạo Phật mà\n  áp dụng cho cái người vào cái sự sống hiện sinh của họ, sống trong cái\n  dục lạc của họ để họ thỏa mãn trong đời sống của họ – họ nói chết là\n  hết rồi, chỉ có đời nay thôi, mình hưởng cho hết dục lạc trên thế gian\n  này, chết thì người nào cũng chết hết. Đó là cái hiểu biết không đúng,\n  cạn cợt, không đúng – chết chưa phải là hết!</p>\n<p>  Và sống không phải có nghĩa là chúng ta sống mà không tái sanh luân\n  hồi. Do học bài đạo đức nhân quả vừa rồi đã xác định cho mấy con thấy\n  1 hành động của chúng ta là sẽ tái sanh làm 1 con vật hoặc là làm con người.</p>\n<p>  Quý vị nhớ kỹ những bài học nhân quả này mà khắc ghi trong lòng để\n  thực hiện đạo đức nhân bản – nhân quả, sống không làm khổ mình, khổ\n  người; tất cả những hành động ác – chúng ta không làm nữa!</p>\n<p>  Cho nên đức Phật nói: <em>“Ngăn ác, Diệt ác – Sanh thiện, Tăng\n    trưởng thiện”</em> hoặc là <em>“Chư ác mạc tác, chúng thiện phụng\n  hành”.</em> Lời nói của đức Phật dạy như vậy, chúng ta hãy cố gắng mà\n  tu tập!</p>\n<p>  Đến đây Thầy xin chấm dứt. Và buổi học hôm nay, mấy con có hỏi gì\n  thì giờ này cứ hỏi, Thầy sẽ trả lời. Bây giờ ai có thắc mắc những gì\n  thì hỏi, mà không thắc mắc thì chúng ta về, vì giờ chúng ta sắp sửa đi\n  khất thực.</p>\n<p>\n  <em>(Trích </em>\n  <a href=\"https://thuvienchonnhu.net/phap-am/LCK-028\">LCK 028D (CHUNG)\n    – HỌC TẬP ĐẠO ĐỨC NHÂN BẢN NHÂN QUẢ – ĐỪNG THEO KIẾN GIẢI ĐẠI THỪA –\n    VẤN ĐẠO LÀM CHỦ NHÂN QUẢ</a>\n  <em>)</em></p>\n','Đại Thừa Dạy Lo Lót Phi Nhân Quả',NULL,'Đại Thừa Dạy Lo Lót Phi Nhân Quả','Đại Thừa Dạy Lo Lót Phi Nhân Quả','Đại Thừa Dạy Lo Lót Phi Nhân Quả','i-tha-dy-lo-lt-phi-nhn-qu',3,150),(15,'2026-09-14 14:27:45','2026-09-14 14:27:45',NULL,'<h1>\n  <span class=\"post-title\">Đại Thừa Dạy Lo Lót Phi Nhân Quả, Nuôi Dưỡng\n    Dục Thế Gian Làm Hư Hoại Phật Giáo!</span></h1>\n<p>\n  <span class=\"post-title\">\n    <img alt=\"\" src=\"/static/files/DEFAULT/IMAGE/logo.jpg\" style=\"float: left;margin: 10.0px 20.0px;border-width: 10.0px;border-style: solid;\" /></span></p>\n<p>\n  <a href=\"https://youtu.be/PsrzF2_SGXc?si=9CjwgZqbCWzQYLAi\">https://youtu.be/PsrzF2_SGXc?si=9CjwgZqbCWzQYLAi</a></p>\n<p>  Bây giờ các con thấy – người ta dạy rất sai! Câu chuyện Mục Liên\n  Thanh Đề ở trong bản kinh Vu Lan Bồn – mấy con thấy sai không? Dạy\n  người ta ngày báo hiếu, mà báo hiếu như vậy sao? Báo hiếu bằng cách lo lót!</p>\n<p>  Nghĩa là Phật tử phải lo lót cho quý thầy, cho Phật rồi mới được\n  cứu độ! Như vậy có đúng không?</p>\n<p>  Các con nghe câu chuyện khi mà ông Mục Kiền Liên tu đắc Lục thông –\n  mẹ ông chết, ông mới đi tìm mẹ ông ở dưới địa ngục; ông mới thấy mẹ\n  ông ngồi ở trong địa ngục Ngạ quỷ, đói khát, khổ sở; ông mới bưng bát\n  cơm cho mẹ ông ăn; mẹ ông vừa bốc cơm ăn thì lửa cháy – ăn, nuốt không\n  được. Cái cảnh quá khổ!</p>\n<p>  Cho nên, ông cũng không đủ sức của mình để cứu mẹ. Cho nên ông về\n  xin Phật dạy cho ông cách nào để cứu mẹ ông thoát khỏi địa ngục Ngạ\n  quỷ này.</p>\n<p>  Đức Phật nói: <em>“Ông hãy về sắm tứ sự…​”.</em></p>\n<p>  Rồi sắm tứ sự rồi thì để làm gì? Các con hiểu – khi đó phải đem đến\n  cúng Phật và cúng chư Thánh Tăng – nhờ công đức tu hành của họ, sau 3\n  tháng an cư kiết hạ, tức là rằm tháng Bảy là người ta giải hạ ra, cho\n  nên ngày đó gọi là ngày báo hiếu.</p>\n<p>  Vì vậy cho nên lấy cái câu chuyện Mục Liên Thanh Đề để làm ngày báo\n  hiếu. Bây giờ chúng ta có cái ngày rằm tháng Bảy là ngày báo hiếu, do\n  đó chúng ta lấy cái tích lịch sử của Mục Kiền Liên.</p>\n<p>  Mà thử hỏi, bây giờ phải cúng dường trai Tăng cho chúng Tăng và\n  Phật, rồi nhờ công đức của các Ngài đó mới cứu độ bà Thanh Đề thoát\n  khỏi địa ngục. Như vậy trước khi cứu độ là ông Mục Kiền Liên có phạm\n  cái tội lo lót! Đứng trên pháp luật mà! Đại thừa dạy chúng ta có sự lo\n  lót rõ ràng!</p>\n<p>  Vậy kinh sách đúng không? – Không đúng! Dạy chúng ta làm điều sai –\n  đâu phải dạy chúng ta làm điều đúng!</p>\n<p>  Bà Thanh Đề tạo tội thì bà phải trả cái tội đó cho đến khi bà trả\n  hết tội đó. Thí dụ như bây giờ mình làm cái tội mà mình ở tù 10 năm,\n  thì phải ở tù 10 năm thì Nhà nước sẽ thả mình ra.</p>\n<p>  Còn bà Thanh Đề làm tội thì bà phải ở tù bao nhiêu năm, chịu khổ đó\n  bao nhiêu để trả cái tội của bà – cớ sao lại làm cái chuyện phi đạo\n  đức như vậy? Rồi Phật và chư Thánh Tăng lại ăn lo hối lộ – nhận của đó\n  mới cứu.</p>\n<p>  Vậy thì trong địa ngục Ngạ quỷ này đâu phải có 1 mình bà Thanh Đề,\n  có nhiều bà Thanh Đề chứ không phải 1 bà Thanh Đề! Không lẽ mở địa\n  ngục ra chỉ có nhận bà Thanh Đề, còn bao nhiêu những người không làm ác?</p>\n<p>  Vậy thì ở địa ngục đó rất nhiều người – đức Phật là 1 người công\n  bằng chứ, đạo lý chứ! Bà Thanh Đề khổ thì những người khác cũng khổ y\n  chứ! Tại sao không cứu độ? Các con có nghe chưa? Mình có công đức cứu\n  được mà tại sao không cứu hết những người này, lại chỉ có cứu bà này thôi?</p>\n<p>  Tại vì cái lý do là những người kia không có lo lót! Có phải không?\n  Nếu mà lo lót như ông Mục Kiền Liên thì chắc chắn là phải cứu hết chứ gì?</p>\n<p>  Thôi, như vậy là các thầy Thánh Tăng trong lúc đó với Phật – chắc\n  là tiền của chất đâu cho hết! Bởi vì đụng ai cũng ăn lo lót hết thì\n  phải giàu chứ sao? Bây giờ mới cất villa – biệt thự mà ở.</p>\n<p>  Như vậy hiện giờ chúng ta thấy villa – biệt thự của các chùa như\n  thế nào mấy con thấy không? Cái sự ăn lo đó bây giờ chúng ta thấy chùa\n  hàng tỷ bạc! Chùa nào mà cất dưới tỷ bao giờ đâu? Cái cửa cổng họ vô,\n  Thầy thấy trời ơi nó sang còn hơn!</p>\n<p>  Lấy số tiền đó mà cho đồng bào, cho những người bất hạnh trong xã\n  hội – nội cái cửa cổng của họ thôi, thì Thầy thấy cũng đem lại hạnh\n  phúc cho biết bao nhiêu người. Có đúng không? Mấy con thấy chưa?</p>\n<p>\n  <span>\n    <em>Những điều dạy phi đạo đức vậy mà chúng ta cho kinh sách Đại\n      thừa là đúng sao? Các con cứ suy ngẫm đi!</em></span></p>\n<p>  Bây giờ Thầy nói về vấn đề Tịnh Độ: các con thấy Đại thừa dạy chúng\n  ta tu tập Tịnh Độ chứ gì? Nghĩa là người nào mà Niệm Phật để cầu về\n  Cực Lạc – dễ dàng quá! Như 48 lời nguyện của đức Phật Di Đà, mấy con\n  có nghe không? <em>“Thiện nam tín nữ các người chí thành tưởng Phật\n    niệm mười tiếng ra. Ta không rước ở nước ta, thệ không làm Phật,\n    chắc đà không sai”.</em></p>\n<p>  Các con có nghe cái lời nguyện của đức Phật Di Đà không? Mấy con\n  chỉ cần niệm 10 tiếng thôi, đừng có niệm nhiều, cũng đủ rồi. Vậy thì\n  mấy con niệm 10 tiếng quá dễ rồi chứ gì?</p>\n<p>  Cho nên bây giờ, tôi niệm cả ngàn tiếng chứ tôi không niệm 10 tiếng\n  đâu! Chắc chắn là Phật Di Đà sẽ sắp xếp cho tôi có cái nhà đâu ở trển\n  rồi đó, mà tôi vừa tắt thở là mang tôi về trển rồi. Vì có 10 tiếng mà\n  ông còn rước, mà bây giờ tôi niệm cả ngàn tiếng rồi, thì chắc ăn rồi\n  chứ còn gì! Các con thấy đúng không? Như vậy quá đúng rồi! Cho nên mọi\n  người đều cùng nhau mà cố gắng niệm Phật.</p>\n<p>  Nhưng thử hỏi, khi mà tâm mấy con còn tham, sân, si, giận hờn mà\n  ông Phật Di Đà mà ông rước về nước ông – chắc chắn mấy con sẽ đánh lộn\n  trên đó hết! Có đúng không?</p>\n<p>  Thì bây giờ ông Phật Di Đà mới thành lập cái tòa án – nước người ta\n  thuở giờ hoàn toàn không có người tham sân si; mà bây giờ rước cái\n  chúng sanh ở dưới thế gian này lên, bây giờ nó có tham, sân, si rồi;\n  cho nên đất thì lát vàng – Thầy nghe trong kinh Di Đà nói mà, đất lát\n  vàng, hàng rào thì âm nhạc; lúc bây giờ chúng ta nghe hát hay quá\n  chúng ta ra nhổ hàng rào đem vô nhà cất hết, bởi vì chúng ta muốn sử\n  dụng mà! Thì các con thấy cái đó có đúng không?</p>\n<p>  Rồi vàng mà lót ở dưới đất như vậy đó, các con thấy vàng ở thế gian\n  này đắt quá; cho nên vì vậy mình cạy, mình cất để mai mốt mình trở về\n  thế gian mình đem bán; thì bây giờ vàng lên quá cao, cho nên mình sẽ\n  giàu sang.</p>\n<p>  1 lần mà đi lên trên đó về, mình ước ao trở về thế gian chứ:\n    <em>“Đặng tôi còn đem bán cái này chứ! Để ở trên tôi đi gom góp, tôi\n    về tôi bán!”.</em> Thì như vậy mấy con thấy cái đó đúng không mấy con?</p>\n<p>  Con người chúng ta phải dọn sạch – tâm chúng ta hết tham, sân, si\n  thì chúng ta sẽ được về đó. Mà tâm chúng ta còn tham, sân, si thì\n  chúng ta về đó sao được mấy con? Làm sao ai chứng cho mình được về đó!\n  Cho nên đâu có dễ dàng được! Mấy con biết các thầy vật lộn với tham,\n  sân, si của mình dường nào không?</p>\n<p>  Các con cứ thử nghĩ cái tâm si của chúng ta nó hiện ra cái tướng\n  hôn trầm, thùy miên, buồn ngủ – mấy con thức 10 giờ, 11 – 12 giờ;\n  chừng mấy con dậy 1 – 2 giờ, mấy con dậy nổi không? Hay là nó lăn qua\n  lộn lại, nó lười biếng, nó nằm đó để nó ráng ngủ thêm? Các con thấy\n  cái si ghê gớm – cái si là tướng lười biếng!</p>\n<p>  Mà ở đây chúng Tăng và quý cư sĩ ở đây tu tập gay go với nó lắm mới\n  thắng nổi! Vậy mà thắng nổi nhưng chưa hẳn đúng pháp thì chưa hẳn nó\n  dứt cơn đâu – nó còn đó, hở ra 1 chút là nó đánh nhẹp liền tức khắc!\n  Tức là chúng ta bị hôn trầm, thùy miên. Các con thấy chưa?</p>\n<p>  Như vậy chúng ta biết rằng kinh sách Nguyên Thủy đúng hay là kinh\n  sách Đại thừa đúng? Đức Phật dạy: <em>“Ngăn ác, Diệt ác – Sanh thiện\n    Tăng trưởng thiện”</em> – sống trong giới luật nghiêm chỉnh thì mới\n  ly dục, ly ác pháp được; mà sống ngoài giới luật thì làm sao ly dục,\n  ly ác pháp được!</p>\n<p>  Mà bây giờ chúng ta sống trong dục lạc, nghe cõi Cực Lạc quá đẹp đẽ\n  – ham mê, thì chúng ta mong chúng ta về đó! Nhưng lòng tham chúng ta\n  hết không – mà không hết thì thử hỏi làm sao chúng ta sống được?</p>\n<p>  Thầy nói thẳng, nói thật thì sẽ mích lòng nhưng phải nói thẳng, nói\n  thật! Dựng lại Phật giáo mà không dám nói thẳng, nói thật thì người ta\n  vẫn cho đó là đúng; mà cho nó là đúng thì người ta sẽ đi theo cái sai.</p>\n<p>  Cho nên Thầy nói như vậy các con sẽ suy ngẫm, tự suy ngẫm; đúng thì\n  mấy con theo – Thầy không ép buộc; được thì mấy con hữu duyên, mà\n  không được thì mấy con chịu chứ không phải riêng Thầy.</p>\n<p>  Còn ở đây Thầy khuyên các thầy nên tu tập đúng theo Thầy hướng dẫn;\n  mà tu tập sai theo kiến giải, tưởng giải của quý thầy thì quý thầy\n  chịu trách nhiệm cái sai của quý thầy.</p>\n<p>  Các Thầy phải hiểu Thầy là 1 người đã kinh nghiệm đi qua trên con\n  đường này, làm chủ được sự sống chết của mình, mà bây giờ đem truyền\n  dạy lại cho quý vị làm chủ sự sống chết cho quý vị. Thì quý vị phải\n  hiểu biết người có kinh nghiệm như vậy, dạy mình sẽ không sai!</p>\n<p>  Cho nên trong kinh sách Phật dạy, bảo mình tìm thiện hữu tri thức –\n  người đó phải hết tham, sân, si; người đó phải chứng đạt được chân lý\n  – đó là Thầy của mình! Người đó phải sống đúng giới luật – giới luật\n  còn là Phật giáo còn, giới luật mất là Phật giáo mất.</p>\n<p>\n  <span>\n    <em>Cho nên chúng ta tìm 1 vị thầy mà giới luật nghiêm chỉnh, không\n      hề vi phạm 1 lỗi nhỏ nhặt nào thì đó là Phật giáo còn. Còn nếu tìm\n      không được thì đương nhiên – dù có trăm ngàn danh từ nói Phật giáo\n      thì Phật giáo đó vẫn sai! Vị thầy chúng ta phạm giới, phá giới mà\n      chúng ta theo tu tập thì chúng ta chẳng làm chủ sanh tử luân hồi.\n      Tại sao vậy? Tại vì tâm không ly dục, ly ác pháp cho nên mới phạm\n      giới. Còn tâm ly dục ly ác pháp thì không bao giờ phạm giới!</em></span></p>\n<p>  (21:36) Cho nên quý Phật tử cũng như các thầy nghe Thiền tông nói:\n  Tự tại vô ngại, đói ăn, khát uống, mệt đi ngủ; rồi thõng tay vào chợ,\n  nào là xách cá quải thịt, nào là uống rượu đủ thứ hết! Cho những vị đó\n  là tự tại rồi, sống vô ngại rồi, không có còn chướng ngại nữa, gọi là\n  giải thoát. Thực sự tu hành rồi mà trở lại sống còn hơn 1 người bê bối\n  – rượu chè say sưa. Sống như vậy có đúng không?</p>\n<p>  1 người tu phải có hạnh của người tu! Người tu gì mà lại rượu chè\n  say sưa – gọi là tự tại; muốn ăn, muốn ngủ hồi nào cũng được hết sao?\n  Giống như người phàm phu – người phàm phu họ cũng muốn ăn, muốn ngủ\n  hồi nào cũng được, có gì đâu!</p>\n<p>  Cho nên ở đây, cái danh từ mà gọi là <em>“tự tại vô ngại”</em> thì\n  Thầy thấy thật sự không phải áp dụng cho người tu sĩ của đạo Phật mà\n  áp dụng cho cái người vào cái sự sống hiện sinh của họ, sống trong cái\n  dục lạc của họ để họ thỏa mãn trong đời sống của họ – họ nói chết là\n  hết rồi, chỉ có đời nay thôi, mình hưởng cho hết dục lạc trên thế gian\n  này, chết thì người nào cũng chết hết. Đó là cái hiểu biết không đúng,\n  cạn cợt, không đúng – chết chưa phải là hết!</p>\n<p>  Và sống không phải có nghĩa là chúng ta sống mà không tái sanh luân\n  hồi. Do học bài đạo đức nhân quả vừa rồi đã xác định cho mấy con thấy\n  1 hành động của chúng ta là sẽ tái sanh làm 1 con vật hoặc là làm con người.</p>\n<p>  Quý vị nhớ kỹ những bài học nhân quả này mà khắc ghi trong lòng để\n  thực hiện đạo đức nhân bản – nhân quả, sống không làm khổ mình, khổ\n  người; tất cả những hành động ác – chúng ta không làm nữa!</p>\n<p>  Cho nên đức Phật nói: <em>“Ngăn ác, Diệt ác – Sanh thiện, Tăng\n    trưởng thiện”</em> hoặc là <em>“Chư ác mạc tác, chúng thiện phụng\n  hành”.</em> Lời nói của đức Phật dạy như vậy, chúng ta hãy cố gắng mà\n  tu tập!</p>\n<p>  Đến đây Thầy xin chấm dứt. Và buổi học hôm nay, mấy con có hỏi gì\n  thì giờ này cứ hỏi, Thầy sẽ trả lời. Bây giờ ai có thắc mắc những gì\n  thì hỏi, mà không thắc mắc thì chúng ta về, vì giờ chúng ta sắp sửa đi\n  khất thực.</p>\n<p>\n  <em>(Trích </em>\n  <a href=\"https://thuvienchonnhu.net/phap-am/LCK-028\">LCK 028D (CHUNG)\n    – HỌC TẬP ĐẠO ĐỨC NHÂN BẢN NHÂN QUẢ – ĐỪNG THEO KIẾN GIẢI ĐẠI THỪA –\n    VẤN ĐẠO LÀM CHỦ NHÂN QUẢ</a>\n  <em>)</em></p>\n','Dai Thua Lo Lot Phi Nhan Qua',NULL,'Đại Thừa Dạy Lo Lót Phi Nhân Quả','Đại Thừa Dạy Lo Lót Phi Nhân Quả','Đại Thừa Dạy Lo Lót Phi Nhân Quả','dai-thua-lo-lot-phi-nhan-qua',1,200),(16,'2026-09-14 14:27:45','2026-09-14 14:27:45',NULL,'<h1>\n  <span class=\"post-title\">Đại Thừa Dạy Lo Lót Phi Nhân Quả, Nuôi Dưỡng\n    Dục Thế Gian Làm Hư Hoại Phật Giáo!</span></h1>\n<p>\n  <span class=\"post-title\">\n    <img alt=\"\" src=\"/static/files/DEFAULT/IMAGE/logo.jpg\" style=\"float: left;margin: 10.0px 20.0px;border-width: 10.0px;border-style: solid;\" /></span></p>\n<p>\n  <a href=\"https://youtu.be/PsrzF2_SGXc?si=9CjwgZqbCWzQYLAi\">https://youtu.be/PsrzF2_SGXc?si=9CjwgZqbCWzQYLAi</a></p>\n<p>  Bây giờ các con thấy – người ta dạy rất sai! Câu chuyện Mục Liên\n  Thanh Đề ở trong bản kinh Vu Lan Bồn – mấy con thấy sai không? Dạy\n  người ta ngày báo hiếu, mà báo hiếu như vậy sao? Báo hiếu bằng cách lo lót!</p>\n<p>  Nghĩa là Phật tử phải lo lót cho quý thầy, cho Phật rồi mới được\n  cứu độ! Như vậy có đúng không?</p>\n<p>  Các con nghe câu chuyện khi mà ông Mục Kiền Liên tu đắc Lục thông –\n  mẹ ông chết, ông mới đi tìm mẹ ông ở dưới địa ngục; ông mới thấy mẹ\n  ông ngồi ở trong địa ngục Ngạ quỷ, đói khát, khổ sở; ông mới bưng bát\n  cơm cho mẹ ông ăn; mẹ ông vừa bốc cơm ăn thì lửa cháy – ăn, nuốt không\n  được. Cái cảnh quá khổ!</p>\n<p>  Cho nên, ông cũng không đủ sức của mình để cứu mẹ. Cho nên ông về\n  xin Phật dạy cho ông cách nào để cứu mẹ ông thoát khỏi địa ngục Ngạ\n  quỷ này.</p>\n<p>  Đức Phật nói: <em>“Ông hãy về sắm tứ sự…​”.</em></p>\n<p>  Rồi sắm tứ sự rồi thì để làm gì? Các con hiểu – khi đó phải đem đến\n  cúng Phật và cúng chư Thánh Tăng – nhờ công đức tu hành của họ, sau 3\n  tháng an cư kiết hạ, tức là rằm tháng Bảy là người ta giải hạ ra, cho\n  nên ngày đó gọi là ngày báo hiếu.</p>\n<p>  Vì vậy cho nên lấy cái câu chuyện Mục Liên Thanh Đề để làm ngày báo\n  hiếu. Bây giờ chúng ta có cái ngày rằm tháng Bảy là ngày báo hiếu, do\n  đó chúng ta lấy cái tích lịch sử của Mục Kiền Liên.</p>\n<p>  Mà thử hỏi, bây giờ phải cúng dường trai Tăng cho chúng Tăng và\n  Phật, rồi nhờ công đức của các Ngài đó mới cứu độ bà Thanh Đề thoát\n  khỏi địa ngục. Như vậy trước khi cứu độ là ông Mục Kiền Liên có phạm\n  cái tội lo lót! Đứng trên pháp luật mà! Đại thừa dạy chúng ta có sự lo\n  lót rõ ràng!</p>\n<p>  Vậy kinh sách đúng không? – Không đúng! Dạy chúng ta làm điều sai –\n  đâu phải dạy chúng ta làm điều đúng!</p>\n<p>  Bà Thanh Đề tạo tội thì bà phải trả cái tội đó cho đến khi bà trả\n  hết tội đó. Thí dụ như bây giờ mình làm cái tội mà mình ở tù 10 năm,\n  thì phải ở tù 10 năm thì Nhà nước sẽ thả mình ra.</p>\n<p>  Còn bà Thanh Đề làm tội thì bà phải ở tù bao nhiêu năm, chịu khổ đó\n  bao nhiêu để trả cái tội của bà – cớ sao lại làm cái chuyện phi đạo\n  đức như vậy? Rồi Phật và chư Thánh Tăng lại ăn lo hối lộ – nhận của đó\n  mới cứu.</p>\n<p>  Vậy thì trong địa ngục Ngạ quỷ này đâu phải có 1 mình bà Thanh Đề,\n  có nhiều bà Thanh Đề chứ không phải 1 bà Thanh Đề! Không lẽ mở địa\n  ngục ra chỉ có nhận bà Thanh Đề, còn bao nhiêu những người không làm ác?</p>\n<p>  Vậy thì ở địa ngục đó rất nhiều người – đức Phật là 1 người công\n  bằng chứ, đạo lý chứ! Bà Thanh Đề khổ thì những người khác cũng khổ y\n  chứ! Tại sao không cứu độ? Các con có nghe chưa? Mình có công đức cứu\n  được mà tại sao không cứu hết những người này, lại chỉ có cứu bà này thôi?</p>\n<p>  Tại vì cái lý do là những người kia không có lo lót! Có phải không?\n  Nếu mà lo lót như ông Mục Kiền Liên thì chắc chắn là phải cứu hết chứ gì?</p>\n<p>  Thôi, như vậy là các thầy Thánh Tăng trong lúc đó với Phật – chắc\n  là tiền của chất đâu cho hết! Bởi vì đụng ai cũng ăn lo lót hết thì\n  phải giàu chứ sao? Bây giờ mới cất villa – biệt thự mà ở.</p>\n<p>  Như vậy hiện giờ chúng ta thấy villa – biệt thự của các chùa như\n  thế nào mấy con thấy không? Cái sự ăn lo đó bây giờ chúng ta thấy chùa\n  hàng tỷ bạc! Chùa nào mà cất dưới tỷ bao giờ đâu? Cái cửa cổng họ vô,\n  Thầy thấy trời ơi nó sang còn hơn!</p>\n<p>  Lấy số tiền đó mà cho đồng bào, cho những người bất hạnh trong xã\n  hội – nội cái cửa cổng của họ thôi, thì Thầy thấy cũng đem lại hạnh\n  phúc cho biết bao nhiêu người. Có đúng không? Mấy con thấy chưa?</p>\n<p>\n  <em>Những điều dạy phi đạo đức vậy mà chúng ta cho kinh sách Đại thừa\n    là đúng sao? Các con cứ suy ngẫm đi!</em></p>\n<p>  Bây giờ Thầy nói về vấn đề Tịnh Độ: các con thấy Đại thừa dạy chúng\n  ta tu tập Tịnh Độ chứ gì? Nghĩa là người nào mà Niệm Phật để cầu về\n  Cực Lạc – dễ dàng quá! Như 48 lời nguyện của đức Phật Di Đà, mấy con\n  có nghe không? <em>“Thiện nam tín nữ các người chí thành tưởng Phật\n    niệm mười tiếng ra. Ta không rước ở nước ta, thệ không làm Phật,\n    chắc đà không sai”.</em></p>\n<p>  Các con có nghe cái lời nguyện của đức Phật Di Đà không? Mấy con\n  chỉ cần niệm 10 tiếng thôi, đừng có niệm nhiều, cũng đủ rồi. Vậy thì\n  mấy con niệm 10 tiếng quá dễ rồi chứ gì?</p>\n<p>  Cho nên bây giờ, tôi niệm cả ngàn tiếng chứ tôi không niệm 10 tiếng\n  đâu! Chắc chắn là Phật Di Đà sẽ sắp xếp cho tôi có cái nhà đâu ở trển\n  rồi đó, mà tôi vừa tắt thở là mang tôi về trển rồi. Vì có 10 tiếng mà\n  ông còn rước, mà bây giờ tôi niệm cả ngàn tiếng rồi, thì chắc ăn rồi\n  chứ còn gì! Các con thấy đúng không? Như vậy quá đúng rồi! Cho nên mọi\n  người đều cùng nhau mà cố gắng niệm Phật.</p>\n<p>  Nhưng thử hỏi, khi mà tâm mấy con còn tham, sân, si, giận hờn mà\n  ông Phật Di Đà mà ông rước về nước ông – chắc chắn mấy con sẽ đánh lộn\n  trên đó hết! Có đúng không?</p>\n<p>  Thì bây giờ ông Phật Di Đà mới thành lập cái tòa án – nước người ta\n  thuở giờ hoàn toàn không có người tham sân si; mà bây giờ rước cái\n  chúng sanh ở dưới thế gian này lên, bây giờ nó có tham, sân, si rồi;\n  cho nên đất thì lát vàng – Thầy nghe trong kinh Di Đà nói mà, đất lát\n  vàng, hàng rào thì âm nhạc; lúc bây giờ chúng ta nghe hát hay quá\n  chúng ta ra nhổ hàng rào đem vô nhà cất hết, bởi vì chúng ta muốn sử\n  dụng mà! Thì các con thấy cái đó có đúng không?</p>\n<p>  Rồi vàng mà lót ở dưới đất như vậy đó, các con thấy vàng ở thế gian\n  này đắt quá; cho nên vì vậy mình cạy, mình cất để mai mốt mình trở về\n  thế gian mình đem bán; thì bây giờ vàng lên quá cao, cho nên mình sẽ\n  giàu sang.</p>\n<p>  1 lần mà đi lên trên đó về, mình ước ao trở về thế gian chứ:\n    <em>“Đặng tôi còn đem bán cái này chứ! Để ở trên tôi đi gom góp, tôi\n    về tôi bán!”.</em> Thì như vậy mấy con thấy cái đó đúng không mấy con?</p>\n<p>  Con người chúng ta phải dọn sạch – tâm chúng ta hết tham, sân, si\n  thì chúng ta sẽ được về đó. Mà tâm chúng ta còn tham, sân, si thì\n  chúng ta về đó sao được mấy con? Làm sao ai chứng cho mình được về đó!\n  Cho nên đâu có dễ dàng được! Mấy con biết các thầy vật lộn với tham,\n  sân, si của mình dường nào không?</p>\n<p>  Các con cứ thử nghĩ cái tâm si của chúng ta nó hiện ra cái tướng\n  hôn trầm, thùy miên, buồn ngủ – mấy con thức 10 giờ, 11 – 12 giờ;\n  chừng mấy con dậy 1 – 2 giờ, mấy con dậy nổi không? Hay là nó lăn qua\n  lộn lại, nó lười biếng, nó nằm đó để nó ráng ngủ thêm? Các con thấy\n  cái si ghê gớm – cái si là tướng lười biếng!</p>\n<p>  Mà ở đây chúng Tăng và quý cư sĩ ở đây tu tập gay go với nó lắm mới\n  thắng nổi! Vậy mà thắng nổi nhưng chưa hẳn đúng pháp thì chưa hẳn nó\n  dứt cơn đâu – nó còn đó, hở ra 1 chút là nó đánh nhẹp liền tức khắc!\n  Tức là chúng ta bị hôn trầm, thùy miên. Các con thấy chưa?</p>\n<p>  Như vậy chúng ta biết rằng kinh sách Nguyên Thủy đúng hay là kinh\n  sách Đại thừa đúng? Đức Phật dạy: <em>“Ngăn ác, Diệt ác – Sanh thiện\n    Tăng trưởng thiện”</em> – sống trong giới luật nghiêm chỉnh thì mới\n  ly dục, ly ác pháp được; mà sống ngoài giới luật thì làm sao ly dục,\n  ly ác pháp được!</p>\n<p>  Mà bây giờ chúng ta sống trong dục lạc, nghe cõi Cực Lạc quá đẹp đẽ\n  – ham mê, thì chúng ta mong chúng ta về đó! Nhưng lòng tham chúng ta\n  hết không – mà không hết thì thử hỏi làm sao chúng ta sống được?</p>\n<p>  Thầy nói thẳng, nói thật thì sẽ mích lòng nhưng phải nói thẳng, nói\n  thật! Dựng lại Phật giáo mà không dám nói thẳng, nói thật thì người ta\n  vẫn cho đó là đúng; mà cho nó là đúng thì người ta sẽ đi theo cái sai.</p>\n<p>  Cho nên Thầy nói như vậy các con sẽ suy ngẫm, tự suy ngẫm; đúng thì\n  mấy con theo – Thầy không ép buộc; được thì mấy con hữu duyên, mà\n  không được thì mấy con chịu chứ không phải riêng Thầy.</p>\n<p>  Còn ở đây Thầy khuyên các thầy nên tu tập đúng theo Thầy hướng dẫn;\n  mà tu tập sai theo kiến giải, tưởng giải của quý thầy thì quý thầy\n  chịu trách nhiệm cái sai của quý thầy.</p>\n<p>  Các Thầy phải hiểu Thầy là 1 người đã kinh nghiệm đi qua trên con\n  đường này, làm chủ được sự sống chết của mình, mà bây giờ đem truyền\n  dạy lại cho quý vị làm chủ sự sống chết cho quý vị. Thì quý vị phải\n  hiểu biết người có kinh nghiệm như vậy, dạy mình sẽ không sai!</p>\n<p>  Cho nên trong kinh sách Phật dạy, bảo mình tìm thiện hữu tri thức –\n  người đó phải hết tham, sân, si; người đó phải chứng đạt được chân lý\n  – đó là Thầy của mình! Người đó phải sống đúng giới luật – giới luật\n  còn là Phật giáo còn, giới luật mất là Phật giáo mất.</p>\n<p>\n  <em>Cho nên chúng ta tìm 1 vị thầy mà giới luật nghiêm chỉnh, không hề\n    vi phạm 1 lỗi nhỏ nhặt nào thì đó là Phật giáo còn. Còn nếu tìm\n    không được thì đương nhiên – dù có trăm ngàn danh từ nói Phật giáo\n    thì Phật giáo đó vẫn sai! Vị thầy chúng ta phạm giới, phá giới mà\n    chúng ta theo tu tập thì chúng ta chẳng làm chủ sanh tử luân hồi.\n    Tại sao vậy? Tại vì tâm không ly dục, ly ác pháp cho nên mới phạm\n    giới. Còn tâm ly dục ly ác pháp thì không bao giờ phạm giới!</em></p>\n<p>  (21:36) Cho nên quý Phật tử cũng như các thầy nghe Thiền tông nói:\n  Tự tại vô ngại, đói ăn, khát uống, mệt đi ngủ; rồi thõng tay vào chợ,\n  nào là xách cá quải thịt, nào là uống rượu đủ thứ hết! Cho những vị đó\n  là tự tại rồi, sống vô ngại rồi, không có còn chướng ngại nữa, gọi là\n  giải thoát. Thực sự tu hành rồi mà trở lại sống còn hơn 1 người bê bối\n  – rượu chè say sưa. Sống như vậy có đúng không?</p>\n<p>  1 người tu phải có hạnh của người tu! Người tu gì mà lại rượu chè\n  say sưa – gọi là tự tại; muốn ăn, muốn ngủ hồi nào cũng được hết sao?\n  Giống như người phàm phu – người phàm phu họ cũng muốn ăn, muốn ngủ\n  hồi nào cũng được, có gì đâu!</p>\n<p>  Cho nên ở đây, cái danh từ mà gọi là <em>“tự tại vô ngại”</em> thì\n  Thầy thấy thật sự không phải áp dụng cho người tu sĩ của đạo Phật mà\n  áp dụng cho cái người vào cái sự sống hiện sinh của họ, sống trong cái\n  dục lạc của họ để họ thỏa mãn trong đời sống của họ – họ nói chết là\n  hết rồi, chỉ có đời nay thôi, mình hưởng cho hết dục lạc trên thế gian\n  này, chết thì người nào cũng chết hết. Đó là cái hiểu biết không đúng,\n  cạn cợt, không đúng – chết chưa phải là hết!</p>\n<p>  Và sống không phải có nghĩa là chúng ta sống mà không tái sanh luân\n  hồi. Do học bài đạo đức nhân quả vừa rồi đã xác định cho mấy con thấy\n  1 hành động của chúng ta là sẽ tái sanh làm 1 con vật hoặc là làm con người.</p>\n<p>  Quý vị nhớ kỹ những bài học nhân quả này mà khắc ghi trong lòng để\n  thực hiện đạo đức nhân bản – nhân quả, sống không làm khổ mình, khổ\n  người; tất cả những hành động ác – chúng ta không làm nữa!</p>\n<p>  Cho nên đức Phật nói: <em>“Ngăn ác, Diệt ác – Sanh thiện, Tăng\n    trưởng thiện”</em> hoặc là <em>“Chư ác mạc tác, chúng thiện phụng\n  hành”.</em> Lời nói của đức Phật dạy như vậy, chúng ta hãy cố gắng mà\n  tu tập!</p>\n<p>  Đến đây Thầy xin chấm dứt. Và buổi học hôm nay, mấy con có hỏi gì\n  thì giờ này cứ hỏi, Thầy sẽ trả lời. Bây giờ ai có thắc mắc những gì\n  thì hỏi, mà không thắc mắc thì chúng ta về, vì giờ chúng ta sắp sửa đi\n  khất thực.</p>\n<p>\n  <em>(Trích </em>\n  <a href=\"https://thuvienchonnhu.net/phap-am/LCK-028\">LCK 028D (CHUNG)\n    – HỌC TẬP ĐẠO ĐỨC NHÂN BẢN NHÂN QUẢ – ĐỪNG THEO KIẾN GIẢI ĐẠI THỪA –\n    VẤN ĐẠO LÀM CHỦ NHÂN QUẢ</a>\n  <em>)</em></p>\n','dai-thua-lo-lot-phi-nhan-qua',NULL,'','Đại Thừa Dạy Lo Lót Phi Nhân Quả','Đại Thừa Dạy Lo Lót Phi Nhân Quả','dai-thua-lo-lot-phi-nhan-qua',2,200),(17,'2026-09-14 14:27:45','2026-09-14 14:27:45',NULL,'<h1>\n  <span class=\"post-title\">Đại Thừa Dạy Lo Lót Phi Nhân Quả, Nuôi Dưỡng\n    Dục Thế Gian Làm Hư Hoại Phật Giáo!</span></h1>\n<p>\n  <span class=\"post-title\">\n    <img alt=\"\" src=\"/static/files/DEFAULT/IMAGE/logo.jpg\" style=\"float: left;margin: 10.0px 20.0px;border-width: 10.0px;border-style: solid;\" /></span></p>\n<p>\n  <a href=\"https://youtu.be/PsrzF2_SGXc?si=9CjwgZqbCWzQYLAi\">https://youtu.be/PsrzF2_SGXc?si=9CjwgZqbCWzQYLAi</a></p>\n<p>  Bây giờ các con thấy – người ta dạy rất sai! Câu chuyện Mục Liên\n  Thanh Đề ở trong bản kinh Vu Lan Bồn – mấy con thấy sai không? Dạy\n  người ta ngày báo hiếu, mà báo hiếu như vậy sao? Báo hiếu bằng cách lo lót!</p>\n<p>  Nghĩa là Phật tử phải lo lót cho quý thầy, cho Phật rồi mới được\n  cứu độ! Như vậy có đúng không?</p>\n<p>  Các con nghe câu chuyện khi mà ông Mục Kiền Liên tu đắc Lục thông –\n  mẹ ông chết, ông mới đi tìm mẹ ông ở dưới địa ngục; ông mới thấy mẹ\n  ông ngồi ở trong địa ngục Ngạ quỷ, đói khát, khổ sở; ông mới bưng bát\n  cơm cho mẹ ông ăn; mẹ ông vừa bốc cơm ăn thì lửa cháy – ăn, nuốt không\n  được. Cái cảnh quá khổ!</p>\n<p>  Cho nên, ông cũng không đủ sức của mình để cứu mẹ. Cho nên ông về\n  xin Phật dạy cho ông cách nào để cứu mẹ ông thoát khỏi địa ngục Ngạ\n  quỷ này.</p>\n<p>  Đức Phật nói: <em>“Ông hãy về sắm tứ sự…​”.</em></p>\n<p>  Rồi sắm tứ sự rồi thì để làm gì? Các con hiểu – khi đó phải đem đến\n  cúng Phật và cúng chư Thánh Tăng – nhờ công đức tu hành của họ, sau 3\n  tháng an cư kiết hạ, tức là rằm tháng Bảy là người ta giải hạ ra, cho\n  nên ngày đó gọi là ngày báo hiếu.</p>\n<p>  Vì vậy cho nên lấy cái câu chuyện Mục Liên Thanh Đề để làm ngày báo\n  hiếu. Bây giờ chúng ta có cái ngày rằm tháng Bảy là ngày báo hiếu, do\n  đó chúng ta lấy cái tích lịch sử của Mục Kiền Liên.</p>\n<p>  Mà thử hỏi, bây giờ phải cúng dường trai Tăng cho chúng Tăng và\n  Phật, rồi nhờ công đức của các Ngài đó mới cứu độ bà Thanh Đề thoát\n  khỏi địa ngục. Như vậy trước khi cứu độ là ông Mục Kiền Liên có phạm\n  cái tội lo lót! Đứng trên pháp luật mà! Đại thừa dạy chúng ta có sự lo\n  lót rõ ràng!</p>\n<p>  Vậy kinh sách đúng không? – Không đúng! Dạy chúng ta làm điều sai –\n  đâu phải dạy chúng ta làm điều đúng!</p>\n<p>  Bà Thanh Đề tạo tội thì bà phải trả cái tội đó cho đến khi bà trả\n  hết tội đó. Thí dụ như bây giờ mình làm cái tội mà mình ở tù 10 năm,\n  thì phải ở tù 10 năm thì Nhà nước sẽ thả mình ra.</p>\n<p>  Còn bà Thanh Đề làm tội thì bà phải ở tù bao nhiêu năm, chịu khổ đó\n  bao nhiêu để trả cái tội của bà – cớ sao lại làm cái chuyện phi đạo\n  đức như vậy? Rồi Phật và chư Thánh Tăng lại ăn lo hối lộ – nhận của đó\n  mới cứu.</p>\n<p>  Vậy thì trong địa ngục Ngạ quỷ này đâu phải có 1 mình bà Thanh Đề,\n  có nhiều bà Thanh Đề chứ không phải 1 bà Thanh Đề! Không lẽ mở địa\n  ngục ra chỉ có nhận bà Thanh Đề, còn bao nhiêu những người không làm ác?</p>\n<p>  Vậy thì ở địa ngục đó rất nhiều người – đức Phật là 1 người công\n  bằng chứ, đạo lý chứ! Bà Thanh Đề khổ thì những người khác cũng khổ y\n  chứ! Tại sao không cứu độ? Các con có nghe chưa? Mình có công đức cứu\n  được mà tại sao không cứu hết những người này, lại chỉ có cứu bà này thôi?</p>\n<p>  Tại vì cái lý do là những người kia không có lo lót! Có phải không?\n  Nếu mà lo lót như ông Mục Kiền Liên thì chắc chắn là phải cứu hết chứ gì?</p>\n<p>  Thôi, như vậy là các thầy Thánh Tăng trong lúc đó với Phật – chắc\n  là tiền của chất đâu cho hết! Bởi vì đụng ai cũng ăn lo lót hết thì\n  phải giàu chứ sao? Bây giờ mới cất villa – biệt thự mà ở.</p>\n<p>  Như vậy hiện giờ chúng ta thấy villa – biệt thự của các chùa như\n  thế nào mấy con thấy không? Cái sự ăn lo đó bây giờ chúng ta thấy chùa\n  hàng tỷ bạc! Chùa nào mà cất dưới tỷ bao giờ đâu? Cái cửa cổng họ vô,\n  Thầy thấy trời ơi nó sang còn hơn!</p>\n<p>  Lấy số tiền đó mà cho đồng bào, cho những người bất hạnh trong xã\n  hội – nội cái cửa cổng của họ thôi, thì Thầy thấy cũng đem lại hạnh\n  phúc cho biết bao nhiêu người. Có đúng không? Mấy con thấy chưa?</p>\n<p>\n  <em>Những điều dạy phi đạo đức vậy mà chúng ta cho kinh sách Đại thừa\n    là đúng sao? Các con cứ suy ngẫm đi!</em></p>\n<p>  Bây giờ Thầy nói về vấn đề Tịnh Độ: các con thấy Đại thừa dạy chúng\n  ta tu tập Tịnh Độ chứ gì? Nghĩa là người nào mà Niệm Phật để cầu về\n  Cực Lạc – dễ dàng quá! Như 48 lời nguyện của đức Phật Di Đà, mấy con\n  có nghe không? <em>“Thiện nam tín nữ các người chí thành tưởng Phật\n    niệm mười tiếng ra. Ta không rước ở nước ta, thệ không làm Phật,\n    chắc đà không sai”.</em></p>\n<p>  Các con có nghe cái lời nguyện của đức Phật Di Đà không? Mấy con\n  chỉ cần niệm 10 tiếng thôi, đừng có niệm nhiều, cũng đủ rồi. Vậy thì\n  mấy con niệm 10 tiếng quá dễ rồi chứ gì?</p>\n<p>  Cho nên bây giờ, tôi niệm cả ngàn tiếng chứ tôi không niệm 10 tiếng\n  đâu! Chắc chắn là Phật Di Đà sẽ sắp xếp cho tôi có cái nhà đâu ở trển\n  rồi đó, mà tôi vừa tắt thở là mang tôi về trển rồi. Vì có 10 tiếng mà\n  ông còn rước, mà bây giờ tôi niệm cả ngàn tiếng rồi, thì chắc ăn rồi\n  chứ còn gì! Các con thấy đúng không? Như vậy quá đúng rồi! Cho nên mọi\n  người đều cùng nhau mà cố gắng niệm Phật.</p>\n<p>  Nhưng thử hỏi, khi mà tâm mấy con còn tham, sân, si, giận hờn mà\n  ông Phật Di Đà mà ông rước về nước ông – chắc chắn mấy con sẽ đánh lộn\n  trên đó hết! Có đúng không?</p>\n<p>  Thì bây giờ ông Phật Di Đà mới thành lập cái tòa án – nước người ta\n  thuở giờ hoàn toàn không có người tham sân si; mà bây giờ rước cái\n  chúng sanh ở dưới thế gian này lên, bây giờ nó có tham, sân, si rồi;\n  cho nên đất thì lát vàng – Thầy nghe trong kinh Di Đà nói mà, đất lát\n  vàng, hàng rào thì âm nhạc; lúc bây giờ chúng ta nghe hát hay quá\n  chúng ta ra nhổ hàng rào đem vô nhà cất hết, bởi vì chúng ta muốn sử\n  dụng mà! Thì các con thấy cái đó có đúng không?</p>\n<p>  Rồi vàng mà lót ở dưới đất như vậy đó, các con thấy vàng ở thế gian\n  này đắt quá; cho nên vì vậy mình cạy, mình cất để mai mốt mình trở về\n  thế gian mình đem bán; thì bây giờ vàng lên quá cao, cho nên mình sẽ\n  giàu sang.</p>\n<p>  1 lần mà đi lên trên đó về, mình ước ao trở về thế gian chứ:\n    <em>“Đặng tôi còn đem bán cái này chứ! Để ở trên tôi đi gom góp, tôi\n    về tôi bán!”.</em> Thì như vậy mấy con thấy cái đó đúng không mấy con?</p>\n<p>  Con người chúng ta phải dọn sạch – tâm chúng ta hết tham, sân, si\n  thì chúng ta sẽ được về đó. Mà tâm chúng ta còn tham, sân, si thì\n  chúng ta về đó sao được mấy con? Làm sao ai chứng cho mình được về đó!\n  Cho nên đâu có dễ dàng được! Mấy con biết các thầy vật lộn với tham,\n  sân, si của mình dường nào không?</p>\n<p>  Các con cứ thử nghĩ cái tâm si của chúng ta nó hiện ra cái tướng\n  hôn trầm, thùy miên, buồn ngủ – mấy con thức 10 giờ, 11 – 12 giờ;\n  chừng mấy con dậy 1 – 2 giờ, mấy con dậy nổi không? Hay là nó lăn qua\n  lộn lại, nó lười biếng, nó nằm đó để nó ráng ngủ thêm? Các con thấy\n  cái si ghê gớm – cái si là tướng lười biếng!</p>\n<p>  Mà ở đây chúng Tăng và quý cư sĩ ở đây tu tập gay go với nó lắm mới\n  thắng nổi! Vậy mà thắng nổi nhưng chưa hẳn đúng pháp thì chưa hẳn nó\n  dứt cơn đâu – nó còn đó, hở ra 1 chút là nó đánh nhẹp liền tức khắc!\n  Tức là chúng ta bị hôn trầm, thùy miên. Các con thấy chưa?</p>\n<p>  Như vậy chúng ta biết rằng kinh sách Nguyên Thủy đúng hay là kinh\n  sách Đại thừa đúng? Đức Phật dạy: <em>“Ngăn ác, Diệt ác – Sanh thiện\n    Tăng trưởng thiện”</em> – sống trong giới luật nghiêm chỉnh thì mới\n  ly dục, ly ác pháp được; mà sống ngoài giới luật thì làm sao ly dục,\n  ly ác pháp được!</p>\n<p>  Mà bây giờ chúng ta sống trong dục lạc, nghe cõi Cực Lạc quá đẹp đẽ\n  – ham mê, thì chúng ta mong chúng ta về đó! Nhưng lòng tham chúng ta\n  hết không – mà không hết thì thử hỏi làm sao chúng ta sống được?</p>\n<p>  Thầy nói thẳng, nói thật thì sẽ mích lòng nhưng phải nói thẳng, nói\n  thật! Dựng lại Phật giáo mà không dám nói thẳng, nói thật thì người ta\n  vẫn cho đó là đúng; mà cho nó là đúng thì người ta sẽ đi theo cái sai.</p>\n<p>  Cho nên Thầy nói như vậy các con sẽ suy ngẫm, tự suy ngẫm; đúng thì\n  mấy con theo – Thầy không ép buộc; được thì mấy con hữu duyên, mà\n  không được thì mấy con chịu chứ không phải riêng Thầy.</p>\n<p>  Còn ở đây Thầy khuyên các thầy nên tu tập đúng theo Thầy hướng dẫn;\n  mà tu tập sai theo kiến giải, tưởng giải của quý thầy thì quý thầy\n  chịu trách nhiệm cái sai của quý thầy.</p>\n<p>  Các Thầy phải hiểu Thầy là 1 người đã kinh nghiệm đi qua trên con\n  đường này, làm chủ được sự sống chết của mình, mà bây giờ đem truyền\n  dạy lại cho quý vị làm chủ sự sống chết cho quý vị. Thì quý vị phải\n  hiểu biết người có kinh nghiệm như vậy, dạy mình sẽ không sai!</p>\n<p>  Cho nên trong kinh sách Phật dạy, bảo mình tìm thiện hữu tri thức –\n  người đó phải hết tham, sân, si; người đó phải chứng đạt được chân lý\n  – đó là Thầy của mình! Người đó phải sống đúng giới luật – giới luật\n  còn là Phật giáo còn, giới luật mất là Phật giáo mất.</p>\n<p>\n  <em>Cho nên chúng ta tìm 1 vị thầy mà giới luật nghiêm chỉnh, không hề\n    vi phạm 1 lỗi nhỏ nhặt nào thì đó là Phật giáo còn. Còn nếu tìm\n    không được thì đương nhiên – dù có trăm ngàn danh từ nói Phật giáo\n    thì Phật giáo đó vẫn sai! Vị thầy chúng ta phạm giới, phá giới mà\n    chúng ta theo tu tập thì chúng ta chẳng làm chủ sanh tử luân hồi.\n    Tại sao vậy? Tại vì tâm không ly dục, ly ác pháp cho nên mới phạm\n    giới. Còn tâm ly dục ly ác pháp thì không bao giờ phạm giới!</em></p>\n<p>  (21:36) Cho nên quý Phật tử cũng như các thầy nghe Thiền tông nói:\n  Tự tại vô ngại, đói ăn, khát uống, mệt đi ngủ; rồi thõng tay vào chợ,\n  nào là xách cá quải thịt, nào là uống rượu đủ thứ hết! Cho những vị đó\n  là tự tại rồi, sống vô ngại rồi, không có còn chướng ngại nữa, gọi là\n  giải thoát. Thực sự tu hành rồi mà trở lại sống còn hơn 1 người bê bối\n  – rượu chè say sưa. Sống như vậy có đúng không?</p>\n<p>  1 người tu phải có hạnh của người tu! Người tu gì mà lại rượu chè\n  say sưa – gọi là tự tại; muốn ăn, muốn ngủ hồi nào cũng được hết sao?\n  Giống như người phàm phu – người phàm phu họ cũng muốn ăn, muốn ngủ\n  hồi nào cũng được, có gì đâu!</p>\n<p>  Cho nên ở đây, cái danh từ mà gọi là <em>“tự tại vô ngại”</em> thì\n  Thầy thấy thật sự không phải áp dụng cho người tu sĩ của đạo Phật mà\n  áp dụng cho cái người vào cái sự sống hiện sinh của họ, sống trong cái\n  dục lạc của họ để họ thỏa mãn trong đời sống của họ – họ nói chết là\n  hết rồi, chỉ có đời nay thôi, mình hưởng cho hết dục lạc trên thế gian\n  này, chết thì người nào cũng chết hết. Đó là cái hiểu biết không đúng,\n  cạn cợt, không đúng – chết chưa phải là hết!</p>\n<p>  Và sống không phải có nghĩa là chúng ta sống mà không tái sanh luân\n  hồi. Do học bài đạo đức nhân quả vừa rồi đã xác định cho mấy con thấy\n  1 hành động của chúng ta là sẽ tái sanh làm 1 con vật hoặc là làm con người.</p>\n<p>  Quý vị nhớ kỹ những bài học nhân quả này mà khắc ghi trong lòng để\n  thực hiện đạo đức nhân bản – nhân quả, sống không làm khổ mình, khổ\n  người; tất cả những hành động ác – chúng ta không làm nữa!</p>\n<p>  Cho nên đức Phật nói: <em>“Ngăn ác, Diệt ác – Sanh thiện, Tăng\n    trưởng thiện”</em> hoặc là <em>“Chư ác mạc tác, chúng thiện phụng\n  hành”.</em> Lời nói của đức Phật dạy như vậy, chúng ta hãy cố gắng mà\n  tu tập!</p>\n<p>  Đến đây Thầy xin chấm dứt. Và buổi học hôm nay, mấy con có hỏi gì\n  thì giờ này cứ hỏi, Thầy sẽ trả lời. Bây giờ ai có thắc mắc những gì\n  thì hỏi, mà không thắc mắc thì chúng ta về, vì giờ chúng ta sắp sửa đi\n  khất thực.</p>\n<p>\n  <em>(Trích </em>\n  <a href=\"https://thuvienchonnhu.net/phap-am/LCK-028\">LCK 028D (CHUNG)\n    – HỌC TẬP ĐẠO ĐỨC NHÂN BẢN NHÂN QUẢ – ĐỪNG THEO KIẾN GIẢI ĐẠI THỪA –\n    VẤN ĐẠO LÀM CHỦ NHÂN QUẢ</a>\n  <em>)</em></p>\n','Đại Thừa Lo Lót Phi Nhân Quả',NULL,'dai-thua-lo-lot-phi-nhan-qua','Đại Thừa Lo Lót Phi Nhân Quả','Đại Thừa Lo Lót Phi Nhân Quả','dai-thua-lo-lot-phi-nhan-qua',3,200),(18,'2026-09-14 14:27:45','2026-09-14 14:27:45',NULL,'<h1>   </h1>\n<p>\n  <span>大乘教导贿赂非因果，滋养世间欲望损坏佛教！</span></p>\n<h1>\n  <img src=\"http://localhost:8080/static/files/DEFAULT/IMAGE/logo.jpg\" style=\"float: left;margin: 10.0px 20.0px;border-width: 10.0px;border-style: solid;\" /></h1>\n<p>\n  <span>\n    <a href=\"https://youtu.be/PsrzF2_SGXc?si=9CjwgZqbCWzQYLAi\">https://youtu.be/PsrzF2_SGXc?si=9CjwgZqbCWzQYLAi</a></span></p>\n<p>   </p>\n<p>\n  <span>现在你们看到了——人们教得非常不对！《盂兰盆经》里目连与青提的故事——孩子们，你们觉得不对吗？教导人们报恩，却这样去报恩吗？以“贿赂”的方式去报恩！</span></p>\n<p>\n  <span>意思是说，信徒必须先去贿赂诸位法师、贿赂佛陀，然后才能得到救度！这样讲对吗？</span></p>\n<p>\n  <span>你们听过这个故事：当目犍尊者修得六神通后，他的母亲去世了，他就去地狱寻找母亲；他看到母亲身在饿鬼地狱中，饥渴交迫，痛苦万分；他便端了一碗饭给母亲吃；他母亲刚伸手拿饭要吃，饭菜就化作烈火——吃不下，咽不进。那场景太痛苦了！</span></p>\n<p>\n  <span>因此，憑他自己的力量也不足以救度母亲。于是他回来请求佛陀指点，有何方法能救母亲脱离这饿鬼地狱。</span></p>\n<p>\n  <span>释迦牟尼佛说：“你回去准备四事供养……”</span></p>\n<p>\n  <span>准备了四事供养后用来做什么？你们要明白——那时必须拿去供养佛陀和诸圣僧——借助他们经三月安居结夏后（即七月十五解夏出关）的修行功德，所以这一天被称为“报恩日”。</span></p>\n<p>\n  <span>正因如此，人们借用“目连救母（青提）”的故事来作为报恩日。现在我们把七月十五作为报恩日，就是引用了目犍连的历史典故。</span></p>\n<p>\n  <span>但是试问，现在必须设斋供僧、供养诸僧与佛，然后再借助诸位的功德去救青提妇脱离地狱。这样一来，在救度之前，目犍连尊者岂不是犯了“行贿”之罪？站在法律的角度来看！大乘教导我们的显然就是一种行贿行为！</span></p>\n<p>\n  <span>那么，经典写得对吗？——不对！教我们做错的事——哪里是教我们做对的事！</span></p>\n<p>\n  <span>青提妇造了罪业，她就必须去偿还那个罪业，直到还清为止。比方说，现在我们犯了罪要坐牢10年，那就必须坐满10年牢，政府才会放我们出来。</span></p>\n<p>\n  <span>而青提妇造了罪，她就该坐牢多少年、受多少苦来偿还她的罪——凭什么去做这种违背道德的事？然后佛陀和诸圣僧居然还接受贿赂——收了东西才肯去救。</span></p>\n<p>\n  <span>那么，在这饿鬼地狱里又不是只有青提妇一个人，还有许许多多的“青提妇”，绝非仅此一人！难道打开地狱的大门，只接收青提妇，而不管其他许许多多没造恶的人吗？</span></p>\n<p>\n  <span>所以说地狱里有那么多人——佛陀应当是一个公平、讲道理的人啊！青提妇受苦，其他人也同样在受苦啊！为什么不救度他们？你们听到了吗？我们既然有功德能救，为什么不把这些人全部救出来，而偏偏只救她一个人？</span></p>\n<p>\n  <span>原因不就是其他人没有去“贿赂”吗？是不是？如果大家都像目犍连那样去行贿，那肯定全部都要救了，对不对？</span></p>\n<p>\n  <span>哎，照这样看，当时的圣僧们和佛陀——那钱财该堆到哪里才堆得下啊？因为碰到谁都收贿赂，那肯定富甲一方了！现在早该盖洋房、建别墅来住了。</span></p>\n<p>\n  <span>所以现在你们看看，各个寺庙的洋房、别墅是什么样子的，你们看到了吗？这种“受贿”的风气，现在让我们看到价值数十亿的寺庙！哪有哪座寺庙盖得低于十亿的？光看他们进门的大门，师父看了，天呐，比什么都豪华！</span></p>\n<p>\n  <span>如果把那些钱拿去给同胞、给社会上不幸的人——光是他们一个大门的花费，师父看就能给许许多多人带来幸福了。对不对？你们看到了没有？</span></p>\n<p>\n  <span>教导这些违背道德的事，我们难道还能认为大乘经典是对的吗？你们好好去思考吧！</span></p>\n<p>\n  <span>现在师父谈谈净土的问题：你们看到大乘教我们修持净土，对吧？意思是说，无论谁念佛求生极乐——太容易了！就像阿弥陀佛的四十八大愿，你们听过吗？“善男子善女人，若能至心念我名号十声，若不生我国，誓不成佛，决无虚言。”</span></p>\n<p>\n  <span>你们听过阿弥陀佛的誓愿了吗？你们只需要念十声，不用念多，就足够了。那你们念十声岂不是太容易了吗？</span></p>\n<p>\n  <span>所以现在，我念成千上声，我不止念十声！阿弥陀佛肯定已经在上面给我安排好房子住了，我只要一断气就把我接上去了。因为念十声他都来接，现在我都念了上千声了，那岂不是稳妥妥的了吗！你们觉得对不对？简直太对了！所以大家才一起拼命念佛。</span></p>\n<p>\n  <span>但是试问，当你们的心里还有贪、嗔、痴、嗔恨的时候，阿弥陀佛把你接去他的国家——你们肯定会在上面打起来！对不对？</span></p>\n<p>\n  <span>那到时候阿弥陀佛就得设立法院了——人家那个国家自古以来完全没有贪嗔痴的人；现在把世间的这些众生接上去，现在他们带着贪、嗔、痴来了；而且那里黄金铺地——师父听《阿弥陀经》里讲的，黄金铺地，篱笆奏乐；到时候我们听音乐太动听了，就把篱笆拔掉搬回自己家里存着，因为我们想用啊！那你们看这像话吗？</span></p>\n<p>\n  <span>还有铺在地上的黄金，你们看世间的黄金多贵啊；所以我们就去撬下来保存好，等哪天回到世间再拿去卖；现在金价涨得这么高，我们就能发财致富了。</span></p>\n<p>\n  <span>去了一趟上面回来，我们肯定盼着回世间：“好让我把这东西拿去卖！留在上面我到处收集，带回来卖！”那你们看，这样合理吗，孩子们？</span></p>\n<p>\n  <span>我们人必须先清理干净——我们的内心断尽了贪、嗔、痴，我们才能去到那里。如果我们心中还有贪、嗔、痴，我们怎么去得了呢，孩子们？谁能给我们证明可以去那里！所以哪有那么容易！你们知道诸位比丘与自己的贪、嗔、痴搏斗得有多辛苦吗？</span></p>\n<p>\n  <span>你们试想想，我们心中的“痴”显现为昏沉、睡眠、打瞌睡的相状——你们熬夜到10点、11点、12点；等叫你们1、2点起来，你们起得来吗？还是翻来覆去、偷懒，躺在那里硬要多睡一会儿？你们看这个“痴”多可怕——“痴”就是懒惰的相状！</span></p>\n<p>\n  <span>而在这里，诸位僧众和居士们在这里修持，跟它作了艰苦的斗争才能战胜它！即便战胜了，如果方法不完全对，也未必能根断——它还在那里，稍微一疏忽，它立刻就打过来！也就是我们陷人了昏沉、睡眠。你们看到了吗？</span></p>\n<p>\n  <span>因此，我们知道到底原始经典是对的，还是大乘经典是对的？佛陀教导：“已生恶令断，未生恶令不生；未生善令生，已生善令增长”——严持戒律地生活，才能离欲、离恶法；而生活在戒律之外，又怎能离欲、离恶法呢！</span></p>\n<p>\n  <span>可现在我们生活在五欲乐中，听说极乐世界无比美好——产生贪爱，便渴望去到那里！但我们的贪心断了吗——如果不断，试问我们怎么生活？</span></p>\n<p>\n  <span>师父说直话、说真话可能会伤人，但必须说直话、说真话！重振正法若不敢说直话、说真话，人们依然会认为那是对的；而一旦认为是对的，人们就会跟着错下去。</span></p>\n<p>\n  <span>所以师父这样说，你们去思考，自己去思考；对的你们就跟随——师父不强求；能做到是你们有善缘，做不到也是你们自己承担，而非师父个人。</span></p>\n<p>\n  <span>至于在这里，师父劝各位比丘应当按照师父的指导好好修持；如果按照你们自己的见解、妄想去错修，那你们要为自己的错误负责。</span></p>\n<p>\n  <span>诸位比丘必须明白，师父是一个过来人，已经亲自走过这条路，能够做主自己的生死，现在把做主生死的法门传授给各位。那各位就必须明白，跟随这样有经验的人，教给你们的绝不会错！</span></p>\n<p>\n  <span>所以佛经中教导我们去找“善知识”——那个人必须断尽贪、嗔、痴；那个人必须亲证真理——那才是我们的老师！那个人必须严持戒律——戒律在则正法在，戒律灭则正法灭。</span></p>\n<p>\n\n  <span>因此，我们去找一位戒律精严、绝不犯一丝一毫微细过失的老师，那就是正法尚存。如果找不到，那理所当然——即便冠以成千上万个“佛教”的名词，那个“佛教”依然是错\n    include 的！我们的老师犯戒、破戒，而我们还跟着他修持，那我们就无法做主生死轮回。为什么呢？因为心没有离欲、离恶法，所以才会犯戒。而心若离欲、离恶法，就绝不会犯戒！</span></p>\n<p>\n  <span>（21:36）所以，诸位位位信士以及诸位比丘听到禅宗说：自在无碍，饥来吃饭，渴来饮水，困来即眠；然后“垂手入肆”，一会儿提鱼挂肉，一会儿饮酒弄欢，无所不为！认为那些人就是自在了、生活无碍了、不再有障碍了，称之为解脱。实际上修行到了最后，回来生活得比一个邋遢小人还不如——酗酒闹事。这样生活对吗？</span></p>\n<p>\n  <span>一个修行人必须有修行人的德行！什么修行人居然酗酒闹事——还称之为自在；想什么时候吃、什么时候睡都可以？那跟凡夫有什么两样——凡夫他们也想什么时候吃、什么时候睡都可以啊，有什么大不了的！</span></p>\n<p>\n  <span>所以在我们这里，所谓“自在无碍”这个词，师父看到它根本不是用来指代佛教修道者的，而是指代那些陷入现实生活、沉溺于自身欲望享受的人，为了满足他们自己的生活——他们说死了就一了百了了，只有这一世，我们要享尽世间的所有欲乐，反正人都是要死的。那是极其错误、浅薄的认知——死绝非一了百了！</span></p>\n<p>\n  <span>而且，活着并不意味着我们可以不再投生轮回。通过学习刚才的因果道德课，已经明确地向你们展示了：我们的一举一动都会投生为一只动物，或者重新做人。</span></p>\n<p>\n  <span>请诸位牢记这些因果课程，刻在心里，去践行人类的基本道德——因果，生活不伤害自己，不伤害他人；一切恶行——我们绝不再做！</span></p>\n<p>\n  <span>所以佛陀说：“诸恶莫作，众善奉行”或“已生恶令断，未生恶令不生；未生善令生，已生善令增长”。佛陀给我们的教诲就是这样，大家请努力修持吧！</span></p>\n<p>\n  <span>讲到这里师父就结束了。今天的课程，大家有什么疑问现在可以提问，师父来解答。现在谁有疑问就问，没有疑问我们就回去，因为我们准备去托钵了。</span></p>\n<p>\n  <span>\n    <i>（摘自 LCK 028D (CHUNG) – 学习因果人类道德 – 切勿跟随大乘见解 – 问答：做主因果）</i></span></p>\n','Đại Thừa Lo Lót Phi Nhân Quả',NULL,'Đại Thừa Lo Lót Phi Nhân Quả','Đại Thừa Lo Lót Phi Nhân Quả','Đại Thừa Lo Lót Phi Nhân Quả','dai-thua-lo-lot-phi-nhan-qua',4,200),(19,'2026-09-18 06:43:01','2026-09-18 06:43:01',NULL,'','安乐缘',NULL,'','',NULL,NULL,4,50);
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
INSERT INTO `COUNTRY` VALUES (1,'AF',_binary '',NULL),(2,'AX',_binary '',NULL),(3,'AL',_binary '',NULL),(4,'DZ',_binary '',NULL),(5,'AS',_binary '',NULL),(6,'AD',_binary '',NULL),(7,'AO',_binary '',NULL),(8,'AI',_binary '',NULL),(9,'AG',_binary '',NULL),(10,'AR',_binary '',NULL),(11,'AM',_binary '',NULL),(12,'AW',_binary '',NULL),(13,'AU',_binary '',NULL),(14,'AT',_binary '',NULL),(15,'AZ',_binary '',NULL),(16,'BS',_binary '',NULL),(17,'BH',_binary '',NULL),(18,'BD',_binary '',NULL),(19,'BB',_binary '',NULL),(20,'BY',_binary '',NULL),(21,'BE',_binary '',NULL),(22,'BZ',_binary '',NULL),(23,'BJ',_binary '',NULL),(24,'BM',_binary '',NULL),(25,'BT',_binary '',NULL),(26,'BO',_binary '',NULL),(27,'BA',_binary '',NULL),(28,'BW',_binary '',NULL),(29,'BR',_binary '',NULL),(30,'IO',_binary '',NULL),(31,'BN',_binary '',NULL),(32,'BG',_binary '',NULL),(33,'BF',_binary '',NULL),(34,'BI',_binary '',NULL),(35,'KH',_binary '',NULL),(36,'CM',_binary '',NULL),(37,'CA',_binary '',NULL),(38,'CV',_binary '',NULL),(39,'KY',_binary '',NULL),(40,'CF',_binary '',NULL),(41,'TD',_binary '',NULL),(42,'CL',_binary '',NULL),(43,'CN',_binary '',NULL),(44,'CX',_binary '',NULL),(45,'CC',_binary '',NULL),(46,'CO',_binary '',NULL),(47,'KM',_binary '',NULL),(48,'CG',_binary '',NULL),(49,'CD',_binary '',NULL),(50,'CK',_binary '',NULL),(51,'CR',_binary '',NULL),(52,'CI',_binary '',NULL),(53,'HR',_binary '',NULL),(54,'CU',_binary '',NULL),(55,'CY',_binary '',NULL),(56,'CZ',_binary '',NULL),(57,'DK',_binary '',NULL),(58,'DJ',_binary '',NULL),(59,'DM',_binary '',NULL),(60,'DO',_binary '',NULL),(61,'EC',_binary '',NULL),(62,'EG',_binary '',NULL),(63,'SV',_binary '',NULL),(64,'GQ',_binary '',NULL),(65,'ER',_binary '',NULL),(66,'EE',_binary '',NULL),(67,'ET',_binary '',NULL),(68,'FK',_binary '',NULL),(69,'FO',_binary '',NULL),(70,'FJ',_binary '',NULL),(71,'FI',_binary '',NULL),(72,'FR',_binary '',NULL),(73,'GF',_binary '',NULL),(74,'PF',_binary '',NULL),(75,'GA',_binary '',NULL),(76,'GM',_binary '',NULL),(77,'GE',_binary '',NULL),(78,'DE',_binary '',NULL),(79,'GH',_binary '',NULL),(80,'GI',_binary '',NULL),(81,'GR',_binary '',NULL),(82,'GL',_binary '',NULL),(83,'GD',_binary '',NULL),(84,'GP',_binary '',NULL),(85,'GU',_binary '',NULL),(86,'GT',_binary '',NULL),(87,'GG',_binary '',NULL),(88,'GN',_binary '',NULL),(89,'GW',_binary '',NULL),(90,'GY',_binary '',NULL),(91,'HT',_binary '',NULL),(92,'VA',_binary '',NULL),(93,'HN',_binary '',NULL),(94,'HK',_binary '',NULL),(95,'HU',_binary '',NULL),(96,'IS',_binary '',NULL),(97,'IN',_binary '',NULL),(98,'ID',_binary '',NULL),(99,'IR',_binary '',NULL),(100,'IQ',_binary '',NULL),(101,'IE',_binary '',NULL),(102,'IM',_binary '',NULL),(103,'IL',_binary '',NULL),(104,'IT',_binary '',NULL),(105,'JM',_binary '',NULL),(106,'JP',_binary '',NULL),(107,'JE',_binary '',NULL),(108,'JO',_binary '',NULL),(109,'KZ',_binary '',NULL),(110,'KE',_binary '',NULL),(111,'KI',_binary '',NULL),(112,'KP',_binary '',NULL),(113,'KR',_binary '',NULL),(114,'KW',_binary '',NULL),(115,'KG',_binary '',NULL),(116,'LA',_binary '',NULL),(117,'LV',_binary '',NULL),(118,'LB',_binary '',NULL),(119,'LS',_binary '',NULL),(120,'LR',_binary '',NULL),(121,'LY',_binary '',NULL),(122,'LI',_binary '',NULL),(123,'LT',_binary '',NULL),(124,'LU',_binary '',NULL),(125,'MO',_binary '',NULL),(126,'MK',_binary '',NULL),(127,'MG',_binary '',NULL),(128,'MW',_binary '',NULL),(129,'MY',_binary '',NULL),(130,'ML',_binary '',NULL),(131,'MT',_binary '',NULL),(132,'MH',_binary '',NULL),(133,'MQ',_binary '',NULL),(134,'MR',_binary '',NULL),(135,'MU',_binary '',NULL),(136,'YT',_binary '',NULL),(137,'MX',_binary '',NULL),(138,'FM',_binary '',NULL),(139,'MD',_binary '',NULL),(140,'MC',_binary '',NULL),(141,'MN',_binary '',NULL),(142,'ME',_binary '',NULL),(143,'MS',_binary '',NULL),(144,'MA',_binary '',NULL),(145,'MZ',_binary '',NULL),(146,'MM',_binary '',NULL),(147,'NA',_binary '',NULL),(148,'NR',_binary '',NULL),(149,'NP',_binary '',NULL),(150,'NL',_binary '',NULL),(151,'NC',_binary '',NULL),(152,'NZ',_binary '',NULL),(153,'NI',_binary '',NULL),(154,'NE',_binary '',NULL),(155,'NG',_binary '',NULL),(156,'NU',_binary '',NULL),(157,'NF',_binary '',NULL),(158,'MP',_binary '',NULL),(159,'NO',_binary '',NULL),(160,'OM',_binary '',NULL),(161,'PK',_binary '',NULL),(162,'PW',_binary '',NULL),(163,'PS',_binary '',NULL),(164,'PA',_binary '',NULL),(165,'PG',_binary '',NULL),(166,'PY',_binary '',NULL),(167,'PE',_binary '',NULL),(168,'PH',_binary '',NULL),(169,'PN',_binary '',NULL),(170,'PL',_binary '',NULL),(171,'PT',_binary '',NULL),(172,'PR',_binary '',NULL),(173,'QA',_binary '',NULL),(174,'RE',_binary '',NULL),(175,'RO',_binary '',NULL),(176,'RU',_binary '',NULL),(177,'RW',_binary '',NULL),(178,'SH',_binary '',NULL),(179,'KN',_binary '',NULL),(180,'LC',_binary '',NULL),(181,'PM',_binary '',NULL),(182,'VC',_binary '',NULL),(183,'WS',_binary '',NULL),(184,'SM',_binary '',NULL),(185,'ST',_binary '',NULL),(186,'SA',_binary '',NULL),(187,'SN',_binary '',NULL),(188,'RS',_binary '',NULL),(189,'SC',_binary '',NULL),(190,'SL',_binary '',NULL),(191,'SG',_binary '',NULL),(192,'SK',_binary '',NULL),(193,'SI',_binary '',NULL),(194,'SB',_binary '',NULL),(195,'SO',_binary '',NULL),(196,'ZA',_binary '',NULL),(197,'ES',_binary '',NULL),(198,'LK',_binary '',NULL),(199,'SD',_binary '',NULL),(200,'SR',_binary '',NULL),(201,'SJ',_binary '',NULL),(202,'SZ',_binary '',NULL),(203,'SE',_binary '',NULL),(204,'CH',_binary '',NULL),(205,'SY',_binary '',NULL),(206,'TW',_binary '',NULL),(207,'TJ',_binary '',NULL),(208,'TZ',_binary '',NULL),(209,'TH',_binary '',NULL),(210,'TL',_binary '',NULL),(211,'TG',_binary '',NULL),(212,'TK',_binary '',NULL),(213,'TO',_binary '',NULL),(214,'TT',_binary '',NULL),(215,'TN',_binary '',NULL),(216,'TR',_binary '',NULL),(217,'TM',_binary '',NULL),(218,'TC',_binary '',NULL),(219,'TV',_binary '',NULL),(220,'UG',_binary '',NULL),(221,'UA',_binary '',NULL),(222,'AE',_binary '',NULL),(223,'GB',_binary '',NULL),(224,'US',_binary '',NULL),(225,'UM',_binary '',NULL),(226,'UY',_binary '',NULL),(227,'UZ',_binary '',NULL),(228,'VU',_binary '',NULL),(229,'VE',_binary '',NULL),(230,'VN',_binary '',NULL),(231,'VG',_binary '',NULL),(232,'VI',_binary '',NULL),(233,'WF',_binary '',NULL),(234,'EH',_binary '',NULL),(235,'YE',_binary '',NULL),(236,'ZM',_binary '',NULL),(237,'ZW',_binary '',NULL);
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
INSERT INTO `COUNTRY_DESCRIPTION` VALUES (1,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,NULL,'Afghanistan',NULL,1,1),(2,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,NULL,'Afghanistan',NULL,2,1),(3,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,NULL,'Afghanistan',NULL,3,1),(4,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,NULL,'Åland Islands',NULL,1,2),(5,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,NULL,'Îles Åland',NULL,2,2),(6,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,NULL,'Åland Islands',NULL,3,2),(7,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,NULL,'Albania',NULL,1,3),(8,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,NULL,'Albanie',NULL,2,3),(9,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,NULL,'Albania',NULL,3,3),(10,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,NULL,'Algeria',NULL,1,4),(11,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Algérie',NULL,2,4),(12,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Algeria',NULL,3,4),(13,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'American Samoa',NULL,1,5),(14,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Samoa américaines',NULL,2,5),(15,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'American Samoa',NULL,3,5),(16,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Andorra',NULL,1,6),(17,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Andorre',NULL,2,6),(18,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Andorra',NULL,3,6),(19,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Angola',NULL,1,7),(20,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Angola',NULL,2,7),(21,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Angola',NULL,3,7),(22,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Anguilla',NULL,1,8),(23,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Anguilla',NULL,2,8),(24,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Anguilla',NULL,3,8),(25,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Antigua & Barbuda',NULL,1,9),(26,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Antigua-et-Barbuda',NULL,2,9),(27,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Antigua & Barbuda',NULL,3,9),(28,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Argentina',NULL,1,10),(29,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Argentine',NULL,2,10),(30,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Argentina',NULL,3,10),(31,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Armenia',NULL,1,11),(32,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Arménie',NULL,2,11),(33,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Armenia',NULL,3,11),(34,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Aruba',NULL,1,12),(35,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Aruba',NULL,2,12),(36,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Aruba',NULL,3,12),(37,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Australia',NULL,1,13),(38,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Australie',NULL,2,13),(39,'2026-09-12 03:17:05','2026-09-12 03:17:05',NULL,NULL,'Australia',NULL,3,13),(40,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Austria',NULL,1,14),(41,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Autriche',NULL,2,14),(42,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Austria',NULL,3,14),(43,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Azerbaijan',NULL,1,15),(44,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Azerbaïdjan',NULL,2,15),(45,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Azerbaijan',NULL,3,15),(46,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Bahamas',NULL,1,16),(47,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Bahamas',NULL,2,16),(48,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Bahamas',NULL,3,16),(49,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Bahrain',NULL,1,17),(50,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Bahreïn',NULL,2,17),(51,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Bahrain',NULL,3,17),(52,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Bangladesh',NULL,1,18),(53,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Bangladesh',NULL,2,18),(54,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Bangladesh',NULL,3,18),(55,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Barbados',NULL,1,19),(56,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Barbade',NULL,2,19),(57,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Barbados',NULL,3,19),(58,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Belarus',NULL,1,20),(59,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Biélorussie',NULL,2,20),(60,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Belarus',NULL,3,20),(61,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Belgium',NULL,1,21),(62,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Belgique',NULL,2,21),(63,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Belgium',NULL,3,21),(64,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Belize',NULL,1,22),(65,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Belize',NULL,2,22),(66,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Belize',NULL,3,22),(67,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Benin',NULL,1,23),(68,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Bénin',NULL,2,23),(69,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Benin',NULL,3,23),(70,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Bermuda',NULL,1,24),(71,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Bermudes',NULL,2,24),(72,'2026-09-12 03:17:06','2026-09-12 03:17:06',NULL,NULL,'Bermuda',NULL,3,24),(73,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'Bhutan',NULL,1,25),(74,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'Bhoutan',NULL,2,25),(75,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'Bhutan',NULL,3,25),(76,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'Bolivia',NULL,1,26),(77,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'Bolivie',NULL,2,26),(78,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'Bolivia',NULL,3,26),(79,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'Bosnia & Herzegovina',NULL,1,27),(80,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'Bosnie-Herzégovine',NULL,2,27),(81,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'Bosnia & Herzegovina',NULL,3,27),(82,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'Botswana',NULL,1,28),(83,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'Botswana',NULL,2,28),(84,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'Botswana',NULL,3,28),(85,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'Brazil',NULL,1,29),(86,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'Brésil',NULL,2,29),(87,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'Brazil',NULL,3,29),(88,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'British Indian Ocean Territory',NULL,1,30),(89,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'Territoire britannique de l’océan Indien',NULL,2,30),(90,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'British Indian Ocean Territory',NULL,3,30),(91,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'Brunei',NULL,1,31),(92,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'Brunéi Darussalam',NULL,2,31),(93,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'Brunei',NULL,3,31),(94,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'Bulgaria',NULL,1,32),(95,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'Bulgarie',NULL,2,32),(96,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'Bulgaria',NULL,3,32),(97,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'Burkina Faso',NULL,1,33),(98,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'Burkina Faso',NULL,2,33),(99,'2026-09-12 03:17:07','2026-09-12 03:17:07',NULL,NULL,'Burkina Faso',NULL,3,33),(100,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'Burundi',NULL,1,34),(101,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'Burundi',NULL,2,34),(102,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'Burundi',NULL,3,34),(103,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'Cambodia',NULL,1,35),(104,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'Cambodge',NULL,2,35),(105,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'Cambodia',NULL,3,35),(106,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'Cameroon',NULL,1,36),(107,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'Cameroun',NULL,2,36),(108,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'Cameroon',NULL,3,36),(109,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'Canada',NULL,1,37),(110,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'Canada',NULL,2,37),(111,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'Canada',NULL,3,37),(112,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'Cape Verde',NULL,1,38),(113,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'Cap-Vert',NULL,2,38),(114,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'Cape Verde',NULL,3,38),(115,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'Cayman Islands',NULL,1,39),(116,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'Îles Caïmans',NULL,2,39),(117,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'Cayman Islands',NULL,3,39),(118,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'Central African Republic',NULL,1,40),(119,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'République centrafricaine',NULL,2,40),(120,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'Central African Republic',NULL,3,40),(121,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'Chad',NULL,1,41),(122,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'Tchad',NULL,2,41),(123,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'Chad',NULL,3,41),(124,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'Chile',NULL,1,42),(125,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'Chili',NULL,2,42),(126,'2026-09-12 03:17:08','2026-09-12 03:17:08',NULL,NULL,'Chile',NULL,3,42),(127,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'China',NULL,1,43),(128,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'Chine',NULL,2,43),(129,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'China',NULL,3,43),(130,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'Christmas Island',NULL,1,44),(131,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'Île Christmas',NULL,2,44),(132,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'Christmas Island',NULL,3,44),(133,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'Cocos (Keeling) Islands',NULL,1,45),(134,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'Îles Cocos',NULL,2,45),(135,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'Cocos (Keeling) Islands',NULL,3,45),(136,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'Colombia',NULL,1,46),(137,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'Colombie',NULL,2,46),(138,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'Colombia',NULL,3,46),(139,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'Comoros',NULL,1,47),(140,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'Comores',NULL,2,47),(141,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'Comoros',NULL,3,47),(142,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'Congo - Brazzaville',NULL,1,48),(143,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'Congo-Brazzaville',NULL,2,48),(144,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'Congo - Brazzaville',NULL,3,48),(145,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'Congo - Kinshasa',NULL,1,49),(146,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'Congo-Kinshasa',NULL,2,49),(147,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'Congo - Kinshasa',NULL,3,49),(148,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'Cook Islands',NULL,1,50),(149,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'Îles Cook',NULL,2,50),(150,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'Cook Islands',NULL,3,50),(151,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'Costa Rica',NULL,1,51),(152,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'Costa Rica',NULL,2,51),(153,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'Costa Rica',NULL,3,51),(154,'2026-09-12 03:17:09','2026-09-12 03:17:09',NULL,NULL,'Côte d’Ivoire',NULL,1,52),(155,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Côte d’Ivoire',NULL,2,52),(156,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Côte d’Ivoire',NULL,3,52),(157,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Croatia',NULL,1,53),(158,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Croatie',NULL,2,53),(159,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Croatia',NULL,3,53),(160,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Cuba',NULL,1,54),(161,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Cuba',NULL,2,54),(162,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Cuba',NULL,3,54),(163,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Cyprus',NULL,1,55),(164,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Chypre',NULL,2,55),(165,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Cyprus',NULL,3,55),(166,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Czechia',NULL,1,56),(167,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Tchéquie',NULL,2,56),(168,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Czechia',NULL,3,56),(169,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Denmark',NULL,1,57),(170,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Danemark',NULL,2,57),(171,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Denmark',NULL,3,57),(172,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Djibouti',NULL,1,58),(173,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Djibouti',NULL,2,58),(174,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Djibouti',NULL,3,58),(175,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Dominica',NULL,1,59),(176,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Dominique',NULL,2,59),(177,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Dominica',NULL,3,59),(178,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Dominican Republic',NULL,1,60),(179,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'République dominicaine',NULL,2,60),(180,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Dominican Republic',NULL,3,60),(181,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Ecuador',NULL,1,61),(182,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Équateur',NULL,2,61),(183,'2026-09-12 03:17:10','2026-09-12 03:17:10',NULL,NULL,'Ecuador',NULL,3,61),(184,'2026-09-12 03:17:11','2026-09-12 03:17:11',NULL,NULL,'Egypt',NULL,1,62),(185,'2026-09-12 03:17:11','2026-09-12 03:17:11',NULL,NULL,'Égypte',NULL,2,62),(186,'2026-09-12 03:17:11','2026-09-12 03:17:11',NULL,NULL,'Egypt',NULL,3,62),(187,'2026-09-12 03:17:11','2026-09-12 03:17:11',NULL,NULL,'El Salvador',NULL,1,63),(188,'2026-09-12 03:17:11','2026-09-12 03:17:11',NULL,NULL,'Salvador',NULL,2,63),(189,'2026-09-12 03:17:11','2026-09-12 03:17:11',NULL,NULL,'El Salvador',NULL,3,63),(190,'2026-09-12 03:17:11','2026-09-12 03:17:11',NULL,NULL,'Equatorial Guinea',NULL,1,64),(191,'2026-09-12 03:17:11','2026-09-12 03:17:11',NULL,NULL,'Guinée équatoriale',NULL,2,64),(192,'2026-09-12 03:17:11','2026-09-12 03:17:11',NULL,NULL,'Equatorial Guinea',NULL,3,64),(193,'2026-09-12 03:17:11','2026-09-12 03:17:11',NULL,NULL,'Eritrea',NULL,1,65),(194,'2026-09-12 03:17:11','2026-09-12 03:17:11',NULL,NULL,'Érythrée',NULL,2,65),(195,'2026-09-12 03:17:11','2026-09-12 03:17:11',NULL,NULL,'Eritrea',NULL,3,65),(196,'2026-09-12 03:17:11','2026-09-12 03:17:11',NULL,NULL,'Estonia',NULL,1,66),(197,'2026-09-12 03:17:11','2026-09-12 03:17:11',NULL,NULL,'Estonie',NULL,2,66),(198,'2026-09-12 03:17:11','2026-09-12 03:17:11',NULL,NULL,'Estonia',NULL,3,66),(199,'2026-09-12 03:17:11','2026-09-12 03:17:11',NULL,NULL,'Ethiopia',NULL,1,67),(200,'2026-09-12 03:17:11','2026-09-12 03:17:11',NULL,NULL,'Éthiopie',NULL,2,67),(201,'2026-09-12 03:17:11','2026-09-12 03:17:11',NULL,NULL,'Ethiopia',NULL,3,67),(202,'2026-09-12 03:17:11','2026-09-12 03:17:11',NULL,NULL,'Falkland Islands',NULL,1,68),(203,'2026-09-12 03:17:11','2026-09-12 03:17:11',NULL,NULL,'Îles Malouines',NULL,2,68),(204,'2026-09-12 03:17:11','2026-09-12 03:17:11',NULL,NULL,'Falkland Islands',NULL,3,68),(205,'2026-09-12 03:17:11','2026-09-12 03:17:11',NULL,NULL,'Faroe Islands',NULL,1,69),(206,'2026-09-12 03:17:11','2026-09-12 03:17:11',NULL,NULL,'Îles Féroé',NULL,2,69),(207,'2026-09-12 03:17:11','2026-09-12 03:17:11',NULL,NULL,'Faroe Islands',NULL,3,69),(208,'2026-09-12 03:17:11','2026-09-12 03:17:11',NULL,NULL,'Fiji',NULL,1,70),(209,'2026-09-12 03:17:12','2026-09-12 03:17:12',NULL,NULL,'Fidji',NULL,2,70),(210,'2026-09-12 03:17:12','2026-09-12 03:17:12',NULL,NULL,'Fiji',NULL,3,70),(211,'2026-09-12 03:17:12','2026-09-12 03:17:12',NULL,NULL,'Finland',NULL,1,71),(212,'2026-09-12 03:17:12','2026-09-12 03:17:12',NULL,NULL,'Finlande',NULL,2,71),(213,'2026-09-12 03:17:12','2026-09-12 03:17:12',NULL,NULL,'Finland',NULL,3,71),(214,'2026-09-12 03:17:12','2026-09-12 03:17:12',NULL,NULL,'France',NULL,1,72),(215,'2026-09-12 03:17:12','2026-09-12 03:17:12',NULL,NULL,'France',NULL,2,72),(216,'2026-09-12 03:17:12','2026-09-12 03:17:12',NULL,NULL,'France',NULL,3,72),(217,'2026-09-12 03:17:12','2026-09-12 03:17:12',NULL,NULL,'French Guiana',NULL,1,73),(218,'2026-09-12 03:17:12','2026-09-12 03:17:12',NULL,NULL,'Guyane française',NULL,2,73),(219,'2026-09-12 03:17:12','2026-09-12 03:17:12',NULL,NULL,'French Guiana',NULL,3,73),(220,'2026-09-12 03:17:12','2026-09-12 03:17:12',NULL,NULL,'French Polynesia',NULL,1,74),(221,'2026-09-12 03:17:12','2026-09-12 03:17:12',NULL,NULL,'Polynésie française',NULL,2,74),(222,'2026-09-12 03:17:12','2026-09-12 03:17:12',NULL,NULL,'French Polynesia',NULL,3,74),(223,'2026-09-12 03:17:12','2026-09-12 03:17:12',NULL,NULL,'Gabon',NULL,1,75),(224,'2026-09-12 03:17:12','2026-09-12 03:17:12',NULL,NULL,'Gabon',NULL,2,75),(225,'2026-09-12 03:17:12','2026-09-12 03:17:12',NULL,NULL,'Gabon',NULL,3,75),(226,'2026-09-12 03:17:12','2026-09-12 03:17:12',NULL,NULL,'Gambia',NULL,1,76),(227,'2026-09-12 03:17:12','2026-09-12 03:17:12',NULL,NULL,'Gambie',NULL,2,76),(228,'2026-09-12 03:17:12','2026-09-12 03:17:12',NULL,NULL,'Gambia',NULL,3,76),(229,'2026-09-12 03:17:12','2026-09-12 03:17:12',NULL,NULL,'Georgia',NULL,1,77),(230,'2026-09-12 03:17:12','2026-09-12 03:17:12',NULL,NULL,'Géorgie',NULL,2,77),(231,'2026-09-12 03:17:12','2026-09-12 03:17:12',NULL,NULL,'Georgia',NULL,3,77),(232,'2026-09-12 03:17:12','2026-09-12 03:17:12',NULL,NULL,'Germany',NULL,1,78),(233,'2026-09-12 03:17:12','2026-09-12 03:17:12',NULL,NULL,'Allemagne',NULL,2,78),(234,'2026-09-12 03:17:12','2026-09-12 03:17:12',NULL,NULL,'Germany',NULL,3,78),(235,'2026-09-12 03:17:13','2026-09-12 03:17:13',NULL,NULL,'Ghana',NULL,1,79),(236,'2026-09-12 03:17:13','2026-09-12 03:17:13',NULL,NULL,'Ghana',NULL,2,79),(237,'2026-09-12 03:17:13','2026-09-12 03:17:13',NULL,NULL,'Ghana',NULL,3,79),(238,'2026-09-12 03:17:13','2026-09-12 03:17:13',NULL,NULL,'Gibraltar',NULL,1,80),(239,'2026-09-12 03:17:13','2026-09-12 03:17:13',NULL,NULL,'Gibraltar',NULL,2,80),(240,'2026-09-12 03:17:13','2026-09-12 03:17:13',NULL,NULL,'Gibraltar',NULL,3,80),(241,'2026-09-12 03:17:13','2026-09-12 03:17:13',NULL,NULL,'Greece',NULL,1,81),(242,'2026-09-12 03:17:13','2026-09-12 03:17:13',NULL,NULL,'Grèce',NULL,2,81),(243,'2026-09-12 03:17:13','2026-09-12 03:17:13',NULL,NULL,'Greece',NULL,3,81),(244,'2026-09-12 03:17:13','2026-09-12 03:17:13',NULL,NULL,'Greenland',NULL,1,82),(245,'2026-09-12 03:17:13','2026-09-12 03:17:13',NULL,NULL,'Groenland',NULL,2,82),(246,'2026-09-12 03:17:13','2026-09-12 03:17:13',NULL,NULL,'Greenland',NULL,3,82),(247,'2026-09-12 03:17:13','2026-09-12 03:17:13',NULL,NULL,'Grenada',NULL,1,83),(248,'2026-09-12 03:17:13','2026-09-12 03:17:13',NULL,NULL,'Grenade',NULL,2,83),(249,'2026-09-12 03:17:13','2026-09-12 03:17:13',NULL,NULL,'Grenada',NULL,3,83),(250,'2026-09-12 03:17:13','2026-09-12 03:17:13',NULL,NULL,'Guadeloupe',NULL,1,84),(251,'2026-09-12 03:17:13','2026-09-12 03:17:13',NULL,NULL,'Guadeloupe',NULL,2,84),(252,'2026-09-12 03:17:13','2026-09-12 03:17:13',NULL,NULL,'Guadeloupe',NULL,3,84),(253,'2026-09-12 03:17:13','2026-09-12 03:17:13',NULL,NULL,'Guam',NULL,1,85),(254,'2026-09-12 03:17:13','2026-09-12 03:17:13',NULL,NULL,'Guam',NULL,2,85),(255,'2026-09-12 03:17:13','2026-09-12 03:17:13',NULL,NULL,'Guam',NULL,3,85),(256,'2026-09-12 03:17:13','2026-09-12 03:17:13',NULL,NULL,'Guatemala',NULL,1,86),(257,'2026-09-12 03:17:13','2026-09-12 03:17:13',NULL,NULL,'Guatemala',NULL,2,86),(258,'2026-09-12 03:17:13','2026-09-12 03:17:13',NULL,NULL,'Guatemala',NULL,3,86),(259,'2026-09-12 03:17:14','2026-09-12 03:17:14',NULL,NULL,'Guernsey',NULL,1,87),(260,'2026-09-12 03:17:14','2026-09-12 03:17:14',NULL,NULL,'Guernesey',NULL,2,87),(261,'2026-09-12 03:17:14','2026-09-12 03:17:14',NULL,NULL,'Guernsey',NULL,3,87),(262,'2026-09-12 03:17:14','2026-09-12 03:17:14',NULL,NULL,'Guinea',NULL,1,88),(263,'2026-09-12 03:17:14','2026-09-12 03:17:14',NULL,NULL,'Guinée',NULL,2,88),(264,'2026-09-12 03:17:14','2026-09-12 03:17:14',NULL,NULL,'Guinea',NULL,3,88),(265,'2026-09-12 03:17:14','2026-09-12 03:17:14',NULL,NULL,'Guinea-Bissau',NULL,1,89),(266,'2026-09-12 03:17:14','2026-09-12 03:17:14',NULL,NULL,'Guinée-Bissau',NULL,2,89),(267,'2026-09-12 03:17:14','2026-09-12 03:17:14',NULL,NULL,'Guinea-Bissau',NULL,3,89),(268,'2026-09-12 03:17:14','2026-09-12 03:17:14',NULL,NULL,'Guyana',NULL,1,90),(269,'2026-09-12 03:17:14','2026-09-12 03:17:14',NULL,NULL,'Guyana',NULL,2,90),(270,'2026-09-12 03:17:14','2026-09-12 03:17:14',NULL,NULL,'Guyana',NULL,3,90),(271,'2026-09-12 03:17:14','2026-09-12 03:17:14',NULL,NULL,'Haiti',NULL,1,91),(272,'2026-09-12 03:17:14','2026-09-12 03:17:14',NULL,NULL,'Haïti',NULL,2,91),(273,'2026-09-12 03:17:14','2026-09-12 03:17:14',NULL,NULL,'Haiti',NULL,3,91),(274,'2026-09-12 03:17:14','2026-09-12 03:17:14',NULL,NULL,'Vatican City',NULL,1,92),(275,'2026-09-12 03:17:14','2026-09-12 03:17:14',NULL,NULL,'État de la Cité du Vatican',NULL,2,92),(276,'2026-09-12 03:17:14','2026-09-12 03:17:14',NULL,NULL,'Vatican City',NULL,3,92),(277,'2026-09-12 03:17:14','2026-09-12 03:17:14',NULL,NULL,'Honduras',NULL,1,93),(278,'2026-09-12 03:17:14','2026-09-12 03:17:14',NULL,NULL,'Honduras',NULL,2,93),(279,'2026-09-12 03:17:14','2026-09-12 03:17:14',NULL,NULL,'Honduras',NULL,3,93),(280,'2026-09-12 03:17:14','2026-09-12 03:17:14',NULL,NULL,'Hong Kong SAR China',NULL,1,94),(281,'2026-09-12 03:17:14','2026-09-12 03:17:14',NULL,NULL,'R.A.S. chinoise de Hong Kong',NULL,2,94),(282,'2026-09-12 03:17:14','2026-09-12 03:17:14',NULL,NULL,'Hong Kong SAR China',NULL,3,94),(283,'2026-09-12 03:17:14','2026-09-12 03:17:14',NULL,NULL,'Hungary',NULL,1,95),(284,'2026-09-12 03:17:14','2026-09-12 03:17:14',NULL,NULL,'Hongrie',NULL,2,95),(285,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'Hungary',NULL,3,95),(286,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'Iceland',NULL,1,96),(287,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'Islande',NULL,2,96),(288,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'Iceland',NULL,3,96),(289,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'India',NULL,1,97),(290,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'Inde',NULL,2,97),(291,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'India',NULL,3,97),(292,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'Indonesia',NULL,1,98),(293,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'Indonésie',NULL,2,98),(294,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'Indonesia',NULL,3,98),(295,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'Iran',NULL,1,99),(296,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'Iran',NULL,2,99),(297,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'Iran',NULL,3,99),(298,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'Iraq',NULL,1,100),(299,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'Irak',NULL,2,100),(300,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'Iraq',NULL,3,100),(301,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'Ireland',NULL,1,101),(302,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'Irlande',NULL,2,101),(303,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'Ireland',NULL,3,101),(304,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'Isle of Man',NULL,1,102),(305,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'Île de Man',NULL,2,102),(306,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'Isle of Man',NULL,3,102),(307,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'Israel',NULL,1,103),(308,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'Israël',NULL,2,103),(309,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'Israel',NULL,3,103),(310,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'Italy',NULL,1,104),(311,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'Italie',NULL,2,104),(312,'2026-09-12 03:17:15','2026-09-12 03:17:15',NULL,NULL,'Italy',NULL,3,104),(313,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'Jamaica',NULL,1,105),(314,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'Jamaïque',NULL,2,105),(315,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'Jamaica',NULL,3,105),(316,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'Japan',NULL,1,106),(317,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'Japon',NULL,2,106),(318,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'Japan',NULL,3,106),(319,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'Jersey',NULL,1,107),(320,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'Jersey',NULL,2,107),(321,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'Jersey',NULL,3,107),(322,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'Jordan',NULL,1,108),(323,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'Jordanie',NULL,2,108),(324,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'Jordan',NULL,3,108),(325,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'Kazakhstan',NULL,1,109),(326,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'Kazakhstan',NULL,2,109),(327,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'Kazakhstan',NULL,3,109),(328,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'Kenya',NULL,1,110),(329,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'Kenya',NULL,2,110),(330,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'Kenya',NULL,3,110),(331,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'Kiribati',NULL,1,111),(332,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'Kiribati',NULL,2,111),(333,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'Kiribati',NULL,3,111),(334,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'North Korea',NULL,1,112),(335,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'Corée du Nord',NULL,2,112),(336,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'North Korea',NULL,3,112),(337,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'South Korea',NULL,1,113),(338,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'Corée du Sud',NULL,2,113),(339,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'South Korea',NULL,3,113),(340,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'Kuwait',NULL,1,114),(341,'2026-09-12 03:17:16','2026-09-12 03:17:16',NULL,NULL,'Koweït',NULL,2,114),(342,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Kuwait',NULL,3,114),(343,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Kyrgyzstan',NULL,1,115),(344,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Kirghizistan',NULL,2,115),(345,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Kyrgyzstan',NULL,3,115),(346,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Laos',NULL,1,116),(347,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Laos',NULL,2,116),(348,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Laos',NULL,3,116),(349,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Latvia',NULL,1,117),(350,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Lettonie',NULL,2,117),(351,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Latvia',NULL,3,117),(352,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Lebanon',NULL,1,118),(353,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Liban',NULL,2,118),(354,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Lebanon',NULL,3,118),(355,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Lesotho',NULL,1,119),(356,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Lesotho',NULL,2,119),(357,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Lesotho',NULL,3,119),(358,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Liberia',NULL,1,120),(359,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Libéria',NULL,2,120),(360,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Liberia',NULL,3,120),(361,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Libya',NULL,1,121),(362,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Libye',NULL,2,121),(363,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Libya',NULL,3,121),(364,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Liechtenstein',NULL,1,122),(365,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Liechtenstein',NULL,2,122),(366,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Liechtenstein',NULL,3,122),(367,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Lithuania',NULL,1,123),(368,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Lituanie',NULL,2,123),(369,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Lithuania',NULL,3,123),(370,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Luxembourg',NULL,1,124),(371,'2026-09-12 03:17:17','2026-09-12 03:17:17',NULL,NULL,'Luxembourg',NULL,2,124),(372,'2026-09-12 03:17:18','2026-09-12 03:17:18',NULL,NULL,'Luxembourg',NULL,3,124),(373,'2026-09-12 03:17:18','2026-09-12 03:17:18',NULL,NULL,'Macau SAR China',NULL,1,125),(374,'2026-09-12 03:17:18','2026-09-12 03:17:18',NULL,NULL,'R.A.S. chinoise de Macao',NULL,2,125),(375,'2026-09-12 03:17:18','2026-09-12 03:17:18',NULL,NULL,'Macao SAR China',NULL,3,125),(376,'2026-09-12 03:17:18','2026-09-12 03:17:18',NULL,NULL,'Macedonia',NULL,1,126),(377,'2026-09-12 03:17:18','2026-09-12 03:17:18',NULL,NULL,'Macédoine',NULL,2,126),(378,'2026-09-12 03:17:18','2026-09-12 03:17:18',NULL,NULL,'North Macedonia',NULL,3,126),(379,'2026-09-12 03:17:18','2026-09-12 03:17:18',NULL,NULL,'Madagascar',NULL,1,127),(380,'2026-09-12 03:17:18','2026-09-12 03:17:18',NULL,NULL,'Madagascar',NULL,2,127),(381,'2026-09-12 03:17:18','2026-09-12 03:17:18',NULL,NULL,'Madagascar',NULL,3,127),(382,'2026-09-12 03:17:18','2026-09-12 03:17:18',NULL,NULL,'Malawi',NULL,1,128),(383,'2026-09-12 03:17:18','2026-09-12 03:17:18',NULL,NULL,'Malawi',NULL,2,128),(384,'2026-09-12 03:17:18','2026-09-12 03:17:18',NULL,NULL,'Malawi',NULL,3,128),(385,'2026-09-12 03:17:18','2026-09-12 03:17:18',NULL,NULL,'Malaysia',NULL,1,129),(386,'2026-09-12 03:17:18','2026-09-12 03:17:18',NULL,NULL,'Malaisie',NULL,2,129),(387,'2026-09-12 03:17:18','2026-09-12 03:17:18',NULL,NULL,'Malaysia',NULL,3,129),(388,'2026-09-12 03:17:18','2026-09-12 03:17:18',NULL,NULL,'Mali',NULL,1,130),(389,'2026-09-12 03:17:18','2026-09-12 03:17:18',NULL,NULL,'Mali',NULL,2,130),(390,'2026-09-12 03:17:18','2026-09-12 03:17:18',NULL,NULL,'Mali',NULL,3,130),(391,'2026-09-12 03:17:18','2026-09-12 03:17:18',NULL,NULL,'Malta',NULL,1,131),(392,'2026-09-12 03:17:18','2026-09-12 03:17:18',NULL,NULL,'Malte',NULL,2,131),(393,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'Malta',NULL,3,131),(394,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'Marshall Islands',NULL,1,132),(395,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'Îles Marshall',NULL,2,132),(396,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'Marshall Islands',NULL,3,132),(397,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'Martinique',NULL,1,133),(398,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'Martinique',NULL,2,133),(399,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'Martinique',NULL,3,133),(400,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'Mauritania',NULL,1,134),(401,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'Mauritanie',NULL,2,134),(402,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'Mauritania',NULL,3,134),(403,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'Mauritius',NULL,1,135),(404,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'Maurice',NULL,2,135),(405,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'Mauritius',NULL,3,135),(406,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'Mayotte',NULL,1,136),(407,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'Mayotte',NULL,2,136),(408,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'Mayotte',NULL,3,136),(409,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'Mexico',NULL,1,137),(410,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'Mexique',NULL,2,137),(411,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'Mexico',NULL,3,137),(412,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'Micronesia',NULL,1,138),(413,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'États fédérés de Micronésie',NULL,2,138),(414,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'Micronesia',NULL,3,138),(415,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'Moldova',NULL,1,139),(416,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'Moldavie',NULL,2,139),(417,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'Moldova',NULL,3,139),(418,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'Monaco',NULL,1,140),(419,'2026-09-12 03:17:19','2026-09-12 03:17:19',NULL,NULL,'Monaco',NULL,2,140),(420,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Monaco',NULL,3,140),(421,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Mongolia',NULL,1,141),(422,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Mongolie',NULL,2,141),(423,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Mongolia',NULL,3,141),(424,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Montenegro',NULL,1,142),(425,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Monténégro',NULL,2,142),(426,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Montenegro',NULL,3,142),(427,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Montserrat',NULL,1,143),(428,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Montserrat',NULL,2,143),(429,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Montserrat',NULL,3,143),(430,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Morocco',NULL,1,144),(431,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Maroc',NULL,2,144),(432,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Morocco',NULL,3,144),(433,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Mozambique',NULL,1,145),(434,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Mozambique',NULL,2,145),(435,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Mozambique',NULL,3,145),(436,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Myanmar (Burma)',NULL,1,146),(437,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Myanmar (Birmanie)',NULL,2,146),(438,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Myanmar (Burma)',NULL,3,146),(439,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Namibia',NULL,1,147),(440,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Namibie',NULL,2,147),(441,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Namibia',NULL,3,147),(442,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Nauru',NULL,1,148),(443,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Nauru',NULL,2,148),(444,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Nauru',NULL,3,148),(445,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Nepal',NULL,1,149),(446,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Népal',NULL,2,149),(447,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Nepal',NULL,3,149),(448,'2026-09-12 03:17:20','2026-09-12 03:17:20',NULL,NULL,'Netherlands',NULL,1,150),(449,'2026-09-12 03:17:21','2026-09-12 03:17:21',NULL,NULL,'Pays-Bas',NULL,2,150),(450,'2026-09-12 03:17:21','2026-09-12 03:17:21',NULL,NULL,'Netherlands',NULL,3,150),(451,'2026-09-12 03:17:21','2026-09-12 03:17:21',NULL,NULL,'New Caledonia',NULL,1,151),(452,'2026-09-12 03:17:21','2026-09-12 03:17:21',NULL,NULL,'Nouvelle-Calédonie',NULL,2,151),(453,'2026-09-12 03:17:21','2026-09-12 03:17:21',NULL,NULL,'New Caledonia',NULL,3,151),(454,'2026-09-12 03:17:21','2026-09-12 03:17:21',NULL,NULL,'New Zealand',NULL,1,152),(455,'2026-09-12 03:17:21','2026-09-12 03:17:21',NULL,NULL,'Nouvelle-Zélande',NULL,2,152),(456,'2026-09-12 03:17:21','2026-09-12 03:17:21',NULL,NULL,'New Zealand',NULL,3,152),(457,'2026-09-12 03:17:21','2026-09-12 03:17:21',NULL,NULL,'Nicaragua',NULL,1,153),(458,'2026-09-12 03:17:21','2026-09-12 03:17:21',NULL,NULL,'Nicaragua',NULL,2,153),(459,'2026-09-12 03:17:21','2026-09-12 03:17:21',NULL,NULL,'Nicaragua',NULL,3,153),(460,'2026-09-12 03:17:21','2026-09-12 03:17:21',NULL,NULL,'Niger',NULL,1,154),(461,'2026-09-12 03:17:21','2026-09-12 03:17:21',NULL,NULL,'Niger',NULL,2,154),(462,'2026-09-12 03:17:21','2026-09-12 03:17:21',NULL,NULL,'Niger',NULL,3,154),(463,'2026-09-12 03:17:21','2026-09-12 03:17:21',NULL,NULL,'Nigeria',NULL,1,155),(464,'2026-09-12 03:17:21','2026-09-12 03:17:21',NULL,NULL,'Nigéria',NULL,2,155),(465,'2026-09-12 03:17:21','2026-09-12 03:17:21',NULL,NULL,'Nigeria',NULL,3,155),(466,'2026-09-12 03:17:21','2026-09-12 03:17:21',NULL,NULL,'Niue',NULL,1,156),(467,'2026-09-12 03:17:21','2026-09-12 03:17:21',NULL,NULL,'Niue',NULL,2,156),(468,'2026-09-12 03:17:21','2026-09-12 03:17:21',NULL,NULL,'Niue',NULL,3,156),(469,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Norfolk Island',NULL,1,157),(470,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Île Norfolk',NULL,2,157),(471,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Norfolk Island',NULL,3,157),(472,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Northern Mariana Islands',NULL,1,158),(473,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Îles Mariannes du Nord',NULL,2,158),(474,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Northern Mariana Islands',NULL,3,158),(475,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Norway',NULL,1,159),(476,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Norvège',NULL,2,159),(477,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Norway',NULL,3,159),(478,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Oman',NULL,1,160),(479,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Oman',NULL,2,160),(480,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Oman',NULL,3,160),(481,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Pakistan',NULL,1,161),(482,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Pakistan',NULL,2,161),(483,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Pakistan',NULL,3,161),(484,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Palau',NULL,1,162),(485,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Palaos',NULL,2,162),(486,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Palau',NULL,3,162),(487,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Palestinian Territories',NULL,1,163),(488,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Territoires palestiniens',NULL,2,163),(489,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Palestinian Territories',NULL,3,163),(490,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Panama',NULL,1,164),(491,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Panama',NULL,2,164),(492,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Panama',NULL,3,164),(493,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Papua New Guinea',NULL,1,165),(494,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Papouasie-Nouvelle-Guinée',NULL,2,165),(495,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Papua New Guinea',NULL,3,165),(496,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Paraguay',NULL,1,166),(497,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Paraguay',NULL,2,166),(498,'2026-09-12 03:17:22','2026-09-12 03:17:22',NULL,NULL,'Paraguay',NULL,3,166),(499,'2026-09-12 03:17:23','2026-09-12 03:17:23',NULL,NULL,'Peru',NULL,1,167),(500,'2026-09-12 03:17:23','2026-09-12 03:17:23',NULL,NULL,'Pérou',NULL,2,167),(501,'2026-09-12 03:17:23','2026-09-12 03:17:23',NULL,NULL,'Peru',NULL,3,167),(502,'2026-09-12 03:17:23','2026-09-12 03:17:23',NULL,NULL,'Philippines',NULL,1,168),(503,'2026-09-12 03:17:23','2026-09-12 03:17:23',NULL,NULL,'Philippines',NULL,2,168),(504,'2026-09-12 03:17:23','2026-09-12 03:17:23',NULL,NULL,'Philippines',NULL,3,168),(505,'2026-09-12 03:17:23','2026-09-12 03:17:23',NULL,NULL,'Pitcairn Islands',NULL,1,169),(506,'2026-09-12 03:17:23','2026-09-12 03:17:23',NULL,NULL,'Îles Pitcairn',NULL,2,169),(507,'2026-09-12 03:17:23','2026-09-12 03:17:23',NULL,NULL,'Pitcairn Islands',NULL,3,169),(508,'2026-09-12 03:17:23','2026-09-12 03:17:23',NULL,NULL,'Poland',NULL,1,170),(509,'2026-09-12 03:17:23','2026-09-12 03:17:23',NULL,NULL,'Pologne',NULL,2,170),(510,'2026-09-12 03:17:23','2026-09-12 03:17:23',NULL,NULL,'Poland',NULL,3,170),(511,'2026-09-12 03:17:23','2026-09-12 03:17:23',NULL,NULL,'Portugal',NULL,1,171),(512,'2026-09-12 03:17:23','2026-09-12 03:17:23',NULL,NULL,'Portugal',NULL,2,171),(513,'2026-09-12 03:17:23','2026-09-12 03:17:23',NULL,NULL,'Portugal',NULL,3,171),(514,'2026-09-12 03:17:23','2026-09-12 03:17:23',NULL,NULL,'Puerto Rico',NULL,1,172),(515,'2026-09-12 03:17:23','2026-09-12 03:17:23',NULL,NULL,'Porto Rico',NULL,2,172),(516,'2026-09-12 03:17:23','2026-09-12 03:17:23',NULL,NULL,'Puerto Rico',NULL,3,172),(517,'2026-09-12 03:17:23','2026-09-12 03:17:23',NULL,NULL,'Qatar',NULL,1,173),(518,'2026-09-12 03:17:23','2026-09-12 03:17:23',NULL,NULL,'Qatar',NULL,2,173),(519,'2026-09-12 03:17:23','2026-09-12 03:17:23',NULL,NULL,'Qatar',NULL,3,173),(520,'2026-09-12 03:17:23','2026-09-12 03:17:23',NULL,NULL,'Réunion',NULL,1,174),(521,'2026-09-12 03:17:23','2026-09-12 03:17:23',NULL,NULL,'La Réunion',NULL,2,174),(522,'2026-09-12 03:17:24','2026-09-12 03:17:24',NULL,NULL,'Réunion',NULL,3,174),(523,'2026-09-12 03:17:24','2026-09-12 03:17:24',NULL,NULL,'Romania',NULL,1,175),(524,'2026-09-12 03:17:24','2026-09-12 03:17:24',NULL,NULL,'Roumanie',NULL,2,175),(525,'2026-09-12 03:17:24','2026-09-12 03:17:24',NULL,NULL,'Romania',NULL,3,175),(526,'2026-09-12 03:17:24','2026-09-12 03:17:24',NULL,NULL,'Russia',NULL,1,176),(527,'2026-09-12 03:17:24','2026-09-12 03:17:24',NULL,NULL,'Russie',NULL,2,176),(528,'2026-09-12 03:17:24','2026-09-12 03:17:24',NULL,NULL,'Russia',NULL,3,176),(529,'2026-09-12 03:17:24','2026-09-12 03:17:24',NULL,NULL,'Rwanda',NULL,1,177),(530,'2026-09-12 03:17:24','2026-09-12 03:17:24',NULL,NULL,'Rwanda',NULL,2,177),(531,'2026-09-12 03:17:24','2026-09-12 03:17:24',NULL,NULL,'Rwanda',NULL,3,177),(532,'2026-09-12 03:17:24','2026-09-12 03:17:24',NULL,NULL,'St. Helena',NULL,1,178),(533,'2026-09-12 03:17:24','2026-09-12 03:17:24',NULL,NULL,'Sainte-Hélène',NULL,2,178),(534,'2026-09-12 03:17:24','2026-09-12 03:17:24',NULL,NULL,'St. Helena',NULL,3,178),(535,'2026-09-12 03:17:24','2026-09-12 03:17:24',NULL,NULL,'St. Kitts & Nevis',NULL,1,179),(536,'2026-09-12 03:17:24','2026-09-12 03:17:24',NULL,NULL,'Saint-Christophe-et-Niévès',NULL,2,179),(537,'2026-09-12 03:17:24','2026-09-12 03:17:24',NULL,NULL,'St. Kitts & Nevis',NULL,3,179),(538,'2026-09-12 03:17:24','2026-09-12 03:17:24',NULL,NULL,'St. Lucia',NULL,1,180),(539,'2026-09-12 03:17:24','2026-09-12 03:17:24',NULL,NULL,'Sainte-Lucie',NULL,2,180),(540,'2026-09-12 03:17:24','2026-09-12 03:17:24',NULL,NULL,'St. Lucia',NULL,3,180),(541,'2026-09-12 03:17:24','2026-09-12 03:17:24',NULL,NULL,'St. Pierre & Miquelon',NULL,1,181),(542,'2026-09-12 03:17:24','2026-09-12 03:17:24',NULL,NULL,'Saint-Pierre-et-Miquelon',NULL,2,181),(543,'2026-09-12 03:17:24','2026-09-12 03:17:24',NULL,NULL,'St. Pierre & Miquelon',NULL,3,181),(544,'2026-09-12 03:17:24','2026-09-12 03:17:24',NULL,NULL,'St. Vincent & Grenadines',NULL,1,182),(545,'2026-09-12 03:17:24','2026-09-12 03:17:24',NULL,NULL,'Saint-Vincent-et-les-Grenadines',NULL,2,182),(546,'2026-09-12 03:17:24','2026-09-12 03:17:24',NULL,NULL,'St. Vincent & Grenadines',NULL,3,182),(547,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Samoa',NULL,1,183),(548,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Samoa',NULL,2,183),(549,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Samoa',NULL,3,183),(550,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'San Marino',NULL,1,184),(551,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Saint-Marin',NULL,2,184),(552,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'San Marino',NULL,3,184),(553,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'São Tomé & Príncipe',NULL,1,185),(554,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Sao Tomé-et-Principe',NULL,2,185),(555,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'São Tomé & Príncipe',NULL,3,185),(556,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Saudi Arabia',NULL,1,186),(557,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Arabie saoudite',NULL,2,186),(558,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Saudi Arabia',NULL,3,186),(559,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Senegal',NULL,1,187),(560,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Sénégal',NULL,2,187),(561,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Senegal',NULL,3,187),(562,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Serbia',NULL,1,188),(563,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Serbie',NULL,2,188),(564,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Serbia',NULL,3,188),(565,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Seychelles',NULL,1,189),(566,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Seychelles',NULL,2,189),(567,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Seychelles',NULL,3,189),(568,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Sierra Leone',NULL,1,190),(569,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Sierra Leone',NULL,2,190),(570,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Sierra Leone',NULL,3,190),(571,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Singapore',NULL,1,191),(572,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Singapour',NULL,2,191),(573,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Singapore',NULL,3,191),(574,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Slovakia',NULL,1,192),(575,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Slovaquie',NULL,2,192),(576,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Slovakia',NULL,3,192),(577,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Slovenia',NULL,1,193),(578,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Slovénie',NULL,2,193),(579,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Slovenia',NULL,3,193),(580,'2026-09-12 03:17:25','2026-09-12 03:17:25',NULL,NULL,'Solomon Islands',NULL,1,194),(581,'2026-09-12 03:17:26','2026-09-12 03:17:26',NULL,NULL,'Îles Salomon',NULL,2,194),(582,'2026-09-12 03:17:26','2026-09-12 03:17:26',NULL,NULL,'Solomon Islands',NULL,3,194),(583,'2026-09-12 03:17:26','2026-09-12 03:17:26',NULL,NULL,'Somalia',NULL,1,195),(584,'2026-09-12 03:17:26','2026-09-12 03:17:26',NULL,NULL,'Somalie',NULL,2,195),(585,'2026-09-12 03:17:26','2026-09-12 03:17:26',NULL,NULL,'Somalia',NULL,3,195),(586,'2026-09-12 03:17:26','2026-09-12 03:17:26',NULL,NULL,'South Africa',NULL,1,196),(587,'2026-09-12 03:17:26','2026-09-12 03:17:26',NULL,NULL,'Afrique du Sud',NULL,2,196),(588,'2026-09-12 03:17:26','2026-09-12 03:17:26',NULL,NULL,'South Africa',NULL,3,196),(589,'2026-09-12 03:17:26','2026-09-12 03:17:26',NULL,NULL,'Spain',NULL,1,197),(590,'2026-09-12 03:17:26','2026-09-12 03:17:26',NULL,NULL,'Espagne',NULL,2,197),(591,'2026-09-12 03:17:26','2026-09-12 03:17:26',NULL,NULL,'Spain',NULL,3,197),(592,'2026-09-12 03:17:26','2026-09-12 03:17:26',NULL,NULL,'Sri Lanka',NULL,1,198),(593,'2026-09-12 03:17:26','2026-09-12 03:17:26',NULL,NULL,'Sri Lanka',NULL,2,198),(594,'2026-09-12 03:17:26','2026-09-12 03:17:26',NULL,NULL,'Sri Lanka',NULL,3,198),(595,'2026-09-12 03:17:26','2026-09-12 03:17:26',NULL,NULL,'Sudan',NULL,1,199),(596,'2026-09-12 03:17:26','2026-09-12 03:17:26',NULL,NULL,'Soudan',NULL,2,199),(597,'2026-09-12 03:17:26','2026-09-12 03:17:26',NULL,NULL,'Sudan',NULL,3,199),(598,'2026-09-12 03:17:26','2026-09-12 03:17:26',NULL,NULL,'Suriname',NULL,1,200),(599,'2026-09-12 03:17:26','2026-09-12 03:17:26',NULL,NULL,'Suriname',NULL,2,200),(600,'2026-09-12 03:17:26','2026-09-12 03:17:26',NULL,NULL,'Suriname',NULL,3,200),(601,'2026-09-12 03:17:26','2026-09-12 03:17:26',NULL,NULL,'Svalbard & Jan Mayen',NULL,1,201),(602,'2026-09-12 03:17:26','2026-09-12 03:17:26',NULL,NULL,'Svalbard et Jan Mayen',NULL,2,201),(603,'2026-09-12 03:17:27','2026-09-12 03:17:27',NULL,NULL,'Svalbard & Jan Mayen',NULL,3,201),(604,'2026-09-12 03:17:27','2026-09-12 03:17:27',NULL,NULL,'Swaziland',NULL,1,202),(605,'2026-09-12 03:17:27','2026-09-12 03:17:27',NULL,NULL,'Swaziland',NULL,2,202),(606,'2026-09-12 03:17:27','2026-09-12 03:17:27',NULL,NULL,'Eswatini',NULL,3,202),(607,'2026-09-12 03:17:27','2026-09-12 03:17:27',NULL,NULL,'Sweden',NULL,1,203),(608,'2026-09-12 03:17:27','2026-09-12 03:17:27',NULL,NULL,'Suède',NULL,2,203),(609,'2026-09-12 03:17:27','2026-09-12 03:17:27',NULL,NULL,'Sweden',NULL,3,203),(610,'2026-09-12 03:17:27','2026-09-12 03:17:27',NULL,NULL,'Switzerland',NULL,1,204),(611,'2026-09-12 03:17:27','2026-09-12 03:17:27',NULL,NULL,'Suisse',NULL,2,204),(612,'2026-09-12 03:17:27','2026-09-12 03:17:27',NULL,NULL,'Switzerland',NULL,3,204),(613,'2026-09-12 03:17:27','2026-09-12 03:17:27',NULL,NULL,'Syria',NULL,1,205),(614,'2026-09-12 03:17:27','2026-09-12 03:17:27',NULL,NULL,'Syrie',NULL,2,205),(615,'2026-09-12 03:17:27','2026-09-12 03:17:27',NULL,NULL,'Syria',NULL,3,205),(616,'2026-09-12 03:17:27','2026-09-12 03:17:27',NULL,NULL,'Taiwan',NULL,1,206),(617,'2026-09-12 03:17:27','2026-09-12 03:17:27',NULL,NULL,'Taïwan',NULL,2,206),(618,'2026-09-12 03:17:27','2026-09-12 03:17:27',NULL,NULL,'Taiwan',NULL,3,206),(619,'2026-09-12 03:17:27','2026-09-12 03:17:27',NULL,NULL,'Tajikistan',NULL,1,207),(620,'2026-09-12 03:17:27','2026-09-12 03:17:27',NULL,NULL,'Tadjikistan',NULL,2,207),(621,'2026-09-12 03:17:27','2026-09-12 03:17:27',NULL,NULL,'Tajikistan',NULL,3,207),(622,'2026-09-12 03:17:27','2026-09-12 03:17:27',NULL,NULL,'Tanzania',NULL,1,208),(623,'2026-09-12 03:17:27','2026-09-12 03:17:27',NULL,NULL,'Tanzanie',NULL,2,208),(624,'2026-09-12 03:17:27','2026-09-12 03:17:27',NULL,NULL,'Tanzania',NULL,3,208),(625,'2026-09-12 03:17:27','2026-09-12 03:17:27',NULL,NULL,'Thailand',NULL,1,209),(626,'2026-09-12 03:17:27','2026-09-12 03:17:27',NULL,NULL,'Thaïlande',NULL,2,209),(627,'2026-09-12 03:17:27','2026-09-12 03:17:27',NULL,NULL,'Thailand',NULL,3,209),(628,'2026-09-12 03:17:28','2026-09-12 03:17:28',NULL,NULL,'Timor-Leste',NULL,1,210),(629,'2026-09-12 03:17:28','2026-09-12 03:17:28',NULL,NULL,'Timor oriental',NULL,2,210),(630,'2026-09-12 03:17:28','2026-09-12 03:17:28',NULL,NULL,'Timor-Leste',NULL,3,210),(631,'2026-09-12 03:17:28','2026-09-12 03:17:28',NULL,NULL,'Togo',NULL,1,211),(632,'2026-09-12 03:17:28','2026-09-12 03:17:28',NULL,NULL,'Togo',NULL,2,211),(633,'2026-09-12 03:17:28','2026-09-12 03:17:28',NULL,NULL,'Togo',NULL,3,211),(634,'2026-09-12 03:17:28','2026-09-12 03:17:28',NULL,NULL,'Tokelau',NULL,1,212),(635,'2026-09-12 03:17:28','2026-09-12 03:17:28',NULL,NULL,'Tokélaou',NULL,2,212),(636,'2026-09-12 03:17:28','2026-09-12 03:17:28',NULL,NULL,'Tokelau',NULL,3,212),(637,'2026-09-12 03:17:28','2026-09-12 03:17:28',NULL,NULL,'Tonga',NULL,1,213),(638,'2026-09-12 03:17:28','2026-09-12 03:17:28',NULL,NULL,'Tonga',NULL,2,213),(639,'2026-09-12 03:17:28','2026-09-12 03:17:28',NULL,NULL,'Tonga',NULL,3,213),(640,'2026-09-12 03:17:28','2026-09-12 03:17:28',NULL,NULL,'Trinidad & Tobago',NULL,1,214),(641,'2026-09-12 03:17:28','2026-09-12 03:17:28',NULL,NULL,'Trinité-et-Tobago',NULL,2,214),(642,'2026-09-12 03:17:28','2026-09-12 03:17:28',NULL,NULL,'Trinidad & Tobago',NULL,3,214),(643,'2026-09-12 03:17:28','2026-09-12 03:17:28',NULL,NULL,'Tunisia',NULL,1,215),(644,'2026-09-12 03:17:28','2026-09-12 03:17:28',NULL,NULL,'Tunisie',NULL,2,215),(645,'2026-09-12 03:17:28','2026-09-12 03:17:28',NULL,NULL,'Tunisia',NULL,3,215),(646,'2026-09-12 03:17:28','2026-09-12 03:17:28',NULL,NULL,'Turkey',NULL,1,216),(647,'2026-09-12 03:17:28','2026-09-12 03:17:28',NULL,NULL,'Turquie',NULL,2,216),(648,'2026-09-12 03:17:28','2026-09-12 03:17:28',NULL,NULL,'Turkey',NULL,3,216),(649,'2026-09-12 03:17:28','2026-09-12 03:17:28',NULL,NULL,'Turkmenistan',NULL,1,217),(650,'2026-09-12 03:17:29','2026-09-12 03:17:29',NULL,NULL,'Turkménistan',NULL,2,217),(651,'2026-09-12 03:17:29','2026-09-12 03:17:29',NULL,NULL,'Turkmenistan',NULL,3,217),(652,'2026-09-12 03:17:29','2026-09-12 03:17:29',NULL,NULL,'Turks & Caicos Islands',NULL,1,218),(653,'2026-09-12 03:17:29','2026-09-12 03:17:29',NULL,NULL,'Îles Turques-et-Caïques',NULL,2,218),(654,'2026-09-12 03:17:29','2026-09-12 03:17:29',NULL,NULL,'Turks & Caicos Islands',NULL,3,218),(655,'2026-09-12 03:17:29','2026-09-12 03:17:29',NULL,NULL,'Tuvalu',NULL,1,219),(656,'2026-09-12 03:17:29','2026-09-12 03:17:29',NULL,NULL,'Tuvalu',NULL,2,219),(657,'2026-09-12 03:17:29','2026-09-12 03:17:29',NULL,NULL,'Tuvalu',NULL,3,219),(658,'2026-09-12 03:17:29','2026-09-12 03:17:29',NULL,NULL,'Uganda',NULL,1,220),(659,'2026-09-12 03:17:29','2026-09-12 03:17:29',NULL,NULL,'Ouganda',NULL,2,220),(660,'2026-09-12 03:17:29','2026-09-12 03:17:29',NULL,NULL,'Uganda',NULL,3,220),(661,'2026-09-12 03:17:29','2026-09-12 03:17:29',NULL,NULL,'Ukraine',NULL,1,221),(662,'2026-09-12 03:17:29','2026-09-12 03:17:29',NULL,NULL,'Ukraine',NULL,2,221),(663,'2026-09-12 03:17:29','2026-09-12 03:17:29',NULL,NULL,'Ukraine',NULL,3,221),(664,'2026-09-12 03:17:29','2026-09-12 03:17:29',NULL,NULL,'United Arab Emirates',NULL,1,222),(665,'2026-09-12 03:17:29','2026-09-12 03:17:29',NULL,NULL,'Émirats arabes unis',NULL,2,222),(666,'2026-09-12 03:17:29','2026-09-12 03:17:29',NULL,NULL,'United Arab Emirates',NULL,3,222),(667,'2026-09-12 03:17:29','2026-09-12 03:17:29',NULL,NULL,'United Kingdom',NULL,1,223),(668,'2026-09-12 03:17:29','2026-09-12 03:17:29',NULL,NULL,'Royaume-Uni',NULL,2,223),(669,'2026-09-12 03:17:29','2026-09-12 03:17:29',NULL,NULL,'United Kingdom',NULL,3,223),(670,'2026-09-12 03:17:29','2026-09-12 03:17:29',NULL,NULL,'United States',NULL,1,224),(671,'2026-09-12 03:17:29','2026-09-12 03:17:29',NULL,NULL,'États-Unis',NULL,2,224),(672,'2026-09-12 03:17:29','2026-09-12 03:17:29',NULL,NULL,'United States',NULL,3,224),(673,'2026-09-12 03:17:29','2026-09-12 03:17:29',NULL,NULL,'U.S. Outlying Islands',NULL,1,225),(674,'2026-09-12 03:17:30','2026-09-12 03:17:30',NULL,NULL,'Îles mineures éloignées des États-Unis',NULL,2,225),(675,'2026-09-12 03:17:30','2026-09-12 03:17:30',NULL,NULL,'U.S. Outlying Islands',NULL,3,225),(676,'2026-09-12 03:17:30','2026-09-12 03:17:30',NULL,NULL,'Uruguay',NULL,1,226),(677,'2026-09-12 03:17:30','2026-09-12 03:17:30',NULL,NULL,'Uruguay',NULL,2,226),(678,'2026-09-12 03:17:30','2026-09-12 03:17:30',NULL,NULL,'Uruguay',NULL,3,226),(679,'2026-09-12 03:17:30','2026-09-12 03:17:30',NULL,NULL,'Uzbekistan',NULL,1,227),(680,'2026-09-12 03:17:30','2026-09-12 03:17:30',NULL,NULL,'Ouzbékistan',NULL,2,227),(681,'2026-09-12 03:17:30','2026-09-12 03:17:30',NULL,NULL,'Uzbekistan',NULL,3,227),(682,'2026-09-12 03:17:30','2026-09-12 03:17:30',NULL,NULL,'Vanuatu',NULL,1,228),(683,'2026-09-12 03:17:30','2026-09-12 03:17:30',NULL,NULL,'Vanuatu',NULL,2,228),(684,'2026-09-12 03:17:30','2026-09-12 03:17:30',NULL,NULL,'Vanuatu',NULL,3,228),(685,'2026-09-12 03:17:30','2026-09-12 03:17:30',NULL,NULL,'Venezuela',NULL,1,229),(686,'2026-09-12 03:17:30','2026-09-12 03:17:30',NULL,NULL,'Venezuela',NULL,2,229),(687,'2026-09-12 03:17:30','2026-09-12 03:17:30',NULL,NULL,'Venezuela',NULL,3,229),(688,'2026-09-12 03:17:30','2026-09-12 03:17:30',NULL,NULL,'Vietnam',NULL,1,230),(689,'2026-09-12 03:17:30','2026-09-12 03:17:30',NULL,NULL,'Vietnam',NULL,2,230),(690,'2026-09-12 03:17:30','2026-09-12 03:17:30',NULL,NULL,'Vietnam',NULL,3,230),(691,'2026-09-12 03:17:30','2026-09-12 03:17:30',NULL,NULL,'British Virgin Islands',NULL,1,231),(692,'2026-09-12 03:17:30','2026-09-12 03:17:30',NULL,NULL,'Îles Vierges britanniques',NULL,2,231),(693,'2026-09-12 03:17:30','2026-09-12 03:17:30',NULL,NULL,'British Virgin Islands',NULL,3,231),(694,'2026-09-12 03:17:30','2026-09-12 03:17:30',NULL,NULL,'U.S. Virgin Islands',NULL,1,232),(695,'2026-09-12 03:17:31','2026-09-12 03:17:31',NULL,NULL,'Îles Vierges des États-Unis',NULL,2,232),(696,'2026-09-12 03:17:31','2026-09-12 03:17:31',NULL,NULL,'U.S. Virgin Islands',NULL,3,232),(697,'2026-09-12 03:17:31','2026-09-12 03:17:31',NULL,NULL,'Wallis & Futuna',NULL,1,233),(698,'2026-09-12 03:17:31','2026-09-12 03:17:31',NULL,NULL,'Wallis-et-Futuna',NULL,2,233),(699,'2026-09-12 03:17:31','2026-09-12 03:17:31',NULL,NULL,'Wallis & Futuna',NULL,3,233),(700,'2026-09-12 03:17:31','2026-09-12 03:17:31',NULL,NULL,'Western Sahara',NULL,1,234),(701,'2026-09-12 03:17:31','2026-09-12 03:17:31',NULL,NULL,'Sahara occidental',NULL,2,234),(702,'2026-09-12 03:17:31','2026-09-12 03:17:31',NULL,NULL,'Western Sahara',NULL,3,234),(703,'2026-09-12 03:17:31','2026-09-12 03:17:31',NULL,NULL,'Yemen',NULL,1,235),(704,'2026-09-12 03:17:31','2026-09-12 03:17:31',NULL,NULL,'Yémen',NULL,2,235),(705,'2026-09-12 03:17:31','2026-09-12 03:17:31',NULL,NULL,'Yemen',NULL,3,235),(706,'2026-09-12 03:17:31','2026-09-12 03:17:31',NULL,NULL,'Zambia',NULL,1,236),(707,'2026-09-12 03:17:31','2026-09-12 03:17:31',NULL,NULL,'Zambie',NULL,2,236),(708,'2026-09-12 03:17:31','2026-09-12 03:17:31',NULL,NULL,'Zambia',NULL,3,236),(709,'2026-09-12 03:17:31','2026-09-12 03:17:31',NULL,NULL,'Zimbabwe',NULL,1,237),(710,'2026-09-12 03:17:31','2026-09-12 03:17:31',NULL,NULL,'Zimbabwe',NULL,2,237),(711,'2026-09-12 03:17:31','2026-09-12 03:17:31',NULL,NULL,'Zimbabwe',NULL,3,237);
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
INSERT INTO `CUSTOMER` VALUES (1,_binary '\0',NULL,'2026-09-13 01:49:44',NULL,'Tu Viện Chơn Như','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','','1649678313',NULL,NULL,NULL,NULL,NULL,NULL,'Tu Viện Chơn Như','Tây Ninh','','Thanh Đức','Thích','80000','','1649678313','thanhduc0@gmail.com','M','thanhduc','$2a$10$INRVdpDvvdZKuWYrDvgAoO3tfBpBk3CA/Hc1.zGFJ7LZBTd4J7d3K',NULL,230,70,3,230,70,1),(50,_binary '\0',NULL,'2026-09-18 07:17:16',NULL,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,NULL,NULL,NULL,NULL,NULL,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','Tây Ninh',NULL,'1649678313','LeVatienamakhe@gmail.com','M','thanhduc1','$2a$10$LxileBDtVGhBfr3aPy9xdu8RjmktLMcJTYGnDPMS1hUtuh8RTVVTm',NULL,230,NULL,3,230,70,1),(100,_binary '\0',NULL,'2026-09-14 10:02:33',NULL,NULL,NULL,NULL,'Thanh Đức','Thích',NULL,NULL,NULL,'Tây Ninh',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'levatienamakhe@gmail.com','M','levatienamakhe@gmail.com','$2a$10$.z9AuigCJNCPJEfNenac4eIihZeRJ7dMuzws1cyXR0n9DpdTgBi2.',NULL,230,70,3,NULL,NULL,1),(101,_binary '\0',NULL,'2026-09-14 10:04:34',NULL,'Tu Vien Chon Nhu','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','','1649678313',NULL,NULL,NULL,NULL,NULL,NULL,'Tu Vien Chon Nhu','Tây Ninh','','Thanh Đức','Thích','80000','','1649678313','levatienamakhe@gmail.com','M','FJjyk-','$2a$10$7G3LMVVu0Wh5JrTTbvQ0JOKucYInkunwkEeJsvoul9Z9ZHD2WAEIy',NULL,230,70,3,230,70,1),(102,_binary '\0',NULL,'2026-09-14 10:06:47',NULL,'Chùa Am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','','1649678313',NULL,NULL,NULL,NULL,NULL,NULL,'Chùa Am','Tây Ninh','','Thanh Đức','Thích','80000','','1649678313','levatienamakhe@gmail.com','M','LvKzJ-','$2a$10$tmSiweBV1G3WIHb0JjVL9.hZLlL1RbG7vNf/GkHbDfYL0qDkgu8Na',NULL,230,70,3,230,70,1),(150,_binary '\0',NULL,'2026-09-16 08:52:32',NULL,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,NULL,NULL,NULL,NULL,NULL,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','thanhduc1@gmail.com','M','zKupOI','$2a$10$0w5.de9yDk/xYzNnYWbYPefz.X4ExVsCQUQhh1RWlLlsk3CkZ4SSe',NULL,230,NULL,3,230,NULL,1),(151,_binary '\0',NULL,'2026-09-16 08:57:13',NULL,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,NULL,NULL,NULL,NULL,NULL,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','tuvienchonnhu1928.01@gmail.com','M','admin@shopizer.com','$2a$10$.JTalqbkHy./LeTYEF8aXuY1npXgzvtUoIeQ/S3A5.BrwaXyT0EWG',NULL,230,NULL,3,230,NULL,1),(200,_binary '\0',NULL,'2026-09-18 08:06:41',NULL,'Tu Viện Chơn Như','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Ningxia','1649678313',NULL,NULL,NULL,NULL,NULL,NULL,'Tu Viện Chơn Như','Tây Ninh','','Thanh Đức','Thích','80000','Ningxia','1649678313','thanhduc2@gmail.com','M','thanhduc2','$2a$10$2VXnWFVQ4WewPJ4yjdYKYevvlkc3PK/zeZv6mUfCo97w0fHmVk3Qa',NULL,230,NULL,3,230,NULL,1);
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
INSERT INTO `CUSTOMER_GROUP` VALUES (1,8),(50,8),(100,8),(101,8),(102,8),(150,8),(151,8),(200,8);
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
INSERT INTO `LANGUAGE` VALUES (1,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,'en',1),(2,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,'fr',3),(3,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,'vi',0),(4,'2026-09-14 02:37:55','2026-09-14 02:37:55',NULL,'zh',2);
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
INSERT INTO `MANUFACTURER` VALUES (1,'2026-09-12 03:18:04','2026-09-12 03:18:04',NULL,'DEFAULT',NULL,0,1);
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
INSERT INTO `MANUFACTURER_DESCRIPTION` VALUES (1,'2026-09-12 03:18:04','2026-09-12 03:18:04',NULL,'DEFAULT','DEFAULT',NULL,NULL,NULL,NULL,1,1);
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
INSERT INTO `MERCHANT_CONFIGURATION` VALUES (1,_binary '\0','2026-09-12 03:18:04','2026-09-15 00:00:55',NULL,'CONFIG','CONFIG','{\"allowPurchaseItems\":true,\"displayContactUs\":true,\"displayCustomerAgreement\":false,\"defaultSearchConfigPath\":{},\"displayCustomerSection\":true,\"displayAddToCartOnFeaturedItems\":true,\"displayPagesMenu\":true,\"testMode\":false,\"displayStoreAddress\":true,\"displaySearchBox\":true,\"debugMode\":false,\"useDefaultSearchConfig\":{\"vn\":true,\"en\":true,\"fr\":true,\"zh\":true}}',1),(2,_binary '\0','2026-09-12 03:24:41','2026-09-12 03:25:02',NULL,'SHIPPING','INTEGRATION','df02614ab6600db0eb4d78e2c4df5574aa0324c2285e18aba55dd89532de92917f50c7b91baa22d4e56e17c3f3b473f6d80047d42d75bcd9e221b2c489dcd65c9d998bd97fba4d3aadad01998bc3e72c5cb3168813702f6e62624d9fc15fd9b808cd1f4d98fff8d3667219355a38cdf7bf9d1df4d3cc32b346ce8611b74650b42941cfce39cc845574d5ad7e401e5fa861ae9c62c5873b735084bd3e3f29cdebc39c03595ca3f67861fe1380919c4d5b104e0c1f7a034328c5a9bd3853f8905bc95c0501fea735d0f57bfc8dd52ee519be71ddeb59ca0f979e605f0ec54b2acda88c15a65882a9bcd3a7f51be8b88f5adfcc9cd0bffb307ded71348d7c193a66a61e7bf395422180ed41c0e423a16b1ddde898f769a1cda3fcef8bcaee3e35d4a90e8fcd5c37ad945bf72d4cb5ee60642d9862d35c01a51ba4763ce82bf7a193fa3bd588f49ff66fe400bd3211a149859b318e2a4cf4c3f733909c35f8b1f571ea1a02db7ed6ec32dbaebda156891481',1),(3,_binary '\0','2026-09-12 03:25:02','2026-09-12 03:25:02',NULL,'weightBased','INTEGRATION','{\"moduleCode\":\"weightBased\",\"active\":true}',1),(4,_binary '\0','2026-09-12 07:18:01','2026-09-13 01:49:05',NULL,'PAYMENT','INTEGRATION','df02614ab6600db0eb4d78e2c4df5574f9ba1903c78f9da01dded48dcbe5fa1395559a2eb8160dd8615b22e900932a7bac035d6eaa57b1ec05f4cedf94c2d8054819918ba0b244669d6987678949825eee5e06278ad1acdb473840b69721531c51e62999ba70c79fdd7257895873ce0e0b5c8b8b55e7ff1cc9f066711f6dbfbb11e037163b67e277b10bfd6140e550c126bb360c89f178db29b60c2f265621242bbc97c43dd779599139b234a50024030d7127e78a6058230cf75a764120a3f3b0791280a387d4dadc19fb8d371b37ff32615883c53d109ea174783dddbe696df61ebf0518ecc26bfab12a82e83160023a1ba3b4a14f211cec01187ec0d7752dca45b17318bfb9ac64f7c6b02d0f30b4eb719803723573b14a31668fdd7f304bd9b6416a4128de1c1a559dd401e1d70c285bccc47c1b0ae0fa439bd6a373fba9ee54f3423a5a76c079df2a38854a5fe60ac45e9ac0800020b4013a7754d1bf51dcd93b3369b341a64ecf9209e82466d7',1),(50,_binary '\0','2026-09-14 10:01:33','2026-09-18 01:50:56',NULL,'EMAIL_CONFIG','INTEGRATION','{\"protocol\":\"smtp\",\"password\":\"iksiovmcvhubpgfr\",\"smtpAuth\":true,\"starttls\":true,\"port\":\"587\",\"host\":\"smtp.gmail.com\",\"username\":\"anlacduyen01@gmail.com\"}',1),(100,_binary '\0','2026-09-18 08:14:15','2026-09-18 10:22:21',NULL,'SHIPPING_CONFIG','INTEGRATION','{\"boxLength\":0,\"orderTotalFreeShipping\":600000.00,\"shipBaseType\":\"SHIPPING\",\"shipOptionPriceType\":\"ALL\",\"maxWeight\":0.0,\"boxHeight\":0,\"packages\":[],\"shipFreeType\":\"NATIONAL\",\"taxOnShipping\":false,\"shipPackageType\":\"ITEM\",\"freeShippingEnabled\":false,\"boxWeight\":0.0,\"shipType\":\"INTERNATIONAL\",\"boxWidth\":0,\"handlingFees\":null,\"shipDescription\":\"SHORT_DESCRIPTION\"}',1);
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
INSERT INTO `MERCHANT_LANGUAGE` VALUES (50,1),(50,2),(50,3),(1,1),(1,2),(1,3),(1,4);
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
INSERT INTO `MERCHANT_STORE` VALUES (1,NULL,NULL,NULL,'DEFAULT',NULL,_binary '\0','','2026-09-12',NULL,_binary '\0','CM','anlacduyen01@gmail.com','logo.jpg','bootstrap','Tu Viện Chơn Như','My city','Bách Hóa  An Lạc Duyên','0949777111','80000','',_binary '\0','KG',230,81,3,NULL,70),(50,NULL,NULL,NULL,'ChayAnLac',NULL,_binary '\0','','2026-09-13',NULL,_binary '\0','CM','chayanlac@gmail.com','','exoticamobilia','Đường tỉnh 787, Phường Gia Lộc','Tây Ninh','Quán Chay An Lạc','1649678313','80000','',_binary '\0','KG',230,81,3,NULL,70);
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
INSERT INTO `MODULE_CONFIGURATION` VALUES (1,'2026-09-12 03:18:03','2026-09-12 03:18:03',NULL,'usps',NULL,'[{\"scheme\":\"http\",\"host\":\"testing.shippingapis.com\",\"port\":\"80\",\"uri\":\"/ShippingAPI.dll\",\"env\":\"TEST\",\"config1\":null,\"config2\":null},{\"scheme\":\"http\",\"host\":\"production.shippingapis.com\",\"port\":\"80\",\"uri\":\"/ShippingAPI.dll\",\"env\":\"PROD\",\"config1\":null,\"config2\":null}]',_binary '\0','usps.jpg','SHIPPING','[\"US\"]',NULL),(2,'2026-09-12 03:18:03','2026-09-12 03:18:03',NULL,'canadapost',NULL,'[{\"scheme\":\"https\",\"host\":\"ct.soa-gw.canadapost.ca\",\"port\":\"443\",\"uri\":\"/rs/ship/price\",\"env\":\"TEST\",\"config1\":null,\"config2\":null},{\"scheme\":\"https\",\"host\":\"soa-gw.canadapost.ca\",\"port\":\"443\",\"uri\":\"/rs/ship/price\",\"env\":\"PROD\",\"config1\":null,\"config2\":null}]',_binary '\0','canadapost.jpg','SHIPPING','[\"CA\"]',NULL),(3,'2026-09-12 03:18:03','2026-09-12 03:18:03',NULL,'ups','{\"01\":\"UPS Next Day Air\",\"02\":\"UPS Second Day Air\",\"03\":\"UPS Ground\",\"07\":\"UPS Worldwide Express\",\"08\":\"UPS Worldwide Expedited\",\"11\":\"UPS Standard\",\"12\":\"UPS Three-Day Select\",\"13\":\"UPS Next Day Air Saver\",\"14\":\"UPS Next Day Air Early A.M.\",\"54\":\"UPS Worldwide Express Plus\",\"59\":\"UPS Second Day Air A.M.\",\"69\":\"UPS Saver\"}','[{\"scheme\":\"https\",\"host\":\"wwwcie.ups.com\",\"port\":\"443\",\"uri\":\"/ups.app/xml/Rate\",\"env\":\"TEST\",\"config1\":null,\"config2\":null},{\"scheme\":\"https\",\"host\":\"onlinetools.ups.com\",\"port\":\"443\",\"uri\":\"/xml/Rate\",\"env\":\"PROD\",\"config1\":null,\"config2\":null}]',_binary '\0','ups.jpg','SHIPPING','[\"US\",\"CA\",\"FR\",\"GB\"]',NULL),(4,'2026-09-12 03:18:03','2026-09-12 03:18:03',NULL,'weightBased',NULL,NULL,_binary '',NULL,'SHIPPING','[\"*\"]',NULL),(5,'2026-09-12 03:18:03','2026-09-12 03:18:03',NULL,'customQuotesRules',NULL,NULL,_binary '\0',NULL,'SHIPPING','[\"*\"]',NULL),(6,'2026-09-12 03:18:03','2026-09-12 03:18:03',NULL,'priceByDistance',NULL,NULL,_binary '\0',NULL,'SHIPPING','[\"*\"]',NULL),(7,'2026-09-12 03:18:03','2026-09-12 03:18:03',NULL,'storePickUp',NULL,NULL,_binary '\0',NULL,'SHIPPING','[\"*\"]',NULL),(8,'2026-09-12 03:18:03','2026-09-12 03:18:03',NULL,'moneyorder',NULL,NULL,_binary '\0','moneyorder.gif','PAYMENT','[\"*\"]','moneyorder'),(9,'2026-09-12 03:18:03','2026-09-12 03:18:03',NULL,'paypal-express-checkout',NULL,'[{\"scheme\":\"\",\"host\":\"\",\"port\":\"\",\"uri\":\"\",\"env\":\"TEST\",\"config1\":\"https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=\",\"config2\":null},{\"scheme\":\"\",\"host\":\"\",\"port\":\"\",\"uri\":\"\",\"env\":\"PROD\",\"config1\":\"https://www.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=\",\"config2\":null}]',_binary '\0','icon-paypal.png','PAYMENT','[\"*\"]','paypal'),(10,'2026-09-12 03:18:03','2026-09-12 03:18:03',NULL,'beanstream',NULL,'[{\"scheme\":\"https\",\"host\":\"www.beanstream.com\",\"port\":\"443\",\"uri\":\"/scripts/process_transaction.asp\",\"env\":\"TEST\",\"config1\":null,\"config2\":null},{\"scheme\":\"https\",\"host\":\"www.beanstream.com\",\"port\":\"443\",\"uri\":\"/scripts/process_transaction.asp\",\"env\":\"PROD\",\"config1\":null,\"config2\":null}]',_binary '\0','beanstream.gif','PAYMENT','[\"US\",\"CA\",\"GB\"]','creditcard'),(11,'2026-09-12 03:18:03','2026-09-12 03:18:03',NULL,'stripe',NULL,'[{\"scheme\":\"https\",\"host\":\"www.stripe.com\",\"port\":\"443\",\"uri\":\"/\",\"env\":\"TEST\",\"config1\":null,\"config2\":null},{\"scheme\":\"https\",\"host\":\"www.stripe.com\",\"port\":\"443\",\"uri\":\"/\",\"env\":\"PROD\",\"config1\":null,\"config2\":null}]',_binary '\0','stripe.png','PAYMENT','[\"US\",\"CA\",\"GB\",\"AU\",\"FI\",\"DK\",\"IE\",\"NO\",\"SE\",\"ES\",\"PT\"]','creditcard'),(12,'2026-09-12 03:18:03','2026-09-12 03:18:03',NULL,'stripe3',NULL,'[{\"scheme\":\"https\",\"host\":\"www.stripe.com\",\"port\":\"443\",\"uri\":\"/\",\"env\":\"TEST\",\"config1\":null,\"config2\":null},{\"scheme\":\"https\",\"host\":\"www.stripe.com\",\"port\":\"443\",\"uri\":\"/\",\"env\":\"PROD\",\"config1\":null,\"config2\":null}]',_binary '\0','stripe.png','PAYMENT','[\"US\",\"CA\",\"GB\",\"AU\",\"FI\",\"DK\",\"IE\",\"NO\",\"SE\",\"ES\",\"PT\"]','creditcard'),(13,'2026-09-12 03:18:03','2026-09-12 03:18:03',NULL,'braintree',NULL,'[{\"scheme\":\"https\",\"host\":\"NOTREQUIRED\",\"port\":\"NOTREQUIRED\",\"uri\":\"NOTREQUIRED\",\"env\":\"TEST\",\"config1\":null,\"config2\":null},{\"scheme\":\"https\",\"host\":\"NOTREQUIRED\",\"port\":\"NOTREQUIRED\",\"uri\":\"NOTREQUIRED\",\"env\":\"PROD\",\"config1\":null,\"config2\":null}]',_binary '\0','braintree.jpg','PAYMENT','[\"US\",\"CA\",\"GB\",\"AU\",\"FI\",\"DK\",\"IE\",\"NO\",\"SE\",\"AL\",\"AD\",\"AT\",\"BY\",\"BE\",\"BG\",\"HY\",\"CY\",\"CZ\",\"FR\",\"GR\",\"IS\",\"IE\",\"IM\",\"IT\",\"PL\",\"LU\",\"CH\",\"RS\",\"SG\",\"MY\",\"HK\",\"NZ\"]','creditcard');
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
INSERT INTO `ORDERS` VALUES (1,'Tu Viện Chơn Như','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','thanhduc0@gmail.com',1,'2026-09-12','Tu Viện Chơn Như','Tây Ninh','','Thanh Đức','Thích','80000','','1649678313','0:0:0:0:0:0:0:1',NULL,'en',NULL,'ORDER','moneyorder','MONEYORDER','storePickUp','09424e71874b451e8280f97c6d132b73','ORDERED',200000.00,230,70,81,230,70,1),(2,'Tu Viện Chơn Như','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','thanhduc0@gmail.com',1,'2026-09-12','Tu Viện Chơn Như','Tây Ninh','','Thanh Đức','Thích','80000','','1649678313','0:0:0:0:0:0:0:1',NULL,'en',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','84321bce6e414f32bf13183b116c5b2a','ORDERED',200140.00,230,70,81,230,70,1),(3,'Tu Viện Chơn Như','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','thanhduc0@gmail.com',1,'2026-09-12','Tu Viện Chơn Như','Tây Ninh','','Thanh Đức','Thích','80000','','1649678313','0:0:0:0:0:0:0:1',NULL,'en',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','8196ce912bcd40ff9d584ac6073feed5','ORDERED',200140.00,230,70,81,230,70,1),(4,'Tu Viện Chơn Như','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','thanhduc0@gmail.com',1,'2026-09-12','Tu Viện Chơn Như','Tây Ninh','','Thanh Đức','Thích','80000','','1649678313','0:0:0:0:0:0:0:1',NULL,'en',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','4292617c01774aaf85b65a59633af5f1','ORDERED',200140.00,230,70,81,230,70,1),(5,'Tu Viện Chơn Như','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','thanhduc0@gmail.com',1,'2026-09-12','Tu Viện Chơn Như','Tây Ninh','','Thanh Đức','Thích','80000','','1649678313','0:0:0:0:0:0:0:1',NULL,'en',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','f157a7796e0046f19ba18c7f43a83598','ORDERED',2000140.00,230,70,81,230,70,1),(50,'Tu Viện Chơn Như','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','thanhduc0@gmail.com',1,'2026-09-12','Tu Viện Chơn Như','Tây Ninh','','Thanh Đức','Thích','80000','','1649678313','0:0:0:0:0:0:0:1',NULL,'en',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','e787b4d3b60148b89ff7ac8253bbe6f5','ORDERED',400140.00,230,70,81,230,70,1),(100,'Tu Viện Chơn Như','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','thanhduc0@gmail.com',1,'2026-09-13','Tu Viện Chơn Như','Tây Ninh','','Thanh Đức','Thích','80000','','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','d5e6ea3194c14352b090b5f2d9bc09cd','ORDERED',400140.00,230,70,81,230,70,1),(101,'Tu Viện Chơn Như','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','thanhduc0@gmail.com',1,'2026-09-13','Tu Viện Chơn Như','Tây Ninh','','Thanh Đức','Thích','80000','','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','e7d1ba7a256d4867b636fc6db66b9f50','ORDERED',200140.00,230,70,81,230,70,1),(102,'Tu Viện Chơn Như','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','thanhduc0@gmail.com',1,'2026-09-13','Tu Viện Chơn Như','Tây Ninh','','Thanh Đức','Thích','80000','','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','16dd9044ac584a579f23655937bc6c0e','ORDERED',400140.00,230,70,81,230,70,1),(150,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','thanhduc1@gmail.com',50,'2026-09-13','số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','c3d345341c3d4d49b6399eafdc150ac3','ORDERED',200140.00,230,NULL,81,230,NULL,1),(200,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','thanhduc1@gmail.com',50,'2026-09-13','số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','50abc5c941a64976be0817abd2addb3b','ORDERED',200140.00,230,NULL,81,230,NULL,1),(250,'Tu Vien Chon Nhu','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','levatienamakhe@gmail.com',101,'2026-09-14','Tu Vien Chon Nhu','Tây Ninh','','Thanh Đức','Thích','80000','','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','storePickUp','d10c74a8bb524d62a00b72d4c6ebd35c','ORDERED',400000.00,230,70,81,230,70,1),(251,'Chùa Am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','levatienamakhe@gmail.com',102,'2026-09-14','Chùa Am','Tây Ninh','','Thanh Đức','Thích','80000','','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','3ace8d8aad74453a83d7cdd6253ee840','ORDERED',200140.00,230,70,81,230,70,1),(300,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','thanhduc1@gmail.com',150,'2026-09-16','số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','86aad2108fcc4be596971ce5c307f7d2','ORDERED',200140.00,230,NULL,81,230,NULL,1),(301,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','tuvienchonnhu1928.01@gmail.com',151,'2026-09-16','số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','6813ef00e9014f4c8eb7d20b8ffbd3ae','ORDERED',200140.00,230,NULL,81,230,NULL,1),(350,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','thanhduc1@gmail.com',50,'2026-09-16','số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','86aad2108fcc4be596971ce5c307f7d2','ORDERED',400140.00,230,NULL,81,230,NULL,1),(400,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','LeVatienamakhe@gmail.com',50,'2026-09-17','số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','c1fc6b51a574410a8be5c6984328f669','ORDERED',400140.00,230,NULL,81,230,NULL,1),(450,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','LeVatienamakhe@gmail.com',50,'2026-09-18','số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','fbe03e5558d54f50bcfc56c88b6a5316','ORDERED',200140.00,230,NULL,81,230,NULL,1),(500,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','LeVatienamakhe@gmail.com',50,'2026-09-18','số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','9431856e46c5408c9a24bfe25585bf15','ORDERED',200140.00,230,NULL,81,230,NULL,1),(550,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','LeVatienamakhe@gmail.com',50,'2026-09-18','số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','23e4874019834366ac2532fd920da816','ORDERED',200140.00,230,NULL,81,230,NULL,1),(600,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','LeVatienamakhe@gmail.com',50,'2026-09-18','số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','4d533d4a34cf438ea8ecbfb4337b669a','ORDERED',200140.00,230,NULL,81,230,NULL,1),(601,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','LeVatienamakhe@gmail.com',50,'2026-09-18','số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','03313fcfd54746f2b7eb8f2f3724a733','ORDERED',200140.00,230,NULL,81,230,NULL,1),(602,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','LeVatienamakhe@gmail.com',50,'2026-09-18','số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','f4b23809b74040e69c9b2df23a3869b0','ORDERED',200140.00,230,NULL,81,230,NULL,1),(603,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','LeVatienamakhe@gmail.com',50,'2026-09-18','số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','e6443cf8b41a44048f6fc63899ad23ba','ORDERED',200140.00,230,NULL,81,230,NULL,1),(650,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','LeVatienamakhe@gmail.com',50,'2026-09-18','số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','68f6851fc490443bb60e4a51c563f896','ORDERED',200140.00,230,NULL,81,230,NULL,1),(651,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','LeVatienamakhe@gmail.com',50,'2026-09-18','số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','ff9c25e9791048079b8354aeddb01a87','ORDERED',200140.00,230,NULL,81,230,NULL,1),(700,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','LeVatienamakhe@gmail.com',50,'2026-09-18','số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','d8e6645fde8e4505b5572360f1f20c6b','ORDERED',200140.00,230,NULL,81,230,NULL,1),(750,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','LeVatienamakhe@gmail.com',50,'2026-09-18','số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','18a5b8c1e5a74e8b9b552aa9275ddadf','ORDERED',200140.00,230,NULL,81,230,NULL,1),(751,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','LeVatienamakhe@gmail.com',50,'2026-09-18','số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','35ffff66da0b4c058b514c5f275e783f','ORDERED',200140.00,230,NULL,81,230,NULL,1),(800,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','LeVatienamakhe@gmail.com',50,'2026-09-18','số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','4d2bdd7b7b0c4f639738ed9abc8f59f2','ORDERED',200140.00,230,NULL,81,230,NULL,1),(850,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','LeVatienamakhe@gmail.com',50,'2026-09-18','số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','e1328b9af04446d5834f6664fe8ddcda','ORDERED',200140.00,230,NULL,81,230,NULL,1),(900,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','LeVatienamakhe@gmail.com',50,'2026-09-18','số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','e340b1371c4a4b7986cea245d7c50cca','ORDERED',200140.00,230,NULL,81,230,NULL,1),(950,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','LeVatienamakhe@gmail.com',50,'2026-09-18','số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','f4191d4379ae4062a8f644d226c132e9','ORDERED',400140.00,230,NULL,81,230,NULL,1),(951,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','LeVatienamakhe@gmail.com',50,'2026-09-18','số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','7e88590a20b54546b54f0fdbe3a0cdca','ORDERED',400140.00,230,NULL,81,230,NULL,1),(952,'số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Tây Ninh','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','LeVatienamakhe@gmail.com',50,'2026-09-18','số 4 đường Chùa am','Tây Ninh','','Thanh Đức','Thích','80000','Tây Ninh','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','6f3ed08b6f5a43138bf54857de9c34e8','ORDERED',200140.00,230,NULL,81,230,NULL,1),(1000,'Tu Viện Chơn Như','Tây Ninh','','Thanh Đức','Thích',NULL,NULL,'80000','Ningxia','1649678313',NULL,_binary '\0',NULL,NULL,NULL,NULL,NULL,1.00,_binary '\0','levatienamakhe@gmail.com',200,'2026-09-18','Tu Viện Chơn Như','Tây Ninh','','Thanh Đức','Thích','80000','Ningxia','1649678313','0:0:0:0:0:0:0:1',NULL,'en_US',NULL,'ORDER','moneyorder','MONEYORDER','customQuotesRules','4d331374cdd145479d2283ed297c0fce','ORDERED',200140.00,230,NULL,81,230,NULL,1);
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
INSERT INTO `ORDER_PRODUCT` VALUES (1,200000.00,'ST25',1,'NK01',1),(2,200000.00,'ST25',1,'NK01',2),(3,200000.00,'Gạo ST25',1,'NK01',3),(4,200000.00,'ST25',1,'NK01',4),(5,200000.00,'Gạo ST25',10,'NK01',5),(50,200000.00,'ST25',2,'NK01',50),(100,200000.00,'ST25',2,'NK01',100),(101,200000.00,'Gạo ST25',1,'NK01',101),(102,200000.00,'Gạo ST25',2,'NK01',102),(150,200000.00,'ST25',1,'NK01',150),(200,200000.00,'Gạo ST25',1,'NK01',200),(250,200000.00,'Gạo ST25',2,'NK01',250),(251,200000.00,'Gạo ST25',1,'NK01',251),(300,200000.00,'',1,'NK01',300),(301,200000.00,'ST25',1,'NK01',301),(350,200000.00,'',1,'NK01',350),(351,200000.00,'',1,'NK01',350),(400,200000.00,'ST25',2,'NK01',400),(450,200000.00,'ST25',1,'NK01',450),(500,200000.00,'ST25',1,'NK01',500),(550,200000.00,'ST25',1,'NK01',550),(600,200000.00,'ST25',1,'NK01',600),(601,200000.00,'ST25',1,'NK01',601),(602,200000.00,'Gạo ST25',1,'NK01',602),(603,200000.00,'ST25',1,'NK01',603),(650,200000.00,'ST25',1,'NK01',650),(651,200000.00,'ST25',1,'NK01',651),(700,200000.00,'ST25',1,'NK01',700),(750,200000.00,'Gạo ST25',1,'NK01',750),(751,200000.00,'ST25',1,'NK01',751),(800,200000.00,'ST25',1,'NK01',800),(850,200000.00,'Gạo ST25',1,'NK01',850),(900,200000.00,'ST25',1,'NK01',900),(950,200000.00,'ST25',2,'NK01',950),(951,200000.00,'Gạo ST25',1,'NK01',951),(952,200000.00,'Gạo ST25',1,'NK01',951),(953,200000.00,'ST25',1,'NK01',952),(1000,200000.00,'Gạo ST25',1,'NK01',1000);
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
INSERT INTO `ORDER_PRODUCT_PRICE` VALUES (1,_binary '',200000.00,'ST25','DEFAULT',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',1),(2,_binary '',200000.00,'ST25','DEFAULT',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',2),(3,_binary '',200000.00,'ST25','ST25',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',3),(4,_binary '',200000.00,'ST25','ST25',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',4),(5,_binary '',200000.00,'ST25','ST25',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',5),(50,_binary '',200000.00,'ST25','DEFAULT',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',50),(100,_binary '',200000.00,'ST25','ST25',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',100),(101,_binary '',200000.00,'ST25','DEFAULT',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',101),(102,_binary '',200000.00,'ST25','DEFAULT',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',102),(150,_binary '',200000.00,'ST25','ST25',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',150),(200,_binary '',200000.00,'ST25','ST25',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',200),(250,_binary '',200000.00,'ST25','DEFAULT',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',250),(251,_binary '',200000.00,'ST25','ST25',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',251),(300,_binary '',200000.00,'ST25','DEFAULT',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',300),(301,_binary '',200000.00,'ST25','DEFAULT',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',301),(350,_binary '',200000.00,'ST25','ST25',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',350),(351,_binary '',200000.00,'ST25','ST25',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',351),(400,_binary '',200000.00,'ST25','DEFAULT',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',400),(450,_binary '',200000.00,'ST25','DEFAULT',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',450),(500,_binary '',200000.00,'ST25','DEFAULT',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',500),(550,_binary '',200000.00,'ST25','DEFAULT',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',550),(600,_binary '',200000.00,'ST25','DEFAULT',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',600),(601,_binary '',200000.00,'ST25','DEFAULT',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',601),(602,_binary '',200000.00,'ST25','ST25',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',602),(603,_binary '',200000.00,'ST25','DEFAULT',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',603),(650,_binary '',200000.00,'ST25','DEFAULT',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',650),(651,_binary '',200000.00,'ST25','DEFAULT',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',651),(700,_binary '',200000.00,'ST25','DEFAULT',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',700),(750,_binary '',200000.00,'ST25','DEFAULT',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',750),(751,_binary '',200000.00,'ST25','ST25',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',751),(800,_binary '',200000.00,'ST25','DEFAULT',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',800),(850,_binary '',200000.00,'ST25','DEFAULT',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',850),(900,_binary '',200000.00,'ST25','DEFAULT',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',900),(950,_binary '',200000.00,'ST25','DEFAULT',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',950),(951,_binary '',200000.00,'ST25','ST25',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',951),(952,_binary '',200000.00,'ST25','ST25',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',952),(953,_binary '',200000.00,'ST25','ST25',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',953),(1000,_binary '',200000.00,'ST25','2000',200000.00,'2026-11-11 17:00:00','2026-09-11 17:00:00',1000);
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
INSERT INTO `ORDER_STATUS_HISTORY` VALUES (1,NULL,NULL,'2026-09-12 07:53:25','ORDERED',1),(2,NULL,NULL,'2026-09-12 08:18:02','ORDERED',2),(3,NULL,NULL,'2026-09-12 08:21:55','ORDERED',3),(4,NULL,NULL,'2026-09-12 08:22:24','ORDERED',4),(5,NULL,NULL,'2026-09-12 08:28:28','ORDERED',5),(50,NULL,NULL,'2026-09-12 08:34:55','ORDERED',50),(100,NULL,NULL,'2026-09-13 01:17:05','ORDERED',100),(101,NULL,NULL,'2026-09-13 01:18:30','ORDERED',101),(102,NULL,NULL,'2026-09-13 01:49:45','ORDERED',102),(150,NULL,NULL,'2026-09-13 12:32:05','ORDERED',150),(200,NULL,NULL,'2026-09-13 13:49:41','ORDERED',200),(250,'aaa',NULL,'2026-09-14 10:04:35','ORDERED',250),(251,NULL,NULL,'2026-09-14 10:06:47','ORDERED',251),(300,NULL,NULL,'2026-09-16 08:52:32','ORDERED',300),(301,NULL,NULL,'2026-09-16 08:57:13','ORDERED',301),(350,NULL,NULL,'2026-09-16 10:27:20','ORDERED',350),(400,NULL,NULL,'2026-09-17 14:42:41','ORDERED',400),(450,NULL,NULL,'2026-09-17 23:38:55','ORDERED',450),(500,NULL,NULL,'2026-09-18 00:14:33','ORDERED',500),(550,NULL,NULL,'2026-09-18 00:45:43','ORDERED',550),(600,NULL,NULL,'2026-09-18 01:32:38','ORDERED',600),(601,NULL,NULL,'2026-09-18 01:36:16','ORDERED',601),(602,NULL,NULL,'2026-09-18 01:41:37','ORDERED',602),(603,NULL,NULL,'2026-09-18 01:42:22','ORDERED',603),(650,NULL,NULL,'2026-09-18 01:45:58','ORDERED',650),(651,NULL,NULL,'2026-09-18 01:51:44','ORDERED',651),(700,NULL,NULL,'2026-09-18 02:20:35','ORDERED',700),(750,NULL,NULL,'2026-09-18 02:53:49','ORDERED',750),(751,NULL,NULL,'2026-09-18 02:55:45','ORDERED',751),(800,NULL,NULL,'2026-09-18 03:08:43','ORDERED',800),(850,NULL,NULL,'2026-09-18 06:17:03','ORDERED',850),(900,NULL,NULL,'2026-09-18 06:36:17','ORDERED',900),(950,NULL,NULL,'2026-09-18 06:59:25','ORDERED',950),(951,NULL,NULL,'2026-09-18 07:16:32','ORDERED',951),(952,NULL,NULL,'2026-09-18 07:17:16','ORDERED',952),(1000,NULL,NULL,'2026-09-18 08:06:41','ORDERED',1000);
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
INSERT INTO `ORDER_TOTAL` VALUES (1,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,1),(2,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',0.0000,1),(3,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200000.0000,1),(4,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,2),(5,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,2),(6,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,2),(7,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,3),(8,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,3),(9,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,3),(10,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,4),(11,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,4),(12,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,4),(13,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',2000000.0000,5),(14,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,5),(15,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',2000140.0000,5),(50,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',400000.0000,50),(51,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,50),(52,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',400140.0000,50),(100,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',400000.0000,100),(101,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,100),(102,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',400140.0000,100),(103,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,101),(104,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,101),(105,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,101),(106,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',400000.0000,102),(107,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,102),(108,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',400140.0000,102),(150,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,150),(151,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,150),(152,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,150),(200,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,200),(201,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,200),(202,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,200),(250,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',400000.0000,250),(251,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',0.0000,250),(252,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',400000.0000,250),(253,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,251),(254,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,251),(255,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,251),(300,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,300),(301,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,300),(302,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,300),(303,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,301),(304,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,301),(305,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,301),(350,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',400000.0000,350),(351,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,350),(352,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',400140.0000,350),(400,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',400000.0000,400),(401,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,400),(402,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',400140.0000,400),(450,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,450),(451,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,450),(452,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,450),(500,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,500),(501,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,500),(502,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,500),(550,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,550),(551,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,550),(552,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,550),(600,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,600),(601,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,600),(602,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,600),(603,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,601),(604,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,601),(605,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,601),(606,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,602),(607,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,602),(608,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,602),(609,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,603),(610,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,603),(611,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,603),(650,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,650),(651,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,650),(652,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,650),(653,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,651),(654,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,651),(655,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,651),(700,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,700),(701,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,700),(702,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,700),(750,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,750),(751,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,750),(752,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,750),(753,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,751),(754,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,751),(755,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,751),(800,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,800),(801,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,800),(802,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,800),(850,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,850),(851,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,850),(852,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,850),(900,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,900),(901,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,900),(902,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,900),(950,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',400000.0000,950),(951,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,950),(952,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',400140.0000,950),(953,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',400000.0000,951),(954,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,951),(955,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',400140.0000,951),(956,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,952),(957,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,952),(958,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,952),(1000,'subtotal','order.total.subtotal','SUBTOTAL','ONE_TIME',5,NULL,'subtotal',200000.0000,1000),(1001,'shipping','order.total.shipping','SHIPPING','ONE_TIME',100,NULL,'shipping',140.0000,1000),(1002,'total','order.total.total','TOTAL','ONE_TIME',500,NULL,'total',200140.0000,1000);
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
INSERT INTO `PERMISSION` VALUES (1,'2026-09-12 03:17:03','2026-09-12 03:17:03',NULL,'AUTH'),(2,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,'SUPERADMIN'),(3,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,'ADMIN'),(4,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,'PRODUCTS'),(5,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,'ORDER'),(6,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,'CONTENT'),(7,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,'STORE'),(8,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,'TAX'),(9,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,'PAYMENT'),(10,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,'CUSTOMER'),(11,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,'SHIPPING'),(12,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,'AUTH_CUSTOMER');
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
INSERT INTO `PERMISSION_GROUP` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(1,2),(1,3),(2,3),(3,3),(1,4),(2,4),(3,4),(5,4),(1,5),(2,5),(3,5),(6,5),(1,6),(2,6),(3,6),(4,6),(7,6),(1,7),(2,7),(3,7),(4,7),(1,8),(2,8),(3,8),(4,8),(1,9),(2,9),(3,9),(4,9),(1,10),(2,10),(3,10),(4,10),(1,11),(2,11),(3,11),(4,11),(8,12);
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
INSERT INTO `PRODUCT` VALUES (1,'2026-09-12 07:23:28','2026-09-18 15:05:07',NULL,_binary '',NULL,'2026-09-11 17:00:00',_binary '',60.00,_binary '\0',10.00,NULL,5.00,1,_binary '',_binary '\0',10.00,40.00,'NK01',NULL,NULL,NULL,'NK01',0,NULL,1,NULL,1,1),(50,'2026-09-14 15:07:50','2026-09-14 15:07:50',NULL,_binary '\0',NULL,'2026-09-14 15:07:49',_binary '\0',NULL,_binary '\0',NULL,NULL,NULL,NULL,_binary '\0',_binary '\0',NULL,NULL,'NK02',NULL,NULL,NULL,'NK02',0,NULL,1,NULL,1,1);
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
INSERT INTO `PRODUCT_AVAILABILITY` VALUES (1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,_binary '\0',147,100,1,_binary '','*',NULL,NULL,NULL,1),(50,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,_binary '\0',0,0,0,_binary '','*',NULL,NULL,NULL,50);
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
INSERT INTO `PRODUCT_CATEGORY` VALUES (1,1),(50,100);
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
INSERT INTO `PRODUCT_DESCRIPTION` VALUES (1,'2026-09-18 06:56:19','2026-09-18 06:56:19',NULL,'<p>  st25</p>\n','ST25',NULL,'ST25','gạo ngon nhất thế giới,st25,ST 25,rice,','Gạo Ngon Nhất Thế Giới','','good','st25',1,1),(2,'2026-09-18 06:56:19','2026-09-18 06:56:19',NULL,'<p>  st25</p>\n','Gạo ST25',NULL,'ST25','st25,gạo ngon nhất thế giới,ST 25,','Gạo Ngon Nhất Thế Giới','','Gạo Ngon Nhất Thế Giới','gao-st25',3,1),(3,'2026-09-14 15:07:50','2026-09-14 15:07:50',NULL,'<h1>\n  <span class=\"post-title\">Đại Thừa Dạy Lo Lót Phi Nhân Quả, Nuôi Dưỡng\n    Dục Thế Gian Làm Hư Hoại Phật Giáo!</span></h1>\n<p>\n  <span class=\"post-title\">\n    <img alt=\"\" src=\"/static/files/DEFAULT/IMAGE/logo.jpg\" style=\"float: left;margin: 10.0px 20.0px;border-width: 10.0px;border-style: solid;\" /></span></p>\n<p>\n  <a href=\"https://youtu.be/PsrzF2_SGXc?si=9CjwgZqbCWzQYLAi\">https://youtu.be/PsrzF2_SGXc?si=9CjwgZqbCWzQYLAi</a></p>\n<p>  Bây giờ các con thấy – người ta dạy rất sai! Câu chuyện Mục Liên\n  Thanh Đề ở trong bản kinh Vu Lan Bồn – mấy con thấy sai không? Dạy\n  người ta ngày báo hiếu, mà báo hiếu như vậy sao? Báo hiếu bằng cách lo lót!</p>\n<p>  Nghĩa là Phật tử phải lo lót cho quý thầy, cho Phật rồi mới được\n  cứu độ! Như vậy có đúng không?</p>\n<p>  Các con nghe câu chuyện khi mà ông Mục Kiền Liên tu đắc Lục thông –\n  mẹ ông chết, ông mới đi tìm mẹ ông ở dưới địa ngục; ông mới thấy mẹ\n  ông ngồi ở trong địa ngục Ngạ quỷ, đói khát, khổ sở; ông mới bưng bát\n  cơm cho mẹ ông ăn; mẹ ông vừa bốc cơm ăn thì lửa cháy – ăn, nuốt không\n  được. Cái cảnh quá khổ!</p>\n<p>  Cho nên, ông cũng không đủ sức của mình để cứu mẹ. Cho nên ông về\n  xin Phật dạy cho ông cách nào để cứu mẹ ông thoát khỏi địa ngục Ngạ\n  quỷ này.</p>\n<p>  Đức Phật nói: <em>“Ông hãy về sắm tứ sự…​”.</em></p>\n<p>  Rồi sắm tứ sự rồi thì để làm gì? Các con hiểu – khi đó phải đem đến\n  cúng Phật và cúng chư Thánh Tăng – nhờ công đức tu hành của họ, sau 3\n  tháng an cư kiết hạ, tức là rằm tháng Bảy là người ta giải hạ ra, cho\n  nên ngày đó gọi là ngày báo hiếu.</p>\n<p>  Vì vậy cho nên lấy cái câu chuyện Mục Liên Thanh Đề để làm ngày báo\n  hiếu. Bây giờ chúng ta có cái ngày rằm tháng Bảy là ngày báo hiếu, do\n  đó chúng ta lấy cái tích lịch sử của Mục Kiền Liên.</p>\n<p>  Mà thử hỏi, bây giờ phải cúng dường trai Tăng cho chúng Tăng và\n  Phật, rồi nhờ công đức của các Ngài đó mới cứu độ bà Thanh Đề thoát\n  khỏi địa ngục. Như vậy trước khi cứu độ là ông Mục Kiền Liên có phạm\n  cái tội lo lót! Đứng trên pháp luật mà! Đại thừa dạy chúng ta có sự lo\n  lót rõ ràng!</p>\n<p>  Vậy kinh sách đúng không? – Không đúng! Dạy chúng ta làm điều sai –\n  đâu phải dạy chúng ta làm điều đúng!</p>\n<p>  Bà Thanh Đề tạo tội thì bà phải trả cái tội đó cho đến khi bà trả\n  hết tội đó. Thí dụ như bây giờ mình làm cái tội mà mình ở tù 10 năm,\n  thì phải ở tù 10 năm thì Nhà nước sẽ thả mình ra.</p>\n<p>  Còn bà Thanh Đề làm tội thì bà phải ở tù bao nhiêu năm, chịu khổ đó\n  bao nhiêu để trả cái tội của bà – cớ sao lại làm cái chuyện phi đạo\n  đức như vậy? Rồi Phật và chư Thánh Tăng lại ăn lo hối lộ – nhận của đó\n  mới cứu.</p>\n<p>  Vậy thì trong địa ngục Ngạ quỷ này đâu phải có 1 mình bà Thanh Đề,\n  có nhiều bà Thanh Đề chứ không phải 1 bà Thanh Đề! Không lẽ mở địa\n  ngục ra chỉ có nhận bà Thanh Đề, còn bao nhiêu những người không làm ác?</p>\n<p>  Vậy thì ở địa ngục đó rất nhiều người – đức Phật là 1 người công\n  bằng chứ, đạo lý chứ! Bà Thanh Đề khổ thì những người khác cũng khổ y\n  chứ! Tại sao không cứu độ? Các con có nghe chưa? Mình có công đức cứu\n  được mà tại sao không cứu hết những người này, lại chỉ có cứu bà này thôi?</p>\n<p>  Tại vì cái lý do là những người kia không có lo lót! Có phải không?\n  Nếu mà lo lót như ông Mục Kiền Liên thì chắc chắn là phải cứu hết chứ gì?</p>\n<p>  Thôi, như vậy là các thầy Thánh Tăng trong lúc đó với Phật – chắc\n  là tiền của chất đâu cho hết! Bởi vì đụng ai cũng ăn lo lót hết thì\n  phải giàu chứ sao? Bây giờ mới cất villa – biệt thự mà ở.</p>\n<p>  Như vậy hiện giờ chúng ta thấy villa – biệt thự của các chùa như\n  thế nào mấy con thấy không? Cái sự ăn lo đó bây giờ chúng ta thấy chùa\n  hàng tỷ bạc! Chùa nào mà cất dưới tỷ bao giờ đâu? Cái cửa cổng họ vô,\n  Thầy thấy trời ơi nó sang còn hơn!</p>\n<p>  Lấy số tiền đó mà cho đồng bào, cho những người bất hạnh trong xã\n  hội – nội cái cửa cổng của họ thôi, thì Thầy thấy cũng đem lại hạnh\n  phúc cho biết bao nhiêu người. Có đúng không? Mấy con thấy chưa?</p>\n<p>\n  <em>Những điều dạy phi đạo đức vậy mà chúng ta cho kinh sách Đại thừa\n    là đúng sao? Các con cứ suy ngẫm đi!</em></p>\n<p>  Bây giờ Thầy nói về vấn đề Tịnh Độ: các con thấy Đại thừa dạy chúng\n  ta tu tập Tịnh Độ chứ gì? Nghĩa là người nào mà Niệm Phật để cầu về\n  Cực Lạc – dễ dàng quá! Như 48 lời nguyện của đức Phật Di Đà, mấy con\n  có nghe không? <em>“Thiện nam tín nữ các người chí thành tưởng Phật\n    niệm mười tiếng ra. Ta không rước ở nước ta, thệ không làm Phật,\n    chắc đà không sai”.</em></p>\n<p>  Các con có nghe cái lời nguyện của đức Phật Di Đà không? Mấy con\n  chỉ cần niệm 10 tiếng thôi, đừng có niệm nhiều, cũng đủ rồi. Vậy thì\n  mấy con niệm 10 tiếng quá dễ rồi chứ gì?</p>\n<p>  Cho nên bây giờ, tôi niệm cả ngàn tiếng chứ tôi không niệm 10 tiếng\n  đâu! Chắc chắn là Phật Di Đà sẽ sắp xếp cho tôi có cái nhà đâu ở trển\n  rồi đó, mà tôi vừa tắt thở là mang tôi về trển rồi. Vì có 10 tiếng mà\n  ông còn rước, mà bây giờ tôi niệm cả ngàn tiếng rồi, thì chắc ăn rồi\n  chứ còn gì! Các con thấy đúng không? Như vậy quá đúng rồi! Cho nên mọi\n  người đều cùng nhau mà cố gắng niệm Phật.</p>\n<p>  Nhưng thử hỏi, khi mà tâm mấy con còn tham, sân, si, giận hờn mà\n  ông Phật Di Đà mà ông rước về nước ông – chắc chắn mấy con sẽ đánh lộn\n  trên đó hết! Có đúng không?</p>\n<p>  Thì bây giờ ông Phật Di Đà mới thành lập cái tòa án – nước người ta\n  thuở giờ hoàn toàn không có người tham sân si; mà bây giờ rước cái\n  chúng sanh ở dưới thế gian này lên, bây giờ nó có tham, sân, si rồi;\n  cho nên đất thì lát vàng – Thầy nghe trong kinh Di Đà nói mà, đất lát\n  vàng, hàng rào thì âm nhạc; lúc bây giờ chúng ta nghe hát hay quá\n  chúng ta ra nhổ hàng rào đem vô nhà cất hết, bởi vì chúng ta muốn sử\n  dụng mà! Thì các con thấy cái đó có đúng không?</p>\n<p>  Rồi vàng mà lót ở dưới đất như vậy đó, các con thấy vàng ở thế gian\n  này đắt quá; cho nên vì vậy mình cạy, mình cất để mai mốt mình trở về\n  thế gian mình đem bán; thì bây giờ vàng lên quá cao, cho nên mình sẽ\n  giàu sang.</p>\n<p>  1 lần mà đi lên trên đó về, mình ước ao trở về thế gian chứ:\n    <em>“Đặng tôi còn đem bán cái này chứ! Để ở trên tôi đi gom góp, tôi\n    về tôi bán!”.</em> Thì như vậy mấy con thấy cái đó đúng không mấy con?</p>\n<p>  Con người chúng ta phải dọn sạch – tâm chúng ta hết tham, sân, si\n  thì chúng ta sẽ được về đó. Mà tâm chúng ta còn tham, sân, si thì\n  chúng ta về đó sao được mấy con? Làm sao ai chứng cho mình được về đó!\n  Cho nên đâu có dễ dàng được! Mấy con biết các thầy vật lộn với tham,\n  sân, si của mình dường nào không?</p>\n<p>  Các con cứ thử nghĩ cái tâm si của chúng ta nó hiện ra cái tướng\n  hôn trầm, thùy miên, buồn ngủ – mấy con thức 10 giờ, 11 – 12 giờ;\n  chừng mấy con dậy 1 – 2 giờ, mấy con dậy nổi không? Hay là nó lăn qua\n  lộn lại, nó lười biếng, nó nằm đó để nó ráng ngủ thêm? Các con thấy\n  cái si ghê gớm – cái si là tướng lười biếng!</p>\n<p>  Mà ở đây chúng Tăng và quý cư sĩ ở đây tu tập gay go với nó lắm mới\n  thắng nổi! Vậy mà thắng nổi nhưng chưa hẳn đúng pháp thì chưa hẳn nó\n  dứt cơn đâu – nó còn đó, hở ra 1 chút là nó đánh nhẹp liền tức khắc!\n  Tức là chúng ta bị hôn trầm, thùy miên. Các con thấy chưa?</p>\n<p>  Như vậy chúng ta biết rằng kinh sách Nguyên Thủy đúng hay là kinh\n  sách Đại thừa đúng? Đức Phật dạy: <em>“Ngăn ác, Diệt ác – Sanh thiện\n    Tăng trưởng thiện”</em> – sống trong giới luật nghiêm chỉnh thì mới\n  ly dục, ly ác pháp được; mà sống ngoài giới luật thì làm sao ly dục,\n  ly ác pháp được!</p>\n<p>  Mà bây giờ chúng ta sống trong dục lạc, nghe cõi Cực Lạc quá đẹp đẽ\n  – ham mê, thì chúng ta mong chúng ta về đó! Nhưng lòng tham chúng ta\n  hết không – mà không hết thì thử hỏi làm sao chúng ta sống được?</p>\n<p>  Thầy nói thẳng, nói thật thì sẽ mích lòng nhưng phải nói thẳng, nói\n  thật! Dựng lại Phật giáo mà không dám nói thẳng, nói thật thì người ta\n  vẫn cho đó là đúng; mà cho nó là đúng thì người ta sẽ đi theo cái sai.</p>\n<p>  Cho nên Thầy nói như vậy các con sẽ suy ngẫm, tự suy ngẫm; đúng thì\n  mấy con theo – Thầy không ép buộc; được thì mấy con hữu duyên, mà\n  không được thì mấy con chịu chứ không phải riêng Thầy.</p>\n<p>  Còn ở đây Thầy khuyên các thầy nên tu tập đúng theo Thầy hướng dẫn;\n  mà tu tập sai theo kiến giải, tưởng giải của quý thầy thì quý thầy\n  chịu trách nhiệm cái sai của quý thầy.</p>\n<p>  Các Thầy phải hiểu Thầy là 1 người đã kinh nghiệm đi qua trên con\n  đường này, làm chủ được sự sống chết của mình, mà bây giờ đem truyền\n  dạy lại cho quý vị làm chủ sự sống chết cho quý vị. Thì quý vị phải\n  hiểu biết người có kinh nghiệm như vậy, dạy mình sẽ không sai!</p>\n<p>  Cho nên trong kinh sách Phật dạy, bảo mình tìm thiện hữu tri thức –\n  người đó phải hết tham, sân, si; người đó phải chứng đạt được chân lý\n  – đó là Thầy của mình! Người đó phải sống đúng giới luật – giới luật\n  còn là Phật giáo còn, giới luật mất là Phật giáo mất.</p>\n<p>\n  <em>Cho nên chúng ta tìm 1 vị thầy mà giới luật nghiêm chỉnh, không hề\n    vi phạm 1 lỗi nhỏ nhặt nào thì đó là Phật giáo còn. Còn nếu tìm\n    không được thì đương nhiên – dù có trăm ngàn danh từ nói Phật giáo\n    thì Phật giáo đó vẫn sai! Vị thầy chúng ta phạm giới, phá giới mà\n    chúng ta theo tu tập thì chúng ta chẳng làm chủ sanh tử luân hồi.\n    Tại sao vậy? Tại vì tâm không ly dục, ly ác pháp cho nên mới phạm\n    giới. Còn tâm ly dục ly ác pháp thì không bao giờ phạm giới!</em></p>\n<p>  (21:36) Cho nên quý Phật tử cũng như các thầy nghe Thiền tông nói:\n  Tự tại vô ngại, đói ăn, khát uống, mệt đi ngủ; rồi thõng tay vào chợ,\n  nào là xách cá quải thịt, nào là uống rượu đủ thứ hết! Cho những vị đó\n  là tự tại rồi, sống vô ngại rồi, không có còn chướng ngại nữa, gọi là\n  giải thoát. Thực sự tu hành rồi mà trở lại sống còn hơn 1 người bê bối\n  – rượu chè say sưa. Sống như vậy có đúng không?</p>\n<p>  1 người tu phải có hạnh của người tu! Người tu gì mà lại rượu chè\n  say sưa – gọi là tự tại; muốn ăn, muốn ngủ hồi nào cũng được hết sao?\n  Giống như người phàm phu – người phàm phu họ cũng muốn ăn, muốn ngủ\n  hồi nào cũng được, có gì đâu!</p>\n<p>  Cho nên ở đây, cái danh từ mà gọi là <em>“tự tại vô ngại”</em> thì\n  Thầy thấy thật sự không phải áp dụng cho người tu sĩ của đạo Phật mà\n  áp dụng cho cái người vào cái sự sống hiện sinh của họ, sống trong cái\n  dục lạc của họ để họ thỏa mãn trong đời sống của họ – họ nói chết là\n  hết rồi, chỉ có đời nay thôi, mình hưởng cho hết dục lạc trên thế gian\n  này, chết thì người nào cũng chết hết. Đó là cái hiểu biết không đúng,\n  cạn cợt, không đúng – chết chưa phải là hết!</p>\n<p>  Và sống không phải có nghĩa là chúng ta sống mà không tái sanh luân\n  hồi. Do học bài đạo đức nhân quả vừa rồi đã xác định cho mấy con thấy\n  1 hành động của chúng ta là sẽ tái sanh làm 1 con vật hoặc là làm con người.</p>\n<p>  Quý vị nhớ kỹ những bài học nhân quả này mà khắc ghi trong lòng để\n  thực hiện đạo đức nhân bản – nhân quả, sống không làm khổ mình, khổ\n  người; tất cả những hành động ác – chúng ta không làm nữa!</p>\n<p>  Cho nên đức Phật nói: <em>“Ngăn ác, Diệt ác – Sanh thiện, Tăng\n    trưởng thiện”</em> hoặc là <em>“Chư ác mạc tác, chúng thiện phụng\n  hành”.</em> Lời nói của đức Phật dạy như vậy, chúng ta hãy cố gắng mà\n  tu tập!</p>\n<p>  Đến đây Thầy xin chấm dứt. Và buổi học hôm nay, mấy con có hỏi gì\n  thì giờ này cứ hỏi, Thầy sẽ trả lời. Bây giờ ai có thắc mắc những gì\n  thì hỏi, mà không thắc mắc thì chúng ta về, vì giờ chúng ta sắp sửa đi\n  khất thực.</p>\n<p>\n  <em>(Trích </em>\n  <a href=\"https://thuvienchonnhu.net/phap-am/LCK-028\">LCK 028D (CHUNG)\n    – HỌC TẬP ĐẠO ĐỨC NHÂN BẢN NHÂN QUẢ – ĐỪNG THEO KIẾN GIẢI ĐẠI THỪA –\n    VẤN ĐẠO LÀM CHỦ NHÂN QUẢ</a>\n  <em>)</em></p>\n','Đại Thừa Lo Lót Phi Nhân Quả',NULL,'','','Đại Thừa Lo Lót Phi Nhân Quả','','Đại Thừa lo lot phi nhân quả','i-tha-lo-lt-phi-nhn-qu',3,50),(4,'2026-09-14 15:07:50','2026-09-14 15:07:50',NULL,'<h1>\n  <span class=\"post-title\">Đại Thừa Dạy Lo Lót Phi Nhân Quả, Nuôi Dưỡng\n    Dục Thế Gian Làm Hư Hoại Phật Giáo!</span></h1>\n<p>\n  <span class=\"post-title\">\n    <img alt=\"\" src=\"/static/files/DEFAULT/IMAGE/logo.jpg\" style=\"float: left;margin: 10.0px 20.0px;border-width: 10.0px;border-style: solid;\" /></span></p>\n<p>\n  <a href=\"https://youtu.be/PsrzF2_SGXc?si=9CjwgZqbCWzQYLAi\">https://youtu.be/PsrzF2_SGXc?si=9CjwgZqbCWzQYLAi</a></p>\n<p>  Bây giờ các con thấy – người ta dạy rất sai! Câu chuyện Mục Liên\n  Thanh Đề ở trong bản kinh Vu Lan Bồn – mấy con thấy sai không? Dạy\n  người ta ngày báo hiếu, mà báo hiếu như vậy sao? Báo hiếu bằng cách lo lót!</p>\n<p>  Nghĩa là Phật tử phải lo lót cho quý thầy, cho Phật rồi mới được\n  cứu độ! Như vậy có đúng không?</p>\n<p>  Các con nghe câu chuyện khi mà ông Mục Kiền Liên tu đắc Lục thông –\n  mẹ ông chết, ông mới đi tìm mẹ ông ở dưới địa ngục; ông mới thấy mẹ\n  ông ngồi ở trong địa ngục Ngạ quỷ, đói khát, khổ sở; ông mới bưng bát\n  cơm cho mẹ ông ăn; mẹ ông vừa bốc cơm ăn thì lửa cháy – ăn, nuốt không\n  được. Cái cảnh quá khổ!</p>\n<p>  Cho nên, ông cũng không đủ sức của mình để cứu mẹ. Cho nên ông về\n  xin Phật dạy cho ông cách nào để cứu mẹ ông thoát khỏi địa ngục Ngạ\n  quỷ này.</p>\n<p>  Đức Phật nói: <em>“Ông hãy về sắm tứ sự…​”.</em></p>\n<p>  Rồi sắm tứ sự rồi thì để làm gì? Các con hiểu – khi đó phải đem đến\n  cúng Phật và cúng chư Thánh Tăng – nhờ công đức tu hành của họ, sau 3\n  tháng an cư kiết hạ, tức là rằm tháng Bảy là người ta giải hạ ra, cho\n  nên ngày đó gọi là ngày báo hiếu.</p>\n<p>  Vì vậy cho nên lấy cái câu chuyện Mục Liên Thanh Đề để làm ngày báo\n  hiếu. Bây giờ chúng ta có cái ngày rằm tháng Bảy là ngày báo hiếu, do\n  đó chúng ta lấy cái tích lịch sử của Mục Kiền Liên.</p>\n<p>  Mà thử hỏi, bây giờ phải cúng dường trai Tăng cho chúng Tăng và\n  Phật, rồi nhờ công đức của các Ngài đó mới cứu độ bà Thanh Đề thoát\n  khỏi địa ngục. Như vậy trước khi cứu độ là ông Mục Kiền Liên có phạm\n  cái tội lo lót! Đứng trên pháp luật mà! Đại thừa dạy chúng ta có sự lo\n  lót rõ ràng!</p>\n<p>  Vậy kinh sách đúng không? – Không đúng! Dạy chúng ta làm điều sai –\n  đâu phải dạy chúng ta làm điều đúng!</p>\n<p>  Bà Thanh Đề tạo tội thì bà phải trả cái tội đó cho đến khi bà trả\n  hết tội đó. Thí dụ như bây giờ mình làm cái tội mà mình ở tù 10 năm,\n  thì phải ở tù 10 năm thì Nhà nước sẽ thả mình ra.</p>\n<p>  Còn bà Thanh Đề làm tội thì bà phải ở tù bao nhiêu năm, chịu khổ đó\n  bao nhiêu để trả cái tội của bà – cớ sao lại làm cái chuyện phi đạo\n  đức như vậy? Rồi Phật và chư Thánh Tăng lại ăn lo hối lộ – nhận của đó\n  mới cứu.</p>\n<p>  Vậy thì trong địa ngục Ngạ quỷ này đâu phải có 1 mình bà Thanh Đề,\n  có nhiều bà Thanh Đề chứ không phải 1 bà Thanh Đề! Không lẽ mở địa\n  ngục ra chỉ có nhận bà Thanh Đề, còn bao nhiêu những người không làm ác?</p>\n<p>  Vậy thì ở địa ngục đó rất nhiều người – đức Phật là 1 người công\n  bằng chứ, đạo lý chứ! Bà Thanh Đề khổ thì những người khác cũng khổ y\n  chứ! Tại sao không cứu độ? Các con có nghe chưa? Mình có công đức cứu\n  được mà tại sao không cứu hết những người này, lại chỉ có cứu bà này thôi?</p>\n<p>  Tại vì cái lý do là những người kia không có lo lót! Có phải không?\n  Nếu mà lo lót như ông Mục Kiền Liên thì chắc chắn là phải cứu hết chứ gì?</p>\n<p>  Thôi, như vậy là các thầy Thánh Tăng trong lúc đó với Phật – chắc\n  là tiền của chất đâu cho hết! Bởi vì đụng ai cũng ăn lo lót hết thì\n  phải giàu chứ sao? Bây giờ mới cất villa – biệt thự mà ở.</p>\n<p>  Như vậy hiện giờ chúng ta thấy villa – biệt thự của các chùa như\n  thế nào mấy con thấy không? Cái sự ăn lo đó bây giờ chúng ta thấy chùa\n  hàng tỷ bạc! Chùa nào mà cất dưới tỷ bao giờ đâu? Cái cửa cổng họ vô,\n  Thầy thấy trời ơi nó sang còn hơn!</p>\n<p>  Lấy số tiền đó mà cho đồng bào, cho những người bất hạnh trong xã\n  hội – nội cái cửa cổng của họ thôi, thì Thầy thấy cũng đem lại hạnh\n  phúc cho biết bao nhiêu người. Có đúng không? Mấy con thấy chưa?</p>\n<p>\n  <em>Những điều dạy phi đạo đức vậy mà chúng ta cho kinh sách Đại thừa\n    là đúng sao? Các con cứ suy ngẫm đi!</em></p>\n<p>  Bây giờ Thầy nói về vấn đề Tịnh Độ: các con thấy Đại thừa dạy chúng\n  ta tu tập Tịnh Độ chứ gì? Nghĩa là người nào mà Niệm Phật để cầu về\n  Cực Lạc – dễ dàng quá! Như 48 lời nguyện của đức Phật Di Đà, mấy con\n  có nghe không? <em>“Thiện nam tín nữ các người chí thành tưởng Phật\n    niệm mười tiếng ra. Ta không rước ở nước ta, thệ không làm Phật,\n    chắc đà không sai”.</em></p>\n<p>  Các con có nghe cái lời nguyện của đức Phật Di Đà không? Mấy con\n  chỉ cần niệm 10 tiếng thôi, đừng có niệm nhiều, cũng đủ rồi. Vậy thì\n  mấy con niệm 10 tiếng quá dễ rồi chứ gì?</p>\n<p>  Cho nên bây giờ, tôi niệm cả ngàn tiếng chứ tôi không niệm 10 tiếng\n  đâu! Chắc chắn là Phật Di Đà sẽ sắp xếp cho tôi có cái nhà đâu ở trển\n  rồi đó, mà tôi vừa tắt thở là mang tôi về trển rồi. Vì có 10 tiếng mà\n  ông còn rước, mà bây giờ tôi niệm cả ngàn tiếng rồi, thì chắc ăn rồi\n  chứ còn gì! Các con thấy đúng không? Như vậy quá đúng rồi! Cho nên mọi\n  người đều cùng nhau mà cố gắng niệm Phật.</p>\n<p>  Nhưng thử hỏi, khi mà tâm mấy con còn tham, sân, si, giận hờn mà\n  ông Phật Di Đà mà ông rước về nước ông – chắc chắn mấy con sẽ đánh lộn\n  trên đó hết! Có đúng không?</p>\n<p>  Thì bây giờ ông Phật Di Đà mới thành lập cái tòa án – nước người ta\n  thuở giờ hoàn toàn không có người tham sân si; mà bây giờ rước cái\n  chúng sanh ở dưới thế gian này lên, bây giờ nó có tham, sân, si rồi;\n  cho nên đất thì lát vàng – Thầy nghe trong kinh Di Đà nói mà, đất lát\n  vàng, hàng rào thì âm nhạc; lúc bây giờ chúng ta nghe hát hay quá\n  chúng ta ra nhổ hàng rào đem vô nhà cất hết, bởi vì chúng ta muốn sử\n  dụng mà! Thì các con thấy cái đó có đúng không?</p>\n<p>  Rồi vàng mà lót ở dưới đất như vậy đó, các con thấy vàng ở thế gian\n  này đắt quá; cho nên vì vậy mình cạy, mình cất để mai mốt mình trở về\n  thế gian mình đem bán; thì bây giờ vàng lên quá cao, cho nên mình sẽ\n  giàu sang.</p>\n<p>  1 lần mà đi lên trên đó về, mình ước ao trở về thế gian chứ:\n    <em>“Đặng tôi còn đem bán cái này chứ! Để ở trên tôi đi gom góp, tôi\n    về tôi bán!”.</em> Thì như vậy mấy con thấy cái đó đúng không mấy con?</p>\n<p>  Con người chúng ta phải dọn sạch – tâm chúng ta hết tham, sân, si\n  thì chúng ta sẽ được về đó. Mà tâm chúng ta còn tham, sân, si thì\n  chúng ta về đó sao được mấy con? Làm sao ai chứng cho mình được về đó!\n  Cho nên đâu có dễ dàng được! Mấy con biết các thầy vật lộn với tham,\n  sân, si của mình dường nào không?</p>\n<p>  Các con cứ thử nghĩ cái tâm si của chúng ta nó hiện ra cái tướng\n  hôn trầm, thùy miên, buồn ngủ – mấy con thức 10 giờ, 11 – 12 giờ;\n  chừng mấy con dậy 1 – 2 giờ, mấy con dậy nổi không? Hay là nó lăn qua\n  lộn lại, nó lười biếng, nó nằm đó để nó ráng ngủ thêm? Các con thấy\n  cái si ghê gớm – cái si là tướng lười biếng!</p>\n<p>  Mà ở đây chúng Tăng và quý cư sĩ ở đây tu tập gay go với nó lắm mới\n  thắng nổi! Vậy mà thắng nổi nhưng chưa hẳn đúng pháp thì chưa hẳn nó\n  dứt cơn đâu – nó còn đó, hở ra 1 chút là nó đánh nhẹp liền tức khắc!\n  Tức là chúng ta bị hôn trầm, thùy miên. Các con thấy chưa?</p>\n<p>  Như vậy chúng ta biết rằng kinh sách Nguyên Thủy đúng hay là kinh\n  sách Đại thừa đúng? Đức Phật dạy: <em>“Ngăn ác, Diệt ác – Sanh thiện\n    Tăng trưởng thiện”</em> – sống trong giới luật nghiêm chỉnh thì mới\n  ly dục, ly ác pháp được; mà sống ngoài giới luật thì làm sao ly dục,\n  ly ác pháp được!</p>\n<p>  Mà bây giờ chúng ta sống trong dục lạc, nghe cõi Cực Lạc quá đẹp đẽ\n  – ham mê, thì chúng ta mong chúng ta về đó! Nhưng lòng tham chúng ta\n  hết không – mà không hết thì thử hỏi làm sao chúng ta sống được?</p>\n<p>  Thầy nói thẳng, nói thật thì sẽ mích lòng nhưng phải nói thẳng, nói\n  thật! Dựng lại Phật giáo mà không dám nói thẳng, nói thật thì người ta\n  vẫn cho đó là đúng; mà cho nó là đúng thì người ta sẽ đi theo cái sai.</p>\n<p>  Cho nên Thầy nói như vậy các con sẽ suy ngẫm, tự suy ngẫm; đúng thì\n  mấy con theo – Thầy không ép buộc; được thì mấy con hữu duyên, mà\n  không được thì mấy con chịu chứ không phải riêng Thầy.</p>\n<p>  Còn ở đây Thầy khuyên các thầy nên tu tập đúng theo Thầy hướng dẫn;\n  mà tu tập sai theo kiến giải, tưởng giải của quý thầy thì quý thầy\n  chịu trách nhiệm cái sai của quý thầy.</p>\n<p>  Các Thầy phải hiểu Thầy là 1 người đã kinh nghiệm đi qua trên con\n  đường này, làm chủ được sự sống chết của mình, mà bây giờ đem truyền\n  dạy lại cho quý vị làm chủ sự sống chết cho quý vị. Thì quý vị phải\n  hiểu biết người có kinh nghiệm như vậy, dạy mình sẽ không sai!</p>\n<p>  Cho nên trong kinh sách Phật dạy, bảo mình tìm thiện hữu tri thức –\n  người đó phải hết tham, sân, si; người đó phải chứng đạt được chân lý\n  – đó là Thầy của mình! Người đó phải sống đúng giới luật – giới luật\n  còn là Phật giáo còn, giới luật mất là Phật giáo mất.</p>\n<p>\n  <em>Cho nên chúng ta tìm 1 vị thầy mà giới luật nghiêm chỉnh, không hề\n    vi phạm 1 lỗi nhỏ nhặt nào thì đó là Phật giáo còn. Còn nếu tìm\n    không được thì đương nhiên – dù có trăm ngàn danh từ nói Phật giáo\n    thì Phật giáo đó vẫn sai! Vị thầy chúng ta phạm giới, phá giới mà\n    chúng ta theo tu tập thì chúng ta chẳng làm chủ sanh tử luân hồi.\n    Tại sao vậy? Tại vì tâm không ly dục, ly ác pháp cho nên mới phạm\n    giới. Còn tâm ly dục ly ác pháp thì không bao giờ phạm giới!</em></p>\n<p>  (21:36) Cho nên quý Phật tử cũng như các thầy nghe Thiền tông nói:\n  Tự tại vô ngại, đói ăn, khát uống, mệt đi ngủ; rồi thõng tay vào chợ,\n  nào là xách cá quải thịt, nào là uống rượu đủ thứ hết! Cho những vị đó\n  là tự tại rồi, sống vô ngại rồi, không có còn chướng ngại nữa, gọi là\n  giải thoát. Thực sự tu hành rồi mà trở lại sống còn hơn 1 người bê bối\n  – rượu chè say sưa. Sống như vậy có đúng không?</p>\n<p>  1 người tu phải có hạnh của người tu! Người tu gì mà lại rượu chè\n  say sưa – gọi là tự tại; muốn ăn, muốn ngủ hồi nào cũng được hết sao?\n  Giống như người phàm phu – người phàm phu họ cũng muốn ăn, muốn ngủ\n  hồi nào cũng được, có gì đâu!</p>\n<p>  Cho nên ở đây, cái danh từ mà gọi là <em>“tự tại vô ngại”</em> thì\n  Thầy thấy thật sự không phải áp dụng cho người tu sĩ của đạo Phật mà\n  áp dụng cho cái người vào cái sự sống hiện sinh của họ, sống trong cái\n  dục lạc của họ để họ thỏa mãn trong đời sống của họ – họ nói chết là\n  hết rồi, chỉ có đời nay thôi, mình hưởng cho hết dục lạc trên thế gian\n  này, chết thì người nào cũng chết hết. Đó là cái hiểu biết không đúng,\n  cạn cợt, không đúng – chết chưa phải là hết!</p>\n<p>  Và sống không phải có nghĩa là chúng ta sống mà không tái sanh luân\n  hồi. Do học bài đạo đức nhân quả vừa rồi đã xác định cho mấy con thấy\n  1 hành động của chúng ta là sẽ tái sanh làm 1 con vật hoặc là làm con người.</p>\n<p>  Quý vị nhớ kỹ những bài học nhân quả này mà khắc ghi trong lòng để\n  thực hiện đạo đức nhân bản – nhân quả, sống không làm khổ mình, khổ\n  người; tất cả những hành động ác – chúng ta không làm nữa!</p>\n<p>  Cho nên đức Phật nói: <em>“Ngăn ác, Diệt ác – Sanh thiện, Tăng\n    trưởng thiện”</em> hoặc là <em>“Chư ác mạc tác, chúng thiện phụng\n  hành”.</em> Lời nói của đức Phật dạy như vậy, chúng ta hãy cố gắng mà\n  tu tập!</p>\n<p>  Đến đây Thầy xin chấm dứt. Và buổi học hôm nay, mấy con có hỏi gì\n  thì giờ này cứ hỏi, Thầy sẽ trả lời. Bây giờ ai có thắc mắc những gì\n  thì hỏi, mà không thắc mắc thì chúng ta về, vì giờ chúng ta sắp sửa đi\n  khất thực.</p>\n<p>\n  <em>(Trích </em>\n  <a href=\"https://thuvienchonnhu.net/phap-am/LCK-028\">LCK 028D (CHUNG)\n    – HỌC TẬP ĐẠO ĐỨC NHÂN BẢN NHÂN QUẢ – ĐỪNG THEO KIẾN GIẢI ĐẠI THỪA –\n    VẤN ĐẠO LÀM CHỦ NHÂN QUẢ</a>\n  <em>)</em></p>\n','Dai Thua Lo Lot Phi Nhan Qua',NULL,'','','Dai Thua Lo Lot Phi Nhan Qua','','','dai-thua-lo-lot-phi-nhan-qua',1,50),(5,'2026-09-14 15:07:50','2026-09-14 15:07:50',NULL,'<h1>\n  <span class=\"post-title\">Đại Thừa Dạy Lo Lót Phi Nhân Quả, Nuôi Dưỡng\n    Dục Thế Gian Làm Hư Hoại Phật Giáo!</span></h1>\n<p>\n  <span class=\"post-title\">\n    <img alt=\"\" src=\"/static/files/DEFAULT/IMAGE/logo.jpg\" style=\"float: left;margin: 10.0px 20.0px;border-width: 10.0px;border-style: solid;\" /></span></p>\n<p>\n  <a href=\"https://youtu.be/PsrzF2_SGXc?si=9CjwgZqbCWzQYLAi\">https://youtu.be/PsrzF2_SGXc?si=9CjwgZqbCWzQYLAi</a></p>\n<p>  Bây giờ các con thấy – người ta dạy rất sai! Câu chuyện Mục Liên\n  Thanh Đề ở trong bản kinh Vu Lan Bồn – mấy con thấy sai không? Dạy\n  người ta ngày báo hiếu, mà báo hiếu như vậy sao? Báo hiếu bằng cách lo lót!</p>\n<p>  Nghĩa là Phật tử phải lo lót cho quý thầy, cho Phật rồi mới được\n  cứu độ! Như vậy có đúng không?</p>\n<p>  Các con nghe câu chuyện khi mà ông Mục Kiền Liên tu đắc Lục thông –\n  mẹ ông chết, ông mới đi tìm mẹ ông ở dưới địa ngục; ông mới thấy mẹ\n  ông ngồi ở trong địa ngục Ngạ quỷ, đói khát, khổ sở; ông mới bưng bát\n  cơm cho mẹ ông ăn; mẹ ông vừa bốc cơm ăn thì lửa cháy – ăn, nuốt không\n  được. Cái cảnh quá khổ!</p>\n<p>  Cho nên, ông cũng không đủ sức của mình để cứu mẹ. Cho nên ông về\n  xin Phật dạy cho ông cách nào để cứu mẹ ông thoát khỏi địa ngục Ngạ\n  quỷ này.</p>\n<p>  Đức Phật nói: <em>“Ông hãy về sắm tứ sự…​”.</em></p>\n<p>  Rồi sắm tứ sự rồi thì để làm gì? Các con hiểu – khi đó phải đem đến\n  cúng Phật và cúng chư Thánh Tăng – nhờ công đức tu hành của họ, sau 3\n  tháng an cư kiết hạ, tức là rằm tháng Bảy là người ta giải hạ ra, cho\n  nên ngày đó gọi là ngày báo hiếu.</p>\n<p>  Vì vậy cho nên lấy cái câu chuyện Mục Liên Thanh Đề để làm ngày báo\n  hiếu. Bây giờ chúng ta có cái ngày rằm tháng Bảy là ngày báo hiếu, do\n  đó chúng ta lấy cái tích lịch sử của Mục Kiền Liên.</p>\n<p>  Mà thử hỏi, bây giờ phải cúng dường trai Tăng cho chúng Tăng và\n  Phật, rồi nhờ công đức của các Ngài đó mới cứu độ bà Thanh Đề thoát\n  khỏi địa ngục. Như vậy trước khi cứu độ là ông Mục Kiền Liên có phạm\n  cái tội lo lót! Đứng trên pháp luật mà! Đại thừa dạy chúng ta có sự lo\n  lót rõ ràng!</p>\n<p>  Vậy kinh sách đúng không? – Không đúng! Dạy chúng ta làm điều sai –\n  đâu phải dạy chúng ta làm điều đúng!</p>\n<p>  Bà Thanh Đề tạo tội thì bà phải trả cái tội đó cho đến khi bà trả\n  hết tội đó. Thí dụ như bây giờ mình làm cái tội mà mình ở tù 10 năm,\n  thì phải ở tù 10 năm thì Nhà nước sẽ thả mình ra.</p>\n<p>  Còn bà Thanh Đề làm tội thì bà phải ở tù bao nhiêu năm, chịu khổ đó\n  bao nhiêu để trả cái tội của bà – cớ sao lại làm cái chuyện phi đạo\n  đức như vậy? Rồi Phật và chư Thánh Tăng lại ăn lo hối lộ – nhận của đó\n  mới cứu.</p>\n<p>  Vậy thì trong địa ngục Ngạ quỷ này đâu phải có 1 mình bà Thanh Đề,\n  có nhiều bà Thanh Đề chứ không phải 1 bà Thanh Đề! Không lẽ mở địa\n  ngục ra chỉ có nhận bà Thanh Đề, còn bao nhiêu những người không làm ác?</p>\n<p>  Vậy thì ở địa ngục đó rất nhiều người – đức Phật là 1 người công\n  bằng chứ, đạo lý chứ! Bà Thanh Đề khổ thì những người khác cũng khổ y\n  chứ! Tại sao không cứu độ? Các con có nghe chưa? Mình có công đức cứu\n  được mà tại sao không cứu hết những người này, lại chỉ có cứu bà này thôi?</p>\n<p>  Tại vì cái lý do là những người kia không có lo lót! Có phải không?\n  Nếu mà lo lót như ông Mục Kiền Liên thì chắc chắn là phải cứu hết chứ gì?</p>\n<p>  Thôi, như vậy là các thầy Thánh Tăng trong lúc đó với Phật – chắc\n  là tiền của chất đâu cho hết! Bởi vì đụng ai cũng ăn lo lót hết thì\n  phải giàu chứ sao? Bây giờ mới cất villa – biệt thự mà ở.</p>\n<p>  Như vậy hiện giờ chúng ta thấy villa – biệt thự của các chùa như\n  thế nào mấy con thấy không? Cái sự ăn lo đó bây giờ chúng ta thấy chùa\n  hàng tỷ bạc! Chùa nào mà cất dưới tỷ bao giờ đâu? Cái cửa cổng họ vô,\n  Thầy thấy trời ơi nó sang còn hơn!</p>\n<p>  Lấy số tiền đó mà cho đồng bào, cho những người bất hạnh trong xã\n  hội – nội cái cửa cổng của họ thôi, thì Thầy thấy cũng đem lại hạnh\n  phúc cho biết bao nhiêu người. Có đúng không? Mấy con thấy chưa?</p>\n<p>\n  <em>Những điều dạy phi đạo đức vậy mà chúng ta cho kinh sách Đại thừa\n    là đúng sao? Các con cứ suy ngẫm đi!</em></p>\n<p>  Bây giờ Thầy nói về vấn đề Tịnh Độ: các con thấy Đại thừa dạy chúng\n  ta tu tập Tịnh Độ chứ gì? Nghĩa là người nào mà Niệm Phật để cầu về\n  Cực Lạc – dễ dàng quá! Như 48 lời nguyện của đức Phật Di Đà, mấy con\n  có nghe không? <em>“Thiện nam tín nữ các người chí thành tưởng Phật\n    niệm mười tiếng ra. Ta không rước ở nước ta, thệ không làm Phật,\n    chắc đà không sai”.</em></p>\n<p>  Các con có nghe cái lời nguyện của đức Phật Di Đà không? Mấy con\n  chỉ cần niệm 10 tiếng thôi, đừng có niệm nhiều, cũng đủ rồi. Vậy thì\n  mấy con niệm 10 tiếng quá dễ rồi chứ gì?</p>\n<p>  Cho nên bây giờ, tôi niệm cả ngàn tiếng chứ tôi không niệm 10 tiếng\n  đâu! Chắc chắn là Phật Di Đà sẽ sắp xếp cho tôi có cái nhà đâu ở trển\n  rồi đó, mà tôi vừa tắt thở là mang tôi về trển rồi. Vì có 10 tiếng mà\n  ông còn rước, mà bây giờ tôi niệm cả ngàn tiếng rồi, thì chắc ăn rồi\n  chứ còn gì! Các con thấy đúng không? Như vậy quá đúng rồi! Cho nên mọi\n  người đều cùng nhau mà cố gắng niệm Phật.</p>\n<p>  Nhưng thử hỏi, khi mà tâm mấy con còn tham, sân, si, giận hờn mà\n  ông Phật Di Đà mà ông rước về nước ông – chắc chắn mấy con sẽ đánh lộn\n  trên đó hết! Có đúng không?</p>\n<p>  Thì bây giờ ông Phật Di Đà mới thành lập cái tòa án – nước người ta\n  thuở giờ hoàn toàn không có người tham sân si; mà bây giờ rước cái\n  chúng sanh ở dưới thế gian này lên, bây giờ nó có tham, sân, si rồi;\n  cho nên đất thì lát vàng – Thầy nghe trong kinh Di Đà nói mà, đất lát\n  vàng, hàng rào thì âm nhạc; lúc bây giờ chúng ta nghe hát hay quá\n  chúng ta ra nhổ hàng rào đem vô nhà cất hết, bởi vì chúng ta muốn sử\n  dụng mà! Thì các con thấy cái đó có đúng không?</p>\n<p>  Rồi vàng mà lót ở dưới đất như vậy đó, các con thấy vàng ở thế gian\n  này đắt quá; cho nên vì vậy mình cạy, mình cất để mai mốt mình trở về\n  thế gian mình đem bán; thì bây giờ vàng lên quá cao, cho nên mình sẽ\n  giàu sang.</p>\n<p>  1 lần mà đi lên trên đó về, mình ước ao trở về thế gian chứ:\n    <em>“Đặng tôi còn đem bán cái này chứ! Để ở trên tôi đi gom góp, tôi\n    về tôi bán!”.</em> Thì như vậy mấy con thấy cái đó đúng không mấy con?</p>\n<p>  Con người chúng ta phải dọn sạch – tâm chúng ta hết tham, sân, si\n  thì chúng ta sẽ được về đó. Mà tâm chúng ta còn tham, sân, si thì\n  chúng ta về đó sao được mấy con? Làm sao ai chứng cho mình được về đó!\n  Cho nên đâu có dễ dàng được! Mấy con biết các thầy vật lộn với tham,\n  sân, si của mình dường nào không?</p>\n<p>  Các con cứ thử nghĩ cái tâm si của chúng ta nó hiện ra cái tướng\n  hôn trầm, thùy miên, buồn ngủ – mấy con thức 10 giờ, 11 – 12 giờ;\n  chừng mấy con dậy 1 – 2 giờ, mấy con dậy nổi không? Hay là nó lăn qua\n  lộn lại, nó lười biếng, nó nằm đó để nó ráng ngủ thêm? Các con thấy\n  cái si ghê gớm – cái si là tướng lười biếng!</p>\n<p>  Mà ở đây chúng Tăng và quý cư sĩ ở đây tu tập gay go với nó lắm mới\n  thắng nổi! Vậy mà thắng nổi nhưng chưa hẳn đúng pháp thì chưa hẳn nó\n  dứt cơn đâu – nó còn đó, hở ra 1 chút là nó đánh nhẹp liền tức khắc!\n  Tức là chúng ta bị hôn trầm, thùy miên. Các con thấy chưa?</p>\n<p>  Như vậy chúng ta biết rằng kinh sách Nguyên Thủy đúng hay là kinh\n  sách Đại thừa đúng? Đức Phật dạy: <em>“Ngăn ác, Diệt ác – Sanh thiện\n    Tăng trưởng thiện”</em> – sống trong giới luật nghiêm chỉnh thì mới\n  ly dục, ly ác pháp được; mà sống ngoài giới luật thì làm sao ly dục,\n  ly ác pháp được!</p>\n<p>  Mà bây giờ chúng ta sống trong dục lạc, nghe cõi Cực Lạc quá đẹp đẽ\n  – ham mê, thì chúng ta mong chúng ta về đó! Nhưng lòng tham chúng ta\n  hết không – mà không hết thì thử hỏi làm sao chúng ta sống được?</p>\n<p>  Thầy nói thẳng, nói thật thì sẽ mích lòng nhưng phải nói thẳng, nói\n  thật! Dựng lại Phật giáo mà không dám nói thẳng, nói thật thì người ta\n  vẫn cho đó là đúng; mà cho nó là đúng thì người ta sẽ đi theo cái sai.</p>\n<p>  Cho nên Thầy nói như vậy các con sẽ suy ngẫm, tự suy ngẫm; đúng thì\n  mấy con theo – Thầy không ép buộc; được thì mấy con hữu duyên, mà\n  không được thì mấy con chịu chứ không phải riêng Thầy.</p>\n<p>  Còn ở đây Thầy khuyên các thầy nên tu tập đúng theo Thầy hướng dẫn;\n  mà tu tập sai theo kiến giải, tưởng giải của quý thầy thì quý thầy\n  chịu trách nhiệm cái sai của quý thầy.</p>\n<p>  Các Thầy phải hiểu Thầy là 1 người đã kinh nghiệm đi qua trên con\n  đường này, làm chủ được sự sống chết của mình, mà bây giờ đem truyền\n  dạy lại cho quý vị làm chủ sự sống chết cho quý vị. Thì quý vị phải\n  hiểu biết người có kinh nghiệm như vậy, dạy mình sẽ không sai!</p>\n<p>  Cho nên trong kinh sách Phật dạy, bảo mình tìm thiện hữu tri thức –\n  người đó phải hết tham, sân, si; người đó phải chứng đạt được chân lý\n  – đó là Thầy của mình! Người đó phải sống đúng giới luật – giới luật\n  còn là Phật giáo còn, giới luật mất là Phật giáo mất.</p>\n<p>\n  <em>Cho nên chúng ta tìm 1 vị thầy mà giới luật nghiêm chỉnh, không hề\n    vi phạm 1 lỗi nhỏ nhặt nào thì đó là Phật giáo còn. Còn nếu tìm\n    không được thì đương nhiên – dù có trăm ngàn danh từ nói Phật giáo\n    thì Phật giáo đó vẫn sai! Vị thầy chúng ta phạm giới, phá giới mà\n    chúng ta theo tu tập thì chúng ta chẳng làm chủ sanh tử luân hồi.\n    Tại sao vậy? Tại vì tâm không ly dục, ly ác pháp cho nên mới phạm\n    giới. Còn tâm ly dục ly ác pháp thì không bao giờ phạm giới!</em></p>\n<p>  (21:36) Cho nên quý Phật tử cũng như các thầy nghe Thiền tông nói:\n  Tự tại vô ngại, đói ăn, khát uống, mệt đi ngủ; rồi thõng tay vào chợ,\n  nào là xách cá quải thịt, nào là uống rượu đủ thứ hết! Cho những vị đó\n  là tự tại rồi, sống vô ngại rồi, không có còn chướng ngại nữa, gọi là\n  giải thoát. Thực sự tu hành rồi mà trở lại sống còn hơn 1 người bê bối\n  – rượu chè say sưa. Sống như vậy có đúng không?</p>\n<p>  1 người tu phải có hạnh của người tu! Người tu gì mà lại rượu chè\n  say sưa – gọi là tự tại; muốn ăn, muốn ngủ hồi nào cũng được hết sao?\n  Giống như người phàm phu – người phàm phu họ cũng muốn ăn, muốn ngủ\n  hồi nào cũng được, có gì đâu!</p>\n<p>  Cho nên ở đây, cái danh từ mà gọi là <em>“tự tại vô ngại”</em> thì\n  Thầy thấy thật sự không phải áp dụng cho người tu sĩ của đạo Phật mà\n  áp dụng cho cái người vào cái sự sống hiện sinh của họ, sống trong cái\n  dục lạc của họ để họ thỏa mãn trong đời sống của họ – họ nói chết là\n  hết rồi, chỉ có đời nay thôi, mình hưởng cho hết dục lạc trên thế gian\n  này, chết thì người nào cũng chết hết. Đó là cái hiểu biết không đúng,\n  cạn cợt, không đúng – chết chưa phải là hết!</p>\n<p>  Và sống không phải có nghĩa là chúng ta sống mà không tái sanh luân\n  hồi. Do học bài đạo đức nhân quả vừa rồi đã xác định cho mấy con thấy\n  1 hành động của chúng ta là sẽ tái sanh làm 1 con vật hoặc là làm con người.</p>\n<p>  Quý vị nhớ kỹ những bài học nhân quả này mà khắc ghi trong lòng để\n  thực hiện đạo đức nhân bản – nhân quả, sống không làm khổ mình, khổ\n  người; tất cả những hành động ác – chúng ta không làm nữa!</p>\n<p>  Cho nên đức Phật nói: <em>“Ngăn ác, Diệt ác – Sanh thiện, Tăng\n    trưởng thiện”</em> hoặc là <em>“Chư ác mạc tác, chúng thiện phụng\n  hành”.</em> Lời nói của đức Phật dạy như vậy, chúng ta hãy cố gắng mà\n  tu tập!</p>\n<p>  Đến đây Thầy xin chấm dứt. Và buổi học hôm nay, mấy con có hỏi gì\n  thì giờ này cứ hỏi, Thầy sẽ trả lời. Bây giờ ai có thắc mắc những gì\n  thì hỏi, mà không thắc mắc thì chúng ta về, vì giờ chúng ta sắp sửa đi\n  khất thực.</p>\n<p>\n  <em>(Trích </em>\n  <a href=\"https://thuvienchonnhu.net/phap-am/LCK-028\">LCK 028D (CHUNG)\n    – HỌC TẬP ĐẠO ĐỨC NHÂN BẢN NHÂN QUẢ – ĐỪNG THEO KIẾN GIẢI ĐẠI THỪA –\n    VẤN ĐẠO LÀM CHỦ NHÂN QUẢ</a>\n  <em>)</em></p>\n','Dai thua lo lot phi nhan qua',NULL,'Đại Thừa Dạy Lo Lót Phi Nhân Quả','','Đại Thừa Dạy Lo Lót Phi Nhân Quả','','Gạo Ngon Nhất Thế Giới','dai-thua-lo-lot-phi-nhan-qua',2,50),(6,'2026-09-14 15:07:50','2026-09-14 15:07:50',NULL,'<h1>\n  <span class=\"post-title\">Đại Thừa Dạy Lo Lót Phi Nhân Quả, Nuôi Dưỡng\n    Dục Thế Gian Làm Hư Hoại Phật Giáo!</span></h1>\n<p>\n  <span class=\"post-title\">\n    <img alt=\"\" src=\"/static/files/DEFAULT/IMAGE/logo.jpg\" style=\"float: left;margin: 10.0px 20.0px;border-width: 10.0px;border-style: solid;\" /></span></p>\n<p>\n  <a href=\"https://youtu.be/PsrzF2_SGXc?si=9CjwgZqbCWzQYLAi\">https://youtu.be/PsrzF2_SGXc?si=9CjwgZqbCWzQYLAi</a></p>\n<p>  Bây giờ các con thấy – người ta dạy rất sai! Câu chuyện Mục Liên\n  Thanh Đề ở trong bản kinh Vu Lan Bồn – mấy con thấy sai không? Dạy\n  người ta ngày báo hiếu, mà báo hiếu như vậy sao? Báo hiếu bằng cách lo lót!</p>\n<p>  Nghĩa là Phật tử phải lo lót cho quý thầy, cho Phật rồi mới được\n  cứu độ! Như vậy có đúng không?</p>\n<p>  Các con nghe câu chuyện khi mà ông Mục Kiền Liên tu đắc Lục thông –\n  mẹ ông chết, ông mới đi tìm mẹ ông ở dưới địa ngục; ông mới thấy mẹ\n  ông ngồi ở trong địa ngục Ngạ quỷ, đói khát, khổ sở; ông mới bưng bát\n  cơm cho mẹ ông ăn; mẹ ông vừa bốc cơm ăn thì lửa cháy – ăn, nuốt không\n  được. Cái cảnh quá khổ!</p>\n<p>  Cho nên, ông cũng không đủ sức của mình để cứu mẹ. Cho nên ông về\n  xin Phật dạy cho ông cách nào để cứu mẹ ông thoát khỏi địa ngục Ngạ\n  quỷ này.</p>\n<p>  Đức Phật nói: <em>“Ông hãy về sắm tứ sự…​”.</em></p>\n<p>  Rồi sắm tứ sự rồi thì để làm gì? Các con hiểu – khi đó phải đem đến\n  cúng Phật và cúng chư Thánh Tăng – nhờ công đức tu hành của họ, sau 3\n  tháng an cư kiết hạ, tức là rằm tháng Bảy là người ta giải hạ ra, cho\n  nên ngày đó gọi là ngày báo hiếu.</p>\n<p>  Vì vậy cho nên lấy cái câu chuyện Mục Liên Thanh Đề để làm ngày báo\n  hiếu. Bây giờ chúng ta có cái ngày rằm tháng Bảy là ngày báo hiếu, do\n  đó chúng ta lấy cái tích lịch sử của Mục Kiền Liên.</p>\n<p>  Mà thử hỏi, bây giờ phải cúng dường trai Tăng cho chúng Tăng và\n  Phật, rồi nhờ công đức của các Ngài đó mới cứu độ bà Thanh Đề thoát\n  khỏi địa ngục. Như vậy trước khi cứu độ là ông Mục Kiền Liên có phạm\n  cái tội lo lót! Đứng trên pháp luật mà! Đại thừa dạy chúng ta có sự lo\n  lót rõ ràng!</p>\n<p>  Vậy kinh sách đúng không? – Không đúng! Dạy chúng ta làm điều sai –\n  đâu phải dạy chúng ta làm điều đúng!</p>\n<p>  Bà Thanh Đề tạo tội thì bà phải trả cái tội đó cho đến khi bà trả\n  hết tội đó. Thí dụ như bây giờ mình làm cái tội mà mình ở tù 10 năm,\n  thì phải ở tù 10 năm thì Nhà nước sẽ thả mình ra.</p>\n<p>  Còn bà Thanh Đề làm tội thì bà phải ở tù bao nhiêu năm, chịu khổ đó\n  bao nhiêu để trả cái tội của bà – cớ sao lại làm cái chuyện phi đạo\n  đức như vậy? Rồi Phật và chư Thánh Tăng lại ăn lo hối lộ – nhận của đó\n  mới cứu.</p>\n<p>  Vậy thì trong địa ngục Ngạ quỷ này đâu phải có 1 mình bà Thanh Đề,\n  có nhiều bà Thanh Đề chứ không phải 1 bà Thanh Đề! Không lẽ mở địa\n  ngục ra chỉ có nhận bà Thanh Đề, còn bao nhiêu những người không làm ác?</p>\n<p>  Vậy thì ở địa ngục đó rất nhiều người – đức Phật là 1 người công\n  bằng chứ, đạo lý chứ! Bà Thanh Đề khổ thì những người khác cũng khổ y\n  chứ! Tại sao không cứu độ? Các con có nghe chưa? Mình có công đức cứu\n  được mà tại sao không cứu hết những người này, lại chỉ có cứu bà này thôi?</p>\n<p>  Tại vì cái lý do là những người kia không có lo lót! Có phải không?\n  Nếu mà lo lót như ông Mục Kiền Liên thì chắc chắn là phải cứu hết chứ gì?</p>\n<p>  Thôi, như vậy là các thầy Thánh Tăng trong lúc đó với Phật – chắc\n  là tiền của chất đâu cho hết! Bởi vì đụng ai cũng ăn lo lót hết thì\n  phải giàu chứ sao? Bây giờ mới cất villa – biệt thự mà ở.</p>\n<p>  Như vậy hiện giờ chúng ta thấy villa – biệt thự của các chùa như\n  thế nào mấy con thấy không? Cái sự ăn lo đó bây giờ chúng ta thấy chùa\n  hàng tỷ bạc! Chùa nào mà cất dưới tỷ bao giờ đâu? Cái cửa cổng họ vô,\n  Thầy thấy trời ơi nó sang còn hơn!</p>\n<p>  Lấy số tiền đó mà cho đồng bào, cho những người bất hạnh trong xã\n  hội – nội cái cửa cổng của họ thôi, thì Thầy thấy cũng đem lại hạnh\n  phúc cho biết bao nhiêu người. Có đúng không? Mấy con thấy chưa?</p>\n<p>\n  <em>Những điều dạy phi đạo đức vậy mà chúng ta cho kinh sách Đại thừa\n    là đúng sao? Các con cứ suy ngẫm đi!</em></p>\n<p>  Bây giờ Thầy nói về vấn đề Tịnh Độ: các con thấy Đại thừa dạy chúng\n  ta tu tập Tịnh Độ chứ gì? Nghĩa là người nào mà Niệm Phật để cầu về\n  Cực Lạc – dễ dàng quá! Như 48 lời nguyện của đức Phật Di Đà, mấy con\n  có nghe không? <em>“Thiện nam tín nữ các người chí thành tưởng Phật\n    niệm mười tiếng ra. Ta không rước ở nước ta, thệ không làm Phật,\n    chắc đà không sai”.</em></p>\n<p>  Các con có nghe cái lời nguyện của đức Phật Di Đà không? Mấy con\n  chỉ cần niệm 10 tiếng thôi, đừng có niệm nhiều, cũng đủ rồi. Vậy thì\n  mấy con niệm 10 tiếng quá dễ rồi chứ gì?</p>\n<p>  Cho nên bây giờ, tôi niệm cả ngàn tiếng chứ tôi không niệm 10 tiếng\n  đâu! Chắc chắn là Phật Di Đà sẽ sắp xếp cho tôi có cái nhà đâu ở trển\n  rồi đó, mà tôi vừa tắt thở là mang tôi về trển rồi. Vì có 10 tiếng mà\n  ông còn rước, mà bây giờ tôi niệm cả ngàn tiếng rồi, thì chắc ăn rồi\n  chứ còn gì! Các con thấy đúng không? Như vậy quá đúng rồi! Cho nên mọi\n  người đều cùng nhau mà cố gắng niệm Phật.</p>\n<p>  Nhưng thử hỏi, khi mà tâm mấy con còn tham, sân, si, giận hờn mà\n  ông Phật Di Đà mà ông rước về nước ông – chắc chắn mấy con sẽ đánh lộn\n  trên đó hết! Có đúng không?</p>\n<p>  Thì bây giờ ông Phật Di Đà mới thành lập cái tòa án – nước người ta\n  thuở giờ hoàn toàn không có người tham sân si; mà bây giờ rước cái\n  chúng sanh ở dưới thế gian này lên, bây giờ nó có tham, sân, si rồi;\n  cho nên đất thì lát vàng – Thầy nghe trong kinh Di Đà nói mà, đất lát\n  vàng, hàng rào thì âm nhạc; lúc bây giờ chúng ta nghe hát hay quá\n  chúng ta ra nhổ hàng rào đem vô nhà cất hết, bởi vì chúng ta muốn sử\n  dụng mà! Thì các con thấy cái đó có đúng không?</p>\n<p>  Rồi vàng mà lót ở dưới đất như vậy đó, các con thấy vàng ở thế gian\n  này đắt quá; cho nên vì vậy mình cạy, mình cất để mai mốt mình trở về\n  thế gian mình đem bán; thì bây giờ vàng lên quá cao, cho nên mình sẽ\n  giàu sang.</p>\n<p>  1 lần mà đi lên trên đó về, mình ước ao trở về thế gian chứ:\n    <em>“Đặng tôi còn đem bán cái này chứ! Để ở trên tôi đi gom góp, tôi\n    về tôi bán!”.</em> Thì như vậy mấy con thấy cái đó đúng không mấy con?</p>\n<p>  Con người chúng ta phải dọn sạch – tâm chúng ta hết tham, sân, si\n  thì chúng ta sẽ được về đó. Mà tâm chúng ta còn tham, sân, si thì\n  chúng ta về đó sao được mấy con? Làm sao ai chứng cho mình được về đó!\n  Cho nên đâu có dễ dàng được! Mấy con biết các thầy vật lộn với tham,\n  sân, si của mình dường nào không?</p>\n<p>  Các con cứ thử nghĩ cái tâm si của chúng ta nó hiện ra cái tướng\n  hôn trầm, thùy miên, buồn ngủ – mấy con thức 10 giờ, 11 – 12 giờ;\n  chừng mấy con dậy 1 – 2 giờ, mấy con dậy nổi không? Hay là nó lăn qua\n  lộn lại, nó lười biếng, nó nằm đó để nó ráng ngủ thêm? Các con thấy\n  cái si ghê gớm – cái si là tướng lười biếng!</p>\n<p>  Mà ở đây chúng Tăng và quý cư sĩ ở đây tu tập gay go với nó lắm mới\n  thắng nổi! Vậy mà thắng nổi nhưng chưa hẳn đúng pháp thì chưa hẳn nó\n  dứt cơn đâu – nó còn đó, hở ra 1 chút là nó đánh nhẹp liền tức khắc!\n  Tức là chúng ta bị hôn trầm, thùy miên. Các con thấy chưa?</p>\n<p>  Như vậy chúng ta biết rằng kinh sách Nguyên Thủy đúng hay là kinh\n  sách Đại thừa đúng? Đức Phật dạy: <em>“Ngăn ác, Diệt ác – Sanh thiện\n    Tăng trưởng thiện”</em> – sống trong giới luật nghiêm chỉnh thì mới\n  ly dục, ly ác pháp được; mà sống ngoài giới luật thì làm sao ly dục,\n  ly ác pháp được!</p>\n<p>  Mà bây giờ chúng ta sống trong dục lạc, nghe cõi Cực Lạc quá đẹp đẽ\n  – ham mê, thì chúng ta mong chúng ta về đó! Nhưng lòng tham chúng ta\n  hết không – mà không hết thì thử hỏi làm sao chúng ta sống được?</p>\n<p>  Thầy nói thẳng, nói thật thì sẽ mích lòng nhưng phải nói thẳng, nói\n  thật! Dựng lại Phật giáo mà không dám nói thẳng, nói thật thì người ta\n  vẫn cho đó là đúng; mà cho nó là đúng thì người ta sẽ đi theo cái sai.</p>\n<p>  Cho nên Thầy nói như vậy các con sẽ suy ngẫm, tự suy ngẫm; đúng thì\n  mấy con theo – Thầy không ép buộc; được thì mấy con hữu duyên, mà\n  không được thì mấy con chịu chứ không phải riêng Thầy.</p>\n<p>  Còn ở đây Thầy khuyên các thầy nên tu tập đúng theo Thầy hướng dẫn;\n  mà tu tập sai theo kiến giải, tưởng giải của quý thầy thì quý thầy\n  chịu trách nhiệm cái sai của quý thầy.</p>\n<p>  Các Thầy phải hiểu Thầy là 1 người đã kinh nghiệm đi qua trên con\n  đường này, làm chủ được sự sống chết của mình, mà bây giờ đem truyền\n  dạy lại cho quý vị làm chủ sự sống chết cho quý vị. Thì quý vị phải\n  hiểu biết người có kinh nghiệm như vậy, dạy mình sẽ không sai!</p>\n<p>  Cho nên trong kinh sách Phật dạy, bảo mình tìm thiện hữu tri thức –\n  người đó phải hết tham, sân, si; người đó phải chứng đạt được chân lý\n  – đó là Thầy của mình! Người đó phải sống đúng giới luật – giới luật\n  còn là Phật giáo còn, giới luật mất là Phật giáo mất.</p>\n<p>\n  <em>Cho nên chúng ta tìm 1 vị thầy mà giới luật nghiêm chỉnh, không hề\n    vi phạm 1 lỗi nhỏ nhặt nào thì đó là Phật giáo còn. Còn nếu tìm\n    không được thì đương nhiên – dù có trăm ngàn danh từ nói Phật giáo\n    thì Phật giáo đó vẫn sai! Vị thầy chúng ta phạm giới, phá giới mà\n    chúng ta theo tu tập thì chúng ta chẳng làm chủ sanh tử luân hồi.\n    Tại sao vậy? Tại vì tâm không ly dục, ly ác pháp cho nên mới phạm\n    giới. Còn tâm ly dục ly ác pháp thì không bao giờ phạm giới!</em></p>\n<p>  (21:36) Cho nên quý Phật tử cũng như các thầy nghe Thiền tông nói:\n  Tự tại vô ngại, đói ăn, khát uống, mệt đi ngủ; rồi thõng tay vào chợ,\n  nào là xách cá quải thịt, nào là uống rượu đủ thứ hết! Cho những vị đó\n  là tự tại rồi, sống vô ngại rồi, không có còn chướng ngại nữa, gọi là\n  giải thoát. Thực sự tu hành rồi mà trở lại sống còn hơn 1 người bê bối\n  – rượu chè say sưa. Sống như vậy có đúng không?</p>\n<p>  1 người tu phải có hạnh của người tu! Người tu gì mà lại rượu chè\n  say sưa – gọi là tự tại; muốn ăn, muốn ngủ hồi nào cũng được hết sao?\n  Giống như người phàm phu – người phàm phu họ cũng muốn ăn, muốn ngủ\n  hồi nào cũng được, có gì đâu!</p>\n<p>  Cho nên ở đây, cái danh từ mà gọi là <em>“tự tại vô ngại”</em> thì\n  Thầy thấy thật sự không phải áp dụng cho người tu sĩ của đạo Phật mà\n  áp dụng cho cái người vào cái sự sống hiện sinh của họ, sống trong cái\n  dục lạc của họ để họ thỏa mãn trong đời sống của họ – họ nói chết là\n  hết rồi, chỉ có đời nay thôi, mình hưởng cho hết dục lạc trên thế gian\n  này, chết thì người nào cũng chết hết. Đó là cái hiểu biết không đúng,\n  cạn cợt, không đúng – chết chưa phải là hết!</p>\n<p>  Và sống không phải có nghĩa là chúng ta sống mà không tái sanh luân\n  hồi. Do học bài đạo đức nhân quả vừa rồi đã xác định cho mấy con thấy\n  1 hành động của chúng ta là sẽ tái sanh làm 1 con vật hoặc là làm con người.</p>\n<p>  Quý vị nhớ kỹ những bài học nhân quả này mà khắc ghi trong lòng để\n  thực hiện đạo đức nhân bản – nhân quả, sống không làm khổ mình, khổ\n  người; tất cả những hành động ác – chúng ta không làm nữa!</p>\n<p>  Cho nên đức Phật nói: <em>“Ngăn ác, Diệt ác – Sanh thiện, Tăng\n    trưởng thiện”</em> hoặc là <em>“Chư ác mạc tác, chúng thiện phụng\n  hành”.</em> Lời nói của đức Phật dạy như vậy, chúng ta hãy cố gắng mà\n  tu tập!</p>\n<p>  Đến đây Thầy xin chấm dứt. Và buổi học hôm nay, mấy con có hỏi gì\n  thì giờ này cứ hỏi, Thầy sẽ trả lời. Bây giờ ai có thắc mắc những gì\n  thì hỏi, mà không thắc mắc thì chúng ta về, vì giờ chúng ta sắp sửa đi\n  khất thực.</p>\n<p>\n  <em>(Trích </em>\n  <a href=\"https://thuvienchonnhu.net/phap-am/LCK-028\">LCK 028D (CHUNG)\n    – HỌC TẬP ĐẠO ĐỨC NHÂN BẢN NHÂN QUẢ – ĐỪNG THEO KIẾN GIẢI ĐẠI THỪA –\n    VẤN ĐẠO LÀM CHỦ NHÂN QUẢ</a>\n  <em>)</em></p>\n','Đại Thừa Lo Lót Phi Nhân Quả',NULL,'','','','','','i-tha-lo-lt-phi-nhn-qu',4,50),(7,'2026-09-18 06:56:19','2026-09-18 06:56:19',NULL,'<p>  st25</p>\n','ST25',NULL,'st25','st25,rice,','st25','','description','st25',4,1),(8,'2026-09-18 06:56:19','2026-09-18 06:56:19',NULL,'<p>  st25</p>\n','ST25',NULL,'','st25,rice,','','','','st25',2,1);
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
INSERT INTO `PRODUCT_IMAGE` VALUES (2,_binary '\0',_binary '\0',0,'logo.jpg',NULL,1),(3,_binary '\0',_binary '\0',0,'image8.gif',NULL,1),(50,_binary '',_binary '\0',0,'logo.jpg',NULL,50),(100,_binary '',_binary '\0',0,'logo.jpg',NULL,1);
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
INSERT INTO `PRODUCT_IMAGE_DESCRIPTION` VALUES (3,'2026-09-14 15:07:50','2026-09-14 15:07:50',NULL,NULL,'logo.jpg',NULL,NULL,1,50),(4,'2026-09-14 15:07:50','2026-09-14 15:07:50',NULL,NULL,'logo.jpg',NULL,NULL,2,50),(5,'2026-09-14 15:07:50','2026-09-14 15:07:50',NULL,NULL,'logo.jpg',NULL,NULL,3,50),(6,'2026-09-14 15:07:50','2026-09-14 15:07:50',NULL,NULL,'logo.jpg',NULL,NULL,4,50),(7,'2026-09-15 14:42:47','2026-09-15 14:42:47',NULL,NULL,'logo.jpg',NULL,NULL,1,100),(8,'2026-09-15 14:42:47','2026-09-15 14:42:47',NULL,NULL,'logo.jpg',NULL,NULL,2,100),(9,'2026-09-15 14:42:47','2026-09-15 14:42:47',NULL,NULL,'logo.jpg',NULL,NULL,3,100),(10,'2026-09-15 14:42:47','2026-09-15 14:42:47',NULL,NULL,'logo.jpg',NULL,NULL,4,100);
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
INSERT INTO `PRODUCT_OPTION` VALUES (1,'gaoloai1',NULL,'radio',_binary '\0',1),(2,'gaoloai2',NULL,'radio',_binary '\0',1);
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
INSERT INTO `PRODUCT_OPTION_DESC` VALUES (1,'2026-09-12 08:55:17','2026-09-12 08:55:17',NULL,NULL,'gạo loại 1',NULL,NULL,3,1),(2,'2026-09-12 08:55:17','2026-09-12 08:55:17',NULL,NULL,'gạo loại 1',NULL,NULL,1,1),(3,'2026-09-12 08:55:41','2026-09-12 08:55:41',NULL,NULL,'gạo loại 2',NULL,NULL,3,2),(4,'2026-09-12 08:55:41','2026-09-12 08:55:41',NULL,NULL,'gạo loại 2',NULL,NULL,1,2);
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
INSERT INTO `PRODUCT_OPTION_VALUE` VALUES (1,'pricegaoloai1',_binary '\0','bag-picture-text.avif',NULL,1),(2,'pricegaoloai2',_binary '\0','logo.jpg',NULL,1);
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
INSERT INTO `PRODUCT_OPTION_VALUE_DESCRIPTION` VALUES (1,'2026-09-12 08:56:41','2026-09-12 08:56:41',NULL,NULL,'gạo loại 1',NULL,3,1),(2,'2026-09-12 08:56:41','2026-09-12 08:56:41',NULL,NULL,'gạo loại 1',NULL,1,1),(3,'2026-09-12 08:57:02','2026-09-12 08:57:02',NULL,NULL,'gạo loại 2',NULL,3,2),(4,'2026-09-12 08:57:02','2026-09-12 08:57:02',NULL,NULL,'gạo loại 2',NULL,1,2);
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
INSERT INTO `PRODUCT_PRICE` VALUES (1,'ST25',_binary '',250000.00,200000.00,'2026-11-12','2026-09-12','ONE_TIME',1),(50,'base',_binary '',0.00,NULL,NULL,NULL,'ONE_TIME',50);
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
INSERT INTO `PRODUCT_PRICE_DESCRIPTION` VALUES (1,'2026-09-18 07:14:39','2026-09-18 07:14:39',NULL,NULL,'usd',NULL,'10',1,1),(2,'2026-09-18 07:14:39','2026-09-18 07:14:39',NULL,NULL,'ST25',NULL,'ST25',3,1),(3,'2026-09-14 15:07:50','2026-09-14 15:07:50',NULL,NULL,'DEFAULT',NULL,NULL,1,50),(4,'2026-09-14 15:07:50','2026-09-14 15:07:50',NULL,NULL,'DEFAULT',NULL,NULL,2,50),(5,'2026-09-14 15:07:50','2026-09-14 15:07:50',NULL,NULL,'DEFAULT',NULL,NULL,4,50),(6,'2026-09-14 15:07:50','2026-09-14 15:07:50',NULL,NULL,'DEFAULT',NULL,NULL,3,50),(7,'2026-09-18 07:14:39','2026-09-18 07:14:39',NULL,NULL,'2000',NULL,'2000',4,1),(8,'2026-09-18 07:14:39','2026-09-18 07:14:39',NULL,NULL,'250',NULL,'250',2,1);
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
INSERT INTO `PRODUCT_RELATIONSHIP` VALUES (1,_binary '','FEATURED_ITEM',NULL,1,1),(50,_binary '','page2',NULL,NULL,1),(100,_binary '','RELATED_ITEM',1,1,1);
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
INSERT INTO `PRODUCT_REVIEW` VALUES (1,'2026-09-13 12:29:53','2026-09-13 12:29:53',NULL,'2026-09-12 17:00:00',5,NULL,NULL,50,1);
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
INSERT INTO `PRODUCT_REVIEW_DESCRIPTION` VALUES (1,'2026-09-13 12:29:53','2026-09-13 12:29:53',NULL,'ngon quá','-',NULL,3,1);
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
INSERT INTO `PRODUCT_TYPE` VALUES (1,NULL,'2026-09-12 03:18:03','2026-09-12 03:18:03',NULL,'GENERAL',NULL,NULL);
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
INSERT INTO `SHIPING_ORIGIN` VALUES (1,_binary '','Phố Đêm Xứ Trảng','Trảng Bàng','80000','',230,1,70);
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
INSERT INTO `SHIPPING_QUOTE` VALUES (1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-12 07:48:22',NULL,0.00,'2026-09-12 07:48:22',230,70),(2,1,NULL,'Tu Viện Chơn Như','Tây Ninh',NULL,NULL,NULL,'80000',NULL,NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-12 07:52:32',NULL,140.00,'2026-09-12 07:52:32',230,70),(3,1,NULL,'Tu Viện Chơn Như','Tây Ninh',NULL,NULL,NULL,'80000',NULL,NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-12 07:52:32',NULL,0.00,'2026-09-12 07:52:32',230,70),(4,1,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-12 07:53:25',NULL,140.00,'2026-09-12 07:53:25',230,70),(5,1,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-12 07:53:25',NULL,0.00,'2026-09-12 07:53:25',230,70),(6,2,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-12 08:17:44',NULL,140.00,'2026-09-12 08:17:44',230,70),(7,2,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-12 08:17:44',NULL,0.00,'2026-09-12 08:17:44',230,70),(8,2,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-12 08:18:02',NULL,140.00,'2026-09-12 08:18:02',230,70),(9,2,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-12 08:18:02',NULL,0.00,'2026-09-12 08:18:02',230,70),(10,3,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-12 08:21:51',NULL,140.00,'2026-09-12 08:21:51',230,70),(11,3,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-12 08:21:52',NULL,0.00,'2026-09-12 08:21:52',230,70),(12,3,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-12 08:21:55',NULL,140.00,'2026-09-12 08:21:55',230,70),(13,3,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-12 08:21:55',NULL,0.00,'2026-09-12 08:21:55',230,70),(14,4,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-12 08:22:18',NULL,140.00,'2026-09-12 08:22:18',230,70),(15,4,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-12 08:22:18',NULL,0.00,'2026-09-12 08:22:18',230,70),(16,4,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-12 08:22:24',NULL,140.00,'2026-09-12 08:22:24',230,70),(17,4,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-12 08:22:24',NULL,0.00,'2026-09-12 08:22:24',230,70),(18,5,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-12 08:28:22',NULL,140.00,'2026-09-12 08:28:22',230,70),(19,5,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-12 08:28:22',NULL,0.00,'2026-09-12 08:28:22',230,70),(20,5,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-12 08:28:28',NULL,140.00,'2026-09-12 08:28:28',230,70),(21,5,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-12 08:28:28',NULL,0.00,'2026-09-12 08:28:28',230,70),(50,50,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-12 08:34:50',NULL,140.00,'2026-09-12 08:34:50',230,70),(51,50,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-12 08:34:50',NULL,0.00,'2026-09-12 08:34:50',230,70),(52,50,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-12 08:34:55',NULL,140.00,'2026-09-12 08:34:55',230,70),(53,50,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-12 08:34:55',NULL,0.00,'2026-09-12 08:34:55',230,70),(100,100,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-13 01:13:43',NULL,140.00,'2026-09-13 01:13:43',230,70),(101,100,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-13 01:13:44',NULL,0.00,'2026-09-13 01:13:44',230,70),(102,100,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-13 01:14:13',NULL,140.00,'2026-09-13 01:14:13',230,70),(103,100,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-13 01:14:13',NULL,0.00,'2026-09-13 01:14:13',230,70),(104,100,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-13 01:14:30',NULL,140.00,'2026-09-13 01:14:30',230,70),(105,100,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-13 01:14:30',NULL,0.00,'2026-09-13 01:14:30',230,70),(106,100,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-13 01:16:51',NULL,140.00,'2026-09-13 01:16:51',230,70),(107,100,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-13 01:16:51',NULL,0.00,'2026-09-13 01:16:51',230,70),(108,100,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-13 01:17:05',NULL,140.00,'2026-09-13 01:17:05',230,70),(109,100,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-13 01:17:05',NULL,0.00,'2026-09-13 01:17:05',230,70),(110,101,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-13 01:18:21',NULL,140.00,'2026-09-13 01:18:21',230,70),(111,101,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-13 01:18:21',NULL,0.00,'2026-09-13 01:18:21',230,70),(112,101,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-13 01:18:30',NULL,140.00,'2026-09-13 01:18:30',230,70),(113,101,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-13 01:18:30',NULL,0.00,'2026-09-13 01:18:30',230,70),(114,102,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-13 01:24:06',NULL,140.00,'2026-09-13 01:24:06',230,70),(115,102,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-13 01:24:06',NULL,0.00,'2026-09-13 01:24:06',230,70),(116,102,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-13 01:48:03',NULL,0.00,'2026-09-13 01:48:03',230,70),(117,102,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-13 01:49:11',NULL,0.00,'2026-09-13 01:49:11',230,70),(118,102,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-13 01:49:30',NULL,140.00,'2026-09-13 01:49:30',230,70),(119,102,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-13 01:49:30',NULL,0.00,'2026-09-13 01:49:30',230,70),(120,102,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-13 01:49:44',NULL,140.00,'2026-09-13 01:49:44',230,70),(121,102,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-13 01:49:44',NULL,0.00,'2026-09-13 01:49:44',230,70),(150,200,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-13 12:30:10',NULL,0.00,'2026-09-13 12:30:10',230,70),(151,200,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-13 12:30:38',NULL,140.00,'2026-09-13 12:30:38',230,NULL),(152,200,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-13 12:30:38',NULL,140.00,'2026-09-13 12:30:38',230,NULL),(153,200,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-13 12:30:38',NULL,0.00,'2026-09-13 12:30:38',230,NULL),(154,200,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-13 12:30:38',NULL,0.00,'2026-09-13 12:30:38',230,NULL),(155,200,NULL,'','','','','','','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-13 12:30:59',NULL,0.00,'2026-09-13 12:30:59',230,70),(156,200,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-13 12:31:23',NULL,140.00,'2026-09-13 12:31:23',230,NULL),(157,200,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-13 12:31:23',NULL,0.00,'2026-09-13 12:31:23',230,NULL),(158,200,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-13 12:32:05',NULL,140.00,'2026-09-13 12:32:05',230,NULL),(159,200,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-13 12:32:05',NULL,0.00,'2026-09-13 12:32:05',230,NULL),(200,150,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-13 13:48:34',NULL,0.00,'2026-09-13 13:48:34',230,70),(201,250,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-13 13:49:26',NULL,140.00,'2026-09-13 13:49:26',230,NULL),(202,250,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-13 13:49:26',NULL,0.00,'2026-09-13 13:49:26',230,NULL),(203,250,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-13 13:49:41',NULL,140.00,'2026-09-13 13:49:41',230,NULL),(204,250,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-13 13:49:41',NULL,0.00,'2026-09-13 13:49:41',230,NULL),(250,150,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-14 10:03:51',NULL,0.00,'2026-09-14 10:03:51',230,70),(251,150,NULL,'','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-14 10:03:56',NULL,140.00,'2026-09-14 10:03:56',230,70),(252,150,NULL,'','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-14 10:03:56',NULL,140.00,'2026-09-14 10:03:56',230,70),(253,150,NULL,'','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-14 10:03:56',NULL,0.00,'2026-09-14 10:03:56',230,70),(254,150,NULL,'','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-14 10:03:56',NULL,0.00,'2026-09-14 10:03:56',230,70),(255,150,NULL,'Tu Vien Chon Nhu','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-14 10:04:34',NULL,140.00,'2026-09-14 10:04:34',230,70),(256,150,NULL,'Tu Vien Chon Nhu','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-14 10:04:34',NULL,0.00,'2026-09-14 10:04:34',230,70),(257,300,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-14 10:06:10',NULL,0.00,'2026-09-14 10:06:10',230,70),(258,300,NULL,'','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-14 10:06:13',NULL,140.00,'2026-09-14 10:06:13',230,70),(259,300,NULL,'','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-14 10:06:13',NULL,140.00,'2026-09-14 10:06:13',230,70),(260,300,NULL,'','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-14 10:06:13',NULL,0.00,'2026-09-14 10:06:13',230,70),(261,300,NULL,'','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-14 10:06:13',NULL,0.00,'2026-09-14 10:06:13',230,70),(262,300,NULL,'Chùa Am','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-14 10:06:22',NULL,140.00,'2026-09-14 10:06:22',230,70),(263,300,NULL,'Chùa Am','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-14 10:06:22',NULL,0.00,'2026-09-14 10:06:22',230,70),(264,300,NULL,'Chùa Am','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-14 10:06:47',NULL,140.00,'2026-09-14 10:06:47',230,70),(265,300,NULL,'Chùa Am','Tây Ninh','',NULL,NULL,'80000','',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-14 10:06:47',NULL,0.00,'2026-09-14 10:06:47',230,70),(300,350,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-14 14:12:30',NULL,0.00,'2026-09-14 14:12:30',230,70),(301,350,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-14 14:12:30',NULL,0.00,'2026-09-14 14:12:30',230,70),(350,400,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-16 08:51:44',NULL,140.00,'2026-09-16 08:51:44',230,NULL),(351,400,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-16 08:51:44',NULL,0.00,'2026-09-16 08:51:44',230,NULL),(352,400,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-16 08:52:32',NULL,140.00,'2026-09-16 08:52:32',230,NULL),(353,400,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-16 08:52:32',NULL,0.00,'2026-09-16 08:52:32',230,NULL),(354,401,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-16 08:56:41',NULL,0.00,'2026-09-16 08:56:41',230,70),(355,401,NULL,'','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-16 08:56:45',NULL,140.00,'2026-09-16 08:56:45',230,NULL),(356,401,NULL,'','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-16 08:56:45',NULL,0.00,'2026-09-16 08:56:45',230,NULL),(357,401,NULL,'','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-16 08:56:45',NULL,140.00,'2026-09-16 08:56:45',230,NULL),(358,401,NULL,'','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-16 08:56:45',NULL,0.00,'2026-09-16 08:56:45',230,NULL),(359,401,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-16 08:57:12',NULL,140.00,'2026-09-16 08:57:12',230,NULL),(360,401,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-16 08:57:12',NULL,0.00,'2026-09-16 08:57:12',230,NULL),(400,450,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-16 10:26:31',NULL,0.00,'2026-09-16 10:26:31',230,70),(401,400,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-16 10:27:10',NULL,140.00,'2026-09-16 10:27:10',230,NULL),(402,400,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-16 10:27:10',NULL,0.00,'2026-09-16 10:27:10',230,NULL),(403,400,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-16 10:27:20',NULL,140.00,'2026-09-16 10:27:20',230,NULL),(404,400,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-16 10:27:20',NULL,0.00,'2026-09-16 10:27:20',230,NULL),(450,500,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-17 14:40:37',NULL,140.00,'2026-09-17 14:40:37',230,NULL),(451,500,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-17 14:40:37',NULL,0.00,'2026-09-17 14:40:37',230,NULL),(452,500,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-17 14:42:41',NULL,140.00,'2026-09-17 14:42:41',230,NULL),(453,500,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-17 14:42:41',NULL,0.00,'2026-09-17 14:42:41',230,NULL),(500,550,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'VN','2026-09-17 15:07:45',NULL,140.00,'2026-09-17 15:07:45',230,NULL),(501,550,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-17 15:07:45',NULL,0.00,'2026-09-17 15:07:45',230,NULL),(502,550,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'VN','2026-09-17 15:08:05',NULL,140.00,'2026-09-17 15:08:05',230,NULL),(503,550,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-17 15:08:05',NULL,0.00,'2026-09-17 15:08:05',230,NULL),(550,550,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-17 23:38:28',NULL,140.00,'2026-09-17 23:38:28',230,NULL),(551,550,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-17 23:38:28',NULL,0.00,'2026-09-17 23:38:28',230,NULL),(552,550,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-17 23:38:55',NULL,140.00,'2026-09-17 23:38:55',230,NULL),(553,550,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-17 23:38:55',NULL,0.00,'2026-09-17 23:38:55',230,NULL),(600,600,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 00:14:15',NULL,140.00,'2026-09-18 00:14:15',230,NULL),(601,600,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 00:14:15',NULL,0.00,'2026-09-18 00:14:15',230,NULL),(602,600,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 00:14:32',NULL,140.00,'2026-09-18 00:14:32',230,NULL),(603,600,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 00:14:33',NULL,0.00,'2026-09-18 00:14:33',230,NULL),(650,650,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'VN','2026-09-18 00:32:33',NULL,140.00,'2026-09-18 00:32:33',230,NULL),(651,650,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 00:32:33',NULL,0.00,'2026-09-18 00:32:33',230,NULL),(700,650,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 00:45:19',NULL,140.00,'2026-09-18 00:45:19',230,NULL),(701,650,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 00:45:19',NULL,0.00,'2026-09-18 00:45:19',230,NULL),(702,650,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 00:45:43',NULL,140.00,'2026-09-18 00:45:43',230,NULL),(703,650,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 00:45:43',NULL,0.00,'2026-09-18 00:45:43',230,NULL),(750,700,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 01:32:23',NULL,140.00,'2026-09-18 01:32:23',230,NULL),(751,700,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 01:32:23',NULL,0.00,'2026-09-18 01:32:23',230,NULL),(752,700,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 01:32:38',NULL,140.00,'2026-09-18 01:32:38',230,NULL),(753,700,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 01:32:38',NULL,0.00,'2026-09-18 01:32:38',230,NULL),(754,701,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 01:35:52',NULL,140.00,'2026-09-18 01:35:52',230,NULL),(755,701,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 01:35:52',NULL,0.00,'2026-09-18 01:35:52',230,NULL),(756,701,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 01:36:16',NULL,140.00,'2026-09-18 01:36:16',230,NULL),(757,701,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 01:36:16',NULL,0.00,'2026-09-18 01:36:16',230,NULL),(758,702,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 01:41:29',NULL,140.00,'2026-09-18 01:41:29',230,NULL),(759,702,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 01:41:29',NULL,0.00,'2026-09-18 01:41:29',230,NULL),(760,702,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 01:41:36',NULL,140.00,'2026-09-18 01:41:36',230,NULL),(761,702,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 01:41:36',NULL,0.00,'2026-09-18 01:41:36',230,NULL),(762,703,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 01:42:07',NULL,140.00,'2026-09-18 01:42:07',230,NULL),(763,703,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 01:42:07',NULL,0.00,'2026-09-18 01:42:07',230,NULL),(764,703,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 01:42:22',NULL,140.00,'2026-09-18 01:42:22',230,NULL),(765,703,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 01:42:22',NULL,0.00,'2026-09-18 01:42:22',230,NULL),(800,750,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 01:45:44',NULL,140.00,'2026-09-18 01:45:44',230,NULL),(801,750,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 01:45:44',NULL,0.00,'2026-09-18 01:45:44',230,NULL),(802,750,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 01:45:58',NULL,140.00,'2026-09-18 01:45:58',230,NULL),(803,750,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 01:45:58',NULL,0.00,'2026-09-18 01:45:58',230,NULL),(804,751,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 01:51:18',NULL,0.00,'2026-09-18 01:51:18',230,70),(805,751,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 01:51:32',NULL,140.00,'2026-09-18 01:51:32',230,NULL),(806,751,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 01:51:32',NULL,0.00,'2026-09-18 01:51:32',230,NULL),(807,751,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 01:51:44',NULL,140.00,'2026-09-18 01:51:44',230,NULL),(808,751,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 01:51:44',NULL,0.00,'2026-09-18 01:51:44',230,NULL),(850,800,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 02:20:11',NULL,140.00,'2026-09-18 02:20:11',230,NULL),(851,800,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 02:20:11',NULL,0.00,'2026-09-18 02:20:11',230,NULL),(852,800,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 02:20:35',NULL,140.00,'2026-09-18 02:20:35',230,NULL),(853,800,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 02:20:35',NULL,0.00,'2026-09-18 02:20:35',230,NULL),(900,850,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 02:53:32',NULL,140.00,'2026-09-18 02:53:32',230,NULL),(901,850,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 02:53:32',NULL,0.00,'2026-09-18 02:53:32',230,NULL),(902,850,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 02:53:49',NULL,140.00,'2026-09-18 02:53:49',230,NULL),(903,850,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 02:53:49',NULL,0.00,'2026-09-18 02:53:49',230,NULL),(904,851,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 02:55:42',NULL,140.00,'2026-09-18 02:55:42',230,NULL),(905,851,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 02:55:42',NULL,0.00,'2026-09-18 02:55:42',230,NULL),(906,851,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 02:55:44',NULL,140.00,'2026-09-18 02:55:44',230,NULL),(907,851,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 02:55:44',NULL,0.00,'2026-09-18 02:55:44',230,NULL),(908,852,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 02:56:19',NULL,140.00,'2026-09-18 02:56:19',230,NULL),(909,852,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 02:56:19',NULL,0.00,'2026-09-18 02:56:19',230,NULL),(950,852,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 03:08:36',NULL,140.00,'2026-09-18 03:08:36',230,NULL),(951,852,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 03:08:36',NULL,0.00,'2026-09-18 03:08:36',230,NULL),(952,852,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 03:08:43',NULL,140.00,'2026-09-18 03:08:43',230,NULL),(953,852,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 03:08:43',NULL,0.00,'2026-09-18 03:08:43',230,NULL),(1000,900,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 06:16:53',NULL,140.00,'2026-09-18 06:16:53',230,NULL),(1001,900,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 06:16:53',NULL,0.00,'2026-09-18 06:16:53',230,NULL),(1002,900,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 06:17:02',NULL,140.00,'2026-09-18 06:17:02',230,NULL),(1003,900,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 06:17:02',NULL,0.00,'2026-09-18 06:17:02',230,NULL),(1050,950,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 06:36:09',NULL,140.00,'2026-09-18 06:36:09',230,NULL),(1051,950,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 06:36:09',NULL,0.00,'2026-09-18 06:36:09',230,NULL),(1052,950,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 06:36:16',NULL,140.00,'2026-09-18 06:36:16',230,NULL),(1053,950,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 06:36:16',NULL,0.00,'2026-09-18 06:36:16',230,NULL),(1100,1000,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 06:59:07',NULL,140.00,'2026-09-18 06:59:07',230,NULL),(1101,1000,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 06:59:07',NULL,0.00,'2026-09-18 06:59:07',230,NULL),(1102,1000,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 06:59:25',NULL,140.00,'2026-09-18 06:59:25',230,NULL),(1103,1000,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 06:59:25',NULL,0.00,'2026-09-18 06:59:25',230,NULL),(1104,1051,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 07:16:19',NULL,0.00,'2026-09-18 07:16:19',230,70),(1105,1050,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 07:16:27',NULL,140.00,'2026-09-18 07:16:27',230,NULL),(1106,1050,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 07:16:27',NULL,0.00,'2026-09-18 07:16:27',230,NULL),(1107,1050,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 07:16:32',NULL,140.00,'2026-09-18 07:16:32',230,NULL),(1108,1050,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 07:16:32',NULL,0.00,'2026-09-18 07:16:32',230,NULL),(1109,1052,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 07:17:11',NULL,140.00,'2026-09-18 07:17:11',230,NULL),(1110,1052,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 07:17:11',NULL,0.00,'2026-09-18 07:17:11',230,NULL),(1111,1052,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 07:17:16',NULL,140.00,'2026-09-18 07:17:16',230,NULL),(1112,1052,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 07:17:16',NULL,0.00,'2026-09-18 07:17:16',230,NULL),(1113,1053,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'VN','2026-09-18 07:18:32',NULL,140.00,'2026-09-18 07:18:32',230,NULL),(1114,1053,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 07:18:32',NULL,0.00,'2026-09-18 07:18:32',230,NULL),(1150,1053,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 07:31:58',NULL,140.00,'2026-09-18 07:31:58',230,NULL),(1151,1053,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 07:31:58',NULL,0.00,'2026-09-18 07:31:58',230,NULL),(1152,1053,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'VN','2026-09-18 07:32:13',NULL,140.00,'2026-09-18 07:32:13',230,NULL),(1153,1053,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 07:32:13',NULL,0.00,'2026-09-18 07:32:13',230,NULL),(1154,1101,NULL,'','','',NULL,NULL,'','Ningxia',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 07:37:13',NULL,0.00,'2026-09-18 07:37:13',230,70),(1155,1101,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','Ningxia',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 07:37:23',NULL,140.00,'2026-09-18 07:37:23',230,70),(1156,1101,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','Ningxia',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 07:37:23',NULL,0.00,'2026-09-18 07:37:23',230,70),(1157,1101,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','Ningxia',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 07:37:23',NULL,140.00,'2026-09-18 07:37:23',230,70),(1158,1101,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','Ningxia',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 07:37:23',NULL,0.00,'2026-09-18 07:37:23',230,70),(1200,1101,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','Ningxia',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 08:06:13',NULL,140.00,'2026-09-18 08:06:13',230,70),(1201,1101,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','Ningxia',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 08:06:13',NULL,0.00,'2026-09-18 08:06:13',230,70),(1202,1101,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','Ningxia',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 08:06:33',NULL,140.00,'2026-09-18 08:06:33',230,70),(1203,1101,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','Ningxia',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 08:06:33',NULL,0.00,'2026-09-18 08:06:33',230,70),(1204,1101,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','Ningxia',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 08:06:41',NULL,140.00,'2026-09-18 08:06:41',230,NULL),(1205,1101,NULL,'Tu Viện Chơn Như','Tây Ninh','',NULL,NULL,'80000','Ningxia',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 08:06:41',NULL,0.00,'2026-09-18 08:06:41',230,NULL),(1250,1053,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','customQuotesRules','customQuotesRules',NULL,'Vietnam','2026-09-18 09:56:16',NULL,140.00,'2026-09-18 09:56:16',230,NULL),(1251,1053,NULL,'số 4 đường Chùa am','Tây Ninh','',NULL,NULL,'80000','Tây Ninh',NULL,NULL,_binary '\0',NULL,'0:0:0:0:0:0:0:1','storePickUp','storePickUp',NULL,NULL,'2026-09-18 09:56:16',NULL,0.00,'2026-09-18 09:56:16',230,NULL);
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
INSERT INTO `SHOPPING_CART` VALUES (1,'2026-09-12 07:48:06','2026-09-12 07:53:25',NULL,1,'0:0:0:0:0:0:0:1',1,NULL,NULL,'09424e71874b451e8280f97c6d132b73',1),(2,'2026-09-12 08:17:37','2026-09-12 08:18:03',NULL,1,'0:0:0:0:0:0:0:1',2,NULL,NULL,'84321bce6e414f32bf13183b116c5b2a',1),(3,'2026-09-12 08:21:46','2026-09-12 08:21:56',NULL,1,'0:0:0:0:0:0:0:1',3,NULL,NULL,'8196ce912bcd40ff9d584ac6073feed5',1),(4,'2026-09-12 08:22:08','2026-09-12 08:22:24',NULL,1,'0:0:0:0:0:0:0:1',4,NULL,NULL,'4292617c01774aaf85b65a59633af5f1',1),(5,'2026-09-12 08:28:08','2026-09-12 08:28:28',NULL,1,'0:0:0:0:0:0:0:1',5,NULL,NULL,'f157a7796e0046f19ba18c7f43a83598',1),(50,'2026-09-12 08:34:40','2026-09-12 08:34:55',NULL,1,'0:0:0:0:0:0:0:1',50,NULL,NULL,'e787b4d3b60148b89ff7ac8253bbe6f5',1),(100,'2026-09-13 01:13:25','2026-09-13 01:17:06',NULL,1,'0:0:0:0:0:0:0:1',100,NULL,NULL,'d5e6ea3194c14352b090b5f2d9bc09cd',1),(101,'2026-09-13 01:17:48','2026-09-13 01:18:30',NULL,1,'0:0:0:0:0:0:0:1',101,NULL,NULL,'e7d1ba7a256d4867b636fc6db66b9f50',1),(102,'2026-09-13 01:23:59','2026-09-13 01:49:45',NULL,1,'0:0:0:0:0:0:0:1',102,NULL,NULL,'16dd9044ac584a579f23655937bc6c0e',1),(150,'2026-09-13 03:15:43','2026-09-14 10:04:35',NULL,1,'0:0:0:0:0:0:0:1',250,NULL,NULL,'d10c74a8bb524d62a00b72d4c6ebd35c',1),(200,'2026-09-13 12:29:20','2026-09-13 12:32:05',NULL,50,'0:0:0:0:0:0:0:1',150,NULL,NULL,'c3d345341c3d4d49b6399eafdc150ac3',1),(250,'2026-09-13 13:49:05','2026-09-13 13:49:42',NULL,50,'0:0:0:0:0:0:0:1',200,NULL,NULL,'50abc5c941a64976be0817abd2addb3b',1),(300,'2026-09-14 10:06:02','2026-09-14 10:06:47',NULL,NULL,'0:0:0:0:0:0:0:1',251,NULL,NULL,'3ace8d8aad74453a83d7cdd6253ee840',1),(350,'2026-09-14 14:12:07','2026-09-15 00:10:39',NULL,1,'0:0:0:0:0:0:0:1',NULL,NULL,NULL,'4cacc3e3c01b4052a5061790e09c4d99',1),(400,'2026-09-16 08:51:32','2026-09-16 10:27:20',NULL,50,'0:0:0:0:0:0:0:1',350,NULL,NULL,'86aad2108fcc4be596971ce5c307f7d2',1),(401,'2026-09-16 08:56:34','2026-09-16 08:57:13',NULL,151,'0:0:0:0:0:0:0:1',301,NULL,NULL,'6813ef00e9014f4c8eb7d20b8ffbd3ae',1),(500,'2026-09-17 01:27:25','2026-09-17 14:42:41',NULL,50,'0:0:0:0:0:0:0:1',400,NULL,NULL,'c1fc6b51a574410a8be5c6984328f669',1),(501,'2026-09-17 01:27:25','2026-09-17 01:27:25',NULL,NULL,'0:0:0:0:0:0:0:1',NULL,NULL,NULL,'958b68da4bf34f51b2aa6a6ace5f8d80',1),(550,'2026-09-17 15:07:36','2026-09-17 23:38:56',NULL,50,'0:0:0:0:0:0:0:1',450,NULL,NULL,'fbe03e5558d54f50bcfc56c88b6a5316',1),(600,'2026-09-18 00:13:56','2026-09-18 00:14:33',NULL,50,'0:0:0:0:0:0:0:1',500,NULL,NULL,'9431856e46c5408c9a24bfe25585bf15',1),(650,'2026-09-18 00:32:23','2026-09-18 00:45:44',NULL,50,'0:0:0:0:0:0:0:1',550,NULL,NULL,'23e4874019834366ac2532fd920da816',1),(700,'2026-09-18 01:32:14','2026-09-18 01:32:39',NULL,50,'0:0:0:0:0:0:0:1',600,NULL,NULL,'4d533d4a34cf438ea8ecbfb4337b669a',1),(701,'2026-09-18 01:35:33','2026-09-18 01:36:17',NULL,50,'0:0:0:0:0:0:0:1',601,NULL,NULL,'03313fcfd54746f2b7eb8f2f3724a733',1),(702,'2026-09-18 01:41:08','2026-09-18 01:41:37',NULL,50,'0:0:0:0:0:0:0:1',602,NULL,NULL,'f4b23809b74040e69c9b2df23a3869b0',1),(703,'2026-09-18 01:42:00','2026-09-18 01:42:22',NULL,50,'0:0:0:0:0:0:0:1',603,NULL,NULL,'e6443cf8b41a44048f6fc63899ad23ba',1),(750,'2026-09-18 01:45:28','2026-09-18 01:45:58',NULL,50,'0:0:0:0:0:0:0:1',650,NULL,NULL,'68f6851fc490443bb60e4a51c563f896',1),(751,'2026-09-18 01:51:11','2026-09-18 01:51:44',NULL,50,'0:0:0:0:0:0:0:1',651,NULL,NULL,'ff9c25e9791048079b8354aeddb01a87',1),(800,'2026-09-18 02:19:36','2026-09-18 02:20:35',NULL,50,'0:0:0:0:0:0:0:1',700,NULL,NULL,'d8e6645fde8e4505b5572360f1f20c6b',1),(850,'2026-09-18 02:53:20','2026-09-18 02:53:49',NULL,50,'0:0:0:0:0:0:0:1',750,NULL,NULL,'18a5b8c1e5a74e8b9b552aa9275ddadf',1),(851,'2026-09-18 02:55:37','2026-09-18 02:55:45',NULL,50,'0:0:0:0:0:0:0:1',751,NULL,NULL,'35ffff66da0b4c058b514c5f275e783f',1),(852,'2026-09-18 02:56:13','2026-09-18 03:08:43',NULL,50,'0:0:0:0:0:0:0:1',800,NULL,NULL,'4d2bdd7b7b0c4f639738ed9abc8f59f2',1),(900,'2026-09-18 03:22:10','2026-09-18 06:17:03',NULL,50,'0:0:0:0:0:0:0:1',850,NULL,NULL,'e1328b9af04446d5834f6664fe8ddcda',1),(950,'2026-09-18 06:19:21','2026-09-18 06:36:17',NULL,50,'0:0:0:0:0:0:0:1',900,NULL,NULL,'e340b1371c4a4b7986cea245d7c50cca',1),(1000,'2026-09-18 06:45:20','2026-09-18 06:59:25',NULL,50,'0:0:0:0:0:0:0:1',950,NULL,NULL,'f4191d4379ae4062a8f644d226c132e9',1),(1050,'2026-09-18 07:02:42','2026-09-18 07:16:32',NULL,50,'0:0:0:0:0:0:0:1',951,NULL,NULL,'7e88590a20b54546b54f0fdbe3a0cdca',1),(1052,'2026-09-18 07:17:06','2026-09-18 07:17:17',NULL,50,'0:0:0:0:0:0:0:1',952,NULL,NULL,'6f3ed08b6f5a43138bf54857de9c34e8',1),(1053,'2026-09-18 07:18:20','2026-09-18 08:21:13',NULL,50,'0:0:0:0:0:0:0:1',NULL,NULL,NULL,'13cdf85236c3469fa99f4ec04e5d3c3b',1),(1101,'2026-09-18 07:36:07','2026-09-18 08:06:42',NULL,200,'0:0:0:0:0:0:0:1',1000,NULL,NULL,'4d331374cdd145479d2283ed297c0fce',1);
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
INSERT INTO `SHOPPING_CART_ITEM` VALUES (1,'2026-09-12 07:48:06','2026-09-12 07:48:06',NULL,1,1,1),(2,'2026-09-12 08:17:38','2026-09-12 08:17:38',NULL,1,1,2),(3,'2026-09-12 08:21:46','2026-09-12 08:21:46',NULL,1,1,3),(4,'2026-09-12 08:22:08','2026-09-12 08:22:08',NULL,1,1,4),(5,'2026-09-12 08:28:08','2026-09-12 08:28:19',NULL,1,10,5),(50,'2026-09-12 08:34:40','2026-09-12 08:34:41',NULL,1,2,50),(100,'2026-09-13 01:13:25','2026-09-13 01:16:38',NULL,1,2,100),(101,'2026-09-13 01:17:48','2026-09-13 01:17:48',NULL,1,1,101),(102,'2026-09-13 01:23:59','2026-09-13 01:24:01',NULL,1,2,102),(150,'2026-09-13 03:15:44','2026-09-14 10:03:36',NULL,1,2,150),(200,'2026-09-13 12:29:20','2026-09-13 12:29:20',NULL,1,1,200),(250,'2026-09-13 13:49:05','2026-09-13 13:49:05',NULL,1,1,250),(300,'2026-09-14 10:06:02','2026-09-14 10:06:02',NULL,1,1,300),(350,'2026-09-14 14:12:08','2026-09-16 08:51:10',NULL,1,3,350),(400,'2026-09-16 08:51:32','2026-09-16 10:27:19',NULL,1,1,400),(401,'2026-09-16 08:56:34','2026-09-16 08:56:34',NULL,1,1,401),(500,'2026-09-16 10:26:45','2026-09-16 10:26:45',NULL,1,1,400),(550,'2026-09-17 01:27:25','2026-09-17 09:19:32',NULL,1,2,500),(551,'2026-09-17 01:27:25','2026-09-17 01:27:25',NULL,1,1,501),(600,'2026-09-17 15:07:36','2026-09-17 15:07:36',NULL,1,1,550),(650,'2026-09-18 00:13:57','2026-09-18 00:13:57',NULL,1,1,600),(700,'2026-09-18 00:32:23','2026-09-18 00:32:23',NULL,1,1,650),(750,'2026-09-18 01:32:14','2026-09-18 01:32:14',NULL,1,1,700),(751,'2026-09-18 01:35:33','2026-09-18 01:35:33',NULL,1,1,701),(752,'2026-09-18 01:41:08','2026-09-18 01:41:08',NULL,1,1,702),(753,'2026-09-18 01:42:01','2026-09-18 01:42:01',NULL,1,1,703),(800,'2026-09-18 01:45:28','2026-09-18 01:45:28',NULL,1,1,750),(801,'2026-09-18 01:51:11','2026-09-18 01:51:11',NULL,1,1,751),(850,'2026-09-18 02:19:36','2026-09-18 02:19:36',NULL,1,1,800),(900,'2026-09-18 02:53:21','2026-09-18 02:53:21',NULL,1,1,850),(901,'2026-09-18 02:55:37','2026-09-18 02:55:37',NULL,1,1,851),(902,'2026-09-18 02:56:13','2026-09-18 02:56:13',NULL,1,1,852),(950,'2026-09-18 03:22:10','2026-09-18 03:22:10',NULL,1,1,900),(1000,'2026-09-18 06:19:21','2026-09-18 06:19:21',NULL,1,1,950),(1050,'2026-09-18 06:45:20','2026-09-18 06:45:27',NULL,1,2,1000),(1100,'2026-09-18 07:02:42','2026-09-18 07:31:20',NULL,1,1,1050),(1102,'2026-09-18 07:16:26','2026-09-18 07:16:26',NULL,1,1,1050),(1103,'2026-09-18 07:17:06','2026-09-18 07:17:06',NULL,1,1,1052),(1151,'2026-09-18 07:31:38','2026-09-18 15:04:54',NULL,1,1,1053),(1152,'2026-09-18 07:36:07','2026-09-18 07:36:07',NULL,1,1,1101);
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
INSERT INTO `SM_GROUP` VALUES (1,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,'SUPERADMIN','ADMIN'),(2,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,'ADMIN','ADMIN'),(3,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,'ADMIN_RETAILER','ADMIN'),(4,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,'ADMIN_STORE','ADMIN'),(5,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,'ADMIN_CATALOGUE','ADMIN'),(6,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,'ADMIN_ORDER','ADMIN'),(7,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,'ADMIN_CONTENT','ADMIN'),(8,'2026-09-12 03:17:04','2026-09-12 03:17:04',NULL,'CUSTOMER','CUSTOMER');
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
INSERT INTO `SM_SEQUENCER` VALUES ('category_description_seq',23),('CATEGORY_SEQ_NEXT_VAL',3),('content_description_seq',20),('CONTENT_SEQ_NEXT_VAL',5),('country_description_seq',712),('COUNTRY_SEQ_NEXT_VAL',5),('CURRENCY_SEQ_NEXT_VAL',4),('CUSTOMER_SEQ_NEXT_VAL',5),('GROUP_SEQ_NEXT_VAL',1),('LANG_SEQ_NEXT_VAL',1),('MANUFACT_SEQ_NEXT_VAL',1),('manufacturer_description_seq',2),('MERCH_CONF_SEQ_NEXT_VAL',3),('MOD_CONF_SEQ_NEXT_VAL',1),('OPTIN_SEQ_NEXT_VAL',1),('ORDER_ID_SEQ_NEXT_VAL',21),('ORDER_PRD_PRICE_ID_NEXT_VAL',21),('ORDER_PRODUCT_ID_NEXT_VALUE',21),('ORDER_TOTAL_ID_NEXT_VALUE',21),('PERMISSION_SEQ_NEXT_VAL',1),('PRD_TYPE_SEQ_NEXT_VAL',1),('PRODUCT_AVAIL_SEQ_NEXT_VAL',2),('product_description_seq',9),('product_image_description_seq',11),('PRODUCT_IMG_SEQ_NEXT_VAL',3),('PRODUCT_OPT_VAL_SEQ_NEXT_VAL',1),('product_option_description_seq',5),('PRODUCT_OPTION_SEQ_NEXT_VAL',1),('product_option_value_description_seq',5),('product_price_description_seq',9),('PRODUCT_PRICE_SEQ_NEXT_VAL',2),('PRODUCT_RELATION_SEQ_NEXT_VAL',3),('product_review_description_seq',2),('PRODUCT_REVIEW_SEQ_NEXT_VAL',1),('PRODUCT_SEQ_NEXT_VAL',2),('SHIP_QUOTE_ID_NEXT_VALUE',26),('SHP_CRT_ITM_SEQ_NEXT_VAL',25),('SHP_CRT_SEQ_NEXT_VAL',24),('SHP_ORIG_SEQ_NEXT_VAL',1),('STATUS_HIST_ID_NEXT_VALUE',21),('STORE_SEQ_NEXT_VAL',2),('TRANSACT_SEQ_NEXT_VAL',21),('TX_CLASS_SEQ_NEXT_VAL',1),('USER_SEQ_NEXT_VAL',1),('zone_description_seq',739),('ZONE_SEQ_NEXT_VAL',5);
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
INSERT INTO `SM_TRANSACTION` VALUES (1,200000.00,'2026-09-12 07:53:25','2026-09-12 07:53:25',NULL,NULL,'MONEYORDER','2026-09-12 07:53:25','AUTHORIZECAPTURE',1),(2,200140.00,'2026-09-12 08:18:02','2026-09-12 08:18:02',NULL,NULL,'MONEYORDER','2026-09-12 08:18:02','AUTHORIZECAPTURE',2),(3,200140.00,'2026-09-12 08:21:55','2026-09-12 08:21:55',NULL,NULL,'MONEYORDER','2026-09-12 08:21:55','AUTHORIZECAPTURE',3),(4,200140.00,'2026-09-12 08:22:24','2026-09-12 08:22:24',NULL,NULL,'MONEYORDER','2026-09-12 08:22:24','AUTHORIZECAPTURE',4),(5,2000140.00,'2026-09-12 08:28:28','2026-09-12 08:28:28',NULL,NULL,'MONEYORDER','2026-09-12 08:28:28','AUTHORIZECAPTURE',5),(50,400140.00,'2026-09-12 08:34:55','2026-09-12 08:34:55',NULL,NULL,'MONEYORDER','2026-09-12 08:34:55','AUTHORIZECAPTURE',50),(100,400140.00,'2026-09-13 01:17:05','2026-09-13 01:17:06',NULL,NULL,'MONEYORDER','2026-09-13 01:17:05','AUTHORIZECAPTURE',100),(101,200140.00,'2026-09-13 01:18:30','2026-09-13 01:18:30',NULL,NULL,'MONEYORDER','2026-09-13 01:18:30','AUTHORIZECAPTURE',101),(102,400140.00,'2026-09-13 01:49:45','2026-09-13 01:49:45',NULL,NULL,'MONEYORDER','2026-09-13 01:49:45','AUTHORIZECAPTURE',102),(150,200140.00,'2026-09-13 12:32:05','2026-09-13 12:32:05',NULL,NULL,'MONEYORDER','2026-09-13 12:32:05','AUTHORIZECAPTURE',150),(200,200140.00,'2026-09-13 13:49:41','2026-09-13 13:49:41',NULL,NULL,'MONEYORDER','2026-09-13 13:49:41','AUTHORIZECAPTURE',200),(250,400000.00,'2026-09-14 10:04:35','2026-09-14 10:04:35',NULL,NULL,'MONEYORDER','2026-09-14 10:04:35','AUTHORIZECAPTURE',250),(251,200140.00,'2026-09-14 10:06:47','2026-09-14 10:06:47',NULL,NULL,'MONEYORDER','2026-09-14 10:06:47','AUTHORIZECAPTURE',251),(300,200140.00,'2026-09-16 08:52:32','2026-09-16 08:52:32',NULL,NULL,'MONEYORDER','2026-09-16 08:52:32','AUTHORIZECAPTURE',300),(301,200140.00,'2026-09-16 08:57:13','2026-09-16 08:57:13',NULL,NULL,'MONEYORDER','2026-09-16 08:57:13','AUTHORIZECAPTURE',301),(350,400140.00,'2026-09-16 10:27:20','2026-09-16 10:27:20',NULL,NULL,'MONEYORDER','2026-09-16 10:27:20','AUTHORIZECAPTURE',350),(400,400140.00,'2026-09-17 14:42:41','2026-09-17 14:42:41',NULL,NULL,'MONEYORDER','2026-09-17 14:42:41','AUTHORIZECAPTURE',400),(450,200140.00,'2026-09-17 23:38:55','2026-09-17 23:38:55',NULL,NULL,'MONEYORDER','2026-09-17 23:38:55','AUTHORIZECAPTURE',450),(500,200140.00,'2026-09-18 00:14:33','2026-09-18 00:14:33',NULL,NULL,'MONEYORDER','2026-09-18 00:14:33','AUTHORIZECAPTURE',500),(550,200140.00,'2026-09-18 00:45:43','2026-09-18 00:45:43',NULL,NULL,'MONEYORDER','2026-09-18 00:45:43','AUTHORIZECAPTURE',550),(600,200140.00,'2026-09-18 01:32:38','2026-09-18 01:32:39',NULL,NULL,'MONEYORDER','2026-09-18 01:32:38','AUTHORIZECAPTURE',600),(601,200140.00,'2026-09-18 01:36:16','2026-09-18 01:36:16',NULL,NULL,'MONEYORDER','2026-09-18 01:36:16','AUTHORIZECAPTURE',601),(602,200140.00,'2026-09-18 01:41:36','2026-09-18 01:41:37',NULL,NULL,'MONEYORDER','2026-09-18 01:41:36','AUTHORIZECAPTURE',602),(603,200140.00,'2026-09-18 01:42:22','2026-09-18 01:42:22',NULL,NULL,'MONEYORDER','2026-09-18 01:42:22','AUTHORIZECAPTURE',603),(650,200140.00,'2026-09-18 01:45:58','2026-09-18 01:45:58',NULL,NULL,'MONEYORDER','2026-09-18 01:45:58','AUTHORIZECAPTURE',650),(651,200140.00,'2026-09-18 01:51:44','2026-09-18 01:51:44',NULL,NULL,'MONEYORDER','2026-09-18 01:51:44','AUTHORIZECAPTURE',651),(700,200140.00,'2026-09-18 02:20:35','2026-09-18 02:20:35',NULL,NULL,'MONEYORDER','2026-09-18 02:20:35','AUTHORIZECAPTURE',700),(750,200140.00,'2026-09-18 02:53:49','2026-09-18 02:53:49',NULL,NULL,'MONEYORDER','2026-09-18 02:53:49','AUTHORIZECAPTURE',750),(751,200140.00,'2026-09-18 02:55:45','2026-09-18 02:55:45',NULL,NULL,'MONEYORDER','2026-09-18 02:55:45','AUTHORIZECAPTURE',751),(800,200140.00,'2026-09-18 03:08:43','2026-09-18 03:08:43',NULL,NULL,'MONEYORDER','2026-09-18 03:08:43','AUTHORIZECAPTURE',800),(850,200140.00,'2026-09-18 06:17:03','2026-09-18 06:17:03',NULL,NULL,'MONEYORDER','2026-09-18 06:17:03','AUTHORIZECAPTURE',850),(900,200140.00,'2026-09-18 06:36:17','2026-09-18 06:36:17',NULL,NULL,'MONEYORDER','2026-09-18 06:36:17','AUTHORIZECAPTURE',900),(950,400140.00,'2026-09-18 06:59:25','2026-09-18 06:59:25',NULL,NULL,'MONEYORDER','2026-09-18 06:59:25','AUTHORIZECAPTURE',950),(951,400140.00,'2026-09-18 07:16:32','2026-09-18 07:16:32',NULL,NULL,'MONEYORDER','2026-09-18 07:16:32','AUTHORIZECAPTURE',951),(952,200140.00,'2026-09-18 07:17:16','2026-09-18 07:17:16',NULL,NULL,'MONEYORDER','2026-09-18 07:17:16','AUTHORIZECAPTURE',952),(1000,200140.00,'2026-09-18 08:06:41','2026-09-18 08:06:42',NULL,NULL,'MONEYORDER','2026-09-18 08:06:41','AUTHORIZECAPTURE',1000);
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
INSERT INTO `USERS` VALUES (1,_binary '','anlacduyen01@gmail.com','admin@shopizer.com','$2a$10$CSVh6iOJpe7IpXF6eRLNYOLdWI13wUYKerMngEGbxIDB2JcMXXcNW',NULL,NULL,NULL,'2026-09-12 03:18:04','2026-09-19 14:55:21',NULL,NULL,NULL,'Administrator','2026-09-18 15:03:57','User','2026-09-19 14:55:21',NULL,NULL,NULL,NULL,1);
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
INSERT INTO `USER_GROUP` VALUES (1,1),(1,2);
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
INSERT INTO `ZONE` VALUES (1,'Guipuzcoa',197),(2,'01',230),(3,'PR',224),(4,'04',230),(5,'05',230),(6,'Zamora',197),(7,'06',230),(8,'07',230),(9,'09',230),(10,'Lleida',197),(11,'QC',37),(12,'ACorua',197),(13,'Castellon',197),(14,'LasPalmas',197),(15,'AA',224),(16,'AB',37),(17,'AC',224),(18,'13',230),(19,'AE',224),(20,'AF',224),(21,'AG',204),(22,'18',230),(23,'AI',204),(24,'AK',224),(25,'Caceres',197),(26,'Segovia',197),(27,'AL',224),(28,'AM',224),(29,'Malaga',197),(30,'CEN',166),(31,'AP',224),(32,'Melilla',197),(33,'AR',224),(34,'AS',224),(35,'RI',224),(36,'AZ',224),(37,'Ceuta',197),(38,'21',230),(39,'22',230),(40,'BC',37),(41,'23',230),(42,'24',230),(43,'BE',204),(44,'26',230),(45,'29',230),(46,'ARCH',204),(47,'BL',204),(48,'SA',13),(49,'SB',14),(50,'SC',224),(51,'THE',78),(52,'SD',224),(53,'BS',204),(54,'Cordoba',197),(55,'Tarragona',197),(56,'Valladolid',197),(57,'SG',204),(58,'SH',204),(59,'WAAU',13),(60,'SK',37),(61,'SO',204),(62,'30',230),(63,'CA',224),(64,'NTAU',13),(65,'33',230),(66,'ST',14),(67,'35',230),(68,'Jaen',197),(69,'ASU',166),(70,'37',230),(71,'CiudadReal',197),(72,'39',230),(73,'SZ',204),(74,'CO',224),(75,'BER',78),(76,'CT',224),(77,'ACT',13),(78,'TG',204),(79,'HAM',78),(80,'TI',204),(81,'Lugo',197),(82,'NECH',204),(83,'TN',224),(84,'DC',224),(85,'Palencia',197),(86,'DE',224),(87,'46',230),(88,'TX',224),(89,'49',230),(90,'Burgos',197),(91,'Cadiz',197),(92,'DN',230),(93,'Guadalajara',197),(94,'UR',204),(95,'UT',224),(96,'56',230),(97,'59',230),(98,'Barcelona',197),(99,'VA',224),(100,'VB',14),(101,'Cuenca',197),(102,'WIAT',14),(103,'VD',204),(104,'VI',224),(105,'Zaragoza',197),(106,'VS',204),(107,'VT',224),(108,'68',230),(109,'FL',224),(110,'FM',224),(111,'WA',224),(112,'Granada',197),(113,'FR',204),(114,'RHE',78),(115,'Ourense',197),(116,'WI',224),(117,'GA',224),(118,'Murcia',197),(119,'71',230),(120,'GE',204),(121,'WV',224),(122,'WY',224),(123,'Avila',197),(124,'GL',204),(125,'GR',204),(126,'GU',224),(127,'HES',78),(128,'HI',224),(129,'89',230),(130,'HN',230),(131,'Vizcaya',197),(132,'HP',230),(133,'OTR',166),(134,'Albacete',197),(135,'NRW',78),(136,'IA',224),(137,'ID',224),(138,'YT',37),(139,'Leon',197),(140,'Pontevedra',197),(141,'Teruel',197),(142,'IL',224),(143,'IN',224),(144,'A Corua',197),(145,'ZG',204),(146,'ZH',204),(147,'LaRioja',197),(148,'NSW',13),(149,'Madrid',197),(150,'Huelva',197),(151,'Huesca',197),(152,'JU',204),(153,'Asturias',197),(154,'TIAT',14),(155,'NDS',78),(156,'KN',14),(157,'Alava',197),(158,'KS',224),(159,'KY',224),(160,'LA',224),(161,'Toledo',197),(162,'TAS',13),(163,'QLD',13),(164,'LU',204),(165,'SantaCruzdeTenerife',197),(166,'MA',224),(167,'MB',37),(168,'MD',224),(169,'Girona',197),(170,'ME',224),(171,'Alicante',197),(172,'Cantabria',197),(173,'MH',224),(174,'MI',224),(175,'MN',224),(176,'MO',224),(177,'MP',224),(178,'MS',224),(179,'MT',224),(180,'Badajoz',197),(181,'MEC',78),(182,'Sevilla',197),(183,'NB',37),(184,'SAC',78),(185,'NC',224),(186,'ND',224),(187,'NE',224),(188,'NF',37),(189,'NH',224),(190,'NJ',224),(191,'NM',224),(192,'NO',14),(193,'SAS',78),(194,'NS',37),(195,'SAR',78),(196,'NT',37),(197,'NU',37),(198,'NV',224),(199,'NW',204),(200,'NY',224),(201,'Soria',197),(202,'OH',224),(203,'OK',224),(204,'ON',37),(205,'OO',14),(206,'BLAT',14),(207,'OR',224),(208,'Salamanca',197),(209,'Baleares',197),(210,'OW',204),(211,'PA',224),(212,'VIC',13),(213,'BRE',78),(214,'PE',37),(215,'BRG',78),(216,'Almeria',197),(217,'BAW',78),(218,'BAY',78),(219,'Navarra',197),(220,'Valencia',197),(221,'SCN',78),(222,'AndhraPradesh',97),(223,'ArunachalPradesh',97),(224,'Assam',97),(225,'Bihar',97),(226,'Chhattisgarh',97),(227,'Goa',97),(228,'Gujarat',97),(229,'Haryana',97),(230,'HimachalPradesh',97),(231,'Jharkhand',97),(232,'Karnataka',97),(233,'Kerala',97),(234,'MadhyaPradesh',97),(235,'Maharashtra',97),(236,'Manipur',97),(237,'Meghalaya',97),(238,'Mizoram',97),(239,'Nagaland',97),(240,'Odisha',97),(241,'Punjab',97),(242,'Rajasthan',97),(243,'Sikkim',97),(244,'TamilNadu',97),(245,'Telangana',97),(246,'Tripura',97),(247,'Uttarakhand',97),(248,'WestBengal',97);
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
INSERT INTO `ZONE_DESCRIPTION` VALUES (1,'2026-09-12 03:17:31','2026-09-12 03:17:31',NULL,NULL,'Guipuzcoa',NULL,1,1),(2,'2026-09-12 03:17:32','2026-09-12 03:17:32',NULL,NULL,'Guipuzcoa',NULL,2,1),(3,'2026-09-12 03:17:32','2026-09-12 03:17:32',NULL,NULL,'Guipuzcoa',NULL,3,1),(4,'2026-09-12 03:17:32','2026-09-12 03:17:32',NULL,NULL,'Lai Châu',NULL,1,2),(5,'2026-09-12 03:17:32','2026-09-12 03:17:32',NULL,NULL,'Lai Châu',NULL,2,2),(6,'2026-09-12 03:17:32','2026-09-12 03:17:32',NULL,NULL,'Lai Châu',NULL,3,2),(7,'2026-09-12 03:17:32','2026-09-12 03:17:32',NULL,NULL,'Puerto Rico',NULL,1,3),(8,'2026-09-12 03:17:32','2026-09-12 03:17:32',NULL,NULL,'Puerto Rico',NULL,2,3),(9,'2026-09-12 03:17:32','2026-09-12 03:17:32',NULL,NULL,'Puerto Rico',NULL,3,3),(10,'2026-09-12 03:17:32','2026-09-12 03:17:32',NULL,NULL,'Cao Bằng',NULL,1,4),(11,'2026-09-12 03:17:32','2026-09-12 03:17:32',NULL,NULL,'Cao Bằng',NULL,2,4),(12,'2026-09-12 03:17:32','2026-09-12 03:17:32',NULL,NULL,'Cao Bằng',NULL,3,4),(13,'2026-09-12 03:17:32','2026-09-12 03:17:32',NULL,NULL,'Sơn La',NULL,1,5),(14,'2026-09-12 03:17:32','2026-09-12 03:17:32',NULL,NULL,'Sơn La',NULL,2,5),(15,'2026-09-12 03:17:32','2026-09-12 03:17:32',NULL,NULL,'Sơn La',NULL,3,5),(16,'2026-09-12 03:17:32','2026-09-12 03:17:32',NULL,NULL,'Zamora',NULL,1,6),(17,'2026-09-12 03:17:32','2026-09-12 03:17:32',NULL,NULL,'Zamora',NULL,2,6),(18,'2026-09-12 03:17:32','2026-09-12 03:17:32',NULL,NULL,'Zamora',NULL,3,6),(19,'2026-09-12 03:17:32','2026-09-12 03:17:32',NULL,NULL,'Yên Bái',NULL,1,7),(20,'2026-09-12 03:17:32','2026-09-12 03:17:32',NULL,NULL,'Yên Bái',NULL,2,7),(21,'2026-09-12 03:17:32','2026-09-12 03:17:32',NULL,NULL,'Yên Bái',NULL,3,7),(22,'2026-09-12 03:17:32','2026-09-12 03:17:32',NULL,NULL,'Tuyên Quang',NULL,1,8),(23,'2026-09-12 03:17:33','2026-09-12 03:17:33',NULL,NULL,'Tuyên Quang',NULL,2,8),(24,'2026-09-12 03:17:33','2026-09-12 03:17:33',NULL,NULL,'Tuyên Quang',NULL,3,8),(25,'2026-09-12 03:17:33','2026-09-12 03:17:33',NULL,NULL,'Lạng Sơn',NULL,1,9),(26,'2026-09-12 03:17:33','2026-09-12 03:17:33',NULL,NULL,'Lạng Sơn',NULL,2,9),(27,'2026-09-12 03:17:33','2026-09-12 03:17:33',NULL,NULL,'Lạng Sơn',NULL,3,9),(28,'2026-09-12 03:17:33','2026-09-12 03:17:33',NULL,NULL,'Lleida',NULL,1,10),(29,'2026-09-12 03:17:33','2026-09-12 03:17:33',NULL,NULL,'Lleida',NULL,2,10),(30,'2026-09-12 03:17:33','2026-09-12 03:17:33',NULL,NULL,'Lleida',NULL,3,10),(31,'2026-09-12 03:17:33','2026-09-12 03:17:33',NULL,NULL,'Quebec',NULL,1,11),(32,'2026-09-12 03:17:33','2026-09-12 03:17:33',NULL,NULL,'Québec',NULL,2,11),(33,'2026-09-12 03:17:33','2026-09-12 03:17:33',NULL,NULL,'Quebec',NULL,3,11),(34,'2026-09-12 03:17:33','2026-09-12 03:17:33',NULL,NULL,'A Corua',NULL,1,12),(35,'2026-09-12 03:17:33','2026-09-12 03:17:33',NULL,NULL,'A Corua',NULL,3,12),(36,'2026-09-12 03:17:33','2026-09-12 03:17:33',NULL,NULL,'Castellon',NULL,1,13),(37,'2026-09-12 03:17:33','2026-09-12 03:17:33',NULL,NULL,'Castellon',NULL,2,13),(38,'2026-09-12 03:17:33','2026-09-12 03:17:33',NULL,NULL,'Castellon',NULL,3,13),(39,'2026-09-12 03:17:33','2026-09-12 03:17:33',NULL,NULL,'Las Palmas',NULL,1,14),(40,'2026-09-12 03:17:33','2026-09-12 03:17:33',NULL,NULL,'Las Palmas',NULL,2,14),(41,'2026-09-12 03:17:33','2026-09-12 03:17:33',NULL,NULL,'Las Palmas',NULL,3,14),(42,'2026-09-12 03:17:33','2026-09-12 03:17:33',NULL,NULL,'Armed Forces Americas',NULL,1,15),(43,'2026-09-12 03:17:33','2026-09-12 03:17:33',NULL,NULL,'Armed Forces Americas',NULL,2,15),(44,'2026-09-12 03:17:34','2026-09-12 03:17:34',NULL,NULL,'Armed Forces Americas',NULL,3,15),(45,'2026-09-12 03:17:34','2026-09-12 03:17:34',NULL,NULL,'Alberta',NULL,1,16),(46,'2026-09-12 03:17:34','2026-09-12 03:17:34',NULL,NULL,'Alberta',NULL,2,16),(47,'2026-09-12 03:17:34','2026-09-12 03:17:34',NULL,NULL,'Alberta',NULL,3,16),(48,'2026-09-12 03:17:34','2026-09-12 03:17:34',NULL,NULL,'Armed Forces Canada',NULL,1,17),(49,'2026-09-12 03:17:34','2026-09-12 03:17:34',NULL,NULL,'Armed Forces Canada',NULL,2,17),(50,'2026-09-12 03:17:34','2026-09-12 03:17:34',NULL,NULL,'Armed Forces Canada',NULL,3,17),(51,'2026-09-12 03:17:34','2026-09-12 03:17:34',NULL,NULL,'Quảng Ninh',NULL,1,18),(52,'2026-09-12 03:17:34','2026-09-12 03:17:34',NULL,NULL,'Quảng Ninh',NULL,2,18),(53,'2026-09-12 03:17:34','2026-09-12 03:17:34',NULL,NULL,'Quảng Ninh',NULL,3,18),(54,'2026-09-12 03:17:34','2026-09-12 03:17:34',NULL,NULL,'Armed Forces Europe',NULL,1,19),(55,'2026-09-12 03:17:34','2026-09-12 03:17:34',NULL,NULL,'Armed Forces Europe',NULL,2,19),(56,'2026-09-12 03:17:34','2026-09-12 03:17:34',NULL,NULL,'Armed Forces Europe',NULL,3,19),(57,'2026-09-12 03:17:34','2026-09-12 03:17:34',NULL,NULL,'Armed Forces Africa',NULL,1,20),(58,'2026-09-12 03:17:34','2026-09-12 03:17:34',NULL,NULL,'Armed Forces Africa',NULL,2,20),(59,'2026-09-12 03:17:34','2026-09-12 03:17:34',NULL,NULL,'Armed Forces Africa',NULL,3,20),(60,'2026-09-12 03:17:35','2026-09-12 03:17:35',NULL,NULL,'Aargau',NULL,1,21),(61,'2026-09-12 03:17:35','2026-09-12 03:17:35',NULL,NULL,'Aargau',NULL,2,21),(62,'2026-09-12 03:17:35','2026-09-12 03:17:35',NULL,NULL,'Aargau',NULL,3,21),(63,'2026-09-12 03:17:35','2026-09-12 03:17:35',NULL,NULL,'Ninh Bình',NULL,1,22),(64,'2026-09-12 03:17:35','2026-09-12 03:17:35',NULL,NULL,'Ninh Bình',NULL,2,22),(65,'2026-09-12 03:17:35','2026-09-12 03:17:35',NULL,NULL,'Ninh Bình',NULL,3,22),(66,'2026-09-12 03:17:35','2026-09-12 03:17:35',NULL,NULL,'Appenzell Innerrhoden',NULL,1,23),(67,'2026-09-12 03:17:35','2026-09-12 03:17:35',NULL,NULL,'Appenzell Innerrhoden',NULL,2,23),(68,'2026-09-12 03:17:35','2026-09-12 03:17:35',NULL,NULL,'Appenzell Innerrhoden',NULL,3,23),(69,'2026-09-12 03:17:35','2026-09-12 03:17:35',NULL,NULL,'Alaska',NULL,1,24),(70,'2026-09-12 03:17:35','2026-09-12 03:17:35',NULL,NULL,'Alaska',NULL,2,24),(71,'2026-09-12 03:17:35','2026-09-12 03:17:35',NULL,NULL,'Alaska',NULL,3,24),(72,'2026-09-12 03:17:35','2026-09-12 03:17:35',NULL,NULL,'Caceres',NULL,1,25),(73,'2026-09-12 03:17:35','2026-09-12 03:17:35',NULL,NULL,'Caceres',NULL,2,25),(74,'2026-09-12 03:17:35','2026-09-12 03:17:35',NULL,NULL,'Caceres',NULL,3,25),(75,'2026-09-12 03:17:35','2026-09-12 03:17:35',NULL,NULL,'Segovia',NULL,1,26),(76,'2026-09-12 03:17:35','2026-09-12 03:17:35',NULL,NULL,'Segovia',NULL,2,26),(77,'2026-09-12 03:17:35','2026-09-12 03:17:35',NULL,NULL,'Segovia',NULL,3,26),(78,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'Alabama',NULL,1,27),(79,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'Alabama',NULL,2,27),(80,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'Alabama',NULL,3,27),(81,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'Armed Forces Middle East',NULL,1,28),(82,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'Armed Forces Middle East',NULL,2,28),(83,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'Armed Forces Middle East',NULL,3,28),(84,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'Malaga',NULL,1,29),(85,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'Malaga',NULL,2,29),(86,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'Malaga',NULL,3,29),(87,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'Central',NULL,1,30),(88,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'Central',NULL,3,30),(89,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'Armed Forces Pacific',NULL,1,31),(90,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'Armed Forces Pacific',NULL,2,31),(91,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'Armed Forces Pacific',NULL,3,31),(92,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'Melilla',NULL,1,32),(93,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'Melilla',NULL,2,32),(94,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'Melilla',NULL,3,32),(95,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'Arkansas',NULL,1,33),(96,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'Arkansas',NULL,2,33),(97,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'Arkansas',NULL,3,33),(98,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'American Samoa',NULL,1,34),(99,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'American Samoa',NULL,2,34),(100,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'American Samoa',NULL,3,34),(101,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'Rhode Island',NULL,1,35),(102,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'Rhode Island',NULL,2,35),(103,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'Rhode Island',NULL,3,35),(104,'2026-09-12 03:17:36','2026-09-12 03:17:36',NULL,NULL,'Arizona',NULL,1,36),(105,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'Arizona',NULL,2,36),(106,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'Arizona',NULL,3,36),(107,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'Ceuta',NULL,1,37),(108,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'Ceuta',NULL,2,37),(109,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'Ceuta',NULL,3,37),(110,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'Thanh Hóa',NULL,1,38),(111,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'Thanh Hóa',NULL,2,38),(112,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'Thanh Hóa',NULL,3,38),(113,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'Nghệ An',NULL,1,39),(114,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'Nghệ An',NULL,2,39),(115,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'Nghệ An',NULL,3,39),(116,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'British Columbia',NULL,1,40),(117,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'Colombie Britanique',NULL,2,40),(118,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'British Columbia',NULL,3,40),(119,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'Hà Tĩnh',NULL,1,41),(120,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'Hà Tĩnh',NULL,2,41),(121,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'Hà Tĩnh',NULL,3,41),(122,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'Quảng Bình',NULL,1,42),(123,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'Quảng Bình',NULL,2,42),(124,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'Quảng Bình',NULL,3,42),(125,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'Bern',NULL,1,43),(126,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'Bern',NULL,2,43),(127,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'Bern',NULL,3,43),(128,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'Thừa Thiên Huế',NULL,1,44),(129,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'Thừa Thiên Huế',NULL,2,44),(130,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'Thừa Thiên Huế',NULL,3,44),(131,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'Quảng Ngãi',NULL,1,45),(132,'2026-09-12 03:17:37','2026-09-12 03:17:37',NULL,NULL,'Quảng Ngãi',NULL,2,45),(133,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Quảng Ngãi',NULL,3,45),(134,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Appenzell Ausserrhoden',NULL,1,46),(135,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Appenzell Ausserrhoden',NULL,2,46),(136,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Appenzell Ausserrhoden',NULL,3,46),(137,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Basel-Landschaft',NULL,1,47),(138,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Basel-Landschaft',NULL,2,47),(139,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Basel-Landschaft',NULL,3,47),(140,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'South Australia',NULL,1,48),(141,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Australie-Mridionale',NULL,2,48),(142,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'South Australia',NULL,3,48),(143,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Salzburg',NULL,1,49),(144,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Salzburg',NULL,2,49),(145,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Salzburg',NULL,3,49),(146,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'South Carolina',NULL,1,50),(147,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Caroline du Sud',NULL,2,50),(148,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'South Carolina',NULL,3,50),(149,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Thringen',NULL,1,51),(150,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Thringen',NULL,2,51),(151,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Thringen',NULL,3,51),(152,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'South Dakota',NULL,1,52),(153,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Dakota du Sud',NULL,2,52),(154,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'South Dakota',NULL,3,52),(155,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Basel-Stadt',NULL,1,53),(156,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Basel-Stadt',NULL,2,53),(157,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Basel-Stadt',NULL,3,53),(158,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Cordoba',NULL,1,54),(159,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Cordoba',NULL,2,54),(160,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Cordoba',NULL,3,54),(161,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Tarragona',NULL,1,55),(162,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Tarragona',NULL,2,55),(163,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Tarragona',NULL,3,55),(164,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Valladolid',NULL,1,56),(165,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Valladolid',NULL,2,56),(166,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'Valladolid',NULL,3,56),(167,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'St. Gallen',NULL,1,57),(168,'2026-09-12 03:17:38','2026-09-12 03:17:38',NULL,NULL,'St. Gallen',NULL,2,57),(169,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'St. Gallen',NULL,3,57),(170,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Schaffhausen',NULL,1,58),(171,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Schaffhausen',NULL,2,58),(172,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Schaffhausen',NULL,3,58),(173,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Western Australia',NULL,1,59),(174,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Australie-Occidentale',NULL,2,59),(175,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Western Australia',NULL,3,59),(176,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Saskatchewan',NULL,1,60),(177,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Saskatchewan',NULL,2,60),(178,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Saskatchewan',NULL,3,60),(179,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Solothurn',NULL,1,61),(180,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Solothurn',NULL,2,61),(181,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Solothurn',NULL,3,61),(182,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Gia Lai',NULL,1,62),(183,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Gia Lai',NULL,2,62),(184,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Gia Lai',NULL,3,62),(185,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'California',NULL,1,63),(186,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Californie',NULL,2,63),(187,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'California',NULL,3,63),(188,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Northern Territory',NULL,1,64),(189,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Territoire du Nord',NULL,2,64),(190,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Northern Territory',NULL,3,64),(191,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Đắk lăk',NULL,1,65),(192,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Đắk lăk',NULL,2,65),(193,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Đắk lăk',NULL,3,65),(194,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Steiermark',NULL,1,66),(195,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Steiermark',NULL,2,66),(196,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Steiermark',NULL,3,66),(197,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Lâm Đồng',NULL,1,67),(198,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Lâm Đồng',NULL,2,67),(199,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Lâm Đồng',NULL,3,67),(200,'2026-09-12 03:17:39','2026-09-12 03:17:39',NULL,NULL,'Jaen',NULL,1,68),(201,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Jaen',NULL,2,68),(202,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Jaen',NULL,3,68),(203,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Asuncion',NULL,1,69),(204,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Asunción',NULL,3,69),(205,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Tây Ninh',NULL,1,70),(206,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Tây Ninh',NULL,2,70),(207,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Tây Ninh',NULL,3,70),(208,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Ciudad Real',NULL,1,71),(209,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Ciudad Real',NULL,2,71),(210,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Ciudad Real',NULL,3,71),(211,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Đồng Nai',NULL,1,72),(212,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Đồng Nai',NULL,2,72),(213,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Đồng Nai',NULL,3,72),(214,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Schwyz',NULL,1,73),(215,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Schwyz',NULL,2,73),(216,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Schwyz',NULL,3,73),(217,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Colorado',NULL,1,74),(218,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Colorado',NULL,2,74),(219,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Colorado',NULL,3,74),(220,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Berlin',NULL,1,75),(221,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Berlin',NULL,2,75),(222,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Berlin',NULL,3,75),(223,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Connecticut',NULL,1,76),(224,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Connecticut',NULL,2,76),(225,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Connecticut',NULL,3,76),(226,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Australian Capital Territory',NULL,1,77),(227,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Territoire de la capitale australienne',NULL,2,77),(228,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Australian Capital Territory',NULL,3,77),(229,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Thurgau',NULL,1,78),(230,'2026-09-12 03:17:40','2026-09-12 03:17:40',NULL,NULL,'Thurgau',NULL,2,78),(231,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Thurgau',NULL,3,78),(232,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Hamburg',NULL,1,79),(233,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Hamburg',NULL,2,79),(234,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Hamburg',NULL,3,79),(235,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Tessin',NULL,1,80),(236,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Tessin',NULL,2,80),(237,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Tessin',NULL,3,80),(238,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Lugo',NULL,1,81),(239,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Lugo',NULL,2,81),(240,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Lugo',NULL,3,81),(241,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Neuenburg',NULL,1,82),(242,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Neuenburg',NULL,2,82),(243,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Neuenburg',NULL,3,82),(244,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Tennessee',NULL,1,83),(245,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Tennessee',NULL,2,83),(246,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Tennessee',NULL,3,83),(247,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'District of Columbia',NULL,1,84),(248,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'District de Columbia',NULL,2,84),(249,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'District of Columbia',NULL,3,84),(250,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Palencia',NULL,1,85),(251,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Palencia',NULL,2,85),(252,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Palencia',NULL,3,85),(253,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Delaware',NULL,1,86),(254,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Delaware',NULL,2,86),(255,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Delaware',NULL,3,86),(256,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Tiền Giang',NULL,1,87),(257,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Tiền Giang',NULL,2,87),(258,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Tiền Giang',NULL,3,87),(259,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Texas',NULL,1,88),(260,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Texas',NULL,2,88),(261,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Texas',NULL,3,88),(262,'2026-09-12 03:17:41','2026-09-12 03:17:41',NULL,NULL,'Vĩnh Long',NULL,1,89),(263,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Vĩnh Long',NULL,2,89),(264,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Vĩnh Long',NULL,3,89),(265,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Burgos',NULL,1,90),(266,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Burgos',NULL,2,90),(267,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Burgos',NULL,3,90),(268,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Cadiz',NULL,1,91),(269,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Cadiz',NULL,2,91),(270,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Cadiz',NULL,3,91),(271,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Đà Nẵng',NULL,1,92),(272,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Đà Nẵng',NULL,2,92),(273,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Đà Nẵng',NULL,3,92),(274,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Guadalajara',NULL,1,93),(275,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Guadalajara',NULL,2,93),(276,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Guadalajara',NULL,3,93),(277,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Uri',NULL,1,94),(278,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Uri',NULL,2,94),(279,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Uri',NULL,3,94),(280,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Utah',NULL,1,95),(281,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Utah',NULL,2,95),(282,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Utah',NULL,3,95),(283,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Bắc Ninh',NULL,1,96),(284,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Bắc Ninh',NULL,2,96),(285,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Bắc Ninh',NULL,3,96),(286,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Cà Mau',NULL,1,97),(287,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Cà Mau',NULL,2,97),(288,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Cà Mau',NULL,3,97),(289,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Barcelona',NULL,1,98),(290,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Barcelona',NULL,2,98),(291,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Barcelona',NULL,3,98),(292,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Virginia',NULL,1,99),(293,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Virginie',NULL,2,99),(294,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Virginia',NULL,3,99),(295,'2026-09-12 03:17:42','2026-09-12 03:17:42',NULL,NULL,'Voralberg',NULL,1,100),(296,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Voralberg',NULL,2,100),(297,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Voralberg',NULL,3,100),(298,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Cuenca',NULL,1,101),(299,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Cuenca',NULL,2,101),(300,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Cuenca',NULL,3,101),(301,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Wien',NULL,1,102),(302,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Wien',NULL,2,102),(303,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Wien',NULL,3,102),(304,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Waadt',NULL,1,103),(305,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Waadt',NULL,2,103),(306,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Waadt',NULL,3,103),(307,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Virgin Islands',NULL,1,104),(308,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Virgin Islands',NULL,2,104),(309,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Virgin Islands',NULL,3,104),(310,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Zaragoza',NULL,1,105),(311,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Zaragoza',NULL,2,105),(312,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Zaragoza',NULL,3,105),(313,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Wallis',NULL,1,106),(314,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Wallis',NULL,2,106),(315,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Wallis',NULL,3,106),(316,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Vermont',NULL,1,107),(317,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Vermont',NULL,2,107),(318,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Vermont',NULL,3,107),(319,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Phú Thọ',NULL,1,108),(320,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Phú Thọ',NULL,2,108),(321,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Phú Thọ',NULL,3,108),(322,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Florida',NULL,1,109),(323,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Floride',NULL,2,109),(324,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Florida',NULL,3,109),(325,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Federated States Of Micronesia',NULL,1,110),(326,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Federated States Of Micronesia',NULL,2,110),(327,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Federated States Of Micronesia',NULL,3,110),(328,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Washington',NULL,1,111),(329,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Washington',NULL,2,111),(330,'2026-09-12 03:17:43','2026-09-12 03:17:43',NULL,NULL,'Washington',NULL,3,111),(331,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Granada',NULL,1,112),(332,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Granada',NULL,2,112),(333,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Granada',NULL,3,112),(334,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Freiburg',NULL,1,113),(335,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Freiburg',NULL,2,113),(336,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Freiburg',NULL,3,113),(337,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Rheinland-Pfalz',NULL,1,114),(338,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Rheinland-Pfalz',NULL,2,114),(339,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Rheinland-Pfalz',NULL,3,114),(340,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Ourense',NULL,1,115),(341,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Ourense',NULL,2,115),(342,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Ourense',NULL,3,115),(343,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Wisconsin',NULL,1,116),(344,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Wisconsin',NULL,2,116),(345,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Wisconsin',NULL,3,116),(346,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Georgia',NULL,1,117),(347,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Georgie',NULL,2,117),(348,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Georgia',NULL,3,117),(349,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Murcia',NULL,1,118),(350,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Murcia',NULL,2,118),(351,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Murcia',NULL,3,118),(352,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Điện Biên',NULL,1,119),(353,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Điện Biên',NULL,2,119),(354,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Điện Biên',NULL,3,119),(355,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Genf',NULL,1,120),(356,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Genf',NULL,2,120),(357,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Genf',NULL,3,120),(358,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'West Virginia',NULL,1,121),(359,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'West Virginia',NULL,2,121),(360,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'West Virginia',NULL,3,121),(361,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Wyoming',NULL,1,122),(362,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Wyoming',NULL,2,122),(363,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Wyoming',NULL,3,122),(364,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Avila',NULL,1,123),(365,'2026-09-12 03:17:44','2026-09-12 03:17:44',NULL,NULL,'Avila',NULL,2,123),(366,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Avila',NULL,3,123),(367,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Glarus',NULL,1,124),(368,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Glarus',NULL,2,124),(369,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Glarus',NULL,3,124),(370,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Graubnden',NULL,1,125),(371,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Graubnden',NULL,2,125),(372,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Graubnden',NULL,3,125),(373,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Guam',NULL,1,126),(374,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Guam',NULL,2,126),(375,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Guam',NULL,3,126),(376,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Hessen',NULL,1,127),(377,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Hessen',NULL,2,127),(378,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Hessen',NULL,3,127),(379,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Hawaii',NULL,1,128),(380,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Hawaii',NULL,2,128),(381,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Hawaii',NULL,3,128),(382,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'An Giang',NULL,1,129),(383,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'An Giang',NULL,2,129),(384,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'An Giang',NULL,3,129),(385,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Hà Nội',NULL,1,130),(386,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Hà Nội',NULL,2,130),(387,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Hà Nội',NULL,3,130),(388,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Vizcaya',NULL,1,131),(389,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Vizcaya',NULL,2,131),(390,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Vizcaya',NULL,3,131),(391,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Hải Phòng',NULL,1,132),(392,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Hải Phòng',NULL,2,132),(393,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Hải Phòng',NULL,3,132),(394,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Other',NULL,1,133),(395,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Otro',NULL,3,133),(396,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Albacete',NULL,1,134),(397,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Albacete',NULL,2,134),(398,'2026-09-12 03:17:45','2026-09-12 03:17:45',NULL,NULL,'Albacete',NULL,3,134),(399,'2026-09-12 03:17:46','2026-09-12 03:17:46',NULL,NULL,'Nordrhein-Westfalen',NULL,1,135),(400,'2026-09-12 03:17:46','2026-09-12 03:17:46',NULL,NULL,'Nordrhein-Westfalen',NULL,2,135),(401,'2026-09-12 03:17:46','2026-09-12 03:17:46',NULL,NULL,'Nordrhein-Westfalen',NULL,3,135),(402,'2026-09-12 03:17:46','2026-09-12 03:17:46',NULL,NULL,'Iowa',NULL,1,136),(403,'2026-09-12 03:17:46','2026-09-12 03:17:46',NULL,NULL,'Iowa',NULL,2,136),(404,'2026-09-12 03:17:46','2026-09-12 03:17:46',NULL,NULL,'Iowa',NULL,3,136),(405,'2026-09-12 03:17:46','2026-09-12 03:17:46',NULL,NULL,'Idaho',NULL,1,137),(406,'2026-09-12 03:17:46','2026-09-12 03:17:46',NULL,NULL,'Idaho',NULL,2,137),(407,'2026-09-12 03:17:46','2026-09-12 03:17:46',NULL,NULL,'Idaho',NULL,3,137),(408,'2026-09-12 03:17:46','2026-09-12 03:17:46',NULL,NULL,'Yukon Territory',NULL,1,138),(409,'2026-09-12 03:17:46','2026-09-12 03:17:46',NULL,NULL,'Yukon',NULL,2,138),(410,'2026-09-12 03:17:46','2026-09-12 03:17:46',NULL,NULL,'Yukon Territory',NULL,3,138),(411,'2026-09-12 03:17:46','2026-09-12 03:17:46',NULL,NULL,'Leon',NULL,1,139),(412,'2026-09-12 03:17:46','2026-09-12 03:17:46',NULL,NULL,'Leon',NULL,2,139),(413,'2026-09-12 03:17:46','2026-09-12 03:17:46',NULL,NULL,'Leon',NULL,3,139),(414,'2026-09-12 03:17:46','2026-09-12 03:17:46',NULL,NULL,'Pontevedra',NULL,1,140),(415,'2026-09-12 03:17:46','2026-09-12 03:17:46',NULL,NULL,'Pontevedra',NULL,2,140),(416,'2026-09-12 03:17:46','2026-09-12 03:17:46',NULL,NULL,'Pontevedra',NULL,3,140),(417,'2026-09-12 03:17:46','2026-09-12 03:17:46',NULL,NULL,'Teruel',NULL,1,141),(418,'2026-09-12 03:17:46','2026-09-12 03:17:46',NULL,NULL,'Teruel',NULL,2,141),(419,'2026-09-12 03:17:46','2026-09-12 03:17:46',NULL,NULL,'Teruel',NULL,3,141),(420,'2026-09-12 03:17:47','2026-09-12 03:17:47',NULL,NULL,'Illinois',NULL,1,142),(421,'2026-09-12 03:17:47','2026-09-12 03:17:47',NULL,NULL,'Illinois',NULL,2,142),(422,'2026-09-12 03:17:47','2026-09-12 03:17:47',NULL,NULL,'Illinois',NULL,3,142),(423,'2026-09-12 03:17:47','2026-09-12 03:17:47',NULL,NULL,'Indiana',NULL,1,143),(424,'2026-09-12 03:17:47','2026-09-12 03:17:47',NULL,NULL,'Indiana',NULL,2,143),(425,'2026-09-12 03:17:47','2026-09-12 03:17:47',NULL,NULL,'Indiana',NULL,3,143),(426,'2026-09-12 03:17:47','2026-09-12 03:17:47',NULL,NULL,'A Corua',NULL,2,144),(427,'2026-09-12 03:17:47','2026-09-12 03:17:47',NULL,NULL,'Zug',NULL,1,145),(428,'2026-09-12 03:17:47','2026-09-12 03:17:47',NULL,NULL,'Zug',NULL,2,145),(429,'2026-09-12 03:17:47','2026-09-12 03:17:47',NULL,NULL,'Zug',NULL,3,145),(430,'2026-09-12 03:17:47','2026-09-12 03:17:47',NULL,NULL,'Zrich',NULL,1,146),(431,'2026-09-12 03:17:47','2026-09-12 03:17:47',NULL,NULL,'Zrich',NULL,2,146),(432,'2026-09-12 03:17:47','2026-09-12 03:17:47',NULL,NULL,'Zrich',NULL,3,146),(433,'2026-09-12 03:17:47','2026-09-12 03:17:47',NULL,NULL,'La Rioja',NULL,1,147),(434,'2026-09-12 03:17:47','2026-09-12 03:17:47',NULL,NULL,'La Rioja',NULL,2,147),(435,'2026-09-12 03:17:47','2026-09-12 03:17:47',NULL,NULL,'La Rioja',NULL,3,147),(436,'2026-09-12 03:17:47','2026-09-12 03:17:47',NULL,NULL,'New South Wales',NULL,1,148),(437,'2026-09-12 03:17:47','2026-09-12 03:17:47',NULL,NULL,'Nouvelle-Galles du Sud',NULL,2,148),(438,'2026-09-12 03:17:47','2026-09-12 03:17:47',NULL,NULL,'New South Wales',NULL,3,148),(439,'2026-09-12 03:17:47','2026-09-12 03:17:47',NULL,NULL,'Madrid',NULL,1,149),(440,'2026-09-12 03:17:47','2026-09-12 03:17:47',NULL,NULL,'Madrid',NULL,2,149),(441,'2026-09-12 03:17:47','2026-09-12 03:17:47',NULL,NULL,'Madrid',NULL,3,149),(442,'2026-09-12 03:17:47','2026-09-12 03:17:47',NULL,NULL,'Huelva',NULL,1,150),(443,'2026-09-12 03:17:47','2026-09-12 03:17:47',NULL,NULL,'Huelva',NULL,2,150),(444,'2026-09-12 03:17:47','2026-09-12 03:17:47',NULL,NULL,'Huelva',NULL,3,150),(445,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Huesca',NULL,1,151),(446,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Huesca',NULL,2,151),(447,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Huesca',NULL,3,151),(448,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Jura',NULL,1,152),(449,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Jura',NULL,2,152),(450,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Jura',NULL,3,152),(451,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Asturias',NULL,1,153),(452,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Asturias',NULL,2,153),(453,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Asturias',NULL,3,153),(454,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Tirol',NULL,1,154),(455,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Tirol',NULL,2,154),(456,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Tirol',NULL,3,154),(457,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Niedersachsen',NULL,1,155),(458,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Niedersachsen',NULL,2,155),(459,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Niedersachsen',NULL,3,155),(460,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Katen',NULL,1,156),(461,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Karten',NULL,2,156),(462,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Katen',NULL,3,156),(463,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Alava',NULL,1,157),(464,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Alava',NULL,2,157),(465,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Alava',NULL,3,157),(466,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Kansas',NULL,1,158),(467,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Kansas',NULL,2,158),(468,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Kansas',NULL,3,158),(469,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Kentucky',NULL,1,159),(470,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Kentucky',NULL,2,159),(471,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Kentucky',NULL,3,159),(472,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Louisiana',NULL,1,160),(473,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Louisiane',NULL,2,160),(474,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Louisiana',NULL,3,160),(475,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Toledo',NULL,1,161),(476,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Toledo',NULL,2,161),(477,'2026-09-12 03:17:48','2026-09-12 03:17:48',NULL,NULL,'Toledo',NULL,3,161),(478,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Tasmania',NULL,1,162),(479,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Tasmanie',NULL,2,162),(480,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Tasmania',NULL,3,162),(481,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Queensland',NULL,1,163),(482,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Queensland',NULL,2,163),(483,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Queensland',NULL,3,163),(484,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Luzern',NULL,1,164),(485,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Luzern',NULL,2,164),(486,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Luzern',NULL,3,164),(487,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Santa Cruz de Tenerife',NULL,1,165),(488,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Santa Cruz de Tenerife',NULL,2,165),(489,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Santa Cruz de Tenerife',NULL,3,165),(490,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Massachusetts',NULL,1,166),(491,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Massachusetts',NULL,2,166),(492,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Massachusetts',NULL,3,166),(493,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Manitoba',NULL,1,167),(494,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Manitoba',NULL,2,167),(495,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Manitoba',NULL,3,167),(496,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Maryland',NULL,1,168),(497,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Maryland',NULL,2,168),(498,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Maryland',NULL,3,168),(499,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Girona',NULL,1,169),(500,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Girona',NULL,2,169),(501,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Girona',NULL,3,169),(502,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Maine',NULL,1,170),(503,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Maine',NULL,2,170),(504,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Maine',NULL,3,170),(505,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Alicante',NULL,1,171),(506,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Alicante',NULL,2,171),(507,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Alicante',NULL,3,171),(508,'2026-09-12 03:17:49','2026-09-12 03:17:49',NULL,NULL,'Cantabria',NULL,1,172),(509,'2026-09-12 03:17:50','2026-09-12 03:17:50',NULL,NULL,'Cantabria',NULL,2,172),(510,'2026-09-12 03:17:50','2026-09-12 03:17:50',NULL,NULL,'Cantabria',NULL,3,172),(511,'2026-09-12 03:17:50','2026-09-12 03:17:50',NULL,NULL,'Marshall Islands',NULL,1,173),(512,'2026-09-12 03:17:50','2026-09-12 03:17:50',NULL,NULL,'Marshall Islands',NULL,2,173),(513,'2026-09-12 03:17:50','2026-09-12 03:17:50',NULL,NULL,'Marshall Islands',NULL,3,173),(514,'2026-09-12 03:17:50','2026-09-12 03:17:50',NULL,NULL,'Michigan',NULL,1,174),(515,'2026-09-12 03:17:50','2026-09-12 03:17:50',NULL,NULL,'Michigan',NULL,2,174),(516,'2026-09-12 03:17:50','2026-09-12 03:17:50',NULL,NULL,'Michigan',NULL,3,174),(517,'2026-09-12 03:17:50','2026-09-12 03:17:50',NULL,NULL,'Minnesota',NULL,1,175),(518,'2026-09-12 03:17:50','2026-09-12 03:17:50',NULL,NULL,'Minnesota',NULL,2,175),(519,'2026-09-12 03:17:50','2026-09-12 03:17:50',NULL,NULL,'Minnesota',NULL,3,175),(520,'2026-09-12 03:17:50','2026-09-12 03:17:50',NULL,NULL,'Missouri',NULL,1,176),(521,'2026-09-12 03:17:50','2026-09-12 03:17:50',NULL,NULL,'Missouri',NULL,2,176),(522,'2026-09-12 03:17:50','2026-09-12 03:17:50',NULL,NULL,'Missouri',NULL,3,176),(523,'2026-09-12 03:17:50','2026-09-12 03:17:50',NULL,NULL,'Northern Mariana Islands',NULL,1,177),(524,'2026-09-12 03:17:50','2026-09-12 03:17:50',NULL,NULL,'Northern Mariana Islands',NULL,2,177),(525,'2026-09-12 03:17:50','2026-09-12 03:17:50',NULL,NULL,'Northern Mariana Islands',NULL,3,177),(526,'2026-09-12 03:17:50','2026-09-12 03:17:50',NULL,NULL,'Mississippi',NULL,1,178),(527,'2026-09-12 03:17:50','2026-09-12 03:17:50',NULL,NULL,'Mississippi',NULL,2,178),(528,'2026-09-12 03:17:50','2026-09-12 03:17:50',NULL,NULL,'Mississippi',NULL,3,178),(529,'2026-09-12 03:17:50','2026-09-12 03:17:50',NULL,NULL,'Montana',NULL,1,179),(530,'2026-09-12 03:17:50','2026-09-12 03:17:50',NULL,NULL,'Montana',NULL,2,179),(531,'2026-09-12 03:17:50','2026-09-12 03:17:50',NULL,NULL,'Montana',NULL,3,179),(532,'2026-09-12 03:17:50','2026-09-12 03:17:50',NULL,NULL,'Badajoz',NULL,1,180),(533,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'Badajoz',NULL,2,180),(534,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'Badajoz',NULL,3,180),(535,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'Mecklenburg-Vorpommern',NULL,1,181),(536,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'Mecklenburg-Vorpommern',NULL,2,181),(537,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'Mecklenburg-Vorpommern',NULL,3,181),(538,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'Sevilla',NULL,1,182),(539,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'Sevilla',NULL,2,182),(540,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'Sevilla',NULL,3,182),(541,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'New Brunswick',NULL,1,183),(542,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'Nouveau Brunswick',NULL,2,183),(543,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'New Brunswick',NULL,3,183),(544,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'Sachsen-Anhalt',NULL,1,184),(545,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'Sachsen-Anhalt',NULL,2,184),(546,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'Sachsen-Anhalt',NULL,3,184),(547,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'North Carolina',NULL,1,185),(548,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'Caroline du Nord',NULL,2,185),(549,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'North Carolina',NULL,3,185),(550,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'North Dakota',NULL,1,186),(551,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'Dakota du Nord',NULL,2,186),(552,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'North Dakota',NULL,3,186),(553,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'Nebraska',NULL,1,187),(554,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'Nebraska',NULL,2,187),(555,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'Nebraska',NULL,3,187),(556,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'Newfoundland - Labrador',NULL,1,188),(557,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'Terre-Neuve - Labrador',NULL,2,188),(558,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'Newfoundland - Labrador',NULL,3,188),(559,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'New Hampshire',NULL,1,189),(560,'2026-09-12 03:17:51','2026-09-12 03:17:51',NULL,NULL,'Nouveau Hampshire',NULL,2,189),(561,'2026-09-12 03:17:52','2026-09-12 03:17:52',NULL,NULL,'New Hampshire',NULL,3,189),(562,'2026-09-12 03:17:52','2026-09-12 03:17:52',NULL,NULL,'New Jersey',NULL,1,190),(563,'2026-09-12 03:17:52','2026-09-12 03:17:52',NULL,NULL,'New Jersey',NULL,2,190),(564,'2026-09-12 03:17:52','2026-09-12 03:17:52',NULL,NULL,'New Jersey',NULL,3,190),(565,'2026-09-12 03:17:52','2026-09-12 03:17:52',NULL,NULL,'New Mexico',NULL,1,191),(566,'2026-09-12 03:17:52','2026-09-12 03:17:52',NULL,NULL,'Nouveau Mexique',NULL,2,191),(567,'2026-09-12 03:17:52','2026-09-12 03:17:52',NULL,NULL,'New Mexico',NULL,3,191),(568,'2026-09-12 03:17:52','2026-09-12 03:17:52',NULL,NULL,'Niederosterreich',NULL,1,192),(569,'2026-09-12 03:17:52','2026-09-12 03:17:52',NULL,NULL,'Niederosterreich',NULL,2,192),(570,'2026-09-12 03:17:52','2026-09-12 03:17:52',NULL,NULL,'Niederosterreich',NULL,3,192),(571,'2026-09-12 03:17:52','2026-09-12 03:17:52',NULL,NULL,'Sachsen',NULL,1,193),(572,'2026-09-12 03:17:52','2026-09-12 03:17:52',NULL,NULL,'Sachsen',NULL,2,193),(573,'2026-09-12 03:17:52','2026-09-12 03:17:52',NULL,NULL,'Sachsen',NULL,3,193),(574,'2026-09-12 03:17:52','2026-09-12 03:17:52',NULL,NULL,'Nova Scotia',NULL,1,194),(575,'2026-09-12 03:17:52','2026-09-12 03:17:52',NULL,NULL,'Nouvelle Écosse',NULL,2,194),(576,'2026-09-12 03:17:52','2026-09-12 03:17:52',NULL,NULL,'Nova Scotia',NULL,3,194),(577,'2026-09-12 03:17:52','2026-09-12 03:17:52',NULL,NULL,'Saarland',NULL,1,195),(578,'2026-09-12 03:17:52','2026-09-12 03:17:52',NULL,NULL,'Saarland',NULL,2,195),(579,'2026-09-12 03:17:53','2026-09-12 03:17:53',NULL,NULL,'Saarland',NULL,3,195),(580,'2026-09-12 03:17:53','2026-09-12 03:17:53',NULL,NULL,'Northwest Territories',NULL,1,196),(581,'2026-09-12 03:17:53','2026-09-12 03:17:53',NULL,NULL,'Territores du Nord-Ouest',NULL,2,196),(582,'2026-09-12 03:17:53','2026-09-12 03:17:53',NULL,NULL,'Northwest Territories',NULL,3,196),(583,'2026-09-12 03:17:53','2026-09-12 03:17:53',NULL,NULL,'Nunavut',NULL,1,197),(584,'2026-09-12 03:17:53','2026-09-12 03:17:53',NULL,NULL,'Nunavut',NULL,2,197),(585,'2026-09-12 03:17:53','2026-09-12 03:17:53',NULL,NULL,'Nunavut',NULL,3,197),(586,'2026-09-12 03:17:53','2026-09-12 03:17:53',NULL,NULL,'Nevada',NULL,1,198),(587,'2026-09-12 03:17:53','2026-09-12 03:17:53',NULL,NULL,'Nevada',NULL,2,198),(588,'2026-09-12 03:17:53','2026-09-12 03:17:53',NULL,NULL,'Nevada',NULL,3,198),(589,'2026-09-12 03:17:53','2026-09-12 03:17:53',NULL,NULL,'Nidwalden',NULL,1,199),(590,'2026-09-12 03:17:53','2026-09-12 03:17:53',NULL,NULL,'Nidwalden',NULL,2,199),(591,'2026-09-12 03:17:53','2026-09-12 03:17:53',NULL,NULL,'Nidwalden',NULL,3,199),(592,'2026-09-12 03:17:53','2026-09-12 03:17:53',NULL,NULL,'New York',NULL,1,200),(593,'2026-09-12 03:17:53','2026-09-12 03:17:53',NULL,NULL,'New York',NULL,2,200),(594,'2026-09-12 03:17:53','2026-09-12 03:17:53',NULL,NULL,'New York',NULL,3,200),(595,'2026-09-12 03:17:53','2026-09-12 03:17:53',NULL,NULL,'Soria',NULL,1,201),(596,'2026-09-12 03:17:53','2026-09-12 03:17:53',NULL,NULL,'Soria',NULL,2,201),(597,'2026-09-12 03:17:53','2026-09-12 03:17:53',NULL,NULL,'Soria',NULL,3,201),(598,'2026-09-12 03:17:53','2026-09-12 03:17:53',NULL,NULL,'Ohio',NULL,1,202),(599,'2026-09-12 03:17:53','2026-09-12 03:17:53',NULL,NULL,'Ohio',NULL,2,202),(600,'2026-09-12 03:17:54','2026-09-12 03:17:54',NULL,NULL,'Ohio',NULL,3,202),(601,'2026-09-12 03:17:54','2026-09-12 03:17:54',NULL,NULL,'Oklahoma',NULL,1,203),(602,'2026-09-12 03:17:54','2026-09-12 03:17:54',NULL,NULL,'Oklahoma',NULL,2,203),(603,'2026-09-12 03:17:54','2026-09-12 03:17:54',NULL,NULL,'Oklahoma',NULL,3,203),(604,'2026-09-12 03:17:54','2026-09-12 03:17:54',NULL,NULL,'Ontario',NULL,1,204),(605,'2026-09-12 03:17:54','2026-09-12 03:17:54',NULL,NULL,'Ontario',NULL,2,204),(606,'2026-09-12 03:17:54','2026-09-12 03:17:54',NULL,NULL,'Ontario',NULL,3,204),(607,'2026-09-12 03:17:54','2026-09-12 03:17:54',NULL,NULL,'Oberosterreich',NULL,1,205),(608,'2026-09-12 03:17:54','2026-09-12 03:17:54',NULL,NULL,'Oberosterreich',NULL,2,205),(609,'2026-09-12 03:17:54','2026-09-12 03:17:54',NULL,NULL,'Oberosterreich',NULL,3,205),(610,'2026-09-12 03:17:54','2026-09-12 03:17:54',NULL,NULL,'Burgenland',NULL,1,206),(611,'2026-09-12 03:17:54','2026-09-12 03:17:54',NULL,NULL,'Burgenland',NULL,2,206),(612,'2026-09-12 03:17:54','2026-09-12 03:17:54',NULL,NULL,'Burgenland',NULL,3,206),(613,'2026-09-12 03:17:54','2026-09-12 03:17:54',NULL,NULL,'Oregon',NULL,1,207),(614,'2026-09-12 03:17:54','2026-09-12 03:17:54',NULL,NULL,'Oregon',NULL,2,207),(615,'2026-09-12 03:17:54','2026-09-12 03:17:54',NULL,NULL,'Oregon',NULL,3,207),(616,'2026-09-12 03:17:55','2026-09-12 03:17:55',NULL,NULL,'Salamanca',NULL,1,208),(617,'2026-09-12 03:17:55','2026-09-12 03:17:55',NULL,NULL,'Salamanca',NULL,2,208),(618,'2026-09-12 03:17:55','2026-09-12 03:17:55',NULL,NULL,'Salamanca',NULL,3,208),(619,'2026-09-12 03:17:55','2026-09-12 03:17:55',NULL,NULL,'Baleares',NULL,1,209),(620,'2026-09-12 03:17:55','2026-09-12 03:17:55',NULL,NULL,'Baleares',NULL,2,209),(621,'2026-09-12 03:17:55','2026-09-12 03:17:55',NULL,NULL,'Baleares',NULL,3,209),(622,'2026-09-12 03:17:55','2026-09-12 03:17:55',NULL,NULL,'Obwalden',NULL,1,210),(623,'2026-09-12 03:17:55','2026-09-12 03:17:55',NULL,NULL,'Obwalden',NULL,2,210),(624,'2026-09-12 03:17:55','2026-09-12 03:17:55',NULL,NULL,'Obwalden',NULL,3,210),(625,'2026-09-12 03:17:55','2026-09-12 03:17:55',NULL,NULL,'Pennsylvania',NULL,1,211),(626,'2026-09-12 03:17:55','2026-09-12 03:17:55',NULL,NULL,'Pennsylvanie',NULL,2,211),(627,'2026-09-12 03:17:55','2026-09-12 03:17:55',NULL,NULL,'Pennsylvania',NULL,3,211),(628,'2026-09-12 03:17:55','2026-09-12 03:17:55',NULL,NULL,'Victoria',NULL,1,212),(629,'2026-09-12 03:17:55','2026-09-12 03:17:55',NULL,NULL,'Victoria',NULL,2,212),(630,'2026-09-12 03:17:55','2026-09-12 03:17:55',NULL,NULL,'Victoria',NULL,3,212),(631,'2026-09-12 03:17:55','2026-09-12 03:17:55',NULL,NULL,'Bremen',NULL,1,213),(632,'2026-09-12 03:17:55','2026-09-12 03:17:55',NULL,NULL,'Bremen',NULL,2,213),(633,'2026-09-12 03:17:56','2026-09-12 03:17:56',NULL,NULL,'Bremen',NULL,3,213),(634,'2026-09-12 03:17:56','2026-09-12 03:17:56',NULL,NULL,'Prince Edward Island',NULL,1,214),(635,'2026-09-12 03:17:56','2026-09-12 03:17:56',NULL,NULL,'Île-du-Prince-Édouard',NULL,2,214),(636,'2026-09-12 03:17:56','2026-09-12 03:17:56',NULL,NULL,'Prince Edward Island',NULL,3,214),(637,'2026-09-12 03:17:56','2026-09-12 03:17:56',NULL,NULL,'Brandenburg',NULL,1,215),(638,'2026-09-12 03:17:56','2026-09-12 03:17:56',NULL,NULL,'Brandenburg',NULL,2,215),(639,'2026-09-12 03:17:56','2026-09-12 03:17:56',NULL,NULL,'Brandenburg',NULL,3,215),(640,'2026-09-12 03:17:56','2026-09-12 03:17:56',NULL,NULL,'Almeria',NULL,1,216),(641,'2026-09-12 03:17:56','2026-09-12 03:17:56',NULL,NULL,'Almeria',NULL,2,216),(642,'2026-09-12 03:17:56','2026-09-12 03:17:56',NULL,NULL,'Almeria',NULL,3,216),(643,'2026-09-12 03:17:56','2026-09-12 03:17:56',NULL,NULL,'Baden-Wrttemberg',NULL,1,217),(644,'2026-09-12 03:17:56','2026-09-12 03:17:56',NULL,NULL,'Baden-Wrttemberg',NULL,2,217),(645,'2026-09-12 03:17:56','2026-09-12 03:17:56',NULL,NULL,'Baden-Wrttemberg',NULL,3,217),(646,'2026-09-12 03:17:57','2026-09-12 03:17:57',NULL,NULL,'Bayern',NULL,1,218),(647,'2026-09-12 03:17:57','2026-09-12 03:17:57',NULL,NULL,'Bayern',NULL,2,218),(648,'2026-09-12 03:17:57','2026-09-12 03:17:57',NULL,NULL,'Bayern',NULL,3,218),(649,'2026-09-12 03:17:57','2026-09-12 03:17:57',NULL,NULL,'Navarra',NULL,1,219),(650,'2026-09-12 03:17:57','2026-09-12 03:17:57',NULL,NULL,'Navarra',NULL,2,219),(651,'2026-09-12 03:17:57','2026-09-12 03:17:57',NULL,NULL,'Navarra',NULL,3,219),(652,'2026-09-12 03:17:57','2026-09-12 03:17:57',NULL,NULL,'Valencia',NULL,1,220),(653,'2026-09-12 03:17:57','2026-09-12 03:17:57',NULL,NULL,'Valencia',NULL,2,220),(654,'2026-09-12 03:17:57','2026-09-12 03:17:57',NULL,NULL,'Valencia',NULL,3,220),(655,'2026-09-12 03:17:57','2026-09-12 03:17:57',NULL,NULL,'Schleswig-Holstein',NULL,1,221),(656,'2026-09-12 03:17:57','2026-09-12 03:17:57',NULL,NULL,'Schleswig-Holstein',NULL,2,221),(657,'2026-09-12 03:17:57','2026-09-12 03:17:57',NULL,NULL,'Schleswig-Holstein',NULL,3,221),(658,'2026-09-12 03:17:58','2026-09-12 03:17:58',NULL,NULL,'Andhra Pradesh',NULL,1,222),(659,'2026-09-12 03:17:58','2026-09-12 03:17:58',NULL,NULL,'Andhra Pradesh',NULL,2,222),(660,'2026-09-12 03:17:58','2026-09-12 03:17:58',NULL,NULL,'Andhra Pradesh',NULL,3,222),(661,'2026-09-12 03:17:58','2026-09-12 03:17:58',NULL,NULL,'Arunachal Pradesh',NULL,1,223),(662,'2026-09-12 03:17:58','2026-09-12 03:17:58',NULL,NULL,'Arunachal Pradesh',NULL,2,223),(663,'2026-09-12 03:17:58','2026-09-12 03:17:58',NULL,NULL,'Arunachal Pradesh',NULL,3,223),(664,'2026-09-12 03:17:58','2026-09-12 03:17:58',NULL,NULL,'Assam',NULL,1,224),(665,'2026-09-12 03:17:58','2026-09-12 03:17:58',NULL,NULL,'Assam',NULL,2,224),(666,'2026-09-12 03:17:58','2026-09-12 03:17:58',NULL,NULL,'Assam',NULL,3,224),(667,'2026-09-12 03:17:58','2026-09-12 03:17:58',NULL,NULL,'Bihar',NULL,1,225),(668,'2026-09-12 03:17:58','2026-09-12 03:17:58',NULL,NULL,'Bihar',NULL,2,225),(669,'2026-09-12 03:17:58','2026-09-12 03:17:58',NULL,NULL,'Bihar',NULL,3,225),(670,'2026-09-12 03:17:58','2026-09-12 03:17:58',NULL,NULL,'Chhattisgarh',NULL,1,226),(671,'2026-09-12 03:17:58','2026-09-12 03:17:58',NULL,NULL,'Chhattisgarh',NULL,2,226),(672,'2026-09-12 03:17:58','2026-09-12 03:17:58',NULL,NULL,'Chhattisgarh',NULL,3,226),(673,'2026-09-12 03:17:58','2026-09-12 03:17:58',NULL,NULL,'Goa',NULL,1,227),(674,'2026-09-12 03:17:58','2026-09-12 03:17:58',NULL,NULL,'Goa',NULL,2,227),(675,'2026-09-12 03:17:58','2026-09-12 03:17:58',NULL,NULL,'Goa',NULL,3,227),(676,'2026-09-12 03:17:59','2026-09-12 03:17:59',NULL,NULL,'Gujarat',NULL,1,228),(677,'2026-09-12 03:17:59','2026-09-12 03:17:59',NULL,NULL,'Gujarat',NULL,2,228),(678,'2026-09-12 03:17:59','2026-09-12 03:17:59',NULL,NULL,'Gujarat',NULL,3,228),(679,'2026-09-12 03:17:59','2026-09-12 03:17:59',NULL,NULL,'Haryana',NULL,1,229),(680,'2026-09-12 03:17:59','2026-09-12 03:17:59',NULL,NULL,'Haryana',NULL,2,229),(681,'2026-09-12 03:17:59','2026-09-12 03:17:59',NULL,NULL,'Haryana',NULL,3,229),(682,'2026-09-12 03:17:59','2026-09-12 03:17:59',NULL,NULL,'Himachal Pradesh',NULL,1,230),(683,'2026-09-12 03:17:59','2026-09-12 03:17:59',NULL,NULL,'Himachal Pradesh',NULL,2,230),(684,'2026-09-12 03:17:59','2026-09-12 03:17:59',NULL,NULL,'Himachal Pradesh',NULL,3,230),(685,'2026-09-12 03:17:59','2026-09-12 03:17:59',NULL,NULL,'Jharkhand',NULL,1,231),(686,'2026-09-12 03:17:59','2026-09-12 03:17:59',NULL,NULL,'Jharkhand',NULL,2,231),(687,'2026-09-12 03:17:59','2026-09-12 03:17:59',NULL,NULL,'Jharkhand',NULL,3,231),(688,'2026-09-12 03:17:59','2026-09-12 03:17:59',NULL,NULL,'Karnataka',NULL,1,232),(689,'2026-09-12 03:17:59','2026-09-12 03:17:59',NULL,NULL,'Karnataka',NULL,2,232),(690,'2026-09-12 03:17:59','2026-09-12 03:17:59',NULL,NULL,'Karnataka',NULL,3,232),(691,'2026-09-12 03:17:59','2026-09-12 03:17:59',NULL,NULL,'Kerala',NULL,1,233),(692,'2026-09-12 03:17:59','2026-09-12 03:17:59',NULL,NULL,'Kerala',NULL,2,233),(693,'2026-09-12 03:18:00','2026-09-12 03:18:00',NULL,NULL,'Kerala',NULL,3,233),(694,'2026-09-12 03:18:00','2026-09-12 03:18:00',NULL,NULL,'Madhya Pradesh',NULL,1,234),(695,'2026-09-12 03:18:00','2026-09-12 03:18:00',NULL,NULL,'Madhya Pradesh',NULL,2,234),(696,'2026-09-12 03:18:00','2026-09-12 03:18:00',NULL,NULL,'Madhya Pradesh',NULL,3,234),(697,'2026-09-12 03:18:00','2026-09-12 03:18:00',NULL,NULL,'Maharashtra',NULL,1,235),(698,'2026-09-12 03:18:00','2026-09-12 03:18:00',NULL,NULL,'Maharashtra',NULL,2,235),(699,'2026-09-12 03:18:00','2026-09-12 03:18:00',NULL,NULL,'Maharashtra',NULL,3,235),(700,'2026-09-12 03:18:00','2026-09-12 03:18:00',NULL,NULL,'Manipur',NULL,1,236),(701,'2026-09-12 03:18:00','2026-09-12 03:18:00',NULL,NULL,'Manipur',NULL,2,236),(702,'2026-09-12 03:18:00','2026-09-12 03:18:00',NULL,NULL,'Manipur',NULL,3,236),(703,'2026-09-12 03:18:00','2026-09-12 03:18:00',NULL,NULL,'Meghalaya',NULL,1,237),(704,'2026-09-12 03:18:00','2026-09-12 03:18:00',NULL,NULL,'Meghalaya',NULL,2,237),(705,'2026-09-12 03:18:00','2026-09-12 03:18:00',NULL,NULL,'Meghalaya',NULL,3,237),(706,'2026-09-12 03:18:00','2026-09-12 03:18:00',NULL,NULL,'Mizoram',NULL,1,238),(707,'2026-09-12 03:18:00','2026-09-12 03:18:00',NULL,NULL,'Mizoram',NULL,2,238),(708,'2026-09-12 03:18:00','2026-09-12 03:18:00',NULL,NULL,'Mizoram',NULL,3,238),(709,'2026-09-12 03:18:01','2026-09-12 03:18:01',NULL,NULL,'Nagaland',NULL,1,239),(710,'2026-09-12 03:18:01','2026-09-12 03:18:01',NULL,NULL,'Nagaland',NULL,2,239),(711,'2026-09-12 03:18:01','2026-09-12 03:18:01',NULL,NULL,'Nagaland',NULL,3,239),(712,'2026-09-12 03:18:01','2026-09-12 03:18:01',NULL,NULL,'Odisha',NULL,1,240),(713,'2026-09-12 03:18:01','2026-09-12 03:18:01',NULL,NULL,'Odisha',NULL,2,240),(714,'2026-09-12 03:18:01','2026-09-12 03:18:01',NULL,NULL,'Odisha',NULL,3,240),(715,'2026-09-12 03:18:01','2026-09-12 03:18:01',NULL,NULL,'Punjab',NULL,1,241),(716,'2026-09-12 03:18:01','2026-09-12 03:18:01',NULL,NULL,'Punjab',NULL,2,241),(717,'2026-09-12 03:18:01','2026-09-12 03:18:01',NULL,NULL,'Punjab',NULL,3,241),(718,'2026-09-12 03:18:01','2026-09-12 03:18:01',NULL,NULL,'Rajasthan',NULL,1,242),(719,'2026-09-12 03:18:01','2026-09-12 03:18:01',NULL,NULL,'Rajasthan',NULL,2,242),(720,'2026-09-12 03:18:01','2026-09-12 03:18:01',NULL,NULL,'Rajasthan',NULL,3,242),(721,'2026-09-12 03:18:01','2026-09-12 03:18:01',NULL,NULL,'Sikkim',NULL,1,243),(722,'2026-09-12 03:18:01','2026-09-12 03:18:01',NULL,NULL,'Sikkim',NULL,2,243),(723,'2026-09-12 03:18:01','2026-09-12 03:18:01',NULL,NULL,'Sikkim',NULL,3,243),(724,'2026-09-12 03:18:01','2026-09-12 03:18:01',NULL,NULL,'Tamil Nadu',NULL,1,244),(725,'2026-09-12 03:18:01','2026-09-12 03:18:01',NULL,NULL,'Tamil Nadu',NULL,2,244),(726,'2026-09-12 03:18:01','2026-09-12 03:18:01',NULL,NULL,'Tamil Nadu',NULL,3,244),(727,'2026-09-12 03:18:01','2026-09-12 03:18:01',NULL,NULL,'Telangana',NULL,1,245),(728,'2026-09-12 03:18:01','2026-09-12 03:18:01',NULL,NULL,'Telangana',NULL,2,245),(729,'2026-09-12 03:18:01','2026-09-12 03:18:01',NULL,NULL,'Telangana',NULL,3,245),(730,'2026-09-12 03:18:01','2026-09-12 03:18:01',NULL,NULL,'Tripura',NULL,1,246),(731,'2026-09-12 03:18:01','2026-09-12 03:18:01',NULL,NULL,'Tripura',NULL,2,246),(732,'2026-09-12 03:18:01','2026-09-12 03:18:01',NULL,NULL,'Tripura',NULL,3,246),(733,'2026-09-12 03:18:01','2026-09-12 03:18:01',NULL,NULL,'Uttarakhand',NULL,1,247),(734,'2026-09-12 03:18:01','2026-09-12 03:18:01',NULL,NULL,'Uttarakhand',NULL,2,247),(735,'2026-09-12 03:18:02','2026-09-12 03:18:02',NULL,NULL,'Uttarakhand',NULL,3,247),(736,'2026-09-12 03:18:02','2026-09-12 03:18:02',NULL,NULL,'West Bengal',NULL,1,248),(737,'2026-09-12 03:18:02','2026-09-12 03:18:02',NULL,NULL,'West Bengal',NULL,2,248),(738,'2026-09-12 03:18:02','2026-09-12 03:18:02',NULL,NULL,'West Bengal',NULL,3,248);
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

-- Dump completed on 2026-09-20 11:38:57
