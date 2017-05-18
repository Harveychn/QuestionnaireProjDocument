/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50711
Source Host           : localhost:3306
Source Database       : questionnaire

Target Server Type    : MYSQL
Target Server Version : 50711
File Encoding         : 65001

Date: 2017-04-18 08:19:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for answer
-- ----------------------------
DROP TABLE IF EXISTS `answer`;
CREATE TABLE `answer` (
  `answer_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `question_id` bigint(20) DEFAULT NULL,
  `answer_string` text NOT NULL,
  PRIMARY KEY (`answer_id`),
  KEY `FK_question_id` (`question_id`),
  CONSTRAINT `FK_question_id` FOREIGN KEY (`question_id`) REFERENCES `question` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='描述问题的答案信息';

-- ----------------------------
-- Records of answer
-- ----------------------------
INSERT INTO `answer` VALUES ('0', null, 'test');

-- ----------------------------
-- Table structure for answer_paper
-- ----------------------------
DROP TABLE IF EXISTS `answer_paper`;
CREATE TABLE `answer_paper` (
  `answer_paper_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `questionnaire_id` bigint(20) DEFAULT NULL,
  `mission_id` bigint(20) DEFAULT NULL,
  `longitude` decimal(10,6) DEFAULT NULL,
  `latitude` decimal(10,6) DEFAULT NULL,
  PRIMARY KEY (`answer_paper_id`),
  KEY `FK_answer_paper_questionnaire_id` (`questionnaire_id`),
  KEY `FK_answer_paper_mission_id` (`mission_id`),
  CONSTRAINT `FK_answer_paper_mission_id` FOREIGN KEY (`mission_id`) REFERENCES `research_mission` (`mission_id`),
  CONSTRAINT `FK_answer_paper_questionnaire_id` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaire` (`questionnaire_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='描述某次任务某张问卷的解答信息';

-- ----------------------------
-- Records of answer_paper
-- ----------------------------

-- ----------------------------
-- Table structure for mapping_answer_paper_answer
-- ----------------------------
DROP TABLE IF EXISTS `mapping_answer_paper_answer`;
CREATE TABLE `mapping_answer_paper_answer` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `answer_id` bigint(20) DEFAULT NULL,
  `answer_paper_id` bigint(20) DEFAULT NULL,
  `answer_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`record_id`),
  KEY `FK_answer_paper_id` (`answer_paper_id`),
  KEY `FK_answer_paper_answer_id` (`answer_id`),
  CONSTRAINT `FK_answer_paper_answer_id` FOREIGN KEY (`answer_id`) REFERENCES `answer` (`answer_id`),
  CONSTRAINT `FK_answer_paper_id` FOREIGN KEY (`answer_paper_id`) REFERENCES `answer_paper` (`answer_paper_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='描述答卷与题目对应关系';

-- ----------------------------
-- Records of mapping_answer_paper_answer
-- ----------------------------

-- ----------------------------
-- Table structure for mapping_mission_questionnaire
-- ----------------------------
DROP TABLE IF EXISTS `mapping_mission_questionnaire`;
CREATE TABLE `mapping_mission_questionnaire` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mission_id` bigint(20) DEFAULT NULL,
  `questionnaire_id` bigint(20) DEFAULT NULL,
  `min_submit_count` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_mapping_questionnaire_mission_id` (`mission_id`),
  KEY `FK_mapping_mission_questionnaire_id` (`questionnaire_id`),
  CONSTRAINT `FK_mapping_mission_questionnaire_id` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaire` (`questionnaire_id`),
  CONSTRAINT `FK_mapping_questionnaire_mission_id` FOREIGN KEY (`mission_id`) REFERENCES `research_mission` (`mission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务的每一份问卷完成量信息';

-- ----------------------------
-- Records of mapping_mission_questionnaire
-- ----------------------------

-- ----------------------------
-- Table structure for mapping_mission_role
-- ----------------------------
DROP TABLE IF EXISTS `mapping_mission_role`;
CREATE TABLE `mapping_mission_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL,
  `mission_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_mapping_mission_role_id` (`role_id`),
  KEY `FK_mapping_mission_id` (`mission_id`),
  CONSTRAINT `FK_mapping_mission_id` FOREIGN KEY (`mission_id`) REFERENCES `research_mission` (`mission_id`),
  CONSTRAINT `FK_mapping_mission_role_id` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='描述任务由什么角色的人员来完成';

-- ----------------------------
-- Records of mapping_mission_role
-- ----------------------------

-- ----------------------------
-- Table structure for mapping_mission_unit
-- ----------------------------
DROP TABLE IF EXISTS `mapping_mission_unit`;
CREATE TABLE `mapping_mission_unit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mission_id` bigint(20) DEFAULT NULL,
  `unit_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_mapping_mission__id` (`mission_id`),
  KEY `FK_mapping_mission_unit_id` (`unit_id`),
  CONSTRAINT `FK_mapping_mission__id` FOREIGN KEY (`mission_id`) REFERENCES `research_mission` (`mission_id`),
  CONSTRAINT `FK_mapping_mission_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `unit` (`unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='描述任务由那些单位来完成';

-- ----------------------------
-- Records of mapping_mission_unit
-- ----------------------------

-- ----------------------------
-- Table structure for mapping_notice_role
-- ----------------------------
DROP TABLE IF EXISTS `mapping_notice_role`;
CREATE TABLE `mapping_notice_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL,
  `notice_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_mapping_notice_role_id` (`role_id`),
  KEY `FK_mapping_notice_notice_id` (`notice_id`),
  CONSTRAINT `FK_mapping_notice_notice_id` FOREIGN KEY (`notice_id`) REFERENCES `notice` (`notice_id`),
  CONSTRAINT `FK_mapping_notice_role_id` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='描述公告由什么角色的人员来完成';

-- ----------------------------
-- Records of mapping_notice_role
-- ----------------------------

-- ----------------------------
-- Table structure for mapping_notice_unit
-- ----------------------------
DROP TABLE IF EXISTS `mapping_notice_unit`;
CREATE TABLE `mapping_notice_unit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `unit_id` bigint(20) DEFAULT NULL,
  `notice_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_mapping_notice_unit_id` (`unit_id`),
  KEY `FK_mapping_notice_id` (`notice_id`),
  CONSTRAINT `FK_mapping_notice_id` FOREIGN KEY (`notice_id`) REFERENCES `notice` (`notice_id`),
  CONSTRAINT `FK_mapping_notice_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `unit` (`unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='描述公告由那些单位来完成';

-- ----------------------------
-- Records of mapping_notice_unit
-- ----------------------------

-- ----------------------------
-- Table structure for mapping_questionnaire_question
-- ----------------------------
DROP TABLE IF EXISTS `mapping_questionnaire_question`;
CREATE TABLE `mapping_questionnaire_question` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `question_id` bigint(20) DEFAULT NULL,
  `questionnaire_id` bigint(20) DEFAULT NULL,
  `question_order` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_mapping_questionnaire_question_id` (`question_id`),
  KEY `FK_mapping_questionnaire_id` (`questionnaire_id`),
  CONSTRAINT `FK_mapping_questionnaire_id` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaire` (`questionnaire_id`),
  CONSTRAINT `FK_mapping_questionnaire_question_id` FOREIGN KEY (`question_id`) REFERENCES `question` (`question_id`)
) ENGINE=InnoDB AUTO_INCREMENT=197 DEFAULT CHARSET=utf8 COMMENT='描述组成问卷的题目对应关系';

-- ----------------------------
-- Records of mapping_questionnaire_question
-- ----------------------------
INSERT INTO `mapping_questionnaire_question` VALUES ('143', '90', '41', '0');
INSERT INTO `mapping_questionnaire_question` VALUES ('144', '91', '41', '1');
INSERT INTO `mapping_questionnaire_question` VALUES ('145', '92', '41', '2');
INSERT INTO `mapping_questionnaire_question` VALUES ('146', '90', '42', '0');
INSERT INTO `mapping_questionnaire_question` VALUES ('147', '91', '42', '1');
INSERT INTO `mapping_questionnaire_question` VALUES ('148', '92', '42', '2');
INSERT INTO `mapping_questionnaire_question` VALUES ('149', '93', '43', '0');
INSERT INTO `mapping_questionnaire_question` VALUES ('150', '94', '43', '1');
INSERT INTO `mapping_questionnaire_question` VALUES ('151', '95', '43', '2');
INSERT INTO `mapping_questionnaire_question` VALUES ('152', '93', '44', '0');
INSERT INTO `mapping_questionnaire_question` VALUES ('153', '94', '44', '1');
INSERT INTO `mapping_questionnaire_question` VALUES ('154', '95', '44', '2');
INSERT INTO `mapping_questionnaire_question` VALUES ('155', '93', '45', '0');
INSERT INTO `mapping_questionnaire_question` VALUES ('156', '94', '45', '1');
INSERT INTO `mapping_questionnaire_question` VALUES ('157', '95', '45', '2');
INSERT INTO `mapping_questionnaire_question` VALUES ('158', '93', '46', '0');
INSERT INTO `mapping_questionnaire_question` VALUES ('159', '94', '46', '1');
INSERT INTO `mapping_questionnaire_question` VALUES ('160', '95', '46', '2');
INSERT INTO `mapping_questionnaire_question` VALUES ('161', '93', '47', '0');
INSERT INTO `mapping_questionnaire_question` VALUES ('162', '94', '47', '1');
INSERT INTO `mapping_questionnaire_question` VALUES ('163', '95', '47', '2');
INSERT INTO `mapping_questionnaire_question` VALUES ('164', '93', '48', '0');
INSERT INTO `mapping_questionnaire_question` VALUES ('165', '94', '48', '1');
INSERT INTO `mapping_questionnaire_question` VALUES ('166', '95', '48', '2');
INSERT INTO `mapping_questionnaire_question` VALUES ('167', '93', '49', '0');
INSERT INTO `mapping_questionnaire_question` VALUES ('168', '94', '49', '1');
INSERT INTO `mapping_questionnaire_question` VALUES ('169', '95', '49', '2');
INSERT INTO `mapping_questionnaire_question` VALUES ('170', '90', '50', '0');
INSERT INTO `mapping_questionnaire_question` VALUES ('171', '91', '50', '1');
INSERT INTO `mapping_questionnaire_question` VALUES ('172', '92', '50', '2');
INSERT INTO `mapping_questionnaire_question` VALUES ('173', '90', '51', '0');
INSERT INTO `mapping_questionnaire_question` VALUES ('174', '91', '51', '1');
INSERT INTO `mapping_questionnaire_question` VALUES ('175', '92', '51', '2');
INSERT INTO `mapping_questionnaire_question` VALUES ('176', '96', '52', '0');
INSERT INTO `mapping_questionnaire_question` VALUES ('177', '97', '52', '1');
INSERT INTO `mapping_questionnaire_question` VALUES ('178', '98', '52', '2');
INSERT INTO `mapping_questionnaire_question` VALUES ('179', '99', '53', '0');
INSERT INTO `mapping_questionnaire_question` VALUES ('180', '100', '53', '1');
INSERT INTO `mapping_questionnaire_question` VALUES ('181', '101', '53', '2');
INSERT INTO `mapping_questionnaire_question` VALUES ('182', '102', '53', '3');
INSERT INTO `mapping_questionnaire_question` VALUES ('183', '103', '53', '4');
INSERT INTO `mapping_questionnaire_question` VALUES ('184', '104', '56', '0');
INSERT INTO `mapping_questionnaire_question` VALUES ('185', '105', '57', '0');
INSERT INTO `mapping_questionnaire_question` VALUES ('186', '106', '57', '1');
INSERT INTO `mapping_questionnaire_question` VALUES ('187', '107', '57', '2');
INSERT INTO `mapping_questionnaire_question` VALUES ('188', '108', '58', '0');
INSERT INTO `mapping_questionnaire_question` VALUES ('189', '109', '59', '0');
INSERT INTO `mapping_questionnaire_question` VALUES ('190', '110', '59', '1');
INSERT INTO `mapping_questionnaire_question` VALUES ('191', '111', '60', '0');
INSERT INTO `mapping_questionnaire_question` VALUES ('192', '112', '60', '1');
INSERT INTO `mapping_questionnaire_question` VALUES ('193', '113', '61', '0');
INSERT INTO `mapping_questionnaire_question` VALUES ('194', '114', '62', '0');
INSERT INTO `mapping_questionnaire_question` VALUES ('195', '115', '62', '1');
INSERT INTO `mapping_questionnaire_question` VALUES ('196', '116', '62', '2');

-- ----------------------------
-- Table structure for mapping_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `mapping_role_permission`;
CREATE TABLE `mapping_role_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NOT NULL,
  `permission_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_permission_id` (`permission_id`),
  KEY `FK_role_id` (`role_id`),
  CONSTRAINT `FK_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`permission_id`),
  CONSTRAINT `FK_role_id` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='描述角色权限之间的对应关系';

-- ----------------------------
-- Records of mapping_role_permission
-- ----------------------------
INSERT INTO `mapping_role_permission` VALUES ('2', '1', '1');
INSERT INTO `mapping_role_permission` VALUES ('3', '1', '2');
INSERT INTO `mapping_role_permission` VALUES ('4', '3', '5');
INSERT INTO `mapping_role_permission` VALUES ('5', '2', '1');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='描述公告相关信息';

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='系统用户可以拥有的权限信息';

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES ('1', '创建问卷');
INSERT INTO `permission` VALUES ('2', '发布问卷');
INSERT INTO `permission` VALUES ('3', '新建调查员');
INSERT INTO `permission` VALUES ('4', '新建疾控中心管理员');
INSERT INTO `permission` VALUES ('5', '创建公告');
INSERT INTO `permission` VALUES ('6', '删除公告');
INSERT INTO `permission` VALUES ('7', '删除调查员');
INSERT INTO `permission` VALUES ('8', '删除疾控中心管理员');
INSERT INTO `permission` VALUES ('9', '更改密码');

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question` (
  `question_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `option_id` bigint(20) DEFAULT NULL,
  `question_context` text,
  `question_type` varchar(3) NOT NULL,
  `question_description` varchar(1000) DEFAULT NULL,
  `is_must` tinyint(1) NOT NULL,
  PRIMARY KEY (`question_id`),
  KEY `FK_question_option_id` (`option_id`),
  CONSTRAINT `FK_question_option_id` FOREIGN KEY (`option_id`) REFERENCES `question_option` (`option_id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8 COMMENT='描述题目信息';

-- ----------------------------
-- Records of question
-- ----------------------------
INSERT INTO `question` VALUES ('90', '90', '测试题目', '1', null, '0');
INSERT INTO `question` VALUES ('91', '91', '兴趣爱好', '2', null, '0');
INSERT INTO `question` VALUES ('92', '92', '地址信息', '5', null, '1');
INSERT INTO `question` VALUES ('93', '93', 'qq1', '1', null, '0');
INSERT INTO `question` VALUES ('94', '94', '问题2', '2', null, '1');
INSERT INTO `question` VALUES ('95', '95', '题目三', '0', null, '1');
INSERT INTO `question` VALUES ('96', '96', 'qq1', '1', null, '0');
INSERT INTO `question` VALUES ('97', '97', '测试题目2', '2', null, '0');
INSERT INTO `question` VALUES ('98', '98', '测试题目3', '5', null, '0');
INSERT INTO `question` VALUES ('99', '99', '单选题目标题', '1', '0', '0');
INSERT INTO `question` VALUES ('100', '100', '多选题目标题', '2', '0', '1');
INSERT INTO `question` VALUES ('101', '101', '单选题目标题', '1', '0', '0');
INSERT INTO `question` VALUES ('102', '102', '单选题目标题', '0', '0', '1');
INSERT INTO `question` VALUES ('103', '103', '单选题目标题', '1', '0', '0');
INSERT INTO `question` VALUES ('104', '104', '单选题目标题', '1', '0', '0');
INSERT INTO `question` VALUES ('105', '105', '你的性别', '1', '0', '1');
INSERT INTO `question` VALUES ('106', '106', '兴趣爱好', '2', '0', '0');
INSERT INTO `question` VALUES ('107', '107', '年龄段', '1', '0', '0');
INSERT INTO `question` VALUES ('108', '108', '单选题目标题', '1', '0', '0');
INSERT INTO `question` VALUES ('109', '109', '单选题目标题', '1', '0', '0');
INSERT INTO `question` VALUES ('110', '110', '多选题目标题', '2', '0', '0');
INSERT INTO `question` VALUES ('111', '111', '单选题目标题', '1', '0', '0');
INSERT INTO `question` VALUES ('112', '112', '多选题目标题', '2', '0', '1');
INSERT INTO `question` VALUES ('113', '113', '填空题目标题', '4', '0', '1');
INSERT INTO `question` VALUES ('114', '114', '单选题目标题', '1', '0', '1');
INSERT INTO `question` VALUES ('115', '115', '多选题目标题', '2', '0', '0');
INSERT INTO `question` VALUES ('116', '116', '单选题目标题', '1', '0', '0');

-- ----------------------------
-- Table structure for questionnaire
-- ----------------------------
DROP TABLE IF EXISTS `questionnaire`;
CREATE TABLE `questionnaire` (
  `questionnaire_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `questionnaire_title` varchar(1000) NOT NULL,
  `questionnaire_subtitle` varchar(1000) DEFAULT NULL,
  `questionnaire_description` text,
  `is_template` tinyint(1) NOT NULL,
  `is_share` tinyint(1) NOT NULL,
  `is_visible` tinyint(1) NOT NULL,
  `is_done` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`questionnaire_id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 COMMENT='问卷基本信息';

-- ----------------------------
-- Records of questionnaire
-- ----------------------------
INSERT INTO `questionnaire` VALUES ('41', '开发测试问卷-q1', 'q1', '一分开发中的测试问卷', '1', '0', '1', '1', '0');
INSERT INTO `questionnaire` VALUES ('42', '开发测试问卷-q1', 'q1', '一分开发中的测试问卷', '1', '1', '1', '1', '0');
INSERT INTO `questionnaire` VALUES ('43', '第二份问卷', 'test', '', '0', '0', '1', '1', '0');
INSERT INTO `questionnaire` VALUES ('44', '第二份问卷', 'test', '', '1', '1', '1', '1', '0');
INSERT INTO `questionnaire` VALUES ('45', '第二份问卷', 'test', '', '1', '0', '1', '1', '0');
INSERT INTO `questionnaire` VALUES ('46', '第二份问卷', 'test', '', '1', '0', '1', '1', '0');
INSERT INTO `questionnaire` VALUES ('47', '第二份问卷', 'test', '', '1', '0', '1', '1', '0');
INSERT INTO `questionnaire` VALUES ('48', '第二份问卷', 'test', '', '1', '0', '1', '1', '0');
INSERT INTO `questionnaire` VALUES ('49', '第二份问卷', 'test', '', '1', '0', '1', '1', '0');
INSERT INTO `questionnaire` VALUES ('50', '开发测试问卷-q1', 'q1', '一分开发中的测试问卷', '1', '0', '1', '1', '0');
INSERT INTO `questionnaire` VALUES ('51', '开发测试问卷-q1', 'q1', '一分开发中的测试问卷', '1', '0', '1', '1', '0');
INSERT INTO `questionnaire` VALUES ('52', '第三份问卷', '12213', '111创建的测试问卷', '1', '0', '1', '1', '0');
INSERT INTO `questionnaire` VALUES ('53', '这里填写问卷标题', '这里填写问卷副标题', '这里填写问卷描述', '0', '0', '1', '1', '0');
INSERT INTO `questionnaire` VALUES ('54', '这里填写问卷标题', '这里填写问卷副标题', '这里填写问卷描述', '0', '0', '1', '1', '0');
INSERT INTO `questionnaire` VALUES ('55', '这里填写问卷标题', '这里填写问卷副标题', '这里填写问卷描述', '0', '0', '1', '1', '0');
INSERT INTO `questionnaire` VALUES ('56', '这里填写问卷标题', '这里填写问卷副标题', '这里填写问卷描述', '0', '0', '1', '1', '0');
INSERT INTO `questionnaire` VALUES ('57', '测试问卷-debug', '测试debug-subtitle', '问卷描述', '0', '0', '1', '0', '0');
INSERT INTO `questionnaire` VALUES ('58', '这里填写问卷标题', '这里填写问卷副标题', '这里填写问卷描述', '0', '0', '1', '1', '0');
INSERT INTO `questionnaire` VALUES ('59', '这里填写问卷标题', '这里填写问卷副标题', '这里填写问卷描述', '0', '0', '1', '1', '0');
INSERT INTO `questionnaire` VALUES ('60', '这里填写问卷标题', '这里填写问卷副标题', '这里填写问卷描述', '0', '0', '1', '1', '0');
INSERT INTO `questionnaire` VALUES ('61', '这里填写问卷标题', '这里填写问卷副标题', '这里填写问卷描述', '0', '0', '1', '1', '0');
INSERT INTO `questionnaire` VALUES ('62', '这里填写问卷标题', '这里填写问卷副标题', '这里填写问卷描述', '0', '0', '1', '0', '0');

-- ----------------------------
-- Table structure for question_option
-- ----------------------------
DROP TABLE IF EXISTS `question_option`;
CREATE TABLE `question_option` (
  `option_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `option_string` text NOT NULL,
  PRIMARY KEY (`option_id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8 COMMENT='描述问题的答项信息';

-- ----------------------------
-- Records of question_option
-- ----------------------------
INSERT INTO `question_option` VALUES ('90', 'test1||test2');
INSERT INTO `question_option` VALUES ('91', '篮球||tt||排球||跑步');
INSERT INTO `question_option` VALUES ('92', '省||市||县||区');
INSERT INTO `question_option` VALUES ('93', '20-30||23121');
INSERT INTO `question_option` VALUES ('94', '三等||地方||测试||示范点');
INSERT INTO `question_option` VALUES ('95', '省线程324323');
INSERT INTO `question_option` VALUES ('96', 'op1||op2');
INSERT INTO `question_option` VALUES ('97', 'op1||op2||op3||op4');
INSERT INTO `question_option` VALUES ('98', 'op1||op2||op3||op4');
INSERT INTO `question_option` VALUES ('99', '0||0');
INSERT INTO `question_option` VALUES ('100', '0||0');
INSERT INTO `question_option` VALUES ('101', '0||0');
INSERT INTO `question_option` VALUES ('102', '00');
INSERT INTO `question_option` VALUES ('103', '0||0');
INSERT INTO `question_option` VALUES ('104', '0||0');
INSERT INTO `question_option` VALUES ('105', '男||女');
INSERT INTO `question_option` VALUES ('106', '运动||学习||娱乐||餐饮');
INSERT INTO `question_option` VALUES ('107', '10-20||20-30');
INSERT INTO `question_option` VALUES ('108', '0||0');
INSERT INTO `question_option` VALUES ('109', '0||0');
INSERT INTO `question_option` VALUES ('110', '0||0');
INSERT INTO `question_option` VALUES ('111', '0||0');
INSERT INTO `question_option` VALUES ('112', '0||0');
INSERT INTO `question_option` VALUES ('113', '');
INSERT INTO `question_option` VALUES ('114', '0||0');
INSERT INTO `question_option` VALUES ('115', '0||0');
INSERT INTO `question_option` VALUES ('116', '0||0');

-- ----------------------------
-- Table structure for record_login
-- ----------------------------
DROP TABLE IF EXISTS `record_login`;
CREATE TABLE `record_login` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_tel` varchar(19) DEFAULT NULL,
  `last_login_date` datetime NOT NULL,
  `last_login_ip` varchar(16) NOT NULL,
  PRIMARY KEY (`record_id`),
  KEY `FK_record_user_tel` (`user_tel`),
  CONSTRAINT `FK_record_user_tel` FOREIGN KEY (`user_tel`) REFERENCES `user` (`user_tel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户登录系统相关信息';

-- ----------------------------
-- Records of record_login
-- ----------------------------

-- ----------------------------
-- Table structure for record_operate_answer_paper
-- ----------------------------
DROP TABLE IF EXISTS `record_operate_answer_paper`;
CREATE TABLE `record_operate_answer_paper` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_tel` varchar(19) DEFAULT NULL,
  `answer_paper_id` bigint(20) DEFAULT NULL,
  `action` varchar(3) NOT NULL,
  `operate_date` datetime NOT NULL,
  PRIMARY KEY (`record_id`),
  KEY `FK_record_operate_answer_paper_user_tel` (`user_tel`),
  KEY `FK_record_operate_answer_paper_id` (`answer_paper_id`),
  CONSTRAINT `FK_record_operate_answer_paper_id` FOREIGN KEY (`answer_paper_id`) REFERENCES `answer_paper` (`answer_paper_id`),
  CONSTRAINT `FK_record_operate_answer_paper_user_tel` FOREIGN KEY (`user_tel`) REFERENCES `user` (`user_tel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='描述用户操作答卷的记录信息，包括提交问卷信息';

-- ----------------------------
-- Records of record_operate_answer_paper
-- ----------------------------

-- ----------------------------
-- Table structure for record_operate_mission
-- ----------------------------
DROP TABLE IF EXISTS `record_operate_mission`;
CREATE TABLE `record_operate_mission` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_tel` varchar(19) DEFAULT NULL,
  `mission_id` bigint(20) DEFAULT NULL,
  `action` varchar(3) NOT NULL,
  `operate_date` datetime NOT NULL,
  PRIMARY KEY (`record_id`),
  KEY `FK_record_operate_mission_user_tel` (`user_tel`),
  KEY `FK_record_operate_mission_id` (`mission_id`),
  CONSTRAINT `FK_record_operate_mission_id` FOREIGN KEY (`mission_id`) REFERENCES `research_mission` (`mission_id`),
  CONSTRAINT `FK_record_operate_mission_user_tel` FOREIGN KEY (`user_tel`) REFERENCES `user` (`user_tel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='描述用户操作任务的记录信息';

-- ----------------------------
-- Records of record_operate_mission
-- ----------------------------

-- ----------------------------
-- Table structure for record_operate_notice
-- ----------------------------
DROP TABLE IF EXISTS `record_operate_notice`;
CREATE TABLE `record_operate_notice` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_tel` varchar(19) DEFAULT NULL,
  `notice_id` bigint(20) DEFAULT NULL,
  `action` varchar(3) NOT NULL,
  `operate_date` datetime NOT NULL,
  PRIMARY KEY (`record_id`),
  KEY `FK_record_notice_id` (`notice_id`),
  KEY `FK_record_notice_user_tel` (`user_tel`),
  CONSTRAINT `FK_record_notice_id` FOREIGN KEY (`notice_id`) REFERENCES `notice` (`notice_id`),
  CONSTRAINT `FK_record_notice_user_tel` FOREIGN KEY (`user_tel`) REFERENCES `user` (`user_tel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记录用户操作公告的相关信息';

-- ----------------------------
-- Records of record_operate_notice
-- ----------------------------

-- ----------------------------
-- Table structure for record_operate_questionnaire
-- ----------------------------
DROP TABLE IF EXISTS `record_operate_questionnaire`;
CREATE TABLE `record_operate_questionnaire` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `questionnaire_id` bigint(20) DEFAULT NULL,
  `user_tel` varchar(19) DEFAULT NULL,
  `action` varchar(3) NOT NULL,
  `operate_date` datetime NOT NULL,
  PRIMARY KEY (`record_id`),
  KEY `FK_record_operate_questionnaire_id` (`questionnaire_id`),
  KEY `FK_record_operate_questionnaire_user_tel` (`user_tel`),
  CONSTRAINT `FK_record_operate_questionnaire_id` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaire` (`questionnaire_id`),
  CONSTRAINT `FK_record_operate_questionnaire_user_tel` FOREIGN KEY (`user_tel`) REFERENCES `user` (`user_tel`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 COMMENT='描述用户操作问卷的记录信息';

-- ----------------------------
-- Records of record_operate_questionnaire
-- ----------------------------
INSERT INTO `record_operate_questionnaire` VALUES ('29', '41', '17764591959', '1', '2017-04-07 14:06:06');
INSERT INTO `record_operate_questionnaire` VALUES ('30', '42', '17764591959', '7', '2017-04-07 14:06:17');
INSERT INTO `record_operate_questionnaire` VALUES ('31', '41', '17764591959', '8', '2017-04-07 14:06:17');
INSERT INTO `record_operate_questionnaire` VALUES ('32', '43', '17764591959', '1', '2017-04-07 14:07:38');
INSERT INTO `record_operate_questionnaire` VALUES ('33', '44', '17764591959', '7', '2017-04-07 14:07:44');
INSERT INTO `record_operate_questionnaire` VALUES ('34', '43', '17764591959', '8', '2017-04-07 14:07:44');
INSERT INTO `record_operate_questionnaire` VALUES ('35', '45', '17764591959', '9', '2017-04-07 14:14:47');
INSERT INTO `record_operate_questionnaire` VALUES ('36', '44', '17764591959', '10', '2017-04-07 14:14:47');
INSERT INTO `record_operate_questionnaire` VALUES ('37', '46', '17764591959', '9', '2017-04-07 14:37:41');
INSERT INTO `record_operate_questionnaire` VALUES ('38', '44', '17764591959', '10', '2017-04-07 14:37:41');
INSERT INTO `record_operate_questionnaire` VALUES ('39', '47', '17764591959', '9', '2017-04-07 14:50:44');
INSERT INTO `record_operate_questionnaire` VALUES ('40', '44', '17764591959', '10', '2017-04-07 14:50:44');
INSERT INTO `record_operate_questionnaire` VALUES ('41', '48', '17764591959', '9', '2017-04-07 14:59:42');
INSERT INTO `record_operate_questionnaire` VALUES ('42', '44', '17764591959', '10', '2017-04-07 14:59:42');
INSERT INTO `record_operate_questionnaire` VALUES ('43', '49', '17764591959', '9', '2017-04-07 15:01:14');
INSERT INTO `record_operate_questionnaire` VALUES ('44', '44', '17764591959', '10', '2017-04-07 15:01:14');
INSERT INTO `record_operate_questionnaire` VALUES ('45', '50', '17764591959', '9', '2017-04-07 15:26:28');
INSERT INTO `record_operate_questionnaire` VALUES ('47', '51', '17764591959', '9', '2017-04-07 15:36:12');
INSERT INTO `record_operate_questionnaire` VALUES ('48', '42', '17764591959', '10', '2017-04-07 15:36:12');
INSERT INTO `record_operate_questionnaire` VALUES ('49', '41', '17764591959', '5', '2017-04-08 14:49:51');
INSERT INTO `record_operate_questionnaire` VALUES ('50', '52', '17764591959', '1', '2017-04-08 15:09:07');
INSERT INTO `record_operate_questionnaire` VALUES ('51', '52', '17764591959', '5', '2017-04-08 15:09:17');
INSERT INTO `record_operate_questionnaire` VALUES ('52', '53', '17764591959', '1', '2017-04-11 23:03:09');
INSERT INTO `record_operate_questionnaire` VALUES ('53', '54', '17764591959', '1', '2017-04-11 23:24:44');
INSERT INTO `record_operate_questionnaire` VALUES ('54', '55', '17764591959', '1', '2017-04-11 23:26:38');
INSERT INTO `record_operate_questionnaire` VALUES ('55', '56', '17764591959', '1', '2017-04-12 08:33:09');
INSERT INTO `record_operate_questionnaire` VALUES ('56', '57', '17764591959', '1', '2017-04-12 09:29:06');
INSERT INTO `record_operate_questionnaire` VALUES ('57', '58', null, '1', '2017-04-12 13:21:00');
INSERT INTO `record_operate_questionnaire` VALUES ('58', '59', '17764591959', '1', '2017-04-12 13:26:27');
INSERT INTO `record_operate_questionnaire` VALUES ('59', '60', '17764591959', '1', '2017-04-12 13:28:39');
INSERT INTO `record_operate_questionnaire` VALUES ('60', '61', '17764591959', '1', '2017-04-12 13:33:11');
INSERT INTO `record_operate_questionnaire` VALUES ('61', '62', '17764591959', '1', '2017-04-16 10:59:55');

-- ----------------------------
-- Table structure for research_mission
-- ----------------------------
DROP TABLE IF EXISTS `research_mission`;
CREATE TABLE `research_mission` (
  `mission_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mission_description` text NOT NULL,
  `mission_final_date` datetime NOT NULL,
  PRIMARY KEY (`mission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='描述调查任务的相关信息';

-- ----------------------------
-- Records of research_mission
-- ----------------------------

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role` varchar(500) NOT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='系统中用户拥有的角色信息';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '系统管理员');
INSERT INTO `role` VALUES ('2', '疾控中心管理员');
INSERT INTO `role` VALUES ('3', '调查员');

-- ----------------------------
-- Table structure for unit
-- ----------------------------
DROP TABLE IF EXISTS `unit`;
CREATE TABLE `unit` (
  `unit_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(500) NOT NULL,
  `unit_code` varchar(50) NOT NULL,
  `unit_level` varchar(50) DEFAULT NULL,
  `unit_province` varchar(500) DEFAULT NULL,
  `unit_city` varchar(500) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`unit_id`),
  UNIQUE KEY `unit_code` (`unit_code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='单位信息';

-- ----------------------------
-- Records of unit
-- ----------------------------
INSERT INTO `unit` VALUES ('1', '杭州电子科技大学', '01', '0', '浙江省', '杭州市', '高教园区杭州电子科技大学');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_tel` varchar(19) NOT NULL,
  `role_id` bigint(20) DEFAULT NULL,
  `unit_id` bigint(20) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `user_real_name` varchar(255) NOT NULL,
  `mail_address` varchar(50) DEFAULT NULL,
  `user_pic_url` varchar(255) DEFAULT NULL,
  `user_sex` int(11) DEFAULT NULL,
  `user_birthday` date DEFAULT NULL,
  `ID` varchar(19) DEFAULT NULL,
  `is_valid` tinyint(1) NOT NULL,
  `last_login_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `last_login_ip` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_tel`),
  KEY `FK_user_role_id` (`role_id`),
  KEY `FK_user_unit_id` (`unit_id`),
  CONSTRAINT `FK_user_role_id` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`),
  CONSTRAINT `FK_user_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `unit` (`unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('11111111111', '2', '1', 'e2d4950a7b903bf17a3b75d1af991a2e', 'admin', '980278090@qq.com', null, '1', '2017-03-26', '111', '1', null, null);
INSERT INTO `user` VALUES ('17764591959', '2', '1', '1dbfdc311858432fe007d0b88472aa1b', 'admin', '980278090@qq.com', null, '1', '2017-03-26', '111', '1', null, null);
SET FOREIGN_KEY_CHECKS=1;
