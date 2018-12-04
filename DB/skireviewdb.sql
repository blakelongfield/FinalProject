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
  `acres` INT NULL,
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
  `resort_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_mountain_resort1_idx` (`resort_id` ASC),
  CONSTRAINT `fk_mountain_resort1`
    FOREIGN KEY (`resort_id`)
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
  `difficulty` ENUM('BEGINNER', 'INTERMEDIATE', 'HARD', 'EXPERT', 'TERRAINPARK') NOT NULL DEFAULT 'BEGINNER',
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
  `name` VARCHAR(45) NOT NULL,
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


-- -----------------------------------------------------
-- Table `day_of_week`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `day_of_week` ;

CREATE TABLE IF NOT EXISTS `day_of_week` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `weekday` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hours`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hours` ;

CREATE TABLE IF NOT EXISTS `hours` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `time` TIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `day_of_week_has_hours`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `day_of_week_has_hours` ;

CREATE TABLE IF NOT EXISTS `day_of_week_has_hours` (
  `day_of_week_id` INT NOT NULL,
  `hours_id` INT NOT NULL,
  PRIMARY KEY (`day_of_week_id`, `hours_id`),
  INDEX `fk_day_of_week_has_hours_hours1_idx` (`hours_id` ASC),
  INDEX `fk_day_of_week_has_hours_day_of_week1_idx` (`day_of_week_id` ASC),
  CONSTRAINT `fk_day_of_week_has_hours_day_of_week1`
    FOREIGN KEY (`day_of_week_id`)
    REFERENCES `day_of_week` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_day_of_week_has_hours_hours1`
    FOREIGN KEY (`hours_id`)
    REFERENCES `hours` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS user@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'user'@'localhost' IDENTIFIED BY 'user';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'user'@'localhost';

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
INSERT INTO `resort` (`id`, `street`, `street2`, `city`, `state`, `zip`, `name`, `acres`) VALUES (1, '28194 US Hwy 6', NULL, 'Keystone', 'CO', '80435', 'Arapahoe Basin', 1428);
INSERT INTO `resort` (`id`, `street`, `street2`, `city`, `state`, `zip`, `name`, `acres`) VALUES (2, 'Vail', NULL, 'Vail', 'CO', '81658', 'Vail', 5289);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mountain`
-- -----------------------------------------------------
START TRANSACTION;
USE `skireviewdb`;
INSERT INTO `mountain` (`id`, `name`, `number_of_trails`, `number_of_lifts`, `elevation_base`, `elevation_peak`, `mountain_map_url`, `resort_id`) VALUES (1, 'Arapahoe Basin', 145, 9, 10780, 13050, NULL, 1);
INSERT INTO `mountain` (`id`, `name`, `number_of_trails`, `number_of_lifts`, `elevation_base`, `elevation_peak`, `mountain_map_url`, `resort_id`) VALUES (2, 'Vail', 195, 31, 8120, 11570, NULL, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `trail`
-- -----------------------------------------------------
START TRANSACTION;
USE `skireviewdb`;
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (1, 'High Noon', 'INTERMEDIATE', NULL, NULL, 'Groomed', 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (2, 'Lynx Lane', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (3, 'Moose Hollow', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (4, 'North Fork', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (5, 'Ramrod', 'INTERMEDIATE', NULL, NULL, 'Groomed', 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (6, 'TB Glades', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (7, 'Weasel Way', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (8, 'Lower Chisholm Trail', 'BEGINNER', NULL, NULL, 'Groomed', 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (9, 'Upper Chisholm Trail', 'BEGINNER', NULL, NULL, 'Groomed', 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (10, 'Sundance', 'BEGINNER', NULL, NULL, 'Groomed', 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (11, 'Wrangler', 'BEGINNER', NULL, NULL, 'Groomed', 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (12, 'High Divide', 'TERRAINPARK', NULL, NULL, 'Terrain Park', 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (13, 'Banana Park', 'TERRAINPARK', NULL, NULL, 'Terrain Park, Groomed', 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (14, 'East Wall - Below the Traverse', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (15, 'Land of the Giants', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (16, 'Corner Chute', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (17, 'North Pole', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (18, 'North Y Chute', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (19, 'South Y Chute', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (20, 'Tree Chute 1', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (21, 'Tree Chute 2', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (22, 'Tree Chute 3', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (23, 'Tree Chute 4', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (24, 'Tree Chute 5', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (25, 'Tree Chute 6', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (26, 'Tree Chute 7', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (27, 'Tree Chute 8', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (28, 'Willy\'s Wide', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (29, 'Cabin Glades', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (30, 'Dragon', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (31, 'East Gully', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (32, 'Falcon', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (33, 'Gentry', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (34, 'Half Moon Glades', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (35, 'Lenawee Parks', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (36, 'Mountain Goat Alley', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (37, 'West Gully', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (38, 'Treeline', 'TERRAINPARK', NULL, NULL, 'Terrain Park', 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (39, 'Dercum\'s Gulch', 'INTERMEDIATE', NULL, NULL, 'Groomed', 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (40, 'Humbug', 'INTERMEDIATE', NULL, NULL, 'Groomed', 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (41, 'Jamie\'s Face', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (42, 'Lenawee Face', 'INTERMEDIATE', NULL, NULL, 'Groomed', 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (43, 'Norway Face', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (44, 'Norway Mountain Run', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (45, 'Powerline', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (46, 'Cornice Run', 'INTERMEDIATE', NULL, NULL, 'Groomed', 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (47, 'King Cornice', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (48, 'Knolls', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (49, 'West Wall', 'INTERMEDIATE', NULL, NULL, 'Groomed', 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (50, 'Challenger', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (51, 'No Name', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (52, 'Radical', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (53, 'Scudder', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (54, '13 Cornices', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (55, 'Bear Trap', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (56, 'International', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (57, 'My Chute', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (58, 'North Glade', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (59, 'Roller Coaster', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (60, 'Timber Glades', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (61, '1st Alley - David\'s Run', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (62, '2nd Alley', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (63, '3rd Alley', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (64, '4th Alley (West Alley)', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (65, 'East Avenue', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (66, 'Gauthier', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (67, 'Pali Face', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (68, 'Pali Main Street', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (69, 'Pali Wog', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (70, 'Rock Garden', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (71, 'The Spine', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (72, 'Turbo', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (73, 'West Turbo', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (74, 'Grizzly Road', 'INTERMEDIATE', NULL, NULL, 'Groomed', 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (75, 'North Chute', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (76, 'Nose', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (77, 'Powder Keg', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (78, 'Slalom Slope', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (79, 'South Chute', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (80, 'Wildcate', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (81, 'Exhibition', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (82, 'Standard', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (83, 'The Gulch', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (84, 'Bald Spot', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (85, 'Christmas Trees', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (86, 'Grand Portage', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (87, 'Janitors Only', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (88, 'SG1', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (89, 'SG2', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (90, 'SG3', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (91, 'SG4', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (92, 'SG5', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (93, 'The Cellar', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (94, 'Steep Gullies Hike Back Trail', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (95, 'Bierstadt', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (96, 'Grays', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (97, 'Lightning Traverse', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (98, 'Log Roll', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (99, 'Mountain Goat Traverse', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (100, 'Northern Spy', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (101, 'Placer Junction', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (102, 'Tieze\'s Claim', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (103, 'Torreys', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (104, 'Black Forest', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (105, 'Crags', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (106, 'Davo', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (107, 'Lightning Trees', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (108, 'Elephant\'s Trunk - Lower', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (109, 'Black Bear', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (110, 'Durrance', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (111, 'Groswold', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (112, 'Long Chute', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (113, 'Max', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (114, 'Zuma Cornice', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (115, 'Columbine', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (116, 'Elk Meadows', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (117, 'Independence', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (118, 'Larkspur', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (119, 'Miner\'s Glade', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (120, 'Ned\'s Cache', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (121, 'Shining Light', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (122, 'Elephant\'s Trunk - Upper', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (123, 'End Zone', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (124, 'Eureka', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (125, 'Gentling\'s Glade', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (126, 'Jump', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (127, 'Monezuma\'s Revenge', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (128, 'Schauffler', 'EXPERT', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (129, 'Winning Card', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (130, 'Davis', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (131, 'Loafer', 'INTERMEDIATE', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (132, 'Bailey Bros.', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (133, 'Castor', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (134, 'East Woods', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (135, 'Face Shot Gully', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (136, 'Porcupine', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (137, 'Thick & Thin', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (138, 'Digger', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (139, 'Alex', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (140, 'Beaver Bowl', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (141, 'Bighorn', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (142, 'Dreamcatcher', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (143, 'Drummond', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (144, 'Faculty Club', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (145, 'Glockenspiel Glade', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (146, 'Hauk', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (147, 'Jaeger', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (148, 'Jetta', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (149, 'Marmot', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (150, 'Peaceful Valley', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (151, 'Pioneet Willy', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (152, 'Ptarmigan', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (153, 'The Last Waltz', 'HARD', NULL, NULL, NULL, 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (154, 'Molly Hogan', 'BEGINNER', NULL, NULL, 'Groomed', 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (155, 'Pika Place', 'BEGINNER', NULL, NULL, 'Groomed', 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (156, 'Boomer', 'BEGINNER', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (157, 'Brisk Walk', 'BEGINNER', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (158, 'Flap Jack - Lower', 'BEGINNER', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (159, 'Flap Jack - Upper', 'BEGINNER', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (160, 'Gopher Hill', 'BEGINNER', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (161, 'Grand Junction Catwalk', 'BEGINNER', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (162, 'Mill Creek Road', 'BEGINNER', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (163, 'Northface Catwalk - Upper', 'BEGINNER', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (164, 'Riva Catwalk', 'BEGINNER', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (165, 'Sourdough', 'BEGINNER', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (166, 'Timberline Catwalk', 'BEGINNER', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (167, 'Tin Pants', 'BEGINNER', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (168, 'Transmontane', 'BEGINNER', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (169, 'Choker Cutoff', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (170, 'Highline Runout', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (171, 'Northface Catwalk - Lower', 'INTERMEDIATE', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (172, 'Northwoods', 'INTERMEDIATE', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (173, 'Rngr Racoon', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (174, 'Ruder\'s Run', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (175, 'Skid Road', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (176, 'Snag Park', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (177, 'Timberline Face', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (178, 'Whippersnapper', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (179, 'Whiskey jack', 'INTERMEDIATE', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (180, 'Blue Ox', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (181, 'First Step', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (182, 'Gandy Dancer', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (183, 'Hairbag Alley', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (184, 'Klickity Klack', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (185, 'Log Chute', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (186, 'North Rim', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (187, 'Northstar', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (188, 'Prima', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (189, 'South Rim', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (190, 'Tourist Trap', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (191, 'Highline', 'EXPERT', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (192, 'Prima Cornice', 'EXPERT', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (193, 'Pronto', 'EXPERT', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (194, 'Roger\'s Run', 'EXPERT', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (195, 'Golden Peak Half Pipe', 'TERRAINPARK', NULL, NULL, 'Half Pipe', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (196, 'Golden Peak Terrain Park', 'TERRAINPARK', NULL, NULL, 'Terrain Park', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (197, 'Cold Feet', 'BEGINNER', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (198, 'Gitalong Road', 'BEGINNER', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (199, 'Overeasy', 'BEGINNER', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (200, 'Swingsville', 'BEGINNER', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (201, 'The Meadows', 'BEGINNER', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (202, 'Vail Village Catwalk', 'BEGINNER', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (203, 'Windisch Way', 'BEGINNER', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (204, 'Avanti', 'INTERMEDIATE', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (205, 'Bear Tree', 'INTERMEDIATE', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (206, 'Ben\'s Face', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (207, 'Cappuccino', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (208, 'Christmas', 'INTERMEDIATE', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (209, 'EpicMix Racing', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (210, 'Hunky Dory', 'INTERMEDIATE', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (211, 'Mid-Vail Express', 'INTERMEDIATE', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (212, 'Ramshorn', 'INTERMEDIATE', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (213, 'Slifer Express', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (214, 'Spruce Face', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (215, 'Whistle Pig', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (216, '38', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (217, 'Cady\'s Café', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (218, 'Challenge', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (219, 'Cookshack', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (220, 'Giant Steps', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (221, 'Head First', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (222, 'Kangaroo Cornice', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (223, 'Lindsey\'s', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (224, 'Look Ma', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (225, 'Pepi\'s Face', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (226, 'Powerline', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (227, 'Powerline Glade', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (228, 'Riva (Lower)', 'HARD', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (229, 'Riva (Upper)', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (230, 'Riva Glade', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (231, 'S. Look Ma', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (232, 'The Skipper', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (233, 'Windows Road', 'HARD', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (234, 'Zot', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (235, 'Frontside Chutes', 'EXPERT', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (236, 'Mudslide', 'EXPERT', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (237, 'Pumphouse', 'EXPERT', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (238, 'The Narrows', 'EXPERT', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (239, 'Chair 15', 'BEGINNER', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (240, 'Coyote Crossing', 'BEGINNER', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (241, 'Cubs Way', 'BEGINNER', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (242, 'Eagle\'s Nest Ridge', 'BEGINNER', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (243, 'Game Trail', 'BEGINNER', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (244, 'Ha Ha Highway', 'BEGINNER', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (245, 'Lion\'s Way', 'BEGINNER', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (246, 'Lionshead Catwalk', 'BEGINNER', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (247, 'Lost Boy', 'BEGINNER', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (248, 'Minnie Haha', 'BEGINNER', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (249, 'Pika', 'BEGINNER', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (250, 'Post Road', 'BEGINNER', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (251, 'Practice Pkwy', 'BEGINNER', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (252, 'Ski School Ledges', 'BEGINNER', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (253, 'The Preserve', 'BEGINNER', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (254, 'Baccarat', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (255, 'Born Free (Lwr)', 'INTERMEDIATE', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (256, 'Born Free (Upr)', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (257, 'Bwana (Lower)', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (258, 'Cascade Way', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (259, 'Cheetah', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (260, 'Columbine', 'INTERMEDIATE', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (261, 'Dealer\'s Choice', 'INTERMEDIATE', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (262, 'Ledges', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (263, 'Lodgepole', 'INTERMEDIATE', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (264, 'Pickeroon', 'INTERMEDIATE', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (265, 'Pride', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (266, 'Safari', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (267, 'Showboat', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (268, 'Simba (Lower)', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (269, 'Simba (Upper)', 'INTERMEDIATE', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (270, 'The Woods', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (271, 'Berries', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (272, 'Cheetah Gully', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (273, 'Deuces Wild', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (274, 'Faro', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (275, 'Minnie\'s', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (276, 'Ouzo', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (277, 'Ouzo Glade', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (278, 'Wildcard', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (279, 'Bwana Park', 'TERRAINPARK', NULL, NULL, 'Terrain Park', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (280, 'Pride Park', 'TERRAINPARK', NULL, NULL, 'Terrain Park', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (281, 'Sleepytime Road', 'INTERMEDIATE', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (282, 'Apres Vous', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (283, 'Campbells', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (284, 'Chicken Yard', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (285, 'Cow\'s Face', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (286, 'Forever', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (287, 'Headwall', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (288, 'Milt\'s Face', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (289, 'Morningside Ridge', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (290, 'Never', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (291, 'OS', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (292, 'Over Yonder', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (293, 'Ptarmigan Ridge', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (294, 'Ricky\'s Ridge', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (295, 'Seldom', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (296, 'Straight Shot', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (297, 'Sun Down Catwalk', 'HARD', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (298, 'Sun Up Catwalk', 'HARD', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (299, 'Tea Cup Glades', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (300, 'The Slot', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (301, 'WFO', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (302, 'Widge\'s Ridge', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (303, 'Windows', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (304, 'Wow', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (305, 'Yonder', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (306, 'Yonder Gully', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (307, 'Chopstix', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (308, 'Poppyfields E.', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (309, 'Poppyfields W.', 'INTERMEDIATE', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (310, 'Silk Road', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (311, 'Bolshoi Ballroom', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (312, 'Emperor\'s Choice', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (313, 'Genghis Khan', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (314, 'Gorky Park', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (315, 'Inner Mongolia', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (316, 'Jade Glade', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (317, 'Morning Thunder', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (318, 'Orient Express', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (319, 'Outer Mongolia', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (320, 'Rasputins', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (321, 'Red Square', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (322, 'Red Zinger', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (323, 'Shangri-La', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (324, 'Sweet N Sour', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (325, 'Big Rock Park', 'INTERMEDIATE', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (326, 'China Spur', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (327, 'Cloud 9', 'INTERMEDIATE', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (328, 'Grand Review', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (329, 'In the Wuides', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (330, 'Kelly\'s Toll Road', 'INTERMEDIATE', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (331, 'Montane Glade', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (332, 'Resolution', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (333, 'The Star', 'INTERMEDIATE', NULL, NULL, 'Groomed', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (334, 'Champagne Glade', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (335, 'Divide Ridge', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (336, 'Encore', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (337, 'Heavy Metal', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (338, 'Hornsilver', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (339, 'Iron Mask', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (340, 'Little Ollie', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (341, 'Lovers Leap', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (342, 'Skree Field', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (343, 'Steep and Deep', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (344, 'The Divide', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (345, 'Golden Peak Race', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (346, 'Pony Express', 'INTERMEDIATE', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (347, 'Dragon\'s Teeth', 'HARD', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (348, 'Eagle\'s Nest Expressway', 'BEGINNER', NULL, NULL, NULL, 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (349, 'Ridge Route', 'BEGINNER', NULL, NULL, NULL, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `report`
-- -----------------------------------------------------
START TRANSACTION;
USE `skireviewdb`;
INSERT INTO `report` (`id`, `report_text`, `rating`, `image_url`, `date_created`, `vote`, `user_id`, `trail_id`, `mountain_id`) VALUES (1, 'Great Powder Today', 5, NULL, '2019-01-01 00:00:00', NULL, 1, 1, NULL);
INSERT INTO `report` (`id`, `report_text`, `rating`, `image_url`, `date_created`, `vote`, `user_id`, `trail_id`, `mountain_id`) VALUES (2, 'This place is awesome', NULL, NULL, '2019-01-01 00:00:00', NULL, 1, NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `chairlift_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `skireviewdb`;
INSERT INTO `chairlift_type` (`id`, `type`, `capacity`) VALUES (1, 'Express Chairlift', '4');
INSERT INTO `chairlift_type` (`id`, `type`, `capacity`) VALUES (2, 'Chairlift', '4');
INSERT INTO `chairlift_type` (`id`, `type`, `capacity`) VALUES (3, 'Chairlift', '3');
INSERT INTO `chairlift_type` (`id`, `type`, `capacity`) VALUES (4, 'Chairlift', '2');
INSERT INTO `chairlift_type` (`id`, `type`, `capacity`) VALUES (5, 'Carpet lift', '1');
INSERT INTO `chairlift_type` (`id`, `type`, `capacity`) VALUES (6, 'Surface lift', '1');
INSERT INTO `chairlift_type` (`id`, `type`, `capacity`) VALUES (7, 'Express Chairlift', '6');
INSERT INTO `chairlift_type` (`id`, `type`, `capacity`) VALUES (8, 'Gondola', '12');
INSERT INTO `chairlift_type` (`id`, `type`, `capacity`) VALUES (9, 'Gondola', '10');

COMMIT;


-- -----------------------------------------------------
-- Data for table `chairlift`
-- -----------------------------------------------------
START TRANSACTION;
USE `skireviewdb`;
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (1, 'Black Mountain Express Lift', NULL, NULL, 1);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (2, 'Zuma Lift', NULL, NULL, 2);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (3, 'Beavers Lift', NULL, NULL, 2);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (4, 'Lenawee Mountain Lift', NULL, NULL, 3);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (5, 'Pallavicini Lift', NULL, NULL, 4);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (6, 'MollyHogan Lift', NULL, NULL, 4);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (7, 'Molly Carpet Lift', NULL, NULL, 5);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (8, 'Pika Place Carpet Lift', NULL, NULL, 5);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (9, 'Lazy J Tow', NULL, NULL, 6);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (10, 'Avanti Express Lift', NULL, NULL, 7);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (11, 'Wildwood Express Lift', NULL, NULL, 1);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (12, 'Mountain Top Epress Lift', NULL, NULL, 7);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (13, 'High Noon Express', NULL, NULL, 1);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (14, 'Riva Bahn Express', NULL, NULL, 1);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (15, 'Game Creek Express Lift', NULL, NULL, 1);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (16, 'Born Free Express Lift', NULL, NULL, 1);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (17, 'Sun Up Express Lift', NULL, NULL, 1);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (18, 'Highline Express Lift', NULL, NULL, 1);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (19, 'Northwoods Express Lift', NULL, NULL, 1);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (20, 'Gopher Hill Lift', NULL, NULL, 4);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (21, 'Sourdough Express Lift', NULL, NULL, 1);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (22, 'Little Eagle Lift', NULL, NULL, 3);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (23, 'Gondola One', NULL, NULL, 9);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (24, 'Eagle\'s Nest Carpet Lift', NULL, NULL, 5);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (25, 'Eagle Bahn Gondola', NULL, NULL, 8);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (26, 'Cascade Village', NULL, NULL, 2);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (27, 'Orient Express Lift', NULL, NULL, 1);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (28, 'Mongolia Surface LIft', NULL, NULL, 6);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (29, 'Wapiti Surface Lift', NULL, NULL, 6);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (30, 'Golden Peak Carpet Lift', NULL, NULL, 5);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (31, 'Pride Express LIft', NULL, NULL, 1);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (32, 'Black Forest Surface Lift', NULL, NULL, 6);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (33, 'Golden Peak Carpet Lift', NULL, NULL, 5);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (34, 'Golden Peak Carpet Lift', NULL, NULL, 5);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (35, 'Lionshead Carpet Lift', NULL, NULL, 5);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (36, 'Eagle\'s Nest Carpet Lift', NULL, NULL, 5);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (37, 'Tea Cup Express Lift', NULL, NULL, 1);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (38, 'SkyLine Express Lift', NULL, NULL, 1);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (39, 'Earl\'s Express Lift', NULL, NULL, 1);
INSERT INTO `chairlift` (`id`, `name`, `ride_length`, `hours`, `chairlift_type_id`) VALUES (40, 'Pete\'s Express Lift', NULL, NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `chairlift_has_trail`
-- -----------------------------------------------------
START TRANSACTION;
USE `skireviewdb`;
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (18, 159);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (18, 191);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (18, 180);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (18, 167);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (14, 345);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (14, 196);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (14, 346);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (14, 174);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (14, 157);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (14, 169);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (14, 185);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (29, 309);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (29, 347);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (29, 310);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (19, 166);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (19, 189);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (19, 309);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (19, 200);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (19, 212);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (19, 281);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (19, 300);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (19, 282);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (19, 286);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (19, 304);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (12, 166);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (12, 189);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (12, 309);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (12, 200);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (12, 212);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (12, 281);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (12, 300);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (12, 282);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (12, 286);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (12, 304);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (13, 166);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (13, 189);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (13, 309);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (13, 200);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (13, 212);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (13, 281);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (13, 300);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (13, 282);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (13, 286);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (13, 304);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (11, 293);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (11, 233);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (11, 210);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (11, 348);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (11, 273);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (15, 267);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (15, 278);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (15, 247);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (10, 211);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (10, 348);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (10, 349);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (10, 276);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (10, 277);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (23, 245);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (23, 198);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (32, 204);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (32, 104);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (20, 160);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (30, 160);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (22, 240);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (24, 240);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (36, 240);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (25, 240);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (25, 241);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (25, 256);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (16, 241);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (16, 256);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (31, 241);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (26, 250);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (17, 306);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (17, 305);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (17, 316);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (17, 312);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (17, 179);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (37, 306);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (37, 305);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (37, 316);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (37, 312);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (37, 179);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (27, 310);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (27, 308);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (28, 310);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (28, 311);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (28, 315);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (40, 328);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (40, 338);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (40, 332);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (38, 327);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (38, 344);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (38, 343);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (38, 334);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (39, 327);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (39, 344);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (39, 343);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (39, 334);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (6, 154);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (1, 1);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (1, 12);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (1, 10);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (1, 2);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (1, 11);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (5, 68);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (5, 134);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (5, 78);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (5, 74);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (3, 131);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (3, 46);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (4, 45);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (4, 42);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (4, 43);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (4, 112);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (2, 99);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (2, 1);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (2, 118);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (9, 99);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (9, 1);
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (9, 118);

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


-- -----------------------------------------------------
-- Data for table `day_of_week`
-- -----------------------------------------------------
START TRANSACTION;
USE `skireviewdb`;
INSERT INTO `day_of_week` (`id`, `weekday`) VALUES (1, 'Sunday');
INSERT INTO `day_of_week` (`id`, `weekday`) VALUES (2, 'Monday');
INSERT INTO `day_of_week` (`id`, `weekday`) VALUES (3, 'Tuesday');
INSERT INTO `day_of_week` (`id`, `weekday`) VALUES (4, 'Wednesday');
INSERT INTO `day_of_week` (`id`, `weekday`) VALUES (5, 'Thursday');
INSERT INTO `day_of_week` (`id`, `weekday`) VALUES (6, 'Friday');
INSERT INTO `day_of_week` (`id`, `weekday`) VALUES (7, 'Saturday');
INSERT INTO `day_of_week` (`id`, `weekday`) VALUES (8, 'Weekdays');
INSERT INTO `day_of_week` (`id`, `weekday`) VALUES (9, 'Weekends');
INSERT INTO `day_of_week` (`id`, `weekday`) VALUES (10, 'Holidays');
INSERT INTO `day_of_week` (`id`, `weekday`) VALUES (11, '7 days a week');

COMMIT;


-- -----------------------------------------------------
-- Data for table `hours`
-- -----------------------------------------------------
START TRANSACTION;
USE `skireviewdb`;
INSERT INTO `hours` (`id`, `time`) VALUES (1, '00:00');
INSERT INTO `hours` (`id`, `time`) VALUES (2, '00:30');
INSERT INTO `hours` (`id`, `time`) VALUES (3, '01:00');
INSERT INTO `hours` (`id`, `time`) VALUES (4, '01:30');
INSERT INTO `hours` (`id`, `time`) VALUES (5, '02:00');
INSERT INTO `hours` (`id`, `time`) VALUES (6, '02:30');
INSERT INTO `hours` (`id`, `time`) VALUES (7, '03:00');
INSERT INTO `hours` (`id`, `time`) VALUES (8, '03:30');
INSERT INTO `hours` (`id`, `time`) VALUES (9, '04:00');
INSERT INTO `hours` (`id`, `time`) VALUES (10, '04:30');
INSERT INTO `hours` (`id`, `time`) VALUES (11, '05:00');
INSERT INTO `hours` (`id`, `time`) VALUES (12, '05:30');
INSERT INTO `hours` (`id`, `time`) VALUES (13, '06:00');
INSERT INTO `hours` (`id`, `time`) VALUES (14, '06:30');
INSERT INTO `hours` (`id`, `time`) VALUES (15, '07:00');
INSERT INTO `hours` (`id`, `time`) VALUES (16, '07:30');
INSERT INTO `hours` (`id`, `time`) VALUES (17, '08:00');
INSERT INTO `hours` (`id`, `time`) VALUES (18, '08:30');
INSERT INTO `hours` (`id`, `time`) VALUES (19, '09:00');
INSERT INTO `hours` (`id`, `time`) VALUES (20, '09:30');
INSERT INTO `hours` (`id`, `time`) VALUES (21, '10:00');
INSERT INTO `hours` (`id`, `time`) VALUES (22, '10:30');
INSERT INTO `hours` (`id`, `time`) VALUES (23, '11:00');
INSERT INTO `hours` (`id`, `time`) VALUES (24, '11:30');
INSERT INTO `hours` (`id`, `time`) VALUES (25, '12:00');
INSERT INTO `hours` (`id`, `time`) VALUES (26, '12:30');
INSERT INTO `hours` (`id`, `time`) VALUES (27, '13:00');
INSERT INTO `hours` (`id`, `time`) VALUES (28, '13:30');
INSERT INTO `hours` (`id`, `time`) VALUES (29, '14:00');
INSERT INTO `hours` (`id`, `time`) VALUES (30, '14:30');
INSERT INTO `hours` (`id`, `time`) VALUES (31, '15:00');
INSERT INTO `hours` (`id`, `time`) VALUES (32, '15:30');
INSERT INTO `hours` (`id`, `time`) VALUES (33, '16:00');
INSERT INTO `hours` (`id`, `time`) VALUES (34, '16:30');
INSERT INTO `hours` (`id`, `time`) VALUES (35, '17:00');
INSERT INTO `hours` (`id`, `time`) VALUES (36, '17:30');
INSERT INTO `hours` (`id`, `time`) VALUES (37, '18:00');
INSERT INTO `hours` (`id`, `time`) VALUES (38, '18:30');
INSERT INTO `hours` (`id`, `time`) VALUES (39, '19:00');
INSERT INTO `hours` (`id`, `time`) VALUES (40, '19:30');
INSERT INTO `hours` (`id`, `time`) VALUES (41, '20:00');
INSERT INTO `hours` (`id`, `time`) VALUES (42, '20:30');
INSERT INTO `hours` (`id`, `time`) VALUES (43, '21:00');
INSERT INTO `hours` (`id`, `time`) VALUES (44, '21:30');
INSERT INTO `hours` (`id`, `time`) VALUES (45, '22:00');
INSERT INTO `hours` (`id`, `time`) VALUES (46, '22:30');
INSERT INTO `hours` (`id`, `time`) VALUES (47, '23:00');
INSERT INTO `hours` (`id`, `time`) VALUES (48, '23:30');

COMMIT;


-- -----------------------------------------------------
-- Data for table `day_of_week_has_hours`
-- -----------------------------------------------------
START TRANSACTION;
USE `skireviewdb`;
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 1);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 2);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 3);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 4);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 5);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 6);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 7);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 8);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 9);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 10);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 11);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 12);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 13);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 14);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 15);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 16);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 17);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 18);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 19);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 20);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 21);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 22);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 23);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 24);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 25);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 26);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 27);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 28);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 29);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 30);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 31);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 32);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 33);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 34);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 35);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 36);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 37);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 38);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 39);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 40);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 41);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 42);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 43);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 44);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 45);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 46);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 47);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (1, 48);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 1);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 2);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 3);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 4);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 5);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 6);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 7);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 8);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 9);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 10);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 11);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 12);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 13);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 14);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 15);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 16);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 17);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 18);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 19);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 20);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 21);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 22);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 23);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 24);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 25);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 26);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 27);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 28);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 29);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 30);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 31);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 32);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 33);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 34);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 35);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 36);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 37);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 38);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 39);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 40);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 41);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 42);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 43);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 44);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 45);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 46);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 47);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (2, 48);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 1);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 2);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 3);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 4);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 5);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 6);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 7);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 8);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 9);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 10);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 11);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 12);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 13);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 14);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 15);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 16);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 17);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 18);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 19);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 20);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 21);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 22);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 23);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 24);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 25);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 26);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 27);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 28);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 29);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 30);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 31);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 32);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 33);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 34);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 35);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 36);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 37);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 38);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 39);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 40);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 41);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 42);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 43);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 44);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 45);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 46);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 47);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (3, 48);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 1);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 2);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 3);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 4);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 5);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 6);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 7);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 8);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 9);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 10);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 11);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 12);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 13);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 14);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 15);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 16);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 17);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 18);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 19);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 20);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 21);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 22);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 23);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 24);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 25);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 26);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 27);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 28);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 29);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 30);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 31);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 32);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 33);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 34);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 35);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 36);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 37);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 38);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 39);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 40);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 41);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 42);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 43);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 44);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 45);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 46);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 47);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (4, 48);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 1);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 2);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 3);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 4);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 5);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 6);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 7);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 8);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 9);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 10);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 11);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 12);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 13);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 14);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 15);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 16);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 17);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 18);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 19);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 20);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 21);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 22);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 23);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 24);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 25);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 26);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 27);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 28);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 29);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 30);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 31);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 32);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 33);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 34);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 35);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 36);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 37);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 38);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 39);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 40);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 41);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 42);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 43);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 44);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 45);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 46);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 47);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (5, 48);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 1);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 2);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 3);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 4);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 5);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 6);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 7);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 8);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 9);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 10);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 11);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 12);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 13);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 14);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 15);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 16);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 17);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 18);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 19);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 20);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 21);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 22);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 23);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 24);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 25);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 26);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 27);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 28);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 29);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 30);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 31);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 32);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 33);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 34);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 35);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 36);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 37);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 38);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 39);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 40);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 41);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 42);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 43);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 44);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 45);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 46);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 47);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (6, 48);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 1);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 2);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 3);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 4);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 5);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 6);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 7);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 8);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 9);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 10);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 11);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 12);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 13);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 14);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 15);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 16);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 17);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 18);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 19);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 20);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 21);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 22);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 23);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 24);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 25);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 26);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 27);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 28);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 29);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 30);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 31);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 32);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 33);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 34);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 35);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 36);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 37);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 38);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 39);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 40);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 41);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 42);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 43);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 44);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 45);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 46);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 47);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (7, 48);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 1);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 2);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 3);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 4);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 5);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 6);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 7);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 8);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 9);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 10);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 11);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 12);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 13);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 14);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 15);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 16);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 17);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 18);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 19);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 20);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 21);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 22);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 23);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 24);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 25);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 26);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 27);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 28);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 29);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 30);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 31);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 32);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 33);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 34);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 35);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 36);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 37);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 38);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 39);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 40);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 41);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 42);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 43);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 44);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 45);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 46);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 47);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (8, 48);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 1);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 2);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 3);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 4);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 5);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 6);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 7);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 8);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 9);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 10);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 11);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 12);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 13);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 14);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 15);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 16);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 17);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 18);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 19);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 20);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 21);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 22);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 23);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 24);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 25);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 26);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 27);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 28);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 29);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 30);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 31);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 32);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 33);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 34);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 35);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 36);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 37);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 38);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 39);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 40);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 41);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 42);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 43);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 44);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 45);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 46);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 47);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (9, 48);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 1);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 2);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 3);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 4);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 5);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 6);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 7);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 8);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 9);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 10);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 11);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 12);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 13);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 14);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 15);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 16);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 17);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 18);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 19);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 20);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 21);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 22);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 23);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 24);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 25);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 26);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 27);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 28);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 29);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 30);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 31);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 32);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 33);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 34);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 35);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 36);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 37);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 38);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 39);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 40);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 41);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 42);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 43);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 44);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 45);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 46);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 47);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (10, 48);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 1);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 2);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 3);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 4);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 5);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 6);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 7);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 8);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 9);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 10);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 11);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 12);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 13);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 14);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 15);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 16);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 17);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 18);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 19);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 20);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 21);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 22);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 23);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 24);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 25);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 26);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 27);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 28);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 29);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 30);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 31);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 32);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 33);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 34);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 35);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 36);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 37);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 38);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 39);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 40);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 41);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 42);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 43);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 44);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 45);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 46);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 47);
INSERT INTO `day_of_week_has_hours` (`day_of_week_id`, `hours_id`) VALUES (11, 48);

COMMIT;

