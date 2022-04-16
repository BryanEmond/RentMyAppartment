CREATE DATABASE rentmyappartment;
USE rentmyappartment;
CREATE TABLE password(PID char(9) primary key, password text);
CREATE TABLE user(UID char(12) NOT NULL, name char(100), email char(100), PID char(12), PRIMARY KEY(UID), 
                    FOREIGN KEY(PID) REFERENCES password(PID));
CREATE TABLE GrandeurAppt (GID char(12) primary key NOT NULL, size float(2) );
CREATE TABLE City(CID char(12), 
                CityName VARCHAR(64), 
                countryname char(12), 
                PRIMARY KEY(CID), foreign key (countryname) REFERENCES Country(countryname);

CREATE TABLE Country(countryname char(12), description text);

CREATE TABLE appartments( AID int NOT NULL, title char(100), address char(100), price int, 
            description text, UID char(12) not null,PRIMARY KEY(AID), 
            CID char(12) not null, GID char(12) not null, sold bool,
            FOREIGN KEY(UID) REFERENCES user(UID), foreign key (CID) REFERENCES city (CID),
            foreign key (GID) REFERENCES GrandeurAppt (GID));


DROP TRIGGER IF EXISTS t_appt_delete;
GO
CREATE TRIGGER t_appt_delete ON appartments INSTEAD OF DELETE
AS BEGIN
    DECLARE @AID INT;
    DECLARE @count INT;
    SELECT @AID = AID FROM DELETED;
    SELECT @count = COUNT(*) FROM city WHERE country_id = @AID;
    IF @SOLD = 1
        DELETE FROM appartments WHERE AID = @AID;
    ELSE
        THROW 51000, 'can not delete - appartment isnt sold yet', 1;
END;
