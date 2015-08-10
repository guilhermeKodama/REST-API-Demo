# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: localhost (MySQL 5.6.26)
# Database: fightclub
# Generation Time: 2015-08-07 15:45:19 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table bet
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bet`;

CREATE TABLE `bet` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `value` decimal(15,2) NOT NULL,
  `finalization` enum('ko','tko','decision','submisson') DEFAULT NULL,
  `round` enum('1','2','3','4','5') DEFAULT NULL,
  `user_id` varchar(255) NOT NULL,
  `fight_id` varchar(255) NOT NULL,
  `is_closed` tinyint(1) NOT NULL DEFAULT '0',
  `winner` varchar(255) DEFAULT NULL,
  `is_draw` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_bet_fight_idx` (`fight_id`),
  KEY `fk_bet_fighter_idx` (`winner`),
  KEY `fk_bet_user` (`user_id`),
  CONSTRAINT `fk_bet_fight` FOREIGN KEY (`fight_id`) REFERENCES `fight` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_bet_fighter` FOREIGN KEY (`winner`) REFERENCES `fighter` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_bet_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

LOCK TABLES `bet` WRITE;
/*!40000 ALTER TABLE `bet` DISABLE KEYS */;

INSERT INTO `bet` (`id`, `value`, `finalization`, `round`, `user_id`, `fight_id`, `is_closed`, `winner`, `is_draw`)
VALUES
	(6,500.00,'ko','1','kevinobruno@gmail.com','1',0,'1',0),
	(7,500.00,'ko','1','kevinobruno@gmail.com','1',0,'1',0),
	(8,500.00,'ko','1','kevinobruno@gmail.com','1',0,'1',0),
	(9,500.00,'ko','1','kevinobruno@gmail.com','1',0,'1',0),
	(10,100.00,'ko','1','kevinobruno@gmail.com','1',0,'1',0),
	(11,50.00,'ko','1','kevinobruno@gmail.com','1',0,'1',0),
	(12,50.00,'ko','1','kevinobruno@gmail.com','1',0,'1',0);

/*!40000 ALTER TABLE `bet` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table event
# ------------------------------------------------------------

DROP TABLE IF EXISTS `event`;

CREATE TABLE `event` (
  `id` varchar(255) NOT NULL,
  `tournament` enum('UFC') NOT NULL DEFAULT 'UFC',
  `name` varchar(255) NOT NULL,
  `date` datetime NOT NULL,
  `location` varchar(255) NOT NULL,
  `arena` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;

INSERT INTO `event` (`id`, `tournament`, `name`, `date`, `location`, `arena`)
VALUES
	('1','UFC','HUE','2008-01-02 00:00:00','Brazil','HueHue');

/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fight
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fight`;

CREATE TABLE `fight` (
  `id` varchar(255) NOT NULL,
  `fighter1` varchar(255) NOT NULL,
  `fighter2` varchar(255) NOT NULL,
  `sequence` bigint(11) NOT NULL,
  `status` enum('open_to_bet','closed_to_bet','waiting_accounting','closed') NOT NULL DEFAULT 'open_to_bet',
  `event_id` varchar(255) NOT NULL,
  `winner` varchar(255) DEFAULT NULL,
  `finalization` enum('ko','tko','decision','submisson') DEFAULT NULL,
  `round` enum('1','2','3','4','5') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_fighter1_idx` (`fighter1`),
  KEY `fk_fighter2_idx` (`fighter2`),
  KEY `fk_event_fight_idx` (`event_id`),
  KEY `fk_winner_fight_idx` (`winner`),
  CONSTRAINT `fk_event_fight` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_fighter1` FOREIGN KEY (`fighter1`) REFERENCES `fighter` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_fighter2` FOREIGN KEY (`fighter2`) REFERENCES `fighter` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_winner_fight` FOREIGN KEY (`winner`) REFERENCES `fighter` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fight` WRITE;
/*!40000 ALTER TABLE `fight` DISABLE KEYS */;

INSERT INTO `fight` (`id`, `fighter1`, `fighter2`, `sequence`, `status`, `event_id`, `winner`, `finalization`, `round`)
VALUES
	('1','1','1',1,'open_to_bet','1',NULL,NULL,NULL);

/*!40000 ALTER TABLE `fight` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fighter
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fighter`;

CREATE TABLE `fighter` (
  `id` varchar(255) NOT NULL,
  `name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `nickname` varchar(50) NOT NULL,
  `country` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fighter` WRITE;
/*!40000 ALTER TABLE `fighter` DISABLE KEYS */;

INSERT INTO `fighter` (`id`, `name`, `last_name`, `nickname`, `country`)
VALUES
	('1','Kevin','Oliveira','Kevin','Brazil');

/*!40000 ALTER TABLE `fighter` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `money` decimal(15,2) NOT NULL DEFAULT '1000.00',
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

INSERT INTO `user` (`email`, `password`, `money`)
VALUES
	('kevinobruno@gmail.com','123',300.00);

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
