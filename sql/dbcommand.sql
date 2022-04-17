CREATE DATABASE rentmyappartment;
USE rentmyappartment;


CREATE TABLE password(PID char(9) primary key, password text);
CREATE TABLE user(UID char(100) NOT NULL, first_name char(100), last_name char(100), middle_name char(100), PID char(12), PRIMARY KEY(UID), 
                    FOREIGN KEY(PID) REFERENCES password(PID));
CREATE TABLE GrandeurAppt (GID char(20) primary key NOT NULL);
CREATE TABLE Country(country_name char(12));

CREATE TABLE City(CID char(100), 
                region char (100), arrondissement char (100), nombre_appt int,
                country_name char(12), PRIMARY KEY(CID), foreign key (country_name) REFERENCES Country(country_name);

CREATE TABLE appartments( AID char(100) NOT NULL, PRIMARY KEY(AID), 
            price int, description text, UID char(12) not null, 
            CID char(12) not null, GID char(12) not null, SOLD BOOLEAN,
            FOREIGN KEY(UID) REFERENCES user(UID), foreign key (CID) REFERENCES city (CID),
            foreign key (GID) REFERENCES GrandeurAppt (GID));


INSERT INTO password('001',' naruto');
INSERT INTO password('002', 'sasuke');
INSERT INTO user ('mfilali99@hotmail.com', 'Moulay', 'Mostafa', 'Filali', '001');
INSERT INTO user('bryanemond@hotmail.com', 'Bryan', ' ', 'Emond', '002');
INSERT INTO GrandeurAppt ('un-et-demi');
INSERT INTO GrandeurAppt ('deux-et-demi');
INSERT INTO GrandeurAppt ('trois-et-demi');
INSERT INTO GrandeurAppt ('quatre-et-demi');
INSERT INTO GrandeurAppt ('cinq-et-demi');
INSERT INTO Country('Canada');
INSERT INTO Country('USA');

INSERT INTO City('Quebec', 'Les Saules', 'Lebourgneuf', 45,  'Canada');
INSERT INTO City('Trois-Rivières', 'Canada');
INSERT INTO City('Montréal', 'Canada');
INSERT INTO City('New York', 'USA');

INSERT INTO appartments VALUES (
            '6270 rue dAlesia appt. 50', 520, 'Studio meublé', 
            'mfilali99@hotmail.com', 'Quebec', 'Canada', 'un-et-demi', FALSE),
            (
            '6268 rue dAlesia appt. 48', 800, 'Appartement meublé 2 chambres', 
            'mfilali99@hotmail.com', 'Quebec', 'Canada', '4-et-demi', FALSE)


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
