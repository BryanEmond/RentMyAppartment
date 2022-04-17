CREATE DATABASE rentmyappartment;
USE rentmyappartment;
CREATE TABLE password(PID char(9) primary key, password text);
CREATE TABLE user(
  UID char(100) NOT NULL,
  PRIMARY KEY(UID),
  first_name char(100),
  last_name char(100),
  middle_name char(100),
  PID char(12),
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
DROP TRIGGER IF EXISTS t_appt_delete;
GO
  CREATE TRIGGER t_appt_delete ON appartments INSTEAD OF DELETE AS BEGIN DECLARE @AID INT;
DECLARE @count INT;
SELECT
  @AID = AID
FROM
  DELETED;
SELECT
  @count = COUNT(*)
FROM
  appartments
WHERE
  AID = @AID;
IF @SOLD = 1
DELETE FROM
  appartments
WHERE
  AID = @AID;
  ELSE THROW 51000,
  'can not delete - appartment isnt sold yet',
  1;
END;