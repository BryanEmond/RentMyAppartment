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
CREATE TABLE City(CID char(100) NOT NULL,PRIMARY KEY(CID));

CREATE TABLE localisation(
  LID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  CID CHAR(100) NOT NULL,
  countryName CHAR(100) NOT NULL,
  states CHAR(100) NOT NULL,
  nbAppartement INT,
  FOREIGN KEY(countryName) REFERENCES Country(countryName),
  FOREIGN KEY(CID) REFERENCES city (CID)
);

CREATE TABLE appartments(
  AID char(100) NOT NULL,
  PRIMARY KEY(AID),
  price int,
  description text,
  UID char(100) not null,
  LID INT AUTO_INCREMENT NOT NULL,
  GID char(100) not null,
  SOLD BOOLEAN,
  FOREIGN KEY(UID) REFERENCES user(UID),
  foreign key (GID) REFERENCES GrandeurAppt (GID),
  FOREIGN KEY(LID) REFERENCES localisation (LID)
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
INSERT INTO GrandeurAppt VALUES('un-et-demi');
INSERT INTO GrandeurAppt VALUES('deux-et-demi');
INSERT INTO GrandeurAppt VALUES('trois-et-demi');
INSERT INTO GrandeurAppt VALUES('quatre-et-demi');
INSERT INTO
  GrandeurAppt
VALUES('cinq-et-demi');
INSERT INTO Country VALUES('Canada');
INSERT INTO Country VALUES('USA');
INSERT INTO City VALUES ('Québec'),('Montréal'),('Mont-tremblant'),('Saint-Jérome'),('Laval'),('Lévis'),('Rouyn-noranda');
INSERT INTO City VALUES ("New-York"),("Austin"),("Houston"),("Los Angeles"),("Miami");

INSERT INTO localisation(CID, countryName, states, nbAppartement) VALUES ('Québec',"Canada","Québec",0),
 ('Montréal',"Canada","Québec",0),
 ('Mont-tremblant',"Canada","Québec",0),
 ('Saint-Jérome',"Canada","Québec",0),
 ('Laval',"Canada","Québec",0),
 ('Lévis',"Canada","Québec",0),
 ('Rouyn-noranda',"Canada","Québec",0),
 ('New-York',"USA","Jersey",0),
 ("Austin","USA","Texas",0),
 ("Houston","USA","Texas",0),
 ("Miami","USA","Florida",0),
 ("Los Angeles","USA","California",0);
INSERT INTO
  appartments
VALUES
  (
    '6270 rue dAlesia appt. 50',
    520,
    'Studio meublé',
    'mfilali99@hotmail.com',
    1,
    'quatre-et-demi',
    FALSE
  ),
  (
    '6268 rue dAlesia appt. 48',
    800,
    'Appartement meublé 2 chambres',
    'mfilali99@hotmail.com',
    1,
    'quatre-et-demi',
    FALSE
  );
