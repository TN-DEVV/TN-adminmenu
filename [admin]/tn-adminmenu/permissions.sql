CREATE TABLE IF NOT EXISTS `adminmenu` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `license` varchar(255) DEFAULT NULL,
  `citizenid` varchar(255) DEFAULT NULL,
  `permission` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1;
