-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- �������汾: 5.1.29
-- PHP �汾: 5.2.6

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
  `schoolId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ѧУid',
  `schoolName` varchar(20)  NOT NULL COMMENT 'ѧУ����',
  PRIMARY KEY (`schoolId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_project` (
  `projectId` int(11) NOT NULL AUTO_INCREMENT COMMENT '��Ŀid',
  `projectName` varchar(20)  NOT NULL COMMENT '��Ŀ����',
  `projectDesc` varchar(500)  NOT NULL COMMENT '��Ŀ����',
  PRIMARY KEY (`projectId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_contest` (
  `contestId` int(11) NOT NULL AUTO_INCREMENT COMMENT '����id',
  `schoolObj` int(11) NOT NULL COMMENT '�ٰ�ѧУ',
  `projectObj` int(11) NOT NULL COMMENT '������Ŀ',
  `contestName` varchar(80)  NOT NULL COMMENT '��������',
  `contestDesc` varchar(5000)  NOT NULL COMMENT '��������',
  `contestPlace` varchar(50)  NOT NULL COMMENT '�����ص�',
  `personNumber` int(11) NOT NULL COMMENT '��������',
  `signUpTime` varchar(20)  NULL COMMENT '����ʱ��',
  `endTime` varchar(20)  NULL COMMENT '��ֹʱ��',
  PRIMARY KEY (`contestId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_student` (
  `user_name` varchar(30)  NOT NULL COMMENT 'user_name',
  `password` varchar(30)  NOT NULL COMMENT '��¼����',
  `contest` int(11) NOT NULL COMMENT '��������',
  `name` varchar(20)  NOT NULL COMMENT '����',
  `gender` varchar(4)  NOT NULL COMMENT '�Ա�',
  `birthDate` varchar(20)  NULL COMMENT '��������',
  `userPhoto` varchar(60)  NOT NULL COMMENT '�û���Ƭ',
  `telephone` varchar(20)  NOT NULL COMMENT '��ϵ�绰',
  `address` varchar(80)  NULL COMMENT '��ͥ��ַ',
  `signUpTime` varchar(20)  NULL COMMENT '����ʱ��',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_score` (
  `scoreId` int(11) NOT NULL AUTO_INCREMENT COMMENT '�ɼ�id',
  `contestObj` int(11) NOT NULL COMMENT '��������',
  `studentObj` varchar(30)  NOT NULL COMMENT 'ѧ��',
  `contentRound` varchar(20)  NOT NULL COMMENT '�����ִ�',
  `scoreValue` float NOT NULL COMMENT '��������',
  PRIMARY KEY (`scoreId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_notice` (
  `noticeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '����id',
  `title` varchar(80)  NOT NULL COMMENT '����',
  `content` varchar(5000)  NOT NULL COMMENT '��������',
  `publishDate` varchar(20)  NULL COMMENT '����ʱ��',
  PRIMARY KEY (`noticeId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE t_contest ADD CONSTRAINT FOREIGN KEY (schoolObj) REFERENCES t_school(schoolId);
ALTER TABLE t_contest ADD CONSTRAINT FOREIGN KEY (projectObj) REFERENCES t_project(projectId);
ALTER TABLE t_student ADD CONSTRAINT FOREIGN KEY (contest) REFERENCES t_contest(contestId);
ALTER TABLE t_score ADD CONSTRAINT FOREIGN KEY (contestObj) REFERENCES t_contest(contestId);
ALTER TABLE t_score ADD CONSTRAINT FOREIGN KEY (studentObj) REFERENCES t_student(user_name);


