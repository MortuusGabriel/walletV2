-- MySQL Script generated by MySQL Workbench
-- Sun Mar 24 16:58:29 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema wallet
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema wallet
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `wallet` DEFAULT CHARACTER SET utf8 ;
USE `wallet` ;

-- -----------------------------------------------------
-- Table `wallet`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wallet`.`users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `token` VARCHAR(2048) NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`));


-- -----------------------------------------------------
-- Table `wallet`.`currencies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wallet`.`currencies` (
  `currency_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `value` FLOAT NOT NULL,
  `is_up` TINYINT NOT NULL,
  `icon` VARCHAR(45) NOT NULL,
  `full_name` VARCHAR(255) NOT NULL,
  `full_list_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`currency_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wallet`.`wallets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wallet`.`wallets` (
  `wallet_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `currency_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `amount` INT NULL DEFAULT 0,
  `limit` INT NULL,
  `income` INT NULL DEFAULT 0,
  `expense` INT NULL DEFAULT 0,
  `is_hide` TINYINT NOT NULL,
  PRIMARY KEY (`wallet_id`),
  INDEX `fk_account_user_idx` (`user_id` ASC) VISIBLE,
  INDEX `currency_idx` (`currency_id` ASC) VISIBLE,
  CONSTRAINT `fk_wallett_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `wallet`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `currency`
    FOREIGN KEY (`currency_id`)
    REFERENCES `wallet`.`currencies` (`currency_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wallet`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wallet`.`categories` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `category_type` TINYINT NOT NULL,
  `user_id` INT NULL,
  `icon_id` INT NULL,
  PRIMARY KEY (`category_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `wallet`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wallet`.`transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wallet`.`transactions` (
  `transaction_id` INT NOT NULL AUTO_INCREMENT,
  `wallet_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  `value` INT NOT NULL,
  `currency_id` INT NOT NULL,
  `transaction_time` TIMESTAMP NOT NULL,
  PRIMARY KEY (`transaction_id`),
  INDEX `wallet_id_idx` (`wallet_id` ASC) VISIBLE,
  INDEX `category_id_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `wallet_id`
    FOREIGN KEY (`wallet_id`)
    REFERENCES `wallet`.`wallets` (`wallet_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `category_id`
    FOREIGN KEY (`category_id`)
    REFERENCES `wallet`.`categories` (`category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
