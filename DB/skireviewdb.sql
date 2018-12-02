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
  `difficulty` ENUM('BEGINNER', 'INTERMEDIATE', 'HARD', 'EXPERT') NULL DEFAULT 'BEGINNER',
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
INSERT INTO `mountain` (`id`, `name`, `number_of_trails`, `number_of_lifts`, `elevation_base`, `elevation_peak`, `mountain_map_url`, `resort_id`) VALUES (2, 'Battle Mountain', 195, 31, 8120, 11570, NULL, 2);

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
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (12, 'High Divide', NULL, NULL, NULL, 'Terrain Park', 1);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (13, 'Banana Park', NULL, NULL, NULL, 'Terrain Park, Groomed', 1);
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
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (38, 'Treeline', NULL, NULL, NULL, 'Terrain Park', 1);
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
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (195, 'Golden Peak Half Pipe', NULL, NULL, NULL, 'Half Pipe', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (196, 'Golden Peak Terrain Park', NULL, NULL, NULL, 'Terrain Park', 2);
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
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (279, 'Bwana Park', NULL, NULL, NULL, 'Terrain Park', 2);
INSERT INTO `trail` (`id`, `name`, `difficulty`, `length`, `elevation_gain_loss`, `features`, `mountain_id`) VALUES (280, 'Pride Park', NULL, NULL, NULL, 'Terrain Park', 2);
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
INSERT INTO `chairlift_has_trail` (`chairlift_id`, `trail_id`) VALUES (1, 1);

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

