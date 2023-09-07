# HeidiSQL Dump 
#
# --------------------------------------------------------
# Host:                         127.0.0.1
# Database:                     db_egrocer
# Server version:               5.0.51b-community-nt
# Server OS:                    Win32
# Target compatibility:         ANSI SQL
# HeidiSQL version:             4.0
# Date/time:                    2021-06-11 13:17:05
# --------------------------------------------------------

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ANSI,NO_BACKSLASH_ESCAPES';*/
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;*/


#
# Database structure for database 'db_egrocer'
#

CREATE DATABASE /*!32312 IF NOT EXISTS*/ "db_egrocer" /*!40100 DEFAULT CHARACTER SET latin1 */;

USE "db_egrocer";


#
# Table structure for table 'tbl_brand'
#

CREATE TABLE /*!32312 IF NOT EXISTS*/ "tbl_brand" (
  "brand_id" int(10) unsigned NOT NULL auto_increment,
  "brand_name" varchar(50) default NULL,
  PRIMARY KEY  ("brand_id")
) AUTO_INCREMENT=13;



#
# Dumping data for table 'tbl_brand'
#

LOCK TABLES "tbl_brand" WRITE;
/*!40000 ALTER TABLE "tbl_brand" DISABLE KEYS;*/
REPLACE INTO "tbl_brand" ("brand_id", "brand_name") VALUES
	('5','Pepsi');
REPLACE INTO "tbl_brand" ("brand_id", "brand_name") VALUES
	('6','Coca Cola');
REPLACE INTO "tbl_brand" ("brand_id", "brand_name") VALUES
	('7','7up');
REPLACE INTO "tbl_brand" ("brand_id", "brand_name") VALUES
	('8','Local');
REPLACE INTO "tbl_brand" ("brand_id", "brand_name") VALUES
	('9','Imported');
REPLACE INTO "tbl_brand" ("brand_id", "brand_name") VALUES
	('10','Kelloggs UK');
REPLACE INTO "tbl_brand" ("brand_id", "brand_name") VALUES
	('11','Nestle India');
REPLACE INTO "tbl_brand" ("brand_id", "brand_name") VALUES
	('12','Mirinda');
/*!40000 ALTER TABLE "tbl_brand" ENABLE KEYS;*/
UNLOCK TABLES;


#
# Table structure for table 'tbl_cartbody'
#

CREATE TABLE /*!32312 IF NOT EXISTS*/ "tbl_cartbody" (
  "cart_itemid" int(10) unsigned NOT NULL auto_increment,
  "cart_id" int(10) unsigned NOT NULL,
  "shopproduct_id" int(50) unsigned NOT NULL,
  "cart_itemqty" int(10) unsigned NOT NULL default '0',
  "cart_itemprice" float unsigned NOT NULL default '0',
  "cart_itemstatus" int(10) unsigned default '0',
  PRIMARY KEY  ("cart_itemid")
) AUTO_INCREMENT=46;



#
# Dumping data for table 'tbl_cartbody'
#

LOCK TABLES "tbl_cartbody" WRITE;
/*!40000 ALTER TABLE "tbl_cartbody" DISABLE KEYS;*/
REPLACE INTO "tbl_cartbody" ("cart_itemid", "cart_id", "shopproduct_id", "cart_itemqty", "cart_itemprice", "cart_itemstatus") VALUES
	('25','7','13','10','100','0');
REPLACE INTO "tbl_cartbody" ("cart_itemid", "cart_id", "shopproduct_id", "cart_itemqty", "cart_itemprice", "cart_itemstatus") VALUES
	('32','7','17','20','200','0');
REPLACE INTO "tbl_cartbody" ("cart_itemid", "cart_id", "shopproduct_id", "cart_itemqty", "cart_itemprice", "cart_itemstatus") VALUES
	('42','6','25','10','80','0');
REPLACE INTO "tbl_cartbody" ("cart_itemid", "cart_id", "shopproduct_id", "cart_itemqty", "cart_itemprice", "cart_itemstatus") VALUES
	('43','9','25','10','80','1');
REPLACE INTO "tbl_cartbody" ("cart_itemid", "cart_id", "shopproduct_id", "cart_itemqty", "cart_itemprice", "cart_itemstatus") VALUES
	('44','10','24','3','100','1');
REPLACE INTO "tbl_cartbody" ("cart_itemid", "cart_id", "shopproduct_id", "cart_itemqty", "cart_itemprice", "cart_itemstatus") VALUES
	('45','11','25','2','80','1');
