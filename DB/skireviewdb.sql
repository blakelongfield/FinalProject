-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema skireviewdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `skireviewdb` ;

-- -----------------------------------------------------
-- Schema skireviewdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `skireviewdb` DEFAULT CHARACTER SET utf8 ;
USE `skireviewdb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `role` VARCHAR(45) NOT NULL DEFAULT 'standard',
  `active` TINYINT(1) NOT NULL DEFAULT 1,
  `profile_pic_url` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `resort`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `resort` ;

CREATE TABLE IF NOT EXISTS `resort` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(255) NOT NULL,
  `street2` VARCHAR(255) NULL,
  `city` VARCHAR(100) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zip` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `acres` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mountain`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mountain` ;

CREATE TABLE IF NOT EXISTS `mountain` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `number_of_trails` INT NOT NULL,
  `number_of_lifts` INT NOT NULL,
  `elevation_base` INT NOT NULL,
  `elevation_peak` INT NOT NULL,
  `mountain_map_url` VARCHAR(255) NULL,
  `location_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_mountain_location1_idx` (`location_id` ASC),
  CONSTRAINT `fk_mountain_location1`
    FOREIGN KEY (`location_id`)
    REFERENCES `resort` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trail` ;

CREATE TABLE IF NOT EXISTS `trail` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `difficulty` ENUM('BEGINNER', 'INTERMEDIATE', 'HARD', 'EXPERT') NOT NULL DEFAULT 'BEGINNER',
  `length` INT NULL,
  `elevation_gain_loss` INT NULL,
  `features` VARCHAR(100) NULL,
  `mountain_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_trail_mountain1_idx` (`mountain_id` ASC),
  CONSTRAINT `fk_trail_mountain1`
    FOREIGN KEY (`mountain_id`)
    REFERENCES `mountain` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `report`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `report` ;

CREATE TABLE IF NOT EXISTS `report` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `report_text` TEXT NULL,
  `rating` INT NULL,
  `image_url` VARCHAR(255) NULL,
  `date_created` DATETIME NULL DEFAULT current_timestamp,
  `vote` INT NULL,
  `user_id` INT NOT NULL,
  `trail_id` INT NULL,
  `mountain_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_report_user_idx` (`user_id` ASC),
  INDEX `fk_report_trail1_idx` (`trail_id` ASC),
  INDEX `fk_report_mountain1_idx` (`mountain_id` ASC),
  CONSTRAINT `fk_report_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_report_trail1`
    FOREIGN KEY (`trail_id`)
    REFERENCES `trail` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_report_mountain1`
    FOREIGN KEY (`mountain_id`)
    REFERENCES `mountain` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chairlift_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chairlift_type` ;

CREATE TABLE IF NOT EXISTS `chairlift_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NULL,
  `capacity` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chairlift`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chairlift` ;

