--SQL SALVESTATUD PROTSEDUURID-- Funktsioonid - mitu SQL kasku kaivitakse jarjest
--SQL SERVER 
CREATE TABLE uudised(
uudisID int PRIMARY KEY identity(1,1),
uudiseTeema varchar(50),
kuupaev date,
autor varchar(25),
kirjeldus text
);
SELECT * FROM uudised;
INSERT INTO uudised(uudiseTeema, kuupaev, autor, kirjeldus)
VALUES(
'udune ilm', '2025-02-06', 'postimees', 'Lounani on udune ilm');
--protseduuri loomine
--sisestab uudised tabelisse ja kohe naitab
CREATE PROCEDURE lisaUudis
@uusTeema varchar(50),
@paev date,
@autor varchar(20),
@kirjeldus text
AS
BEGIN
INSERT INTO uudised(uudiseTeema, kuupaev, autor, kirjeldus)
VALUES(
@uusTeema, @paev, @autor, @kirjeldus);
SELECT * FROM uudised;
END;
--kutse
EXEC lisaUudis 'windows 11', '2025-02-06', 'opetaja Pant', 'w11 ei tootab multimeedia klassis';
--teine kutse voimalus
EXEC lisaUudis 
@uusTeema='1.marts on juba kevad',
@paev='2025-02-06',
@autor='test',
@kirjeldus='puudub';

--protsedur, mis kustutam tabelist id jargi
CREATE PROCEDURE kustutaUudis
@id int
AS
BEGIN
SELECT * FROM uudised;
DELETE FROM uudised WHERE uudisID=@id;
SELECT * FROM uudised;
END;
--kutse
EXEC kustutaUudis 3;
EXEC kustutaUudis @id=3;

UPDATE uudised SET kirjeldus='uus kurjeldus'
WHERE kirjeldus Like'puudub';
SELECT * FROM uudised;
--protseduur mis uuendab andmed tabelis/UPDATE

CREATE Procedure uuendaKirjeldus
@uuskurjeldus text
AS
BEGIN
UPDATE uudised SET kirjeldus=@uuskurjeldus
WHERE kirjeldus Like 'puudub';
END;
--kutse
EXEC uuendaKirjeldus 'uus tekst kirjelduses';
EXEC uuendaKirjeldus @uuskurjeldus='uus tekst kirjelduses';
--protseduur mis otssib ja naitab uudist esimese tahte jargi

CREATE PROCEDURE otsingUudiseTeema
@taht char(1)
AS
BEGIN
SELECT * FROM uudised
WHERE uudiseTeema LIKE @taht +'%';
END;
--kutse
EXEC otsingUudiseTeema 'w';