/*!40000 ALTER TABLE "tbl_cartbody" ENABLE KEYS;*/
UNLOCK TABLES;


#
# Table structure for table 'tbl_carthead'
#

CREATE TABLE /*!32312 IF NOT EXISTS*/ "tbl_carthead" (
  "cart_id" int(10) unsigned NOT NULL auto_increment,
  "shop_id" int(10) unsigned default NULL,
  "user_id" int(10) unsigned default NULL,
  "cart_price" float unsigned default '0',
  "cart_delvmod" int(10) unsigned default '0',
  "cart_paymod" int(10) unsigned default '0',
  "cart_paystat" int(10) unsigned default '0',
  "cart_date" varchar(50) default NULL,
  "cart_time" varchar(50) default NULL,
  "cart_delvstat" int(10) unsigned default '0',
  "da_id" int(10) unsigned default '0',
  "cart_daassign" int(10) unsigned default '0',
  "cart_status" int(10) unsigned default '0',
  PRIMARY KEY  ("cart_id")
) AUTO_INCREMENT=12;



#
# Dumping data for table 'tbl_carthead'
#

LOCK TABLES "tbl_carthead" WRITE;
/*!40000 ALTER TABLE "tbl_carthead" DISABLE KEYS;*/
REPLACE INTO "tbl_carthead" ("cart_id", "shop_id", "user_id", "cart_price", "cart_delvmod", "cart_paymod", "cart_paystat", "cart_date", "cart_time", "cart_delvstat", "da_id", "cart_daassign", "cart_status") VALUES
	('6','8','11','800','1','1','1','2021-05-28','22:30','3','7','0','1');
REPLACE INTO "tbl_carthead" ("cart_id", "shop_id", "user_id", "cart_price", "cart_delvmod", "cart_paymod", "cart_paystat", "cart_date", "cart_time", "cart_delvstat", "da_id", "cart_daassign", "cart_status") VALUES
	('9','8','11','800','0','1','0','2021-05-29','10:30','4','7','0','1');
REPLACE INTO "tbl_carthead" ("cart_id", "shop_id", "user_id", "cart_price", "cart_delvmod", "cart_paymod", "cart_paystat", "cart_date", "cart_time", "cart_delvstat", "da_id", "cart_daassign", "cart_status") VALUES
	('10','8','11','300','0','1','1','2021-05-30','19:15','4','7','0','1');
REPLACE INTO "tbl_carthead" ("cart_id", "shop_id", "user_id", "cart_price", "cart_delvmod", "cart_paymod", "cart_paystat", "cart_date", "cart_time", "cart_delvstat", "da_id", "cart_daassign", "cart_status") VALUES
	('11','8','11','160','0','1','0','2021-06-09','19:25','1','0','0','1');
/*!40000 ALTER TABLE "tbl_carthead" ENABLE KEYS;*/
UNLOCK TABLES;


#
# Table structure for table 'tbl_category'
#

CREATE TABLE /*!32312 IF NOT EXISTS*/ "tbl_category" (
  "category_id" int(10) unsigned NOT NULL auto_increment,
  "category_name" varchar(50) default NULL,
  PRIMARY KEY  ("category_id")
) AUTO_INCREMENT=18;



#
# Dumping data for table 'tbl_category'
#

LOCK TABLES "tbl_category" WRITE;
/*!40000 ALTER TABLE "tbl_category" DISABLE KEYS;*/
REPLACE INTO "tbl_category" ("category_id", "category_name") VALUES
	('14','Baby');
REPLACE INTO "tbl_category" ("category_id", "category_name") VALUES
	('15','Beverages');
REPLACE INTO "tbl_category" ("category_id", "category_name") VALUES
	('16','Bread & Bakery');
REPLACE INTO "tbl_category" ("category_id", "category_name") VALUES
	('17','Breakfast & Cereals');
/*!40000 ALTER TABLE "tbl_category" ENABLE KEYS;*/
UNLOCK TABLES;


#
# Table structure for table 'tbl_deliveryagent'
#

