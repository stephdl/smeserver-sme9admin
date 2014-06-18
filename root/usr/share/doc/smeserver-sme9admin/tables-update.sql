USE `sme9admin`;


-- Modify one error in table construction
ALTER TABLE `pppoe` CHANGE `ip` `ip` INT( 10 ) UNSIGNED NOT NULL DEFAULT '0'
