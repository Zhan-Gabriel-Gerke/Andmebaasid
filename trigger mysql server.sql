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
CONCAT(m.maakond, ' linn ',l.linnanimi, ', ', l.rahvaarv)
FROM linnad l
INNER JOIN maakond m ON m.maakondID=l.maakondID;