CREATE TABLE /*!32312 IF NOT EXISTS*/ "tbl_deliveryagent" (
  "da_id" int(10) unsigned NOT NULL auto_increment,
  "da_name" varchar(50) default NULL,
  "da_photo" varchar(50) default NULL,
  "da_dob" varchar(50) default NULL,
  "da_contact" varchar(50) default NULL,
  "da_email" varchar(50) default NULL,
  "da_address" varchar(50) default NULL,
  "place_id" varchar(50) default NULL,
  "da_pincode" varchar(50) default NULL,
  "da_drivlic" varchar(50) default NULL,
  "da_vehproof" varchar(50) default NULL,
  "da_pwd" varchar(50) default NULL,
  "da_status" varchar(50) NOT NULL default '0',
  PRIMARY KEY  ("da_id")
) AUTO_INCREMENT=10;



#
# Dumping data for table 'tbl_deliveryagent'
#

LOCK TABLES "tbl_deliveryagent" WRITE;
/*!40000 ALTER TABLE "tbl_deliveryagent" DISABLE KEYS;*/
REPLACE INTO "tbl_deliveryagent" ("da_id", "da_name", "da_photo", "da_dob", "da_contact", "da_email", "da_address", "place_id", "da_pincode", "da_drivlic", "da_vehproof", "da_pwd", "da_status") VALUES
	('7','Predator 999g','fl_photo_1006.png','1994-06-17','6282475109','leo@gmail.com','Alappatt House, Mulakulam North P.O, Piravomg','13','686664','fl_drvlic_1679.png','fl_vehproof_1211.png','asd@123','1');
REPLACE INTO "tbl_deliveryagent" ("da_id", "da_name", "da_photo", "da_dob", "da_contact", "da_email", "da_address", "place_id", "da_pincode", "da_drivlic", "da_vehproof", "da_pwd", "da_status") VALUES
	('8','Yuio','fl_photo_1817.jpg','2021-06-19','5676789067','a@gmail.com','Dfghj','12','686663','fl_drvlic_1653.jpg','fl_vehproof_1435.png','Asd@12345','1');
REPLACE INTO "tbl_deliveryagent" ("da_id", "da_name", "da_photo", "da_dob", "da_contact", "da_email", "da_address", "place_id", "da_pincode", "da_drivlic", "da_vehproof", "da_pwd", "da_status") VALUES
	('9','Xgjio','fl_photo_1394.jpg','2021-06-17','7878676756','anujaksoman@gmail.com','Dgjkjt','12','786756','fl_drvlic_1647.jpg','fl_vehproof_1628.jpg','asd@124','1');
/*!40000 ALTER TABLE "tbl_deliveryagent" ENABLE KEYS;*/
UNLOCK TABLES;


#
# Table structure for table 'tbl_district'
#

CREATE TABLE /*!32312 IF NOT EXISTS*/ "tbl_district" (
  "district_id" int(10) unsigned NOT NULL auto_increment,
  "district_name" varchar(50) default NULL,
  PRIMARY KEY  ("district_id")
) AUTO_INCREMENT=15;



#
# Dumping data for table 'tbl_district'
#

LOCK TABLES "tbl_district" WRITE;
/*!40000 ALTER TABLE "tbl_district" DISABLE KEYS;*/
REPLACE INTO "tbl_district" ("district_id", "district_name") VALUES
	('1','Alappuzha');
REPLACE INTO "tbl_district" ("district_id", "district_name") VALUES
	('2','Ernakulam');
REPLACE INTO "tbl_district" ("district_id", "district_name") VALUES
	('3','Idukki');
REPLACE INTO "tbl_district" ("district_id", "district_name") VALUES
	('4','Kannur');
REPLACE INTO "tbl_district" ("district_id", "district_name") VALUES
	('5','Kasaragod');
REPLACE INTO "tbl_district" ("district_id", "district_name") VALUES
	('6','Kollam');
REPLACE INTO "tbl_district" ("district_id", "district_name") VALUES
	('7','Kottayam');
REPLACE INTO "tbl_district" ("district_id", "district_name") VALUES
	('8','Kozhikode');
REPLACE INTO "tbl_district" ("district_id", "district_name") VALUES
	('9','Malappuram');
REPLACE INTO "tbl_district" ("district_id", "district_name") VALUES
	('10','Palakkad');
REPLACE INTO "tbl_district" ("district_id", "district_name") VALUES
	('11','Pathanamthitta');
REPLACE INTO "tbl_district" ("district_id", "district_name") VALUES
	('12','Thiruvananthapuram');
REPLACE INTO "tbl_district" ("district_id", "district_name") VALUES
	('13','Thrissur');
REPLACE INTO "tbl_district" ("district_id", "district_name") VALUES
	('14','Wayanad ');
/*!40000 ALTER TABLE "tbl_district" ENABLE KEYS;*/
UNLOCK TABLES;


