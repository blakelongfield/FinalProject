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
  `date_created` DATE NOT NULL,
  `vote` INT NULL,
  `user_id` INT NOT NULL,
  `trail_id` INT NOT NULL,
  `mountain_id` INT NOT NULL,
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
-- Table `chairlift`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chairlift` ;

CREATE TABLE IF NOT EXISTS `chairlift` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` ENUM('CHAIRLIFT', 'EXPRESS LIFT', 'SURFACE LIFT', 'CARPET LIFT', 'GONDOLA') NOT NULL DEFAULT 'CHAIRLIFT',
  `number_of_seats` INT NULL DEFAULT 2,
  `ride_length` INT NULL,
  `hours` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
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
  `report_id` INT NOT NULL,
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
-- Table `chairlift_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chairlift_type` ;

CREATE TABLE IF NOT EXISTS `chairlift_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NULL,
  `capacity` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS skier@loaclhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'skier'@'loaclhost' IDENTIFIED BY 'skier';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'skier'@'loaclhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
