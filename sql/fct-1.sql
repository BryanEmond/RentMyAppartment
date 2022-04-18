 delimiter //
    CREATE PROCEDURE new_account
    (EMAIL char,firstName char,lastName char,middleName char,PASSWORD1 char)
BEGIN
    insert into password values (EMAIL, PASSWORD1);
    insert INTO user VALUES (EMAIL, firstName, lastName, middleName, EMAIL);

END //

CREATE PROCEDURE selection_appt_grandeur()
BEGIN

    SELECT * FROM GrandeurAppt;

END //

CREATE FUNCTION select_user (EMAIL text) RETURNS TEXT DETERMINISTIC 
BEGIN
    DECLARE var_password TEXT;
    DECLARE var_pid TEXT;
    SET var_pid = (  SELECT PID FROM user WHERE UID = EMAIL );
    SET var_password = (  SELECT password FROM password WHERE PID = var_pid );
    RETURN var_password;
END// 
delimiter ;
