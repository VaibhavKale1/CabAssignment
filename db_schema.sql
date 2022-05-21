CREATE DATABASE IF NOT EXISTS cab_svc;
use cab_svc;

CREATE TABLE IF NOT EXISTS `user` (
    `user_id` INT AUTO_INCREMENT PRIMARY KEY,
    `user_full_name` varchar(200) NOT NULL,
    `user_address` varchar(200),
    `user_phone`  varchar(45),
    `user_role` varchar(45)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `cab` (
  `cab_id` INT AUTO_INCREMENT PRIMARY KEY,
  `cab_user_id` INT NOT NULL,
  `cab_number` varchar(150) NOT NULL,
  `cab_state` varchar(150) NOT NULL, -- booked, ontrip, idle, not_functioning
  -- `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cab_city_id` varchar(150) NOT NULL,
  `cab_lat` varchar(150) ,
  `cab_long` varchar(150),
  FOREIGN KEY (`cab_user_id`) REFERENCES user(`user_id`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `city` (
    `city_id` INT AUTO_INCREMENT PRIMARY KEY,
    `city_name` varchar(200) NOT NULL,
    `state_name` varchar(200),
    `service_available` varchar(10) -- true/false
)ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS `journey` (
  `jn_id` INT AUTO_INCREMENT PRIMARY KEY,
  `cab_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `booked_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `start_time` timestamp,
  `end_time` timestamp,
  `start_city_id` INT,
  `end_city_id` INT,
  `start_lat` varchar(150),
  `start_long` varchar(150),
  `end_lat` varchar(150),
  `end_long` varchar(150),
  `travelled_dist` INT,
  `bill_amount` FLOAT,
  FOREIGN KEY (`cab_id`) REFERENCES cab(`cab_id`),
  FOREIGN KEY (`customer_id`)  REFERENCES user(`user_id`),
  FOREIGN KEY (`start_city_id`) REFERENCES city(`city_id`),
  FOREIGN KEY (`end_city_id`)  REFERENCES city(`city_id`)
) ENGINE=InnoDB;