/*
Navicat MySQL Data Transfer

Source Server         : aliservicemysql
Source Server Version : 50718
Source Host           : localhost:3306
Source Database       : blog

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2018-04-25 10:41:44
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `blog_article`
-- ----------------------------
DROP TABLE IF EXISTS `blog_article`;
CREATE TABLE `blog_article` (
  `article_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT '1',
  `title` varchar(50) DEFAULT NULL COMMENT '标题',
  `content` longtext COMMENT '内容',
  `text` text COMMENT '文本，不含html代码的',
  `browse_num` int(11) DEFAULT '0' COMMENT '浏览数',
  `comment_num` int(11) DEFAULT '0' COMMENT '评论数',
  `praise_num` int(11) DEFAULT '0' COMMENT '点赞数',
  `isrecommend` int(11) DEFAULT '0' COMMENT '是否推荐',
  `isdel` int(11) DEFAULT '0' COMMENT '是否删除了',
  `hot_num` int(11) DEFAULT '0' COMMENT '热门搜索的值',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` varchar(50) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`article_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of blog_article
-- ----------------------------
INSERT INTO `blog_article` VALUES ('1', '1', 'Linux 安装jdk', '<p><strong style=\"color: rgb(47, 47, 47);\">1.判断是否安装了jdk</strong><br/></p><pre class=\"brush:bash;toolbar:false\">#&nbsp;rpm&nbsp;-qa&nbsp;|&nbsp;grep&nbsp;jdk&nbsp;&nbsp;或者&nbsp;rpm&nbsp;-qa&nbsp;|&nbsp;grep&nbsp;openjdk</pre><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 25px; word-break: break-word; color: rgb(47, 47, 47); font-family: -apple-system, \">有，不满意则卸载</p><pre class=\"brush:bash;toolbar:false\">#&nbsp;rpm&nbsp;-e&nbsp;&nbsp;--nodeps&nbsp;&nbsp;jdk-xxx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-nodeps&nbsp;是强制卸载</pre><p><strong>2.去官网下载jdk包</strong></p><pre class=\"brush:bash;toolbar:false\">#&nbsp;wget&nbsp;--no-check-certificate&nbsp;--no-cookies&nbsp;--header&nbsp;&quot;Cookie:&nbsp;oraclelicense=accept-securebackup-cookie&quot;&nbsp;http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz</pre><p><strong>3.解压</strong></p><pre class=\"brush:bash;toolbar:false\">#&nbsp;tar&nbsp;-zxvf&nbsp;jdk-8u131-linux-x64.tar.gz&nbsp;-C&nbsp;/usr/local/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//解压到/usr/local下</pre><p><strong>4.重命名</strong><br/></p><pre class=\"brush:bash;toolbar:false\">#&nbsp;cd&nbsp;/usr/local\r\n#&nbsp;mv&nbsp;jdk-8u131-linux-x64&nbsp;jdk</pre><p><strong>5.配置环境变量</strong></p><pre class=\"brush:bash;toolbar:false\">#&nbsp;vim&nbsp;/etc/profile</pre><p>在文件最后加上：</p><pre class=\"brush:bash;toolbar:false\">export&nbsp;JAVA_HOME=/usr/local/jdk\r\nexport&nbsp;PATH=$JAVA_HOME/bin:$PATH\r\nexport&nbsp;CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar</pre><p><strong>保存退出</strong></p><p><strong>使配置文件直接生效</strong></p><pre class=\"brush:bash;toolbar:false\">#source&nbsp;/etc/profile\r\n#&nbsp;java&nbsp;-version&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//查看是否配置成功</pre><p><br/></p><p><strong><br/></strong></p>', '1.判断是否安装了jdk# rpm -qa | grep jdk  或者 rpm -qa | grep openjdk有，不满意则卸载# rpm -e  --nodeps  jdk-xxx                      -nodeps 是强制卸载2.去官网下载jdk包# wget --no-check-certificate --no-cookies --header \"Cookie: oraclelicense=accept-securebackup-cookie\" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz3.解压# tar -zxvf jdk-8u131-linux-x64.tar.gz -C /usr/local/                     //解压到/usr/local下4.重命名# cd /usr/local# mv jdk-8u131-linux-x64 jdk5.配置环境变量# vim /etc/profile在文件最后加上：export JAVA_HOME=/usr/local/jdkexport PATH=$JAVA_HOME/bin:$PATHexport CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar保存退出使配置文件直接生效#source /etc/profile# java -version                    //查看是否配置成功', '11', '1', '2', '0', '0', '3', '2017-06-09 19:00:00', '2017-05-09 16:34:21');

-- ----------------------------
-- Table structure for `blog_article_label`
-- ----------------------------
DROP TABLE IF EXISTS `blog_article_label`;
CREATE TABLE `blog_article_label` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) DEFAULT NULL,
  `label_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of blog_article_label
-- ----------------------------


-- ----------------------------
-- Table structure for `blog_browse`
-- ----------------------------
DROP TABLE IF EXISTS `blog_browse`;
CREATE TABLE `blog_browse` (
  `browse_id` int(11) NOT NULL AUTO_INCREMENT,
  `table_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`browse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=675 DEFAULT CHARSET=utf8mb4;


-- ----------------------------
-- Table structure for `blog_comment`
-- ----------------------------
DROP TABLE IF EXISTS `blog_comment`;
CREATE TABLE `blog_comment` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL COMMENT '父级ID',
  `table_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL COMMENT '评论的用户ID',
  `content` text COMMENT '内容',
  `reply_user_id` int(11) DEFAULT NULL COMMENT '收到评论的用户id',
  `create_time` varchar(255) DEFAULT NULL,
  `praise_num` int(11) NOT NULL DEFAULT '0' COMMENT '点赞数',
  PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4;


-- ----------------------------
-- Table structure for `blog_concern`
-- ----------------------------
DROP TABLE IF EXISTS `blog_concern`;
CREATE TABLE `blog_concern` (
  `concern_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `beconcern_user_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`concern_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of blog_concern
-- ----------------------------

-- ----------------------------
-- Table structure for `blog_firend_link`
-- ----------------------------
DROP TABLE IF EXISTS `blog_firend_link`;
CREATE TABLE `blog_firend_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `link_name` varchar(50) DEFAULT NULL,
  `link` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of blog_firend_link
-- ----------------------------

-- ----------------------------
-- Table structure for `blog_jumbotron`
-- ----------------------------
DROP TABLE IF EXISTS `blog_jumbotron`;
CREATE TABLE `blog_jumbotron` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `content` text,
  `type` enum('label','month','home') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of blog_jumbotron
-- ----------------------------
INSERT INTO `blog_jumbotron` VALUES ('1', '干了下面这碗鸡汤', '生命本是场漂泊的远行。珍惜能让你感动的人，铭记能让你哭泣的人，放下能让你淡漠的人，遗忘能让你无关的人。是风雨，就勇敢地追逐，用挑战衡量人生的成色;是阳光，就尽情的接纳，用成长舒展生活的底色;是挫败，就无畏地笑对，用坚强浸润命运的本色', 'home');
INSERT INTO `blog_jumbotron` VALUES ('2', '把握今天', '昨天已经过去，即使昨天发生了再美的事情，我们也无法让它重新来过，明天还未来到，你把未来想象的像花一样那也是以后的事情，纵使你的手在长也无法抓到，我们唯一能够抓得到，掌控的了的就是今天', 'month');
INSERT INTO `blog_jumbotron` VALUES ('3', '鸡汤', '书不成诵，无以致思索之功;书不精读，无以得义理之益', 'label');

-- ----------------------------
-- Table structure for `blog_labels`
-- ----------------------------
DROP TABLE IF EXISTS `blog_labels`;
CREATE TABLE `blog_labels` (
  `label_id` int(11) NOT NULL,
  `label_name` varchar(20) DEFAULT NULL COMMENT '标签名称',
  `label_type` enum('article','author') DEFAULT NULL COMMENT 'author -- 作者，aricle --文章',
  `label_class` enum('friend','warning','info','success','primary','default','danger') DEFAULT 'success' COMMENT '标签样式',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_time` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`label_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of blog_labels
-- ----------------------------
INSERT INTO `blog_labels` VALUES ('1', 'Java', 'article', 'danger', '2017-04-28 17:34:18', '2017-04-28 17:06:11');
INSERT INTO `blog_labels` VALUES ('2', 'Spring', 'article', 'friend', '2017-04-28 17:34:23', '2017-04-28 17:06:11');
INSERT INTO `blog_labels` VALUES ('3', 'Redis', 'article', 'info', '2017-04-28 17:34:25', '2017-04-28 17:06:11');
INSERT INTO `blog_labels` VALUES ('4', 'MYSQL', 'article', 'friend', '2017-04-28 17:34:27', '2017-04-28 17:06:11');
INSERT INTO `blog_labels` VALUES ('5', 'Linux', 'article', 'success', '2017-04-28 17:34:31', '2017-04-28 17:06:11');
INSERT INTO `blog_labels` VALUES ('6', 'CSS', 'article', 'warning', '2017-04-28 17:34:35', '2017-04-28 17:06:11');
INSERT INTO `blog_labels` VALUES ('7', 'HTML', 'article', 'info', '2017-04-28 17:34:41', '2017-04-28 17:06:11');
INSERT INTO `blog_labels` VALUES ('8', 'JavaScript', 'article', 'default', '2017-04-28 17:08:30', '2017-04-28 17:06:11');
INSERT INTO `blog_labels` VALUES ('9', 'PHP', 'article', 'danger', '2017-04-28 17:34:44', '2017-04-28 17:06:11');
INSERT INTO `blog_labels` VALUES ('10', '其他', 'article', 'success', '2017-05-01 13:27:45', '2017-05-01 13:27:38');
INSERT INTO `blog_labels` VALUES ('11', '干货', 'article', 'warning', '2017-05-01 14:32:24', '2017-05-01 14:30:51');
INSERT INTO `blog_labels` VALUES ('12', '开发工具', 'article', 'default', '2017-05-01 14:33:01', '2017-05-01 14:30:51');
INSERT INTO `blog_labels` VALUES ('13', 'Maven', 'article', 'primary', '2017-05-01 14:33:21', '2017-05-01 14:30:51');
INSERT INTO `blog_labels` VALUES ('14', '游戏', 'article', 'success', '2017-05-09 18:17:39', '2017-05-09 18:17:35');
INSERT INTO `blog_labels` VALUES ('15', 'SVN', 'article', 'friend', '2017-06-12 09:50:05', '2017-05-13 16:44:51');
INSERT INTO `blog_labels` VALUES ('16', '帅大叔', 'author', 'danger', '2017-06-07 16:11:59', '2017-06-07 12:03:20');
INSERT INTO `blog_labels` VALUES ('17', '90后', 'author', 'primary', '2017-06-08 16:43:19', '2017-06-07 12:03:20');
INSERT INTO `blog_labels` VALUES ('18', '80后', 'author', 'success', '2017-06-08 16:44:07', '2017-06-07 12:03:20');
INSERT INTO `blog_labels` VALUES ('19', '型男', 'author', 'info', '2017-06-07 12:03:40', '2017-06-07 12:03:20');
INSERT INTO `blog_labels` VALUES ('20', '美淑女', 'author', 'warning', '2017-06-08 16:44:18', '2017-06-07 12:03:20');
INSERT INTO `blog_labels` VALUES ('21', '女汉子', 'author', 'friend', '2017-06-07 12:03:38', '2017-06-07 12:03:20');
INSERT INTO `blog_labels` VALUES ('22', 'IT', 'author', 'default', '2017-06-12 09:50:40', '2017-06-07 12:03:20');
INSERT INTO `blog_labels` VALUES ('23', '00后', 'author', 'success', '2017-06-08 16:44:55', '2017-06-08 16:44:42');
INSERT INTO `blog_labels` VALUES ('24', '邋遢', 'author', 'success', '2017-06-08 16:44:56', '2017-06-08 16:44:42');
INSERT INTO `blog_labels` VALUES ('25', '靓大婶', 'author', 'danger', '2017-06-08 16:46:10', '2017-06-08 16:44:42');
INSERT INTO `blog_labels` VALUES ('26', '宅', 'author', 'primary', '2017-06-09 13:58:19', '2017-06-09 13:57:05');
INSERT INTO `blog_labels` VALUES ('27', '大叔控', 'author', 'success', '2017-06-09 13:58:42', '2017-06-09 13:57:05');
INSERT INTO `blog_labels` VALUES ('28', '萝莉控', 'author', 'warning', '2017-06-09 13:58:55', '2017-06-09 13:57:05');
INSERT INTO `blog_labels` VALUES ('29', '吃货', 'author', 'info', '2017-06-09 17:22:16', '2017-06-09 17:22:10');
INSERT INTO `blog_labels` VALUES ('30', 'Netty', 'article', 'success', '2017-06-12 09:49:51', '2017-06-12 09:45:36');
INSERT INTO `blog_labels` VALUES ('31', 'C/C++', 'article', 'primary', '2017-06-12 09:46:06', '2017-06-12 09:45:36');
INSERT INTO `blog_labels` VALUES ('32', 'RocketMQ', 'article', 'warning', '2017-06-12 09:46:38', '2017-06-12 09:45:36');
INSERT INTO `blog_labels` VALUES ('33', 'ActiveMQ', 'article', 'info', '2017-06-12 09:47:17', '2017-06-12 09:45:36');
INSERT INTO `blog_labels` VALUES ('34', 'RabbitMQ', 'article', 'danger', '2017-06-12 09:49:12', '2017-06-12 09:45:36');

-- ----------------------------
-- Table structure for `blog_leaveword`
-- ----------------------------
DROP TABLE IF EXISTS `blog_leaveword`;
CREATE TABLE `blog_leaveword` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  `ip` varchar(50) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of blog_leaveword
-- ----------------------------
INSERT INTO `blog_leaveword` VALUES ('24', '测试留言功能', '116.25.97.242', null, '2017-05-09 18:08:33');
INSERT INTO `blog_leaveword` VALUES ('25', '哎，好累，好多功能没写呢，但现在好懒啊，没有最初的动力了！！！！1', '119.123.123.162', null, '2017-05-09 22:30:33');
INSERT INTO `blog_leaveword` VALUES ('26', '这留言有用吗？\n\n', '119.123.122.225', null, '2017-05-14 21:23:50');
INSERT INTO `blog_leaveword` VALUES ('27', '留言功能好使不？\n', '116.24.154.5', null, '2017-06-12 09:16:56');

-- ----------------------------
-- Table structure for `blog_letter`
-- ----------------------------
DROP TABLE IF EXISTS `blog_letter`;
CREATE TABLE `blog_letter` (
  `letter_id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `from_user_id` int(11) DEFAULT NULL,
  `content` text,
  `create_time` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`letter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of blog_letter
-- ----------------------------
INSERT INTO `blog_letter` VALUES ('6', null, '26', '1', '来测试一把', '2017-06-07 17:13:37');
INSERT INTO `blog_letter` VALUES ('7', '6', '1', '26', '好啊', '2017-06-07 17:13:52');
INSERT INTO `blog_letter` VALUES ('8', '6', '1', '1', 'asdfsa', '2017-06-07 17:14:50');
INSERT INTO `blog_letter` VALUES ('9', '6', '1', '26', '士大夫', '2017-06-07 17:15:24');
INSERT INTO `blog_letter` VALUES ('10', '6', '26', '1', '发送呢', '2017-06-07 18:00:23');
INSERT INTO `blog_letter` VALUES ('11', '6', '1', '26', '好像可以了', '2017-06-07 18:00:45');
INSERT INTO `blog_letter` VALUES ('12', null, '1', '27', '怪大叔', '2017-06-12 16:44:09');

-- ----------------------------
-- Table structure for `blog_music`
-- ----------------------------
DROP TABLE IF EXISTS `blog_music`;
CREATE TABLE `blog_music` (
  `music_id` int(11) NOT NULL AUTO_INCREMENT,
  `music_name` varchar(100) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) DEFAULT '1',
  PRIMARY KEY (`music_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of blog_music
-- ----------------------------
INSERT INTO `blog_music` VALUES ('1', '汪苏泷 - 不分手的恋爱', '2017-05-09 17:49:16', '1');
INSERT INTO `blog_music` VALUES ('2', 'Clubringer-Sound-Of-My-Dream', '2017-05-09 17:49:14', '1');

-- ----------------------------
-- Table structure for `blog_notice`
-- ----------------------------
DROP TABLE IF EXISTS `blog_notice`;
CREATE TABLE `blog_notice` (
  `notice_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '收到消息的用户id',
  `from_user_id` int(11) DEFAULT NULL COMMENT '这条消息是因为哪个用户产生的',
  `text` varchar(200) DEFAULT NULL COMMENT '评论id,或者是系统消息的html内容',
  `notice_type` enum('letter','concern','comment','system','praise') DEFAULT NULL COMMENT 'reward -- 打赏，letter -- 写信，concern -- 关注，praise -- 点赞',
  `table_id` int(11) DEFAULT NULL,
  `is_read` int(1) DEFAULT '0',
  `create_time` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of blog_notice
-- ----------------------------

-- ----------------------------
-- Table structure for `blog_picture`
-- ----------------------------
DROP TABLE IF EXISTS `blog_picture`;
CREATE TABLE `blog_picture` (
  `pic_id` int(11) NOT NULL,
  `pic_path` varchar(100) DEFAULT NULL,
  `pic_type` enum('article','author') DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of blog_picture
-- ----------------------------

-- ----------------------------
-- Table structure for `blog_praise`
-- ----------------------------
DROP TABLE IF EXISTS `blog_praise`;
CREATE TABLE `blog_praise` (
  `praise_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `table_type` enum('comment','article') DEFAULT 'article',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`praise_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of blog_praise
-- ----------------------------

-- ----------------------------
-- Table structure for `blog_user`
-- ----------------------------
DROP TABLE IF EXISTS `blog_user`;
CREATE TABLE `blog_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT NULL COMMENT '用户名',
  `name` varchar(20) DEFAULT NULL COMMENT '昵称',
  `password` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `img` varchar(100) DEFAULT 'upload/user/default.png' COMMENT '用户头像路径',
  `sex` enum('girl','boy') DEFAULT 'boy',
  `sign` varchar(50) DEFAULT '人懒连个性签名都没有!' COMMENT '个人签名',
  `locate` varchar(10) DEFAULT '地球' COMMENT '位置',
  `fans_num` int(11) DEFAULT '0',
  `concern_num` int(11) DEFAULT '0',
  `register_type` enum('blog','weibo','weixin','qq') DEFAULT 'blog' COMMENT 'blog --博客上注册的，',
  `third_uuid` varchar(50) DEFAULT NULL COMMENT '第三方的唯一ID',
  `last_login` varchar(40) DEFAULT NULL COMMENT '最后登录时间',
  `ip` varchar(40) DEFAULT NULL,
  `status` enum('unlock','lock') DEFAULT 'lock',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of blog_user
-- ----------------------------
INSERT INTO `blog_user` VALUES ('1', 'admin', '这个冬天不太冷', '7a2a5e8fa232e6a822ae39714e3a59779f6dece6', '', '/upload/user/20170612/05976238.png', 'boy', '我就是我，不一样的博主！', '深圳', '0', '0', 'blog', null, '2017-04-28 16:52:42', '116.24.154.5', 'unlock', '2017-06-12 09:30:40');
-- ----------------------------
-- Table structure for `blog_user_label`
-- ----------------------------
DROP TABLE IF EXISTS `blog_user_label`;
CREATE TABLE `blog_user_label` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `label_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of blog_user_label
-- ----------------------------
INSERT INTO `blog_user_label` VALUES ('54', '1', '26', '2017-06-09 17:31:31');
INSERT INTO `blog_user_label` VALUES ('55', '1', '16', '2017-06-09 17:31:31');
INSERT INTO `blog_user_label` VALUES ('56', '1', '17', '2017-06-09 17:31:31');
INSERT INTO `blog_user_label` VALUES ('57', '1', '22', '2017-06-09 17:31:31');
