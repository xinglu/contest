-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- 服务器版本: 5.1.29
-- PHP 版本: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a'); 

CREATE TABLE IF NOT EXISTS `t_school` (
  `schoolId` int(11) NOT NULL AUTO_INCREMENT COMMENT '学校id',
  `schoolName` varchar(20)  NOT NULL COMMENT '学校名称',
  PRIMARY KEY (`schoolId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_project` (
  `projectId` int(11) NOT NULL AUTO_INCREMENT COMMENT '项目id',
  `projectName` varchar(20)  NOT NULL COMMENT '项目名称',
  `projectDesc` varchar(500)  NOT NULL COMMENT '项目介绍',
  PRIMARY KEY (`projectId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_contest` (
  `contestId` int(11) NOT NULL AUTO_INCREMENT COMMENT '比赛id',
  `schoolObj` int(11) NOT NULL COMMENT '举办学校',
  `projectObj` int(11) NOT NULL COMMENT '比赛项目',
  `contestName` varchar(80)  NOT NULL COMMENT '比赛名称',
  `contestDesc` varchar(5000)  NOT NULL COMMENT '比赛介绍',
  `contestPlace` varchar(50)  NOT NULL COMMENT '比赛地点',
  `personNumber` int(11) NOT NULL COMMENT '人数限制',
  `signUpTime` varchar(20)  NULL COMMENT '报名时间',
  `endTime` varchar(20)  NULL COMMENT '截止时间',
  PRIMARY KEY (`contestId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_student` (
  `user_name` varchar(30)  NOT NULL COMMENT 'user_name',
  `password` varchar(30)  NOT NULL COMMENT '登录密码',
  `contest` int(11) NOT NULL COMMENT '报名比赛',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `gender` varchar(4)  NOT NULL COMMENT '性别',
  `birthDate` varchar(20)  NULL COMMENT '出生日期',
  `userPhoto` varchar(60)  NOT NULL COMMENT '用户照片',
  `telephone` varchar(20)  NOT NULL COMMENT '联系电话',
  `address` varchar(80)  NULL COMMENT '家庭地址',
  `signUpTime` varchar(20)  NULL COMMENT '报名时间',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_score` (
  `scoreId` int(11) NOT NULL AUTO_INCREMENT COMMENT '成绩id',
  `contestObj` int(11) NOT NULL COMMENT '比赛名称',
  `studentObj` varchar(30)  NOT NULL COMMENT '学生',
  `contentRound` varchar(20)  NOT NULL COMMENT '比赛轮次',
  `scoreValue` float NOT NULL COMMENT '比赛积分',
  PRIMARY KEY (`scoreId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_notice` (
  `noticeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告id',
  `title` varchar(80)  NOT NULL COMMENT '标题',
  `content` varchar(5000)  NOT NULL COMMENT '公告内容',
  `publishDate` varchar(20)  NULL COMMENT '发布时间',
  PRIMARY KEY (`noticeId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE t_contest ADD CONSTRAINT FOREIGN KEY (schoolObj) REFERENCES t_school(schoolId);
ALTER TABLE t_contest ADD CONSTRAINT FOREIGN KEY (projectObj) REFERENCES t_project(projectId);
ALTER TABLE t_student ADD CONSTRAINT FOREIGN KEY (contest) REFERENCES t_contest(contestId);
ALTER TABLE t_score ADD CONSTRAINT FOREIGN KEY (contestObj) REFERENCES t_contest(contestId);
ALTER TABLE t_score ADD CONSTRAINT FOREIGN KEY (studentObj) REFERENCES t_student(user_name);


