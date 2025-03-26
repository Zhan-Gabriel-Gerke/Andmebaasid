Create table linnad(​
linnID int PRIMARY KEY identity(1,1),​
linnanimi varchar(15),​
rahvaarv int);​
​
Create table logi(
id int identity(1,1) PRIMARY KEY,​
aeg DATETIME,​
toiming  varchar(100),​
andmed varchar(200)​
)​;​
CREATE TABLE maakond(​
maakondID int identity(1,1) Primary KEY,​
maakond varchar(100) UNIQUE,
pindala int);

INSERT INTO maakond(maakond, pindala)​
VALUES ('Pärnumaa', 75000);

ALTER TABLE linnad ADD maakondID int;​
ALTER TABLE linnad ADD CONSTRAINT fk_maakond​
FOREIGN KEY (maakondID) References maakond(maakondID)
--drop trigger
drop trigger linnalisamine
--
SELECT * FROM linnad;
SELECT * FROM maakond;
INSERT INTO linnad(linnanimi, rahvaarv, maakondID)
VALUES ('Tallinn', 6000000, 100)
SELECT * FROM logi;
--disable
Create trigger linnaLisamine
ON linnad
FOR INSERT
AS
INSERT INTO logi(aeg, toiming, andmed)
SELECT GETDATE(),
'on tehtud INSERT',
CONCAT(m.maakond, ' linn ',inserted.linnanimi, ', ', inserted.rahvaarv)
FROM inserted
INNER JOIN maakond m ON m.maakondID=inserted.maakondID;

--kontroll
INSERT INTO linnad(linnanimi, rahvaarv, maakondID)
VALUES ('Parnu1', 10000, 2)
SELECT * FROM logi;
SELECT * FROM linnad;

--delete from logi
DELETE FROM logi;
ALTER TABLE logi ADD kasutaja varchar(25);
CREATE TRIGGER linnaKustutamine
ON linnad
FOR DELETE
AS
INSERT INTO logi (aeg, toiming, andmed, kasutaja)
SELECT 
GETDATE(),
'on tehtud Delete',
CONCAT(m.maakond, ' linn ', deleted.linnanimi, ', ', deleted.rahvaarv),
SUSER_NAME()
FROM deleted
INNER JOIN maakond m ON m.maakondID = deleted.maakondID;
SELECT * FROM linnad;

CREATE TRIGGER linnaUuendamine
ON linnad
FOR UPDATE
AS
INSERT INTO logi (aeg, toiming, andmed, kasutaja)
SELECT 
GETDATE(),
'on tehtud Update',
CONCAT('Vana andmed ',m1.maakond, ' linn ', deleted.linnanimi, ', ', deleted.rahvaarv,
' uued andmed ',m2.maakond, ' linn ', inserted.linnanimi, ', ', inserted.rahvaarv),
SUSER_NAME()
FROM deleted
INNER JOIN inserted ON deleted.linnID=inserted.linnID
INNER JOIN maakond m1 ON m1.maakondID = deleted.maakondID
INNER JOIN maakond m2 ON m2.maakondID = deleted.maakondID;;
SELECT * FROM linnad;

DROP TRIGGER linnaUuendamine;
--kontroll
UPDATE linnad SET maakondID = 2
WHERE linnID=3;
SELECT * FROM linnad;
SELECT * FROM logi;
