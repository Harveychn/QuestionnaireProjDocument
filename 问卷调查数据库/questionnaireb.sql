/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : questionnaireprojdocument

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-03-12 20:04:03
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for answer
-- ----------------------------
DROP TABLE IF EXISTS `answer`;
CREATE TABLE `answer` (
  `answer_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `answer_string` text NOT NULL,
  PRIMARY KEY (`answer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of answer
-- ----------------------------

-- ----------------------------
-- Table structure for answer_paper
-- ----------------------------
DROP TABLE IF EXISTS `answer_paper`;
CREATE TABLE `answer_paper` (
  `answer_paper_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `questionnaire_id` bigint(20) NOT NULL,
  `longitude` decimal(10,0) NOT NULL,
  `latitude` decimal(10,0) NOT NULL,
  PRIMARY KEY (`answer_paper_id`),
  KEY `questionnaire_id_answer` (`questionnaire_id`),
  CONSTRAINT `questionnaire_id_answer` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaire` (`questionnaire_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of answer_paper
-- ----------------------------

-- ----------------------------
-- Table structure for mapping_notice_role
-- ----------------------------
DROP TABLE IF EXISTS `mapping_notice_role`;
CREATE TABLE `mapping_notice_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `unit_id` bigint(20) NOT NULL,
  `notice_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `unit_id_mnr` (`unit_id`),
  KEY `notice_id_mnr` (`notice_id`),
  CONSTRAINT `notice_id_mnr` FOREIGN KEY (`notice_id`) REFERENCES `notice` (`notice_id`),
  CONSTRAINT `unit_id_mnr` FOREIGN KEY (`unit_id`) REFERENCES `unit` (`unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mapping_notice_role
-- ----------------------------

-- ----------------------------
-- Table structure for mapping_notice_unit
-- ----------------------------
DROP TABLE IF EXISTS `mapping_notice_unit`;
CREATE TABLE `mapping_notice_unit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `unit_id` bigint(20) NOT NULL,
  `notice_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `unit_id_mnu` (`unit_id`),
  KEY `notice_id_mnu` (`notice_id`),
  CONSTRAINT `notice_id_mnu` FOREIGN KEY (`notice_id`) REFERENCES `notice` (`notice_id`),
  CONSTRAINT `unit_id_mnu` FOREIGN KEY (`unit_id`) REFERENCES `unit` (`unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mapping_notice_unit
-- ----------------------------

-- ----------------------------
-- Table structure for mapping_questionnaire_question
-- ----------------------------
DROP TABLE IF EXISTS `mapping_questionnaire_question`;
CREATE TABLE `mapping_questionnaire_question` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `questionnaire_id` bigint(20) NOT NULL,
  `question_id` bigint(20) NOT NULL,
  `question_order` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `questionnaire_id_mqq` (`questionnaire_id`),
  KEY `question_id_mqq` (`question_id`),
  CONSTRAINT `question_id_mqq` FOREIGN KEY (`question_id`) REFERENCES `question` (`question_id`),
  CONSTRAINT `questionnaire_id_mqq` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaire` (`questionnaire_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mapping_questionnaire_question
-- ----------------------------

-- ----------------------------
-- Table structure for mapping_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `mapping_role_permission`;
CREATE TABLE `mapping_role_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `permission_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `permission_id_mrp` (`permission_id`) USING BTREE,
  KEY `role_id_mrp` (`role_id`) USING BTREE,
  CONSTRAINT `permission_id` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`permission_id`),
  CONSTRAINT `role_id` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mapping_role_permission
-- ----------------------------

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `notice_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `notice_title` varchar(1000) NOT NULL,
  `notice_context` text NOT NULL,
  `last_date` datetime NOT NULL,
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of notice
-- ----------------------------

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `permission_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `permission` varchar(500) NOT NULL,
  PRIMARY KEY (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of permission
-- ----------------------------

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question` (
  `question_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `option_id` bigint(20) NOT NULL,
  `answer_id` bigint(20) NOT NULL,
  `question_context` varchar(50) NOT NULL,
  `question_type` varchar(3) NOT NULL,
  `question_description` varchar(1000) DEFAULT NULL,
  `is_must` tinyint(1) NOT NULL,
  PRIMARY KEY (`question_id`),
  KEY `option_id_que` (`option_id`),
  KEY `answer_id_que` (`answer_id`),
  CONSTRAINT `answer_id_que` FOREIGN KEY (`answer_id`) REFERENCES `answer` (`answer_id`),
  CONSTRAINT `option_id_que` FOREIGN KEY (`option_id`) REFERENCES `question_option` (`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of question
-- ----------------------------

-- ----------------------------
-- Table structure for questionnaire
-- ----------------------------
DROP TABLE IF EXISTS `questionnaire`;
CREATE TABLE `questionnaire` (
  `questionnaire_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `questionnaire_title` varchar(1000) NOT NULL,
  `questionnaire_subtitle` varchar(1000) DEFAULT NULL,
  `questionnaire_description` text NOT NULL,
  `is_template` tinyint(1) NOT NULL,
  `is_share` tinyint(1) NOT NULL,
  `is_visiable` tinyint(1) NOT NULL,
  `is_done` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  PRIMARY KEY (`questionnaire_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of questionnaire
-- ----------------------------

-- ----------------------------
-- Table structure for question_option
-- ----------------------------
DROP TABLE IF EXISTS `question_option`;
CREATE TABLE `question_option` (
  `option_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `option_string` text NOT NULL,
  PRIMARY KEY (`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of question_option
-- ----------------------------

-- ----------------------------
-- Table structure for receive_user
-- ----------------------------
DROP TABLE IF EXISTS `receive_user`;
CREATE TABLE `receive_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `questionnaire_id` bigint(20) NOT NULL,
  `user_tel` varchar(19) NOT NULL,
  `receive_num` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `questionnaire_id_receive` (`questionnaire_id`),
  KEY `user_tel_receive` (`user_tel`),
  CONSTRAINT `questionnaire_id_receive` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaire` (`questionnaire_id`),
  CONSTRAINT `user_tel_receive` FOREIGN KEY (`user_tel`) REFERENCES `user` (`user_tel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of receive_user
-- ----------------------------

-- ----------------------------
-- Table structure for record_login
-- ----------------------------
DROP TABLE IF EXISTS `record_login`;
CREATE TABLE `record_login` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_tel` varchar(19) NOT NULL,
  `last_login_date` datetime NOT NULL,
  `last_login_ip` varchar(16) NOT NULL,
  PRIMARY KEY (`record_id`),
  KEY `user_tel_login` (`user_tel`),
  CONSTRAINT `user_tel_login` FOREIGN KEY (`user_tel`) REFERENCES `user` (`user_tel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of record_login
-- ----------------------------

-- ----------------------------
-- Table structure for record_operate_answer_paper
-- ----------------------------
DROP TABLE IF EXISTS `record_operate_answer_paper`;
CREATE TABLE `record_operate_answer_paper` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `answer_paper_id` bigint(20) NOT NULL,
  `user_tel` varchar(19) NOT NULL,
  `action` varchar(1) NOT NULL,
  `operate_date` datetime NOT NULL,
  PRIMARY KEY (`record_id`),
  KEY `answer_paper_id_roa` (`answer_paper_id`),
  KEY `user_tel_roa` (`user_tel`),
  CONSTRAINT `answer_paper_id_roa` FOREIGN KEY (`answer_paper_id`) REFERENCES `answer_paper` (`answer_paper_id`),
  CONSTRAINT `user_tel_roa` FOREIGN KEY (`user_tel`) REFERENCES `user` (`user_tel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of record_operate_answer_paper
-- ----------------------------

-- ----------------------------
-- Table structure for record_operate_notice
-- ----------------------------
DROP TABLE IF EXISTS `record_operate_notice`;
CREATE TABLE `record_operate_notice` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `notice_id` bigint(20) NOT NULL,
  `user_tel` varchar(19) NOT NULL,
  `action` char(1) NOT NULL,
  `operate_date` datetime NOT NULL,
  PRIMARY KEY (`record_id`),
  KEY `notice_id_ron` (`notice_id`),
  KEY `user_tel_ron` (`user_tel`),
  CONSTRAINT `notice_id_ron` FOREIGN KEY (`notice_id`) REFERENCES `notice` (`notice_id`),
  CONSTRAINT `user_tel_ron` FOREIGN KEY (`user_tel`) REFERENCES `user` (`user_tel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of record_operate_notice
-- ----------------------------

-- ----------------------------
-- Table structure for record_operate_questionnaire
-- ----------------------------
DROP TABLE IF EXISTS `record_operate_questionnaire`;
CREATE TABLE `record_operate_questionnaire` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `questionnaire_id` bigint(20) NOT NULL,
  `user_tel` varchar(19) NOT NULL,
  `action` char(1) NOT NULL,
  `operate_date` datetime NOT NULL,
  PRIMARY KEY (`record_id`),
  KEY `questionnaire_id_roq` (`questionnaire_id`),
  KEY `user_tel_roq` (`user_tel`),
  CONSTRAINT `questionnaire_id_roq` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaire` (`questionnaire_id`),
  CONSTRAINT `user_tel_roq` FOREIGN KEY (`user_tel`) REFERENCES `user` (`user_tel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of record_operate_questionnaire
-- ----------------------------

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role` varchar(500) NOT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------

-- ----------------------------
-- Table structure for send_unit
-- ----------------------------
DROP TABLE IF EXISTS `send_unit`;
CREATE TABLE `send_unit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `questionnaire_id` bigint(20) NOT NULL,
  `unit_id` bigint(20) NOT NULL,
  `send_num` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `questionnaire_id_sent` (`questionnaire_id`),
  KEY `unit_id_sent` (`unit_id`),
  CONSTRAINT `questionnaire_id_sent` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaire` (`questionnaire_id`),
  CONSTRAINT `unit_id_sent` FOREIGN KEY (`unit_id`) REFERENCES `unit` (`unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of send_unit
-- ----------------------------

-- ----------------------------
-- Table structure for unit
-- ----------------------------
DROP TABLE IF EXISTS `unit`;
CREATE TABLE `unit` (
  `unit_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(50) NOT NULL,
  `unit_code` varchar(50) NOT NULL,
  `unit_level` char(1) DEFAULT NULL,
  `unit_province` varchar(500) NOT NULL,
  `unit_city` varchar(500) NOT NULL,
  `unit_address` varchar(500) NOT NULL,
  PRIMARY KEY (`unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of unit
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_tel` varchar(19) NOT NULL,
  `unit_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `user_real_name` varchar(255) NOT NULL,
  `mail_address` varchar(50) DEFAULT NULL,
  `user_pic_url` varchar(255) DEFAULT NULL,
  `user_sex` int(11) DEFAULT NULL,
  `user_birthday` date DEFAULT NULL,
  `ID` varchar(19) NOT NULL,
  `is_valid` tinyint(1) NOT NULL,
  PRIMARY KEY (`user_tel`),
  KEY `role_id_user` (`role_id`),
  KEY `unit_id_user` (`unit_id`),
  CONSTRAINT `role_id_user` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`),
  CONSTRAINT `unit_id_user` FOREIGN KEY (`unit_id`) REFERENCES `unit` (`unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