CREATE TABLE IF NOT EXISTS `chairlift` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ride_length` INT NULL,
  `hours` VARCHAR(45) NULL,
  `chairlift_type_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_chairlift_chairlift_type1_idx` (`chairlift_type_id` ASC),
  CONSTRAINT `fk_chairlift_chairlift_type1`
    FOREIGN KEY (`chairlift_type_id`)
    REFERENCES `chairlift_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chairlift_has_trail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chairlift_has_trail` ;

CREATE TABLE IF NOT EXISTS `chairlift_has_trail` (
  `chairlift_id` INT NOT NULL,
  `trail_id` INT NOT NULL,
  PRIMARY KEY (`chairlift_id`, `trail_id`),
  INDEX `fk_chairlifts_has_trail_trail1_idx` (`trail_id` ASC),
  INDEX `fk_chairlifts_has_trail_chairlifts1_idx` (`chairlift_id` ASC),
  CONSTRAINT `fk_chairlifts_has_trail_chairlifts1`
    FOREIGN KEY (`chairlift_id`)
    REFERENCES `chairlift` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_chairlifts_has_trail_trail1`
    FOREIGN KEY (`trail_id`)
    REFERENCES `trail` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comment` ;

CREATE TABLE IF NOT EXISTS `comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comment_text` TEXT NOT NULL,
  `report_id` INT NULL,
  `user_id` INT NOT NULL,
  `comment_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comment_report1_idx` (`report_id` ASC),
  INDEX `fk_comment_user1_idx` (`user_id` ASC),
  INDEX `fk_comment_comment1_idx` (`comment_id` ASC),
  CONSTRAINT `fk_comment_report1`
    FOREIGN KEY (`report_id`)
    REFERENCES `report` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_comment1`
    FOREIGN KEY (`comment_id`)
    REFERENCES `comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS skier@loaclhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'skier'@'loaclhost' IDENTIFIED BY 'skier';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'skier'@'loaclhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `skireviewdb`;
INSERT INTO `user` (`id`, `first_name`, `last_name`, `username`, `password`, `email`, `role`, `active`, `profile_pic_url`) VALUES (1, 'Zachary', 'Lamb', 'zach', 'zach', 'zach@zach.com', 'Admin', 1, NULL);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `username`, `password`, `email`, `role`, `active`, `profile_pic_url`) VALUES (2, 'Kyle', 'Paladini', 'kyle', 'kyle', 'kyle@kyle.com', 'Admin', 1, NULL);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `username`, `password`, `email`, `role`, `active`, `profile_pic_url`) VALUES (3, 'Tyler', 'Paladini', 'tyler', 'tyler', 'tyler@tyler.com', 'Admin', 1, NULL);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `username`, `password`, `email`, `role`, `active`, `profile_pic_url`) VALUES (4, 'Blake', 'Longfield', 'blake', 'blake', 'blake@blake.com', 'Admin', 1, NULL);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `username`, `password`, `email`, `role`, `active`, `profile_pic_url`) VALUES (5, 'John', 'smith', 'john', 'john', 'john@john.com', 'Standard', 1, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `resort`
-- -----------------------------------------------------
START TRANSACTION;
USE `skireviewdb`;
INSERT INTO `resort` (`id`, `street`, `street2`, `city`, `state`, `zip`, `name`, `acres`) VALUES (1, '28194 US Hwy 6', NULL, 'Keystone', 'CO', '80435', 'Arapahoe Basin', '1428');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mountain`
-- -----------------------------------------------------
START TRANSACTION;
USE `skireviewdb`;
INSERT INTO `mountain` (`id`, `name`, `number_of_trails`, `number_of_lifts`, `elevation_base`, `elevation_peak`, `mountain_map_url`, `location_id`) VALUES (1, 'Arapahoe Basin', 145, 9, 10780, 13050, NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `trail`
-- -----------------------------------------------------
START TRANSACTION;
USE `skireviewdb`;
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (1, 'Lower Chisholm Trail', 'BEGINNER', NULL, NULL, NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `report`
-- -----------------------------------------------------
START TRANSACTION;
USE `skireviewdb`;
INSERT INTO `report` (`id`, `report_text`, `rating`, `image_url`, `date_created`, `vote`, `user_id`, `trail_id`, `mountain_id`) VALUES (1, 'Great Powder Todal', 5, NULL, '2019-01-01 00:00:00', NULL, 1, 1, NULL);
INSERT INTO `report` (`id`, `report_text`, `rating`, `image_url`, `date_created`, `vote`, `user_id`, `trail_id`, `mountain_id`) VALUES (2, 'This place is awesome', NULL, NULL, '2019-01-01 00:00:00', NULL, 1, NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `chairlift_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `skireviewdb`;
INSERT INTO `chairlift_type` (`id`, `type`, `capacity`) VALUES (1, 'Express', '4');

COMMIT;


-- -----------------------------------------------------
-- Data for table `chairlift`
-- -----------------------------------------------------
START TRANSACTION;
USE `skireviewdb`;
INSERT INTO `chairlift` (`id`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (1, NULL, '9:00 AM - 4:00 PM', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `skireviewdb`;
INSERT INTO `comment` (`id`, `comment_text`, `report_id`, `user_id`, `comment_id`) VALUES (1, 'Awesome powder', 1, 5, NULL);
INSERT INTO `comment` (`id`, `comment_text`, `report_id`, `user_id`, `comment_id`) VALUES (2, 'Totally', NULL, 5, 1);
INSERT INTO `comment` (`id`, `comment_text`, `report_id`, `user_id`, `comment_id`) VALUES (3, 'Yes', NULL, 5, 2);
INSERT INTO `comment` (`id`, `comment_text`, `report_id`, `user_id`, `comment_id`) VALUES (4, 'Nope', NULL, 5, 1);

COMMIT;