#
# Table structure for table 'tbl_masterstock'
#

CREATE TABLE /*!32312 IF NOT EXISTS*/ "tbl_masterstock" (
  "mstock_id" int(50) unsigned NOT NULL auto_increment,
  "mstock_qty" varchar(50) default '0',
  "shopproduct_id" int(50) unsigned default NULL,
  "mstock_price" float unsigned default '0',
  PRIMARY KEY  ("mstock_id")
) AUTO_INCREMENT=24;



#
# Dumping data for table 'tbl_masterstock'
#

LOCK TABLES "tbl_masterstock" WRITE;
/*!40000 ALTER TABLE "tbl_masterstock" DISABLE KEYS;*/
REPLACE INTO "tbl_masterstock" ("mstock_id", "mstock_qty", "shopproduct_id", "mstock_price") VALUES
	('11','60','10','40');
REPLACE INTO "tbl_masterstock" ("mstock_id", "mstock_qty", "shopproduct_id", "mstock_price") VALUES
	('12','25','11','200');
REPLACE INTO "tbl_masterstock" ("mstock_id", "mstock_qty", "shopproduct_id", "mstock_price") VALUES
	('13','340','13','100');
REPLACE INTO "tbl_masterstock" ("mstock_id", "mstock_qty", "shopproduct_id", "mstock_price") VALUES
	('14','40','16','120');
REPLACE INTO "tbl_masterstock" ("mstock_id", "mstock_qty", "shopproduct_id", "mstock_price") VALUES
	('15','30','17','200');
REPLACE INTO "tbl_masterstock" ("mstock_id", "mstock_qty", "shopproduct_id", "mstock_price") VALUES
	('16','50','18','75');
REPLACE INTO "tbl_masterstock" ("mstock_id", "mstock_qty", "shopproduct_id", "mstock_price") VALUES
	('17','10','19','70');
REPLACE INTO "tbl_masterstock" ("mstock_id", "mstock_qty", "shopproduct_id", "mstock_price") VALUES
	('18','75','20','140');
REPLACE INTO "tbl_masterstock" ("mstock_id", "mstock_qty", "shopproduct_id", "mstock_price") VALUES
	('19','15','21','55');
REPLACE INTO "tbl_masterstock" ("mstock_id", "mstock_qty", "shopproduct_id", "mstock_price") VALUES
	('20','75','22','100');
REPLACE INTO "tbl_masterstock" ("mstock_id", "mstock_qty", "shopproduct_id", "mstock_price") VALUES
	('21','25','23','110');
REPLACE INTO "tbl_masterstock" ("mstock_id", "mstock_qty", "shopproduct_id", "mstock_price") VALUES
	('22','94','24','100');
REPLACE INTO "tbl_masterstock" ("mstock_id", "mstock_qty", "shopproduct_id", "mstock_price") VALUES
	('23','6','25','80');
/*!40000 ALTER TABLE "tbl_masterstock" ENABLE KEYS;*/
UNLOCK TABLES;


#
# Table structure for table 'tbl_msgadmin'
#

CREATE TABLE /*!32312 IF NOT EXISTS*/ "tbl_msgadmin" (
  "ma_id" int(10) unsigned NOT NULL auto_increment,
  "ma_content" varchar(500) default NULL,
  "ma_senderid" int(10) unsigned default NULL,
  "ma_senddesg" int(10) unsigned default NULL,
  "ma_read" int(10) unsigned default '0',
  PRIMARY KEY  ("ma_id")
) AUTO_INCREMENT=8;



#
# Dumping data for table 'tbl_msgadmin'
#

LOCK TABLES "tbl_msgadmin" WRITE;
/*!40000 ALTER TABLE "tbl_msgadmin" DISABLE KEYS;*/
REPLACE INTO "tbl_msgadmin" ("ma_id", "ma_content", "ma_senderid", "ma_senddesg", "ma_read") VALUES
	('5','Checking run from Grocer','7','0','1');
REPLACE INTO "tbl_msgadmin" ("ma_id", "ma_content", "ma_senderid", "ma_senddesg", "ma_read") VALUES
	('6','Checking run from Customer','11','1','1');
REPLACE INTO "tbl_msgadmin" ("ma_id", "ma_content", "ma_senderid", "ma_senddesg", "ma_read") VALUES
	('7','Checking run from Delivery Agent','7','2','1');
/*!40000 ALTER TABLE "tbl_msgadmin" ENABLE KEYS;*/
UNLOCK TABLES;


