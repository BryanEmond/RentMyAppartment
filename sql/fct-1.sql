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
delimiter ;

