/*
 Navicat Premium Data Transfer

 Source Server         : Vic
 Source Server Type    : MySQL
 Source Server Version : 80031
 Source Host           : localhost:3306
 Source Schema         : myfourm

 Target Server Type    : MySQL
 Target Server Version : 80031
 File Encoding         : 65001

 Date: 20/06/2023 11:09:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for clientinfo
-- ----------------------------
DROP TABLE IF EXISTS `clientinfo`;
CREATE TABLE `clientinfo`  (
  `clientCode` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `clientName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `clientAreaId` int(0) NOT NULL DEFAULT 1,
  `clientCustId` int(0) NOT NULL,
  `clientLevelId` int(0) NOT NULL DEFAULT 1,
  `clientContentment` int(0) NOT NULL DEFAULT 3,
  `clientCredit` int(0) UNSIGNED NOT NULL DEFAULT 3,
  `clientAddress` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '暂无',
  `clientDakCode` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '暂无',
  `clientTel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '暂无',
  `clientFax` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '暂无',
  `clientNet` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '暂无',
  `clientCharter` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `clientCorporation` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '暂无',
  `clientBankroll` int(0) NULL DEFAULT NULL,
  `clientTurnoverYear` int(0) NULL DEFAULT NULL,
  `clientBank` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '暂无',
  `clientAccounts` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '暂无',
  `clientNativeTax` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `clientCountryTax` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `clientState` int(0) NOT NULL DEFAULT 1,
  `clientLoseReason` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `clientLoseDate` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`clientCode`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of clientinfo
-- ----------------------------

-- ----------------------------
-- Table structure for clientlinkman
-- ----------------------------
DROP TABLE IF EXISTS `clientlinkman`;
CREATE TABLE `clientlinkman`  (
  `clientLinkmanId` int(0) NOT NULL AUTO_INCREMENT,
  `clientLinkmanName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `clientLinkmanSex` int(0) NOT NULL,
  `clientLinkmanJob` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `clientLinkmanTel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `clientLinkmanMobile` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `remark` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `clientCode` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`clientLinkmanId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of clientlinkman
-- ----------------------------

-- ----------------------------
-- Table structure for clientreprievelose
-- ----------------------------
DROP TABLE IF EXISTS `clientreprievelose`;
CREATE TABLE `clientreprievelose`  (
  `clientReprieveLoseId` int(0) NOT NULL AUTO_INCREMENT,
  `reprieveStep` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `clientCode` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`clientReprieveLoseId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of clientreprievelose
-- ----------------------------

-- ----------------------------
-- Table structure for clientserver
-- ----------------------------
DROP TABLE IF EXISTS `clientserver`;
CREATE TABLE `clientserver`  (
  `serverId` int(0) NOT NULL AUTO_INCREMENT,
  `serverTypeId` int(0) NOT NULL,
  `serverTitle` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `clientCode` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `serverStatus` int(0) NOT NULL DEFAULT 1,
  `serverContent` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `serverCreateId` int(0) NOT NULL,
  `serverCreateDate` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `serverDueId` int(0) NOT NULL DEFAULT 0,
  `serverDueDate` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `serverProcessing` varchar(600) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `processingDate` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `processingResult` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `clientContentment` int(0) NOT NULL DEFAULT 1,
  PRIMARY KEY (`serverId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 64 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of clientserver
-- ----------------------------
INSERT INTO `clientserver` VALUES (1, 1, '咨询', 'KH150210001', 4, '服务请求的内容', 2, '2015-02-12', 3, '2015-02-14', '服务处理内容', '2015-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (2, 1, '咨询', 'KH150210001', 4, '服务请求的内容', 2, '2015-02-12', 3, '2015-02-14', '服务处理内容', '2015-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (3, 1, '咨询', 'KH150210001', 4, '服务请求的内容', 2, '2015-02-12', 3, '2015-02-14', '服务处理内容', '2015-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (4, 2, '投诉', 'KH150210001', 4, '服务请求的内容', 2, '2015-02-12', 3, '2015-02-14', '服务处理内容', '2015-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (5, 2, '投诉', 'KH150210001', 4, '服务请求的内容', 2, '2015-02-12', 3, '2015-02-14', '服务处理内容', '2015-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (6, 2, '投诉', 'KH150210001', 4, '服务请求的内容', 2, '2015-02-12', 3, '2015-02-14', '服务处理内容', '2015-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (7, 3, '建议', 'KH150210001', 4, '服务请求的内容', 2, '2015-02-12', 3, '2015-02-14', '服务处理内容', '2015-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (8, 3, '建议', 'KH150210001', 4, '服务请求的内容', 2, '2015-02-12', 3, '2015-02-14', '服务处理内容', '2015-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (9, 3, '建议', 'KH150210001', 4, '服务请求的内容', 2, '2015-02-12', 3, '2015-02-14', '服务处理内容', '2015-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (10, 3, '建议', 'KH150210001', 4, '服务请求的内容', 2, '2015-02-12', 3, '2015-02-14', '服务处理内容', '2015-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (11, 3, '建议', 'KH150210001', 4, '服务请求的内容', 2, '2015-02-12', 3, '2015-02-14', '服务处理内容', '2015-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (12, 1, '咨询', 'KH160210001', 4, '服务请求的内容', 2, '2016-02-12', 3, '2016-02-14', '服务处理内容', '2016-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (13, 1, '咨询', 'KH160210001', 4, '服务请求的内容', 2, '2016-02-12', 3, '2016-02-14', '服务处理内容', '2016-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (14, 2, '投诉', 'KH160210001', 4, '服务请求的内容', 2, '2016-02-12', 3, '2016-02-14', '服务处理内容', '2016-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (15, 2, '投诉', 'KH160210001', 4, '服务请求的内容', 2, '2016-02-12', 3, '2016-02-14', '服务处理内容', '2016-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (16, 2, '投诉', 'KH160210001', 4, '服务请求的内容', 2, '2016-02-12', 3, '2016-02-14', '服务处理内容', '2016-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (17, 3, '建议', 'KH160210001', 4, '服务请求的内容', 2, '2016-02-12', 3, '2016-02-14', '服务处理内容', '2016-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (18, 3, '建议', 'KH160210001', 4, '服务请求的内容', 2, '2016-02-12', 3, '2016-02-14', '服务处理内容', '2016-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (19, 3, '建议', 'KH160210001', 4, '服务请求的内容', 2, '2016-02-12', 3, '2016-02-14', '服务处理内容', '2016-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (20, 3, '建议', 'KH160210001', 4, '服务请求的内容', 2, '2016-02-12', 3, '2016-02-14', '服务处理内容', '2016-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (21, 3, '建议', 'KH160210001', 4, '服务请求的内容', 2, '2016-02-12', 3, '2016-02-14', '服务处理内容', '2016-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (22, 3, '建议', 'KH160210001', 4, '服务请求的内容', 2, '2016-02-12', 3, '2016-02-14', '服务处理内容', '2016-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (23, 3, '建议', 'KH160210001', 4, '服务请求的内容', 2, '2016-02-12', 3, '2016-02-14', '服务处理内容', '2016-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (24, 2, '投诉', 'KH170210001', 4, '服务请求的内容', 2, '2017-02-12', 3, '2017-02-14', '服务处理内容', '2017-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (25, 2, '投诉', 'KH170210001', 4, '服务请求的内容', 2, '2017-02-12', 3, '2017-02-14', '服务处理内容', '2017-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (26, 2, '投诉', 'KH170210001', 4, '服务请求的内容', 2, '2017-02-12', 3, '2017-02-14', '服务处理内容', '2017-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (27, 2, '投诉', 'KH170210001', 4, '服务请求的内容', 2, '2017-02-12', 3, '2017-02-14', '服务处理内容', '2017-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (28, 2, '投诉', 'KH170210001', 4, '服务请求的内容', 2, '2017-02-12', 3, '2017-02-14', '服务处理内容', '2017-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (29, 3, '建议', 'KH170210001', 4, '服务请求的内容', 2, '2017-02-12', 3, '2017-02-14', '服务处理内容', '2017-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (30, 3, '建议', 'KH170210001', 4, '服务请求的内容', 2, '2017-02-12', 3, '2017-02-14', '服务处理内容', '2017-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (31, 3, '建议', 'KH170210001', 4, '服务请求的内容', 2, '2017-02-12', 3, '2017-02-14', '服务处理内容', '2017-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (32, 3, '建议', 'KH170210001', 4, '服务请求的内容', 2, '2017-02-12', 3, '2017-02-14', '服务处理内容', '2017-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (33, 3, '建议', 'KH170210001', 4, '服务请求的内容', 2, '2017-02-12', 3, '2017-02-14', '服务处理内容', '2017-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (34, 1, '咨询', 'KH180210001', 4, '服务请求的内容', 2, '2018-02-12', 3, '2018-02-14', '服务处理内容', '2018-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (35, 1, '咨询', 'KH180210001', 4, '服务请求的内容', 2, '2018-02-12', 3, '2018-02-14', '服务处理内容', '2018-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (36, 1, '咨询', 'KH180210001', 4, '服务请求的内容', 2, '2018-02-12', 3, '2018-02-14', '服务处理内容', '2018-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (37, 2, '投诉', 'KH180210001', 4, '服务请求的内容', 2, '2018-02-12', 3, '2018-02-14', '服务处理内容', '2018-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (38, 2, '投诉', 'KH180210001', 4, '服务请求的内容', 2, '2018-02-12', 3, '2018-02-14', '服务处理内容', '2018-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (39, 2, '投诉', 'KH180210001', 4, '服务请求的内容', 2, '2018-02-12', 3, '2018-02-14', '服务处理内容', '2018-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (40, 2, '投诉', 'KH180210001', 4, '服务请求的内容', 2, '2018-02-12', 3, '2018-02-14', '服务处理内容', '2018-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (41, 2, '投诉', 'KH180210001', 4, '服务请求的内容', 2, '2018-02-12', 3, '2018-02-14', '服务处理内容', '2018-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (42, 2, '投诉', 'KH180210001', 4, '服务请求的内容', 2, '2018-02-12', 3, '2018-02-14', '服务处理内容', '2018-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (43, 3, '建议', 'KH180210001', 4, '服务请求的内容', 2, '2018-02-12', 3, '2018-02-14', '服务处理内容', '2018-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (44, 3, '建议', 'KH180210001', 4, '服务请求的内容', 2, '2018-02-12', 3, '2018-02-14', '服务处理内容', '2018-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (45, 3, '建议', 'KH180210001', 4, '服务请求的内容', 2, '2018-02-12', 3, '2018-02-14', '服务处理内容', '2018-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (46, 3, '建议', 'KH180210001', 4, '服务请求的内容', 2, '2018-02-12', 3, '2018-02-14', '服务处理内容', '2018-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (47, 3, '建议', 'KH180210001', 4, '服务请求的内容', 2, '2018-02-12', 3, '2018-02-14', '服务处理内容', '2018-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (48, 3, '建议', 'KH180210001', 4, '服务请求的内容', 2, '2018-02-12', 3, '2018-02-14', '服务处理内容', '2018-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (49, 1, '咨询', 'KH190210001', 4, '服务请求的内容', 2, '2019-02-12', 3, '2019-02-14', '服务处理内容', '2019-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (50, 1, '咨询', 'KH190210001', 4, '服务请求的内容', 2, '2019-02-12', 3, '2019-02-14', '服务处理内容', '2019-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (51, 2, '投诉', 'KH190210001', 4, '服务请求的内容', 2, '2019-02-12', 3, '2019-02-14', '服务处理内容', '2019-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (52, 2, '投诉', 'KH190210001', 4, '服务请求的内容', 2, '2019-02-12', 3, '2019-02-14', '服务处理内容', '2019-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (53, 2, '投诉', 'KH190210001', 4, '服务请求的内容', 2, '2019-02-12', 3, '2019-02-14', '服务处理内容', '2019-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (54, 2, '投诉', 'KH190210001', 4, '服务请求的内容', 2, '2019-02-12', 3, '2019-02-14', '服务处理内容', '2019-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (55, 2, '投诉', 'KH190210001', 4, '服务请求的内容', 2, '2019-02-12', 3, '2019-02-14', '服务处理内容', '2019-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (56, 2, '投诉', 'KH190210001', 4, '服务请求的内容', 2, '2019-02-12', 3, '2019-02-14', '服务处理内容', '2019-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (57, 2, '投诉', 'KH190210001', 4, '服务请求的内容', 2, '2019-02-12', 3, '2019-02-14', '服务处理内容', '2019-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (58, 3, '建议', 'KH190210001', 4, '服务请求的内容', 2, '2019-02-12', 3, '2019-02-14', '服务处理内容', '2019-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (59, 3, '建议', 'KH190210001', 4, '服务请求的内容', 2, '2019-02-12', 3, '2019-02-14', '服务处理内容', '2019-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (60, 3, '建议', 'KH190210001', 4, '服务请求的内容', 2, '2019-02-12', 3, '2019-02-14', '服务处理内容', '2019-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (61, 3, '建议', 'KH190210001', 4, '服务请求的内容', 2, '2019-02-12', 3, '2019-02-14', '服务处理内容', '2019-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (62, 3, '建议', 'KH190210001', 4, '服务请求的内容', 2, '2019-02-12', 3, '2019-02-14', '服务处理内容', '2019-02-14', '处理结果', 3);
INSERT INTO `clientserver` VALUES (63, 3, '建议', 'KH190210001', 4, '服务请求的内容', 2, '2019-02-12', 3, '2019-02-14', '服务处理内容', '2019-02-14', '处理结果', 3);

-- ----------------------------
-- Table structure for dataarea
-- ----------------------------
DROP TABLE IF EXISTS `dataarea`;
CREATE TABLE `dataarea`  (
  `daId` int(0) NOT NULL AUTO_INCREMENT,
  `daName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `delMark` int(0) NOT NULL DEFAULT 1 COMMENT '除删标记',
  PRIMARY KEY (`daId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dataarea
-- ----------------------------
INSERT INTO `dataarea` VALUES (1, '北京', 1);
INSERT INTO `dataarea` VALUES (2, '华北', 1);
INSERT INTO `dataarea` VALUES (3, '中南', 1);
INSERT INTO `dataarea` VALUES (4, '东北', 1);
INSERT INTO `dataarea` VALUES (5, '西部', 1);

-- ----------------------------
-- Table structure for dataclientlevel
-- ----------------------------
DROP TABLE IF EXISTS `dataclientlevel`;
CREATE TABLE `dataclientlevel`  (
  `dclId` int(0) NOT NULL AUTO_INCREMENT,
  `dclName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `delMark` int(0) NOT NULL DEFAULT 1 COMMENT '删除标记',
  PRIMARY KEY (`dclId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dataclientlevel
-- ----------------------------
INSERT INTO `dataclientlevel` VALUES (1, '普通客户', 1);
INSERT INTO `dataclientlevel` VALUES (2, '大客户', 1);
INSERT INTO `dataclientlevel` VALUES (3, '合作伙伴', 1);
INSERT INTO `dataclientlevel` VALUES (4, '战略合作伙伴', 1);

-- ----------------------------
-- Table structure for dataservertype
-- ----------------------------
DROP TABLE IF EXISTS `dataservertype`;
CREATE TABLE `dataservertype`  (
  `dstId` int(0) NOT NULL AUTO_INCREMENT,
  `dstName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `delMark` int(0) NOT NULL DEFAULT 1 COMMENT '删除标记',
  PRIMARY KEY (`dstId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dataservertype
-- ----------------------------
INSERT INTO `dataservertype` VALUES (1, '咨询', 1);
INSERT INTO `dataservertype` VALUES (2, '投诉', 1);
INSERT INTO `dataservertype` VALUES (3, '建议', 1);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `ordersId` int(0) NOT NULL AUTO_INCREMENT,
  `ordersDate` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ordersState` int(0) NOT NULL DEFAULT 1,
  `clientCode` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ordersTotal` int(0) NOT NULL,
  `remark` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ordersId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, '2019-02-23', 2, 'KH191023011', 500, '第一笔订单');
INSERT INTO `orders` VALUES (2, '2019-03-26', 2, 'KH191023011', 300, NULL);
INSERT INTO `orders` VALUES (3, '2019-04-14', 1, 'KH191023011', 1000, '不知道能不能回款啊！！！');
INSERT INTO `orders` VALUES (4, '2019-04-20', 2, 'KH191023009', 80, '第一笔订单');

-- ----------------------------
-- Table structure for salechance
-- ----------------------------
DROP TABLE IF EXISTS `salechance`;
CREATE TABLE `salechance`  (
  `chanceId` int(0) NOT NULL AUTO_INCREMENT COMMENT '销售机会编号',
  `chanceSource` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '机会来源',
  `chanceCustName` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '客户名称',
  `chanceTitle` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '概要',
  `chanceRate` int(0) NOT NULL COMMENT '成功机率',
  `chanceLinkman` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `chanceTel` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '联系人电话',
  `chanceDesc` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '机会描述',
  `chanceCreateId` int(0) UNSIGNED NOT NULL COMMENT '创建人编号',
  `chanceCreateDate` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '创建日期',
  `chanceDueId` int(0) NULL DEFAULT NULL COMMENT '指派人编号',
  `chanceDueDate` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '指派日期',
  `chanceStatus` int(0) NOT NULL DEFAULT 0 COMMENT '销售机会状态',
  PRIMARY KEY (`chanceId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of salechance
-- ----------------------------
INSERT INTO `salechance` VALUES (1, '朋友介绍', '华为技术有限公司', '华为云推广合作意向', 80, '张经理', '13625487589', '华为公司对我公司技术实力非常认可，合作意向浓厚，前景看好', 2, '2017-02-15', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (2, '微信', '中兴通讯股份有限公司', '通讯器材外包生产合作意向', 70, '王经理', '13547892563', '中兴通讯股份有限公司的产品做不过来，需要外包出去。', 2, '2017-02-26', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (3, '产品发布会', '海信集团有限公司', '海信VR项目技术外包意向', 75, '李经理', '13956584254', '海信感觉VR项目技术难度比较大，为规避风险，寻求外包。', 3, '2017-03-01', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (4, '朋友介绍', 'UT 斯达康通讯有限公司', 'UT项目服务器采购意向', 72, '赵经理', '024-45685215', 'UT 斯达康在选购服务器，我公司产品比较匹配。', 3, '2017-03-05', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (5, 'QQ群', '海尔集团公司', '海尔电视机顶盒采购意向', 60, '刘经理', '13526326326', '机顶盒需要一千万台，数量庞大，机会难得。', 2, '2017-03-10', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (6, '澳门赌场', '神州数码 ( 中国 ) 有限公司', '数码产品线下销售合作意向', 82, '蒋先生', '024-58526666', '数码产品线下门店预计要开一百五十万个，机会难得，且合作意向浓厚。', 4, '2017-03-13', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (7, '万国博览会', '浙大网新科技有限公司', '浙大网校在校考试系统项目', 78, '沈女士', '13958698569', '浙大网校在校考试系统项目，预计开发6个月，30人项目组。', 5, '2017-03-20', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (8, '朋友介绍', '熊猫电子集团有限公司', '熊猫牌收音机下乡活动', 99, '韩女士', '15956854755', '政府项目，必须要做好，做不好就玩完。', 2, '2017-03-22', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (9, '微信', '浪潮集团有限公司', '浪潮NMD系统控制软件开发', 60, '杨经理', '13852145569', 'NMD系统多目标跟踪控制软件部分开发项目，需要有专业军事素质人员开发。', 2, '2017-03-24', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (10, 'QQ群', '东软集团有限公司', '东软与西软的合作项目', 86, '奥巴马', '024-58978521', '北软与南软也在竞争这个项目，但我们的优势比较大。', 6, '2017-03-28', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (11, '产品发布会', '北京北大方正集团', '北大方正与南小圆歪合作项目', 66, '方小圆', '14852632563', '南小圆歪是我们近期要努力争取的客户，他们的潜力很大，前景看好。', 6, '2017-03-28', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (12, '六方会谈', '微软 ( 中国 ) 有限公司', '微软与我方共建微硬专业', 68, '比尔盖茨', '15926348753', '微硬专业是今年来最火的专业，为什么呢？因为它比微软硬。', 2, '2017-03-30', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (13, '朋友介绍', '北京中软国际信息技术有限公司', '中软国际信息合作意向', 80, '张经理', '13625487589', '中软国际信息对我公司技术实力非常认可，合作意向浓厚，前景看好', 2, '2017-02-15', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (14, '微信', '亚信科技（中国）有限公司', '亚信科技信息合作意向', 80, '张经理', '13625487589', '亚信科技对我公司技术实力非常认可，合作意向浓厚，前景看好', 6, '2017-02-15', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (15, '朋友介绍', '福州福大自动化科技有限公司', '福州福大自动化科技有限公司合作意向', 80, '王经理', '13625487589', '福州福大自动化科技有限公司对我公司技术实力非常认可，合作意向浓厚，前景看好', 2, '2017-02-15', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (16, '产品发布会', '江苏省通信服务有限公司', '江苏省通信服务有限公司合作意向', 80, '李经理', '13625487589', '江苏省通信服务有限公司对我公司技术实力非常认可，合作意向浓厚，前景看好', 5, '2017-02-15', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (17, '朋友介绍', '国电南京自动化股份有限公司', '国电南京自动化股份有限公司合作意向', 80, '迟经理', '13625487589', '国电南京自动化股份有限公司对我公司技术实力非常认可，合作意向浓厚，前景看好', 6, '2017-02-15', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (18, '微信', '大唐电信科技股份有限公司', '大唐电信科技股份有限公司合作意向', 80, '马经理', '13625487589', '大唐电信科技股份有限公司对我公司技术实力非常认可，合作意向浓厚，前景看好', 2, '2017-02-15', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (19, '朋友介绍', '广州佳都集团有限公司', '广州佳都集团有限公司合作意向', 80, '牛经理', '13625487589', '广州佳都集团有限公司对我公司技术实力非常认可，合作意向浓厚，前景看好', 2, '2017-02-15', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (20, '产品发布会', '上海宝信软件股份有限公司', '上海宝信软件股份有限公司合作意向', 80, '大经理', '13625487589', '上海宝信软件股份有限公司对我公司技术实力非常认可，合作意向浓厚，前景看好', 4, '2017-02-15', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (21, '万国博览会', '北京小米移动软件有限公司', '北京小米移动软件有限公司合作意向', 80, '小经理', '13625487589', '北京小米移动软件有限公司对我公司技术实力非常认可，合作意向浓厚，前景看好', 2, '2017-02-15', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (22, '产品发布会', '太极计算机股份有限公司', '太极计算机股份有限公司合作意向', 80, '阿经理', '13625487589', '太极计算机股份有限公司对我公司技术实力非常认可，合作意向浓厚，前景看好', 2, '2017-02-15', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (23, '微信', '上海华讯网络系统有限公司', '上海华讯网络系统有限公司合作意向', 80, '白经理', '13625487589', '上海华讯网络系统有限公司对我公司技术实力非常认可，合作意向浓厚，前景看好', 4, '2017-02-15', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (24, '朋友介绍', '中国软件与技术服务股份有限公司', '中国软件与技术服务股份有限公司合作意向', 80, '黑经理', '13625487589', '中国软件与技术服务股份有限公司对我公司技术实力非常认可，合作意向浓厚，前景看好', 3, '2017-02-15', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (25, '产品发布会', '神州数码系统集成服务有限公司', '神州数码系统集成服务有限公司合作意向', 80, '洪经理', '13625487589', '神州数码系统集成服务有限公司对我公司技术实力非常认可，合作意向浓厚，前景看好', 2, '2017-02-15', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (26, '朋微信', '中科软科技股份有限公司', '中科软科技股份有限公司合作意向', 80, '黄经理', '13625487589', '中科软科技股份有限公司对我公司技术实力非常认可，合作意向浓厚，前景看好', 5, '2017-02-15', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (27, '万国博览会', '中国民航信息网络股份有限公司', '中国民航信息网络股份有限公司合作意向', 80, '绿经理', '13625487589', '中国民航信息网络股份有限公司对我公司技术实力非常认可，合作意向浓厚，前景看好', 4, '2017-02-15', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (28, '朋友介绍', '用友网络科技股份有限公司', '用友网络科技股份有限公司合作意向', 80, '青经理', '13625487589', '用友网络科技股份有限公司对我公司技术实力非常认可，合作意向浓厚，前景看好', 2, '2017-02-15', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (29, '产品发布会', '四川省通信产业服务有限公司', '四川省通信产业服务有限公司合作意向', 80, '蓝经理', '13625487589', '四川省通信产业服务有限公司对我公司技术实力非常认可，合作意向浓厚，前景看好', 2, '2017-02-15', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (30, '微信', '上海贝尔软件有限公司', '上海贝尔软件有限公司合作意向', 80, '紫经理', '13625487589', '上海贝尔软件有限公司对我公司技术实力非常认可，合作意向浓厚，前景看好', 2, '2017-02-15', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (31, '朋友介绍', '阿里云计算有限公司', '阿里云计算有限公司合作意向', 80, '超经理', '13625487589', '阿里云计算有限公司对我公司技术实力非常认可，合作意向浓厚，前景看好', 3, '2017-02-15', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (32, '万国博览会', '石化盈科信息技术有限责任公司', '石化盈科信息技术有限责任公司合作意向', 80, '曹经理', '13625487589', '石化盈科信息技术有限责任公司对我公司技术实力非常认可，合作意向浓厚，前景看好', 2, '2017-02-15', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (33, '地摊上认识的', '拉斯特星球驻地球办事处', '与地球合作开发宇宙事宜', 60, '异形人', '024-78655786', '拉斯特星球要与地球人类合作，开发本宇宙暗物质能量事宜', 2, '2017-06-18', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (34, '邻居老大妈介绍', '宇宙联盟科技有限公司', '宇宙联盟要开战，急需我方科技', 98, '钢铁侠', '024-34236788', '宇宙联盟要与另外一个宇宙开战，急需我方科技的支持', 6, '2017-06-18', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (35, '相亲会上', '银河系安全防御理事会', '银安会向我方订购宇宙航空母舰', 70, '安德鲁先生', '15825411452', '银安会为了加强防御力量，向我方订购1亿艘宇宙航空母舰', 3, '2017-06-19', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (36, '旅游中认识', 'NGC474星系驻地球办事处', 'NGC474星系采购土豆事宜', 88, '史密斯小姐', '024-45689875', 'NGC474星系对地球土豆非常喜欢吃，此次计划采购1亿吨', 3, '2017-06-19', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (37, '微微信', 'FGH458星系驻地球办事处', 'FGH458星系采购西红柿事宜', 81, '普吉女士', '16958474785', 'FGH458星系采购西红柿，准备回去之后做汤喝！', 5, '2017-06-19', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (38, '雨中漫步中认识的', '仙女座星云开发计划办公室', '与我方共同开发仙女座星云中的氢资源', 78, '詹姆斯邦德', '18958475487', '与我方共同开发仙女座星云中的氢资源，而且非常迫切。', 2, '2017-06-24', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (39, '比武中获取的信息', '九阴白骨爪技术开发有限公司', '发掘中华武术传统技术', 89, '王大娘', '14587458745', '发掘中华武术传统技术，弘扬民族文明。', 6, '2017-06-24', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (40, '微信', '德州仪器公司', '向我方采购个人电脑一百亿台', 77, '赵女士', '02458966589', '向我方采购个人电脑一百亿台，要求附带一百亿个鼠标垫', 6, '2017-06-24', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (41, 'QQ', '西门子(SIEMENS)', '西门子急缺电池，需要两个', 85, '谭女士', '02415874125', '西门子急缺电池，需要两个。我方报价：一个一百亿，他们已经同意了。', 6, '2017-06-24', NULL, NULL, 0);
INSERT INTO `salechance` VALUES (42, '国际博览会', '美国电话电报（AT&T）', '美国电话电报（AT&T）向我方采购电池', 44, '乔布斯', '15554785478', '美国电话电报（AT&T）向我方采购电池，需要一千亿个。', 6, '2017-06-24', NULL, NULL, 0);

-- ----------------------------
-- Table structure for saleplan
-- ----------------------------
DROP TABLE IF EXISTS `saleplan`;
CREATE TABLE `saleplan`  (
  `planId` int(0) NOT NULL AUTO_INCREMENT COMMENT '销售机会执行计划编号',
  `planChcId` int(0) NOT NULL COMMENT '所属销售机会编号',
  `planTodo` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '执行内容',
  `planResult` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '执行结果',
  PRIMARY KEY (`planId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of saleplan
-- ----------------------------

-- ----------------------------
-- Table structure for sysuser
-- ----------------------------
DROP TABLE IF EXISTS `sysuser`;
CREATE TABLE `sysuser`  (
  `userId` int(0) NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `userName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户名称',
  `userPassword` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户密码',
  `userRoleId` int(0) NOT NULL COMMENT '用户职责ID',
  `daId` int(0) NOT NULL COMMENT '用户所属地区',
  `delMark` int(0) NOT NULL DEFAULT 1 COMMENT '除删标记',
  `gmtCreate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `gmtModified` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'https://cube.elemecdn.com/6/94/4d3ea53c084bad6931a56d5158a48jpeg.jpeg' COMMENT '头像url',
  PRIMARY KEY (`userId`) USING BTREE,
  UNIQUE INDEX `name_un`(`userName`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sysuser
-- ----------------------------
INSERT INTO `sysuser` VALUES (1, 'huangyaoshi', '$2a$10$fPUtcGvW9/QR1o9Ryngl4uJoUl8lKfcKP44J/DBxtMdkTS2CdxeLS', 4, 5, 1, '2023-06-19 06:03:14', '2023-06-19 14:09:04', '1344722238@qq.com', 'https://cube.elemecdn.com/6/94/4d3ea53c084bad6931a56d5158a48jpeg.jpeg');
INSERT INTO `sysuser` VALUES (2, 'chenxuanfeng', '$2a$10$fPUtcGvW9/QR1o9Ryngl4uJoUl8lKfcKP44J/DBxtMdkTS2CdxeLS', 3, 2, 1, '2023-06-19 10:07:49', '2023-06-19 14:09:05', NULL, 'https://cube.elemecdn.com/6/94/4d3ea53c084bad6931a56d5158a48jpeg.jpeg');
INSERT INTO `sysuser` VALUES (3, 'meichaofeng', '$2a$10$fPUtcGvW9/QR1o9Ryngl4uJoUl8lKfcKP44J/DBxtMdkTS2CdxeLS', 3, 1, 1, '2023-06-19 01:08:50', '2023-06-19 14:09:06', NULL, 'https://cube.elemecdn.com/6/94/4d3ea53c084bad6931a56d5158a48jpeg.jpeg');
INSERT INTO `sysuser` VALUES (4, 'qulingfeng', '$2a$10$fPUtcGvW9/QR1o9Ryngl4uJoUl8lKfcKP44J/DBxtMdkTS2CdxeLS', 3, 1, 1, '2023-06-19 01:08:51', '2023-06-19 14:09:07', NULL, 'https://cube.elemecdn.com/6/94/4d3ea53c084bad6931a56d5158a48jpeg.jpeg');
INSERT INTO `sysuser` VALUES (5, 'luchengfeng', '$2a$10$fPUtcGvW9/QR1o9Ryngl4uJoUl8lKfcKP44J/DBxtMdkTS2CdxeLS', 3, 1, 1, '2023-06-19 01:08:52', '2023-06-19 14:09:08', NULL, 'https://cube.elemecdn.com/6/94/4d3ea53c084bad6931a56d5158a48jpeg.jpeg');
INSERT INTO `sysuser` VALUES (6, 'huangrong', '$2a$10$fPUtcGvW9/QR1o9Ryngl4uJoUl8lKfcKP44J/DBxtMdkTS2CdxeLS', 2, 1, 1, '2023-06-19 01:08:52', '2023-06-19 14:09:10', NULL, 'https://cube.elemecdn.com/6/94/4d3ea53c084bad6931a56d5158a48jpeg.jpeg');
INSERT INTO `sysuser` VALUES (7, 'aheng', '$2a$10$fPUtcGvW9/QR1o9Ryngl4uJoUl8lKfcKP44J/DBxtMdkTS2CdxeLS', 1, 1, 1, '2023-06-19 01:08:54', '2023-06-19 14:09:11', NULL, 'https://cube.elemecdn.com/6/94/4d3ea53c084bad6931a56d5158a48jpeg.jpeg');

SET FOREIGN_KEY_CHECKS = 1;