#
# Table structure for table 'tbl_msgshop'
#

CREATE TABLE /*!32312 IF NOT EXISTS*/ "tbl_msgshop" (
  "ms_id" int(10) unsigned NOT NULL auto_increment,
  "ms_content" varchar(500) default NULL,
  "shop_id" int(10) unsigned default NULL,
  "user_id" int(10) unsigned default NULL,
  "ms_read" int(10) unsigned default '0',
  "cart_id" int(10) unsigned default NULL,
  "ms_date" varchar(50) default NULL,
  "ms_time" varchar(50) default NULL,
  PRIMARY KEY  ("ms_id")
) AUTO_INCREMENT=5;



#
# Dumping data for table 'tbl_msgshop'
#

LOCK TABLES "tbl_msgshop" WRITE;
/*!40000 ALTER TABLE "tbl_msgshop" DISABLE KEYS;*/
REPLACE INTO "tbl_msgshop" ("ms_id", "ms_content", "shop_id", "user_id", "ms_read", "cart_id", "ms_date", "ms_time") VALUES
	('1','Hello testing customer to grocer','8','11','1','9','2021-05-29','06:54:59');
REPLACE INTO "tbl_msgshop" ("ms_id", "ms_content", "shop_id", "user_id", "ms_read", "cart_id", "ms_date", "ms_time") VALUES
	('2','hello 2nd check','8','11','0','9','2021-05-28','06:57:27');
REPLACE INTO "tbl_msgshop" ("ms_id", "ms_content", "shop_id", "user_id", "ms_read", "cart_id", "ms_date", "ms_time") VALUES
	('3','hello 3','8','11','1','9','2021-05-29','07:07:11');
REPLACE INTO "tbl_msgshop" ("ms_id", "ms_content", "shop_id", "user_id", "ms_read", "cart_id", "ms_date", "ms_time") VALUES
	('4','hello 4','8','11','0','9','2021-05-28','07:08:11');
/*!40000 ALTER TABLE "tbl_msgshop" ENABLE KEYS;*/
UNLOCK TABLES;


#
# Table structure for table 'tbl_orderhomedelivery'
#

CREATE TABLE /*!32312 IF NOT EXISTS*/ "tbl_orderhomedelivery" (
  "order_id" int(10) unsigned NOT NULL,
  "user_id" int(11) NOT NULL,
  "order_status" int(10) unsigned NOT NULL,
  "da_id" int(10) unsigned NOT NULL,
  PRIMARY KEY  ("order_id")
);



#
# Dumping data for table 'tbl_orderhomedelivery'
#

# No data found.



#
# Table structure for table 'tbl_orderpickup'
#

CREATE TABLE /*!32312 IF NOT EXISTS*/ "tbl_orderpickup" (
  "order_id" int(10) unsigned NOT NULL,
  "order_pickuptime" varchar(50) NOT NULL,
  "order_status" int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  ("order_id")
);



#
# Dumping data for table 'tbl_orderpickup'
#

# No data found.



#
# Table structure for table 'tbl_place'
#

CREATE TABLE /*!32312 IF NOT EXISTS*/ "tbl_place" (
  "place_id" int(10) unsigned NOT NULL auto_increment,
  "place_name" varchar(50) default NULL,
  "district_id" int(10) unsigned default NULL,
  PRIMARY KEY  ("place_id")
) AUTO_INCREMENT=16;



#
# Dumping data for table 'tbl_place'
#

LOCK TABLES "tbl_place" WRITE;
/*!40000 ALTER TABLE "tbl_place" DISABLE KEYS;*/
REPLACE INTO "tbl_place" ("place_id", "place_name", "district_id") VALUES
	('12','Muvattupuzha','2');
REPLACE INTO "tbl_place" ("place_id", "place_name", "district_id") VALUES
	('13','Piravom','2');
REPLACE INTO "tbl_place" ("place_id", "place_name", "district_id") VALUES
	('14','Kumily','3');
REPLACE INTO "tbl_place" ("place_id", "place_name", "district_id") VALUES
	('15','Angamaly','2');
/*!40000 ALTER TABLE "tbl_place" ENABLE KEYS;*/
UNLOCK TABLES;


#
# Table structure for table 'tbl_product'
#

CREATE TABLE /*!32312 IF NOT EXISTS*/ "tbl_product" (
  "product_id" int(10) unsigned NOT NULL auto_increment,
  "product_name" varchar(50) default NULL,
  "product_img" varchar(50) default NULL,
  "category_id" int(10) unsigned default NULL,
  PRIMARY KEY  ("product_id")
) AUTO_INCREMENT=15;



