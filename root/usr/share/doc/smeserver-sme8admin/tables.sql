-- Creation de la base

CREATE DATABASE IF NOT EXISTS `sme8admin` DEFAULT CHARACTER SET latin1;

USE `sme8admin`;


-- Ces tables vont garder l'historique
-- des connexions aux services sensibles


-- Structure de la table samba

create table samba (
    ip int unsigned not null,
    login varchar(10) not null,
--  service varchar(10) not null,
    machine varchar(30) not null,
    debut datetime,
    derniere_vue datetime,
    primary key (ip,login,machine) );

-- Structure de la table afp

create table afp (
    ip int unsigned not null,
    debut datetime not null,
    fin datetime,
    pid_afpd int unsigned not null,
    login varchar(10),
    volume_read int unsigned,
    volume_write int unsigned,
    primary key (debut) );

-- Structure de la table dchpd

create table dhcpd (
    ip int unsigned not null,
    mac varchar(18) not null,
    hostname varchar(30),
    debut datetime,
--  encours bool,
    primary key (ip) );

-- Structure de la table ftp

create table ftp (
    debut datetime not null,
    fin datetime,
    duree time,
    ip int unsigned not null,
    pid_proftpd int unsigned not null,
    login varchar(10),
    connecte bool,
    volume_in int unsigned,
    volume_out int unsigned,
    primary key (debut) );

-- Structure de la table pppoe

create table pppoe (
    debut datetime not null,
    fin datetime,
    duree time,
    pid_pppd int unsigned not null,
    ip int unsigned not null,
    peer int unsigned not null,
    volume_in int unsigned,
    volume_out int unsigned,
    primary key (debut) );

-- Structure de la table ssh

create table ssh (
    debut datetime not null,
    ip int unsigned not null,
    login varchar(10) not null,
    ok bool,
    primary key (debut) );

-- Structure de la table vpn

create table vpn (
    debut datetime not null,
    fin datetime,
    duree time,
    ip int unsigned,
    vpn_clt int unsigned,
    vpn_srv int unsigned not null,
    volume_in int unsigned,
    volume_out int unsigned,
    login varchar(10),
    pid_pptpd int unsigned not null,
    pid_pppd int unsigned,
    primary key (debut) );
