CREATE INDEX indexMDP ON password(PID) USING BTREE;
CREATE INDEX indexLocalisation ON localisation(LID, CID, countryName) USING BTREE;
CREATE INDEX indexUser ON user(UID) USING BTREE;
CREATE INDEX indexAppartments ON appartments(AID, price, LID, SOLD, description text) USING BTREE;


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

CREATE TRIGGER update_qty AFTER INSERT ON appartments 
    FOR EACH ROW
    BEGIN
        UPDATE nbAppartement;
        SET nbAppartement = nbAppartement + 1;
        WHERE 
END//


delimiter ;

