use pets;

DELIMITER //

DROP PROCEDURE IF EXISTS IncreaseDays;

DELIMITER //
CREATE PROCEDURE IncreaseDays()
BEGIN
    UPDATE vet_service
    SET removed_fur_days = removed_fur_days + 1,
        last_bath = last_bath + 1,
        checkup_days = checkup_days + 1;
END//

DROP PROCEDURE IF EXISTS updatenotify;
DELIMITER //
CREATE PROCEDURE updatenotify()
BEGIN
    delete from notify where pet_id>0;
END//




DROP EVENT IF EXISTS E2 ;
CREATE EVENT E2
    ON SCHEDULE EVERY 30 SECOND
    DO
        CALL updatenotify();

DROP EVENT IF EXISTS increase_days_event ;
CREATE EVENT increase_days_event
    ON SCHEDULE EVERY 30 SECOND
    DO
        CALL IncreaseDays();


DELIMITER //
DROP TRIGGER IF EXISTS after_vet_service_update //
CREATE TRIGGER after_vet_service_update
BEFORE UPDATE ON vet_service
FOR EACH ROW
BEGIN
    IF NEW.last_bath > 10 THEN
       INSERT INTO notify (pet_id, work) VALUES (NEW.pet_id, 'Bath it today');
        SET NEW.last_bath = 0;
    END IF;
END//



DELIMITER //
DROP TRIGGER IF EXISTS after_vet_service_update2 //
CREATE TRIGGER after_vet_service_update2
BEFORE UPDATE ON vet_service
FOR EACH ROW
BEGIN
    IF NEW.removed_fur_days > 60 THEN
        INSERT INTO notify (pet_id, work) VALUES (NEW.pet_id, 'Trim it');
        SET NEW.removed_fur_days = 0;
    END IF;
END//


DELIMITER //
DROP TRIGGER IF EXISTS after_vet_service_update3 //
CREATE TRIGGER after_vet_service_update3
BEFORE UPDATE ON vet_service
FOR EACH ROW
BEGIN
    IF NEW.checkup_days > 30 THEN
        INSERT INTO notify (pet_id, work) VALUES (NEW.pet_id, 'Check it up');
        SET NEW.checkup_days = 0;
    END IF;
END//

DELIMITER //
DROP TRIGGER IF EXISTS update_sold_and_delete_vet_service //
CREATE TRIGGER update_sold_and_delete_vet_service
AFTER INSERT ON petting
FOR EACH ROW
BEGIN
    UPDATE animals
    SET sold = 1
    WHERE pet_id = NEW.pet_id;

    DELETE FROM vet_service
    WHERE pet_id = NEW.pet_id;
END;


select * from notify;
select * from vet_service;
SHOW PROCEDURE STATUS WHERE Db = 'pets' AND Name = 'IncreaseDays';