#
# Dumping data for table 'tbl_product'
#

LOCK TABLES "tbl_product" WRITE;
/*!40000 ALTER TABLE "tbl_product" DISABLE KEYS;*/
REPLACE INTO "tbl_product" ("product_id", "product_name", "product_img", "category_id") VALUES
	('6','Coca Cola','fl_productimg_1944.png','15');
REPLACE INTO "tbl_product" ("product_id", "product_name", "product_img", "category_id") VALUES
	('7','Pepsi','fl_productimg_1093.jfif','15');
REPLACE INTO "tbl_product" ("product_id", "product_name", "product_img", "category_id") VALUES
	('8','7up','fl_productimg_1317.png','15');
REPLACE INTO "tbl_product" ("product_id", "product_name", "product_img", "category_id") VALUES
	('9','Mirinda','fl_productimg_1448.png','15');
REPLACE INTO "tbl_product" ("product_id", "product_name", "product_img", "category_id") VALUES
	('10','Kellogs UK Corn Flakes','fl_productimg_1673.jpg','17');
REPLACE INTO "tbl_product" ("product_id", "product_name", "product_img", "category_id") VALUES
	('11','Nestle Corn Flakes','fl_productimg_1022.jfif','17');
REPLACE INTO "tbl_product" ("product_id", "product_name", "product_img", "category_id") VALUES
	('13','Quaker Oats','fl_productimg_1688.png','17');
REPLACE INTO "tbl_product" ("product_id", "product_name", "product_img", "category_id") VALUES
	('14','English Oven Bread','fl_productimg_1989.jpeg','16');
/*!40000 ALTER TABLE "tbl_product" ENABLE KEYS;*/
UNLOCK TABLES;


#
# Table structure for table 'tbl_replymsg'
#

CREATE TABLE /*!32312 IF NOT EXISTS*/ "tbl_replymsg" (
  "rm_id" int(10) unsigned NOT NULL auto_increment,
  "rm_content" varchar(500) NOT NULL,
  "ma_id" int(10) unsigned default NULL,
  "rm_status" int(10) unsigned default '0',
  PRIMARY KEY  ("rm_id")
) AUTO_INCREMENT=10;



#
# Dumping data for table 'tbl_replymsg'
#

LOCK TABLES "tbl_replymsg" WRITE;
/*!40000 ALTER TABLE "tbl_replymsg" DISABLE KEYS;*/
REPLACE INTO "tbl_replymsg" ("rm_id", "rm_content", "ma_id", "rm_status") VALUES
	('7','Check Successfull','5','1');
REPLACE INTO "tbl_replymsg" ("rm_id", "rm_content", "ma_id", "rm_status") VALUES
	('8','Check Successfull','6','1');
REPLACE INTO "tbl_replymsg" ("rm_id", "rm_content", "ma_id", "rm_status") VALUES
	('9','Check Successfull','7','1');
/*!40000 ALTER TABLE "tbl_replymsg" ENABLE KEYS;*/
UNLOCK TABLES;


#
# Table structure for table 'tbl_shop'
#

CREATE TABLE /*!32312 IF NOT EXISTS*/ "tbl_shop" (
  "shop_id" int(10) unsigned NOT NULL auto_increment,
  "shop_name" varchar(50) NOT NULL,
  "place_id" int(10) unsigned default NULL,
  "shop_licsno" varchar(50) default NULL,
  "shop_gstno" varchar(50) default NULL,
  "shop_owner" varchar(50) default NULL,
  "shop_address" varchar(50) default NULL,
  "shop_pincode" varchar(50) default NULL,
  "shop_email" varchar(50) default NULL,
  "shop_contact" varchar(50) default NULL,
  "shop_pwd" varchar(50) default NULL,
  "shop_proof" varchar(50) default NULL,
  "idproof" varchar(50) default NULL,
  "shop_img" varchar(50) NOT NULL,
  "shop_status" varchar(50) NOT NULL default '0',
  PRIMARY KEY  ("shop_id")
) AUTO_INCREMENT=9;



#
# Dumping data for table 'tbl_shop'
#

