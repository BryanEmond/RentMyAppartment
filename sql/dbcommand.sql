CREATE DATABASE rentmyappartment;
USE rentmyappartment;


CREATE TABLE password(PID char(9) primary key, password text);
CREATE TABLE user(UID char(12) NOT NULL, name char(100), email char(100), PID char(12), PRIMARY KEY(UID), 
                    FOREIGN KEY(PID) REFERENCES password(PID));
CREATE TABLE GrandeurAppt (GID char(12) primary key NOT NULL, size float(2) );
CREATE TABLE Country(countryname char(12));
CREATE TABLE City(CID char(12), 
                CityName VARCHAR(64), 
                countryname char(12), 
                PRIMARY KEY(CID), foreign key (countryname) REFERENCES Country(countryname);


CREATE TABLE appartments( AID int NOT NULL, title char(100), address char(100), price int,
            description text, UID char(12) not null, PRIMARY KEY(AID), 
            CID char(12) not null, GID char(12) not null, sold BOOLEAN,
            FOREIGN KEY(UID) REFERENCES user(UID), foreign key (CID) REFERENCES city (CID),
            foreign key (GID) REFERENCES GrandeurAppt (GID));


INSERT INTO password('001', naruto);
INSERT INTO password('002', sasuke);
CREATE TABLE user('kingmufasa99', 'Mostafa Filali', 'mfilali99@hotmail.com', '001');
CREATE TABLE user('bryan', 'Bryan Emond', 'mfilali99@hotmail.com', '002');
INSERT INTO GrandeurAppt ('un-et-demi', 1.5 );
INSERT INTO GrandeurAppt ('deux-et-demi', 2.5 );
INSERT INTO GrandeurAppt ('trois-et-demi', 3.5 );
INSERT INTO GrandeurAppt ('quatre-et-demi', 4.5 );
INSERT INTO GrandeurAppt ('cinq-et-demi', 5.5 );

INSERT INTO Country('Canada');
INSERT INTO Country('USA');
INSERT INTO City('qc', 'Ville de Québec', 'Canada');
INSERT INTO City('trv', 'Trois-Rivières', 'Canada');
INSERT INTO City('mtl', 'Montréal', 'Canada');
INSERT INTO City('ny', 'New York', 'USA');

INSERT INTO appartments( 001, 'Studio Lebourgneuf', 
            '6270 rue dAlésia', 520,
            description text, 'kingmufasa99', 
            'qc'l, 'un-et-demi', false);









DROP TRIGGER IF EXISTS t_appt_delete;
GO
CREATE TRIGGER t_appt_delete ON appartments INSTEAD OF DELETE
AS BEGIN
    DECLARE @AID INT;
    DECLARE @count INT;
    SELECT @AID = AID FROM DELETED;
    SELECT @count = COUNT(*) FROM appartments WHERE AID = @AID;
    IF @SOLD = 1
        DELETE FROM appartments WHERE AID = @AID;
    ELSE
        THROW 51000, 'can not delete - appartment isnt sold yet', 1;
END;
