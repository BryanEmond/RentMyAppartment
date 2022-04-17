CREATE DATABASE rentmyappartment;
USE rentmyappartment;
CREATE TABLE password(PID char(100) primary key, password text);
CREATE TABLE user(
  UID char(100) NOT NULL,
  PRIMARY KEY(UID),
  firstName char(100),
  lastName char(100),
  middleName char(100),
  PID char(100),
  FOREIGN KEY(PID) REFERENCES password(PID)
);
CREATE TABLE GrandeurAppt (GID char(20) primary key NOT NULL);
CREATE TABLE Country(countryName char(100) PRIMARY KEY);
CREATE TABLE City(
  CID char(100) NOT NULL,
  countryName char(12),
  PRIMARY KEY(CID),
  FOREIGN KEY(countryName) REFERENCES Country(countryName)
);
CREATE TABLE appartments(
  AID char(100) NOT NULL,
  PRIMARY KEY(AID),
  price int,
  description text,
  UID char(100) not null,
  CID char(100) not null,
  GID char(100) not null,
  SOLD BOOLEAN,
  FOREIGN KEY(UID) REFERENCES user(UID),
  foreign key (CID) REFERENCES city (CID),
  foreign key (GID) REFERENCES GrandeurAppt (GID)
);
INSERT INTO
  password
VALUES('001', ' naruto');
INSERT INTO
  password
VALUES('002', 'sasuke');
INSERT INTO
  user
VALUES(
    'mfilali99@hotmail.com',
    'Moulay',
    'Mostafa',
    'Filali',
    '001'
  );
INSERT INTO
  user
VALUES(
    'bryanemond@hotmail.com',
    'Bryan',
    ' ',
    'Emond',
    '002'
  );
INSERT INTO
  GrandeurAppt
VALUES('un-et-demi');
INSERT INTO
  GrandeurAppt
VALUES('deux-et-demi');
INSERT INTO
  GrandeurAppt
VALUES('trois-et-demi');
INSERT INTO
  GrandeurAppt
VALUES('quatre-et-demi');
INSERT INTO
  GrandeurAppt
VALUES('cinq-et-demi');
INSERT INTO
  Country
VALUES('Canada');
INSERT INTO
  Country
VALUES('USA');
INSERT INTO
  City
VALUES('Quebec', 'Canada');
INSERT INTO
  City
VALUES('Montréal', 'Canada');
INSERT INTO
  appartments
VALUES
  (
    '6270 rue dAlesia appt. 50',
    520,
    'Studio meublé',
    'mfilali99@hotmail.com',
    'Quebec',
    'quatre-et-demi',
    FALSE
  ),
  (
    '6268 rue dAlesia appt. 48',
    800,
    'Appartement meublé 2 chambres',
    'mfilali99@hotmail.com',
    'Quebec',
    'quatre-et-demi',
    FALSE
  );