LOCK TABLES "tbl_shop" WRITE;
/*!40000 ALTER TABLE "tbl_shop" DISABLE KEYS;*/
REPLACE INTO "tbl_shop" ("shop_id", "shop_name", "place_id", "shop_licsno", "shop_gstno", "shop_owner", "shop_address", "shop_pincode", "shop_email", "shop_contact", "shop_pwd", "shop_proof", "idproof", "shop_img", "shop_status") VALUES
	('7','XYZ Groceries','13','L193492','GSTN92379DS8438','Ranger','Alappatt House, Mulakulam North P.O','686664','xyzgroceries@gmail.com','1234512345','welcome','shopproof_1587.jpg','ownerproof_1210.jpg','shopimg_1992.jpg','1');
REPLACE INTO "tbl_shop" ("shop_id", "shop_name", "place_id", "shop_licsno", "shop_gstno", "shop_owner", "shop_address", "shop_pincode", "shop_email", "shop_contact", "shop_pwd", "shop_proof", "idproof", "shop_img", "shop_status") VALUES
	('8','ABC Groceries','14','L87348378739','8734582879892','Mardog','jbajbfjfbjaebfjkbe ndnwsjnfgwe jwhjghwj jhewjghwjh','387489','abcgroceries@gmail.com','9447822631','welcome','shopproof_1389.jpg','ownerproof_1636.jpg','shopimg_1719.jpg','1');
/*!40000 ALTER TABLE "tbl_shop" ENABLE KEYS;*/
UNLOCK TABLES;


#
# Table structure for table 'tbl_shopproduct'
#

CREATE TABLE /*!32312 IF NOT EXISTS*/ "tbl_shopproduct" (
  "shopproduct_id" int(10) unsigned NOT NULL auto_increment,
  "product_id" int(11) default NULL,
  "shop_id" int(10) unsigned default NULL,
  "brand_id" int(10) unsigned default NULL,
  "shopproduct_desc" varchar(100) default NULL,
  PRIMARY KEY  ("shopproduct_id")
) AUTO_INCREMENT=27;



#
# Dumping data for table 'tbl_shopproduct'
#

LOCK TABLES "tbl_shopproduct" WRITE;
/*!40000 ALTER TABLE "tbl_shopproduct" DISABLE KEYS;*/
REPLACE INTO "tbl_shopproduct" ("shopproduct_id", "product_id", "shop_id", "brand_id", "shopproduct_desc") VALUES
	('10',7,'7','5','250ml can');
REPLACE INTO "tbl_shopproduct" ("shopproduct_id", "product_id", "shop_id", "brand_id", "shopproduct_desc") VALUES
	('11',14,'7','9','Made in England ');
REPLACE INTO "tbl_shopproduct" ("shopproduct_id", "product_id", "shop_id", "brand_id", "shopproduct_desc") VALUES
	('13',7,'7','5','750 ml bottle');
REPLACE INTO "tbl_shopproduct" ("shopproduct_id", "product_id", "shop_id", "brand_id", "shopproduct_desc") VALUES
	('17',13,'7','11','Made in India');
REPLACE INTO "tbl_shopproduct" ("shopproduct_id", "product_id", "shop_id", "brand_id", "shopproduct_desc") VALUES
	('24',14,'8','10','Imported from UK');
REPLACE INTO "tbl_shopproduct" ("shopproduct_id", "product_id", "shop_id", "brand_id", "shopproduct_desc") VALUES
	('25',9,'8','12','750 ml bottle');
REPLACE INTO "tbl_shopproduct" ("shopproduct_id", "product_id", "shop_id", "brand_id", "shopproduct_desc") VALUES
	('26',8,'8','7','Made by njdj');
/*!40000 ALTER TABLE "tbl_shopproduct" ENABLE KEYS;*/
UNLOCK TABLES;


#
# Table structure for table 'tbl_slot'
#

CREATE TABLE /*!32312 IF NOT EXISTS*/ "tbl_slot" (
  "slot_id" int(10) unsigned NOT NULL auto_increment,
  "sb_id" int(10) unsigned default NULL,
  "slot_date" varchar(50) default NULL,
  "slot_starttime" varchar(50) default NULL,
  "slot_endtime" varchar(50) default NULL,
  "slot_status" int(50) default '0',
  "slot_user" int(3) unsigned default NULL,
  PRIMARY KEY  ("slot_id")
);



#
# Dumping data for table 'tbl_slot'
#

# No data found.



#
# Table structure for table 'tbl_slotbundle'
#

