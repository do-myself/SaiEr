/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : localhost:3306
 Source Schema         : db_network

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : 65001

 Date: 28/12/2020 15:03:03
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_acl
-- ----------------------------
DROP TABLE IF EXISTS `tb_acl`;
CREATE TABLE `tb_acl`  (
  `id` int(11) NOT NULL,
  `ipsrc` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ipdst` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `action` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_acl
-- ----------------------------
INSERT INTO `tb_acl` VALUES (1, '10.12.1.10/24', '192.168.12.1/24', 'allow');
INSERT INTO `tb_acl` VALUES (2, '10.12.12.10/24', '172.16.12.1/24', 'allow');
INSERT INTO `tb_acl` VALUES (3, '225.12.256.25/24', '192.168.45.23/2', 'deny');

-- ----------------------------
-- Table structure for tb_attack
-- ----------------------------
DROP TABLE IF EXISTS `tb_attack`;
CREATE TABLE `tb_attack`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `switchId` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `inPort` int(10) NOT NULL,
  `srcMac` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `dstMac` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `srcIp` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `dstIp` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `attackTime` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_attack
-- ----------------------------
INSERT INTO `tb_attack` VALUES (1, '00:00:00:00:00:00:00:01', 1, '00:00:00:00:00:11', '00:00:00:00:00:14', '::9.82.108.119', '::10.0.0.4', '2020-10-28 10:20:06');
INSERT INTO `tb_attack` VALUES (2, '00:00:00:00:00:00:00:01', 1, '00:00:00:00:00:11', '00:00:00:00:00:13', '::8.156.165.253', '::10.0.0.3', '2020-11-05 13:41:05');
INSERT INTO `tb_attack` VALUES (3, '00:00:00:00:00:00:00:01', 1, '00:00:00:00:00:11', '00:00:00:00:00:14', '::9.233.106.21', '::10.0.0.4', '2020-11-06 15:15:46');
INSERT INTO `tb_attack` VALUES (4, '00:00:00:00:00:00:00:02', 3, '00:00:00:00:00:11', '00:00:00:00:00:14', '::9.222.4.238', '::10.0.0.4', '2020-11-06 15:16:32');
INSERT INTO `tb_attack` VALUES (5, '00:00:00:00:00:00:00:02', 3, '00:00:00:00:00:11', '00:00:00:00:00:14', '::8.125.151.80', '::10.0.0.4', '2020-11-10 19:19:37');
INSERT INTO `tb_attack` VALUES (6, '00:00:00:00:00:00:00:01', 1, '00:00:00:00:00:11', '00:00:00:00:00:14', '::9.219.21.214', '::10.0.0.4', '2020-11-10 19:19:37');
INSERT INTO `tb_attack` VALUES (7, '00:00:00:00:00:00:00:02', 3, '00:00:00:00:00:11', '00:00:00:00:00:14', '::8.20.190.217', '::10.0.0.4', '2020-11-10 19:19:52');
INSERT INTO `tb_attack` VALUES (8, '00:00:00:00:00:00:00:01', 1, '00:00:00:00:00:11', '00:00:00:00:00:14', '::9.197.13.125', '::10.0.0.4', '2020-11-10 22:19:28');
INSERT INTO `tb_attack` VALUES (9, '00:00:00:00:00:00:00:01', 1, '02:0b:a9:aa:2b:e6', '12:59:2e:02:14:b8', '::9.97.64.34', '::10.0.0.10', '2020-11-11 15:57:18');
INSERT INTO `tb_attack` VALUES (10, '00:00:00:00:00:00:00:02', 3, '82:85:3c:af:38:77', '32:0b:d1:75:c0:eb', '::9.173.113.40', '::10.0.0.9', '2020-11-11 16:02:20');
INSERT INTO `tb_attack` VALUES (11, '00:00:00:00:00:00:00:01', 1, '02:0b:a9:aa:2b:e6', '12:59:2e:02:14:b8', '::9.173.113.43', '::10.0.0.10', '2020-11-11 16:02:20');
INSERT INTO `tb_attack` VALUES (12, '00:00:00:00:00:00:00:02', 3, '82:85:3c:af:38:77', '32:0b:d1:75:c0:eb', '::8.60.185.43', '::10.0.0.9', '2020-11-11 16:04:35');
INSERT INTO `tb_attack` VALUES (13, '00:00:00:00:00:00:00:02', 3, '82:85:3c:af:38:77', '32:0b:d1:75:c0:eb', '::8.177.76.238', '::10.0.0.9', '2020-11-11 16:06:09');
INSERT INTO `tb_attack` VALUES (14, '00:00:00:00:00:00:00:04', 1, '6e:93:33:27:64:68', 'fe:fe:65:28:61:56', '::8.212.211.211', '::10.0.0.2', '2020-11-11 16:08:02');
INSERT INTO `tb_attack` VALUES (15, '00:00:00:00:00:00:00:04', 1, '6e:93:33:27:64:68', 'fe:fe:65:28:61:56', '::8.22.164.64', '::10.0.0.2', '2020-11-11 16:09:36');
INSERT INTO `tb_attack` VALUES (16, '00:00:00:00:00:00:00:04', 1, '6e:93:33:27:64:68', 'fe:fe:65:28:61:56', '::8.162.245.208', '::10.0.0.2', '2020-11-11 16:12:53');
INSERT INTO `tb_attack` VALUES (17, '00:00:00:00:00:00:00:01', 1, 'fe:c6:56:11:14:13', '7e:a7:d0:e2:07:15', '::8.150.143.142', '::10.0.0.10', '2020-11-25 17:08:50');
INSERT INTO `tb_attack` VALUES (18, '00:00:00:00:00:00:00:01', 1, 'fe:c6:56:11:14:13', '7e:a7:d0:e2:07:15', '::8.145.211.185', '::10.0.0.10', '2020-11-25 17:12:37');
INSERT INTO `tb_attack` VALUES (19, '00:00:00:00:00:00:00:01', 1, '5e:69:e1:fd:91:fb', '5a:5d:e6:6c:1e:c1', '::8.108.81.39', '::10.0.0.10', '2020-11-25 17:20:04');
INSERT INTO `tb_attack` VALUES (20, '00:00:00:00:00:00:00:01', 1, '5e:69:e1:fd:91:fb', '5a:5d:e6:6c:1e:c1', '::8.100.250.180', '::10.0.0.10', '2020-11-25 17:20:27');
INSERT INTO `tb_attack` VALUES (21, '00:00:00:00:00:00:00:01', 1, '62:b0:af:46:eb:a4', '4e:cb:28:58:48:47', '::9.2.39.44', '::10.0.0.10', '2020-11-26 16:12:42');
INSERT INTO `tb_attack` VALUES (22, '00:00:00:00:00:00:00:01', 1, '62:b0:af:46:eb:a4', '4e:cb:28:58:48:47', '::9.25.54.176', '::10.0.0.10', '2020-11-26 16:12:57');
INSERT INTO `tb_attack` VALUES (23, '00:00:00:00:00:00:00:01', 1, 'd2:b1:ec:6b:8c:36', 'c6:ef:46:08:ff:c4', '::8.146.143.221', '::10.0.0.10', '2020-11-26 17:55:19');
INSERT INTO `tb_attack` VALUES (24, '00:00:00:00:00:00:00:01', 1, 'd2:b1:ec:6b:8c:36', 'c6:ef:46:08:ff:c4', '::8.247.187.102', '::10.0.0.10', '2020-11-26 17:56:47');
INSERT INTO `tb_attack` VALUES (25, '00:00:00:00:00:00:00:01', 1, '26:fe:86:c5:e5:7c', '1a:6a:c1:0c:5a:d8', '::97f:2786', '::a00:a', '2020-12-27 18:57:18');
INSERT INTO `tb_attack` VALUES (26, '00:00:00:00:00:00:00:01', 1, '26:fe:86:c5:e5:7c', '1a:6a:c1:0c:5a:d8', '::9f9:32c1', '::a00:a', '2020-12-27 18:59:16');

-- ----------------------------
-- Table structure for tb_firewall
-- ----------------------------
DROP TABLE IF EXISTS `tb_firewall`;
CREATE TABLE `tb_firewall`  (
  `id` int(11) NOT NULL,
  `ipsrc` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ipdst` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `proto` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tpsrc` int(11) NOT NULL,
  `tpdst` int(11) NOT NULL,
  `action` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_forward
-- ----------------------------
DROP TABLE IF EXISTS `tb_forward`;
CREATE TABLE `tb_forward`  (
  `switchid` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `name` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `priority` int(11) NOT NULL,
  `inport` int(11) NOT NULL,
  `outport` int(11) NOT NULL,
  PRIMARY KEY (`switchid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_forward
-- ----------------------------
INSERT INTO `tb_forward` VALUES ('00:00:00:00:00:01', 'flow1', 2342, 1, 2);
INSERT INTO `tb_forward` VALUES ('00:00:00:00:00:02', 'flow2', 231, 1, 33);
INSERT INTO `tb_forward` VALUES ('00:00:00:00:00:04', 'flow2', 231, 4, 1);

-- ----------------------------
-- Table structure for tb_host
-- ----------------------------
DROP TABLE IF EXISTS `tb_host`;
CREATE TABLE `tb_host`  (
  `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ip` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mac` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `linkSwitch` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `linkPort` int(5) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_host
-- ----------------------------
INSERT INTO `tb_host` VALUES (1, 'host1', '::10.0.0.1', '00:00:00:00:00:11', '00:00:00:00:00:00:00:01', 1);
INSERT INTO `tb_host` VALUES (2, 'host2', '::10.0.0.2', '00:00:00:00:00:12', '00:00:00:00:00:00:00:01', 2);
INSERT INTO `tb_host` VALUES (3, 'host3', '::10.0.0.3', '00:00:00:00:00:13', '00:00:00:00:00:00:00:01', 3);
INSERT INTO `tb_host` VALUES (4, 'host4', '::10.0.0.4', '00:00:00:00:00:14', '00:00:00:00:00:00:00:01', 4);
INSERT INTO `tb_host` VALUES (5, 'host5', '::10.0.0.5', '00:00:00:00:00:15', '00:00:00:00:00:00:00:02', 3);
INSERT INTO `tb_host` VALUES (6, 'host6', '::10.0.0.6', '00:00:00:00:00:16', '00:00:00:00:00:00:00:02', 4);
INSERT INTO `tb_host` VALUES (7, 'host7', '::10.0.0.7', '00:00:00:00:00:17', '00:00:00:00:00:00:00:02', 1);
INSERT INTO `tb_host` VALUES (8, 'host8', '::10.0.0.8', '00:00:00:00:00:18', '00:00:00:00:00:00:00:02', 2);
INSERT INTO `tb_host` VALUES (9, 'host9', '::10.0.0.9', '00:00:00:00:00:19', '00:00:00:00:00:00:00:03', 1);
INSERT INTO `tb_host` VALUES (10, 'host10', '::10.0.0.10', '00:00:00:00:00:20', '00:00:00:00:00:00:00:03', 2);
INSERT INTO `tb_host` VALUES (11, 'host11', '::10.0.0.11', '00:00:00:00:00:21', '00:00:00:00:00:00:00:03', 3);
INSERT INTO `tb_host` VALUES (12, 'host12', '::10.0.0.12', '00:00:00:00:00:22', '00:00:00:00:00:00:00:03', 4);
INSERT INTO `tb_host` VALUES (13, 'host13', '::10.0.0.13', '00:00:00:00:00:23', '00:00:00:00:00:00:00:04', 1);
INSERT INTO `tb_host` VALUES (14, 'host14', '::10.0.0.14', '00:00:00:00:00:24', '00:00:00:00:00:00:00:04', 2);
INSERT INTO `tb_host` VALUES (15, 'host15', '::10.0.0.15', '00:00:00:00:00:25', '00:00:00:00:00:00:00:04', 3);
INSERT INTO `tb_host` VALUES (16, 'host16', '::10.0.0.16', '00:00:00:00:00:26', '00:00:00:00:00:00:00:04', 4);

-- ----------------------------
-- Table structure for tb_link
-- ----------------------------
DROP TABLE IF EXISTS `tb_link`;
CREATE TABLE `tb_link`  (
  `id` int(11) NOT NULL,
  `direction` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `srcport` int(11) NOT NULL,
  `srcsw` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `dstport` int(11) NOT NULL,
  `dstsw` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `type` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT 'internal',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_link
-- ----------------------------
INSERT INTO `tb_link` VALUES (1, 'direction', 3, '00:00:00:00:00:01', 3, '00:00:00:00:00:02', 'type');
INSERT INTO `tb_link` VALUES (2, 'direction', 4, '00:00:00:00:00:02', 3, '00:00:00:00:00:03', 'type');
INSERT INTO `tb_link` VALUES (3, 'direction', 2, '00:00:00:00:00:03', 3, '00:00:00:00:00:04', 'type');

-- ----------------------------
-- Table structure for tb_staticflow
-- ----------------------------
DROP TABLE IF EXISTS `tb_staticflow`;
CREATE TABLE `tb_staticflow`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `priority` int(11) NULL DEFAULT 32768,
  `srcMac` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `dstMac` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '1',
  `srcIp` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dstIp` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `inPort` int(10) NOT NULL,
  `outPort` int(10) NOT NULL,
  `switchID` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `action` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_staticflow
-- ----------------------------
INSERT INTO `tb_staticflow` VALUES (1, 1, '00:00:00:00:00:11', '00:00:00:00:00:12', '::10.0.0.1', '::10.0.0.2', 1, 2, '00:00:00:00:00:00:00:01', 'output');
INSERT INTO `tb_staticflow` VALUES (2, 1, '00:00:00:00:00:11', '00:00:00:00:00:13', '::10.0.0.1', '::10.0.0.3', 1, 3, '00:00:00:00:00:00:00:01', 'output');
INSERT INTO `tb_staticflow` VALUES (3, 1, '00:00:00:00:00:11', '00:00:00:00:00:14', '::10.0.0.1', '::10.0.0.4', 1, 4, '00:00:00:00:00:00:00:01', 'output');
INSERT INTO `tb_staticflow` VALUES (4, 1, '00:00:00:00:00:11', '00:00:00:00:00:15', '::10.0.0.1', '::10.0.0.5', 5, 1, '00:00:00:00:00:00:00:02', 'output');
INSERT INTO `tb_staticflow` VALUES (5, 1, '00:00:00:00:00:12', '00:00:00:00:00:15', '::10.0.0.2', '::10.0.0.5', 5, 1, '00:00:00:00:00:00:00:02', 'output');
INSERT INTO `tb_staticflow` VALUES (6, 1, '00:00:00:00:00:13', '00:00:00:00:00:15', '::10.0.0.3', '::10.0.0.5', 5, 1, '00:00:00:00:00:00:00:02', 'output');
INSERT INTO `tb_staticflow` VALUES (7, 1, '00:00:00:00:00:14', '00:00:00:00:00:15', '::10.0.0.4', '::10.0.0.5', 5, 1, '00:00:00:00:00:00:00:02', 'output');
INSERT INTO `tb_staticflow` VALUES (8, 1, '00:00:00:00:00:11', '00:00:00:00:00:16', '::10.0.0.1', '::10.0.0.6', 5, 2, '00:00:00:00:00:00:00:02', 'output');
INSERT INTO `tb_staticflow` VALUES (9, 1, '00:00:00:00:00:12', '00:00:00:00:00:16', '::10.0.0.2', '::10.0.0.6', 5, 2, '00:00:00:00:00:00:00:02', 'output');
INSERT INTO `tb_staticflow` VALUES (10, 1, '00:00:00:00:00:13', '00:00:00:00:00:16', '::10.0.0.3', '::10.0.0.6', 5, 2, '00:00:00:00:00:00:00:02', 'output');
INSERT INTO `tb_staticflow` VALUES (11, 1, '00:00:00:00:00:14', '00:00:00:00:00:16', '::10.0.0.4', '::10.0.0.6', 5, 2, '00:00:00:00:00:00:00:02', 'output');
INSERT INTO `tb_staticflow` VALUES (12, 1, '00:00:00:00:00:11', '00:00:00:00:00:17', '::10.0.0.1', '::10.0.0.7', 5, 3, '00:00:00:00:00:00:00:02', 'output');
INSERT INTO `tb_staticflow` VALUES (13, 1, '00:00:00:00:00:12', '00:00:00:00:00:18', '::10.0.0.2', '::10.0.0.8', 5, 4, '00:00:00:00:00:00:00:02', 'output');
INSERT INTO `tb_staticflow` VALUES (14, 1, '00:00:00:00:00:13', '00:00:00:00:00:17', '::10.0.0.3', '::10.0.0.7', 5, 3, '00:00:00:00:00:00:00:02', 'output');
INSERT INTO `tb_staticflow` VALUES (15, 1, '00:00:00:00:00:14', '00:00:00:00:00:18', '::10.0.0.4', '::10.0.0.8', 5, 4, '00:00:00:00:00:00:00:02', 'output');
INSERT INTO `tb_staticflow` VALUES (16, 1, '00:00:00:00:00:11', '00:00:00:00:00:19', '::10.0.0.1', '::10.0.0.9', 5, 1, '00:00:00:00:00:00:00:03', 'output');
INSERT INTO `tb_staticflow` VALUES (17, 1, '00:00:00:00:00:12', '00:00:00:00:00:20', '::10.0.0.2', '::10.0.0.10', 5, 2, '00:00:00:00:00:00:00:03', 'output');
INSERT INTO `tb_staticflow` VALUES (18, 1, '00:00:00:00:00:13', '00:00:00:00:00:24', '::10.0.0.3', '::10.0.0.14', 5, 2, '00:00:00:00:00:00:00:04', 'output');
INSERT INTO `tb_staticflow` VALUES (19, 1, '00:00:00:00:00:14', '00:00:00:00:00:26', '::10.0.0.4', '::10.0.0.16', 5, 4, '00:00:00:00:00:00:00:04', 'output');
INSERT INTO `tb_staticflow` VALUES (20, 1, '00:00:00:00:00:15', '00:00:00:00:00:25', '::10.0.0.5', '::10.0.0.15', 5, 3, '00:00:00:00:00:00:00:04', 'output');

-- ----------------------------
-- Table structure for tb_switch
-- ----------------------------
DROP TABLE IF EXISTS `tb_switch`;
CREATE TABLE `tb_switch`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mac` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `version` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT 'OF_12',
  `ipv4` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ipv6` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ports` int(11) NOT NULL,
  `flows` int(11) NOT NULL,
  `role` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'master',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_switch
-- ----------------------------
INSERT INTO `tb_switch` VALUES (1, '00:00:00:00:00:00:00:01', 'OF_12', '10.0.0.21', '::10.0.0.21', 5, 50, 'master');
INSERT INTO `tb_switch` VALUES (2, '00:00:00:00:00:00:00:02', 'OF_12', '10.0.0.22', '::10.0.0.22', 6, 48, 'master');
INSERT INTO `tb_switch` VALUES (3, '00:00:00:00:00:00:00:03', 'OF_12', '10.0.0.23', '::10.0.0.23', 6, 49, 'master');
INSERT INTO `tb_switch` VALUES (4, '00:00:00:00:00:00:00:04', 'OF_12', '10.0.0.24', '::10.0.0.24', 5, 53, 'master');

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userCode` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `userName` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phoneNum` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `age` int(5) NULL DEFAULT NULL,
  `sex` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES (1, 'admin', '123456', '管理员', '1008611', 23, '男');
INSERT INTO `tb_user` VALUES (2, 'liang', '111111', '亮', '15223379867', 23, '男');
INSERT INTO `tb_user` VALUES (3, 'shang', '111111', '尚', '', 48, '男');
INSERT INTO `tb_user` VALUES (4, 'mao', '123456', '毛毛', NULL, 26, '男');

SET FOREIGN_KEY_CHECKS = 1;
