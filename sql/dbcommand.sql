CREATE DATABASE rentmyappartment;
USE rentmyappartment;
CREATE TABLE password(PID char(9) primary key, password text);
CREATE TABLE user(UID char(12) NOT NULL, name char(100), email char(100), PID char(12), PRIMARY KEY(UID), FOREIGN KEY(PID) REFERENCES password(PID));
CREATE TABLE appartments(AID char(12) NOT NULL,appAddress char(100),size char(10),price int, description text,coordinate char(20),UID char(12) not null,PRIMARY KEY(AID),FOREIGN KEY(UID) REFERENCES user(UID)) ;