CREATE TABLE /*!32312 IF NOT EXISTS*/ "tbl_slotbundle" (
  "sb_id" int(10) unsigned NOT NULL auto_increment,
  "sb_starttime" varchar(50) default NULL,
  "sb_endtime" varchar(50) default NULL,
  "sb_lifetime" varchar(50) default NULL,
  "sb_totalslots" varchar(50) default NULL,
  "sb_fine" varchar(50) default NULL,
  "sb_break" varchar(50) default NULL,
  "sb_date" varchar(50) default NULL,
  "sb_generateslot" varchar(50) default NULL,
  "shop_id" int(10) unsigned default NULL,
  PRIMARY KEY  ("sb_id")
);



#
# Dumping data for table 'tbl_slotbundle'
#

# No data found.



#
# Table structure for table 'tbl_stockupdate'
#

CREATE TABLE /*!32312 IF NOT EXISTS*/ "tbl_stockupdate" (
  "stockupd_id" int(10) unsigned NOT NULL auto_increment,
  "shopproduct_id" int(10) unsigned default NULL,
  "stockupd_qty" varchar(50) default '0',
  "stockupd_rate" double unsigned default NULL,
  "stockupd_date" varchar(50) default NULL,
  PRIMARY KEY  ("stockupd_id")
) AUTO_INCREMENT=51;



#
# Dumping data for table 'tbl_stockupdate'
#

LOCK TABLES "tbl_stockupdate" WRITE;
/*!40000 ALTER TABLE "tbl_stockupdate" DISABLE KEYS;*/
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('22','10','20','35','2021-04-30');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('23','11','25','200','2021-04-30');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('24','13','50','75','2021-04-30');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('25','13','300','100','2021-05-01');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('26','16','20','100','2021-04-30');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('27','10','20','40','2021-05-13');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('28','10','20','40','2021-05-13');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('29','17','50','200','2021-05-13');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('30','16','20','120','2021-05-13');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('31','18','50','75','2021-05-13');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('32','19','10','70','2021-05-13');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('33','19','0','75','2021-05-13');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('34','19','0','75','2021-05-13');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('35','20','25','135','2021-05-12');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('36','20','50','130','2021-05-10');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('37','20','0','140','2021-05-13');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('38','20','0','135','2021-05-08');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('39','21','15','55','2021-05-13');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('40','21','0','50','2021-05-13');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('41','22','50','100','2021-05-12');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('42','22','0','75','2021-05-12');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('43','22','25','125','2021-05-11');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('44','23','25','100','2021-05-12');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('45','23','0','110','2021-05-12');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('46','24','50','100','2021-05-12');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('47','24','0','110','2021-05-12');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('48','25','15','55','2021-05-12');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('49','24','50','100','2021-05-13');
REPLACE INTO "tbl_stockupdate" ("stockupd_id", "shopproduct_id", "stockupd_qty", "stockupd_rate", "stockupd_date") VALUES
	('50','25','25','80','2021-05-13');
/*!40000 ALTER TABLE "tbl_stockupdate" ENABLE KEYS;*/
UNLOCK TABLES;


#
# Table structure for table 'tbl_user'
#

CREATE TABLE /*!32312 IF NOT EXISTS*/ "tbl_user" (
  "user_id" int(10) unsigned NOT NULL auto_increment,
  "user_name" varchar(50) default NULL,
  "email" varchar(50) default NULL,
  "password" varchar(50) default NULL,
  "contact" varchar(50) default NULL,
  "address" varchar(50) default NULL,
  "place_id" int(11) default NULL,
  "pincode" varchar(50) default NULL,
  PRIMARY KEY  ("user_id")
) AUTO_INCREMENT=13;



#
# Dumping data for table 'tbl_user'
#

LOCK TABLES "tbl_user" WRITE;
/*!40000 ALTER TABLE "tbl_user" DISABLE KEYS;*/
REPLACE INTO "tbl_user" ("user_id", "user_name", "email", "password", "contact", "address", "place_id", "pincode") VALUES
	('11','Leo Johnson','leojohnsonofficial@gmail.com','welcome','6282475102','Alappatt House, Mulakulam North P.O, Piravom',12,'686664');
REPLACE INTO "tbl_user" ("user_id", "user_name", "email", "password", "contact", "address", "place_id", "pincode") VALUES
	('12','Leo Johnson','leojohnsonofficiaal@gmail.com','welcome','9087654321','Alappatt House, Mulakulam North P.O, Piravom',13,'686664');
/*!40000 ALTER TABLE "tbl_user" ENABLE KEYS;*/
UNLOCK TABLES;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE;*/
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;*/
