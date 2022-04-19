-- CREATE INDEX indexMDP ON password(PID) USING HASH;
-- CREATE INDEX indexLocalisation ON localisation(LID, CID, countryName) USING HASH;
-- CREATE INDEX indexUser ON user(UID) USING HASH;
-- CREATE INDEX indexAppartments ON appartments(AID, price, LID, SOLD, description text) USING HASH;


delimiter //

    CREATE PROCEDURE new_account
    (EMAIL text,firstName text,lastName text,middleName text,PASSWORD1 text)
BEGIN
    DECLARE var_PID INT;
    insert into password(password) values (PASSWORD1);
    set var_PID = (SELECT PID from password WHERE password = PASSWORD1);
    insert INTO user VALUES (EMAIL, firstName, lastName, middleName, var_PID);
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

CREATE TRIGGER update_qty AFTER INSERT ON appartments 
    FOR EACH ROW
    BEGIN
        UPDATE nbAppartement;
        SET nbAppartement = nbAppartement + 1;
        WHERE 
END//

delimiter ;

