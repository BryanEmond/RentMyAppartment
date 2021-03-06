CREATE INDEX indexMDP ON password(PID) ;
CREATE INDEX indexLocalisation ON localisation(LID, CID, countryName) ;
CREATE INDEX indexUser ON user(UID) ;
CREATE INDEX indexAppartments ON appartments(AID, price, LID, SOLD) ;


delimiter //

    CREATE PROCEDURE new_account
    (EMAIL text,firstName text,lastName text,middleName text,PASSWORD1 text)
BEGIN
    DECLARE var_PID INT;
    insert into password(password) values (PASSWORD1);
    set var_PID = (SELECT PID from password WHERE password = PASSWORD1);
    insert INTO user VALUES (EMAIL, firstName, lastName, middleName, var_PID);
END //

CREATE PROCEDURE selection_appartment
    (AID text,LOC INT,SIZE text,MINP INT,MAXP INT)
BEGIN
    IF MAXP > 0 AND SIZE <> "0" AND LOC >= 0 THEN
      SELECT * FROM appartments WHERE AID LIKE CONCAT('%', AID, '%') AND SOLD <> TRUE AND LID = LOC AND GID = SIZE AND (price >= MINP AND price <= MAXP);
    ELSEIF MAXP > 0 AND SIZE <> "0" THEN
      SELECT * FROM appartments WHERE AID LIKE CONCAT('%', AID , '%') AND SOLD <> TRUE AND GID = SIZE AND (price >= MINP AND price <= MAXP);
    ELSEIF MAXP > 0 AND LOC >= 0 THEN
      SELECT * FROM appartments WHERE AID LIKE CONCAT('%', AID , '%') AND SOLD <> TRUE AND LID = LOC AND (price >= MINP AND price <= MAXP);
    ELSEIF MAXP > 0 THEN
      SELECT * FROM appartments WHERE (AID LIKE CONCAT('%', AID , '%') AND SOLD <> TRUE AND price >= MINP AND price <= MAXP);
    ELSEIF SIZE <> "0" THEN
      SELECT * FROM appartments WHERE (AID LIKE CONCAT('%', AID , '%') AND SOLD <> TRUE AND GID = SIZE AND price >= MINP);
    ELSEIF LOC >= 0 THEN
      SELECT * FROM appartments WHERE (AID LIKE CONCAT('%', AID , '%') AND SOLD <> TRUE AND LID = LOC AND price >= MINP);
    ELSE
      SELECT * FROM appartments WHERE (AID LIKE CONCAT('%', AID , '%') AND SOLD <> TRUE AND price >= MINP);
    END IF;
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
    UPDATE localisation SET nbAppartement = nbAppartement + 1 WHERE LID = NEW.LID;
END//

delimiter ;

INSERT INTO
  appartments
VALUES
  (
    '6270 rue dAlesia appt. 50',
    520,
    'Studio meubl??',
    'mfilali99@hotmail.com',
    1,
    'quatre-et-demi',
    FALSE
  ),
  (
    '6268 rue dAlesia appt. 48',
    800,
    'Appartement meubl?? 2 chambres',
    'mfilali99@hotmail.com',
    1,
    'quatre-et-demi',
    FALSE
  ),(
    '6268 rue dAlesia appt. 38',
    800,
    'Appartement meubl?? 2 chambres',
    'mfilali99@hotmail.com',
    2,
    'quatre-et-demi',
    FALSE
  ),
  (
    '123 rue label',
    530,
    'Appartement meubl?? 2 chambres',
    'mfilali99@hotmail.com',
    4,
    'un-et-demi',
    FALSE
  );