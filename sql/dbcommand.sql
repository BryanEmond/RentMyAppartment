CREATE DATABASE rentmyappartment;
USE rentmyappartment;
CREATE TABLE password(PID char(9) primary key, password text);
CREATE TABLE user(UID char(12) NOT NULL, username char(100), email char(100), PID char(12), PRIMARY KEY(UID), FOREIGN KEY(PID) REFERENCES password(PID));
CREATE TABLE appartments(AID char(12) NOT NULL, title char(100), address char(100), appartment char(5), zipCode char(100),town char(100),size char(10),price int, description text,coordinate text,UID char(12) not null,PRIMARY KEY(AID),FOREIGN KEY(UID) REFERENCES user(UID));
CREATE TABLE City(CID INT NOT NULL AUTO_INCREMENT, 
                CityName VARCHAR(64), 
                Country VARCHAR(64), 
                qty_locations int, 
                CoordinateCity text,
                PRIMARY KEY(CID));
INSERT INTO City
    (CID, CityName, Country, qty_locations, CoordinateCity)
VALUES
    (1,'Québec', 'Canada', 136, (46.829853, -71.254028)),
    (2,'Montréal', 'Canada', 396, (45.508888, -73.561668)),

    ;
