 delimiter //
    create PROCEDURE new_account
    (
    EMAIL char(100) NOT NULL,
    firstName char(100) NOT NULL,
    lastName char(100)NOT NULL,
    middleName char(100),
    PASSWORD1 char(100)NOT NULL
    ) 
begin
    insert into password values (EMAIL, PASSWORD1)
end //
delimiter ;