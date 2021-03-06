--
-- Table structure for table `settings`
--
DROP TABLE IF EXISTS `settings`;
CREATE TABLE IF NOT EXISTS `settings` (
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `type` enum('bool','int','float','string','array(string)','hash') DEFAULT 'string',
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `settings`
--
INSERT INTO `settings` (`name`, `value`, `type`) VALUES
('debug.display_exceptions', '1', 'bool'),
('cache.base_dir', '/dev/shm/testplan-executor/', 'string'),
('auth', 'Database', 'string'),
('logging.plugins', 'Database\nFlatFile', 'array(string)'),
('logging.Database', 'webui', 'array(string)'),
('logging.Database.webui.table', 'log', 'string'),
('logging.Database.webui.severity', 'debug\ninfo\nwarning\ndebug', 'array(string)'),
('logging.Database.webui.category', 'webui\ndefault', 'array(string)'),
('logging.FlatFile', 'tmp', 'array(string)'),
('logging.FlatFile.tmp.filename', '/tmp/testplan-executor.log', 'string'),
('logging.FlatFile.tmp.format', '%timestamp% %hostname%:%pid% %progname%:%file%[%line%] %message%', 'string'),
('logging.FlatFile.tmp.severity', 'debug\ninfo\nwarning\nerror', 'array(string)'),
('logging.FlatFile.tmp.category', 'webui\ndefault', 'array(string)'),
('templates.tmp_path', '/var/tmp/testplan-executor/', 'string'),
('sessions', 1, 'bool'),
('sessions.path', '/', 'string');

--
-- Table structure for table `log`
--
DROP TABLE IF EXISTS `log`;
CREATE TABLE IF NOT EXISTS `log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `level` varchar(32) NOT NULL,
  `category` varchar(32) NOT NULL,
  `ctime` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `hostname` varchar(32) NOT NULL,
  `progname` varchar(64) NOT NULL,
  `file` text NOT NULL,
  `line` int(11) NOT NULL,
  `message` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;

--
-- Table structure for table `user`
--
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` char(40) NOT NULL,
  `fullname` varchar(255) NULL,
  `email` varchar(255) NULL,
  `last_login` int(10) NULL,
  `last_password_change` int(10) NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;

--
-- Dumping data for table `user`
--
INSERT INTO `user` (`id`, `username`, `password`, `fullname`, `email`, `last_login`, `last_password_change`) VALUES
(1, 'admin', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Administrator', NULL, NULL, 1324211456);

--
-- Table structure for table `group`
--
DROP TABLE IF EXISTS `group`;
CREATE TABLE IF NOT EXISTS `group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;

--
-- Dumping data for table `group`
--
INSERT INTO `group` (`id`, `name`, `description`) VALUES
(1, 'admins', 'Administrative users will full control over the testplan application.');

--
-- Table structure for table `usergroup`
--
DROP TABLE IF EXISTS `usergroup`;
CREATE TABLE IF NOT EXISTS `usergroup` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user` int(10) unsigned NOT NULL,
  `group` int(10) unsigned NOT NULL,
  `added` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user` (`user`,`group`),
  KEY `group` (`group`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;

--
-- Dumping data for table `usergroup`
--
INSERT INTO `usergroup` (`id`, `user`, `group`, `added`) VALUES
(1, 1, 1, 1324211572);

--
-- Table structure for view `groups_by_user`
--
DROP VIEW IF EXISTS `groups_by_user`;
CREATE VIEW `groups_by_user` AS (
  SELECT 
    `u`.`id` AS `user`,
    `g`.*
  FROM
    `usergroup` as `ug`
    LEFT JOIN `user` AS `u` ON `ug`.`user`=`u`.`id`
    LEFT JOIN `group` AS `g` ON `ug`.`group`=`g`.`id`
);

--
-- Table structure for view `users_by_group`
--
DROP VIEW IF EXISTS `users_by_group`;
CREATE VIEW `users_by_group` AS (
  SELECT 
    `g`.`id` AS `group`,
    `u`.*
  FROM
    `usergroup` as `ug`
    LEFT JOIN `user` AS `u` ON `ug`.`user`=`u`.`id`
    LEFT JOIN `group` AS `g` ON `ug`.`group`=`g`.`id`
);

--
-- Table structure for view `user_unmatchedgroups`
--
DROP VIEW IF EXISTS `user_unmatchedgroups`;
CREATE VIEW `user_unmatchedgroups` AS (
  SELECT 
    `g`.`id` AS `group`,
    `u`.*
  FROM
    `user` AS `u`
    CROSS JOIN `group` as `g`
    LEFT JOIN `usergroup` AS `ug` ON
        `ug`.`group` = `g`.`id`
        AND `ug`.`user` = `u`.`id`
    WHERE
        `ug`.`id` IS NULL
);

--
-- Table structure for view `group_unmatchedusers`
--
DROP VIEW IF EXISTS `group_unmatchedusers`;
CREATE VIEW `group_unmatchedusers` AS (
  SELECT 
    `u`.`id` AS `user`,
    `g`.*
  FROM
    `group` AS `g`
    CROSS JOIN `user` as `u`
    LEFT JOIN `usergroup` AS `ug` ON
        `ug`.`group` = `g`.`id`
        AND `ug`.`user` = `u`.`id`
    WHERE
        `ug`.`id` IS NULL
);

--
-- Table structure for table `permission`
--
DROP TABLE IF EXISTS `permission`;
CREATE TABLE IF NOT EXISTS `permission` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;

--
-- Dumping data for table `permission`
--
INSERT INTO `permission` (`id`, `name`, `description`) VALUES
(1, 'Administrator', 'Full administrative rights.');


--
-- Table structure for table `grouppermission`
--
DROP TABLE IF EXISTS `grouppermission`;
CREATE TABLE IF NOT EXISTS `grouppermission` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group` int(10) unsigned NOT NULL,
  `permission` int(10) unsigned NOT NULL,
  `added` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `group` (`group`,`permission`),
  KEY `permission` (`permission`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;

--
-- Dumping data for table `grouppermission`
--
INSERT INTO `grouppermission` (`id`, `group`, `permission`, `added`) VALUES
(1, 1, 1, 1324211935);

--
-- Table structure for view `permissions_by_group`
--
DROP VIEW IF EXISTS `permissions_by_group`;
CREATE VIEW `permissions_by_group` AS (
  SELECT 
    `g`.`id` AS `group`,
    `p`.*
  FROM
    `grouppermission` as `gp`
    LEFT JOIN `group` AS `g` ON `gp`.`group`=`g`.`id`
    LEFT JOIN `permission` AS `p` on `gp`.`permission`=`p`.`id`
);

--
-- Table structure for view `permissions_by_user`
--
DROP VIEW IF EXISTS `permissions_by_user`;
CREATE VIEW `permissions_by_user` AS (
  SELECT 
    `u`.`id` AS `user`,
    `p`.*
  FROM
    `usergroup` as `ug`
    LEFT JOIN `user` AS `u` ON `ug`.`user`=`u`.`id`
    LEFT JOIN `permissions_by_group` AS `p` on `ug`.`group`=`p`.`group`
);

--
-- Table structure for view `permission_unmatchedgroups`
--
DROP VIEW IF EXISTS `permission_unmatchedgroups`;
CREATE VIEW `permission_unmatchedgroups` AS (
  SELECT DISTINCT
    `p`.*,
    `g`.`id` AS `group`
  FROM
    `permission` AS `p`
    CROSS JOIN `group` AS `g`
    LEFT JOIN `grouppermission` AS `gp` ON
      `gp`.`group` = `g`.`id`
      AND `gp`.`permission` = `p`.`id`
  WHERE
    `gp`.`id` IS NULL
);

--
-- Table structure for view `permission_unmatchedusers`
--
DROP VIEW IF EXISTS `permission_unmatchedusers`;
CREATE VIEW `permission_unmatchedusers` AS (
  SELECT DISTINCT
    `p`.*,
    `u`.`id` AS `user`
  FROM
    `permission` AS `p`
    CROSS JOIN `user` AS `u`
    LEFT JOIN `usergroup` AS `ug` ON `ug`.`user` = `u`.`id`
    LEFT JOIN `group` AS `g` ON `ug`.`group` = `g`.`id`
    LEFT JOIN `grouppermission` AS `gp` ON
      `gp`.`group` = `g`.`id`
      AND `gp`.`permission` = `p`.`id`
  WHERE
    `gp`.`id` IS NULL
);

--
-- Constraints for table `grouppermission`
--
ALTER TABLE `grouppermission`
  ADD CONSTRAINT `grouppermission_ibfk_2` FOREIGN KEY (`permission`) REFERENCES `permission` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `grouppermission_ibfk_1` FOREIGN KEY (`group`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `usergroup`
--
ALTER TABLE `usergroup`
  ADD CONSTRAINT `usergroup_ibfk_2` FOREIGN KEY (`group`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `usergroup_ibfk_1` FOREIGN KEY (`user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
