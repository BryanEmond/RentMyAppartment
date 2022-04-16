CREATE DATABASE rentmyappartment;
USE rentmyappartment;
CREATE TABLE password(PID char(9) primary key, password text);
CREATE TABLE user(UID char(12) NOT NULL, name char(100), email char(100), PID char(12), PRIMARY KEY(UID), 
                    FOREIGN KEY(PID) REFERENCES password(PID));


CREATE TABLE GrandeurAppt (GID char(12) primary key NOT NULL, size float(2) );
CREATE TABLE City(CID char(12), 
                CityName VARCHAR(64), 
                Country VARCHAR(64), 
                CoordinateCity text,
                PRIMARY KEY(CID));

CREATE TABLE appartments( AID char(12) NOT NULL, title char(100), address char(100), numeroAppt char(5), 
            zipCode char(100), price int, description text, UID char(12) not null,PRIMARY KEY(AID), 
            CID char(12) not null, GID char(12) not null,
            FOREIGN KEY(UID) REFERENCES user(UID), foreign key (CID) REFERENCES city (CID),
            foreign key (GID) REFERENCES GrandeurAppt (GID));



