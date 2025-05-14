CREATE TABLE T(
id int not null Primary key,
s varchar(40),
si smallint);

INSERT INTO T(id, s)VALUES (1, 'one');
INSERT INTO T(id, s)VALUES (2, 'two');
INSERT INTO T(id, s)VALUES (3, 'thee');
SELECT * FROM T;
--tagasi voitmine
ROLLBACK;
--alustame transaktioooni
BEGIN TRANSACTION;
INSERT INTO T(id, s)VALUES (4, 'fourth');
SELECT * FROM T;

--tagasi voitmine
ROLLBACK;
SELECT * FROM T;

BEGIN TRANSACTION;
DELETE FROM T WHERE id > 1;
SELECT * FROM T;

--transaktsion mis salvestab uuendamine ja votab tagasi
BEGIN TRANSACTION;
UPDATE T SET si=3;
SELECT * FROM T;
ROLLBACK;
SELECT * FROM T;
