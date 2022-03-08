CREATE DATABASE rentmyappartment;
USE DATABASE rentmyappartment;
CREATE TABLE password(PID char(9) primary key, password text);
CREATE TABLE user(UID char(9) NOT NULL, name char(100), email char(100), PID char(9), PRIMARY KEY(UID), FOREIGN KEY(PID) REFERENCES password(PID));
