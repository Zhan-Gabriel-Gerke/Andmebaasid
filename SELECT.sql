CREATE TABLE laps(
lapsID int primary key identity(1,1),
nimi varchar(10) not null,
pikkus smallint,
synniaasta smallint,
synnilinn varchar(20)
);
SELECT * FROM laps;
INSERT INTO laps(nimi, pikkus, synniaasta, synnilinn)
VALUES 
('Kati', 156, 2001, 'Tallinn'),
('Mati', 166, 2001, 'Narva'),
('Sati', 176, 2001, 'Kohla-jarve'),
('Tati', 126, 2001, 'Tartu'),
('Nuti', 136, 2001, 'Parnu');
---sortirerimine
SELECT nimi, pikkus
FROM laps
ORDER by pikkus, nimi;--ORDER by pikkus DESK; (Если нужно в обратном порядке)(nimi - чтобы если будет одинаковый рост то отсортируется по имени)
--lapsed, mis on syndinud peale 2005
SELECT nimi, synniaasta
FROM laps
WHERE synniaasta >=2005
ORDER by nimi; --  Если хотим чтобы ещё отсортировалось. СТАВИТЬ НА ПОСЛЕДНИЮ ПОЗИЦИЮ
-- DISTINCT Используется чтобы увитеть варианты которые есть (не показывает дубликатов)
SELECT DISTINCT synniaasta
FROM laps
WHERE synniaasta > 2000;

--BETWEEN
--lapsed mis on syndinum (2000 kuni 2005)
SELECT nimi, synniaasta
FROM laps
WHERE synniaasta >= 2000 AND synniaasta <= 2005;
--OR WITH BETWEEN
SELECT nimi, synniaasta
FROM laps
WHERE synniaasta BETWEEN 2000 AND 2005;
--LIKE
--naita lapsed, kelle nimi algab K
--% Все возможные символы
SELECT nimi
FROM laps
WHERE nimi like 'K%';
--Содержит букву K = '%K%'
SELECT nimi
FROM laps
WHERE nimi like '%K%';

--tapsem maaratud tahtede arv Показать на где буква А находиться на втором месяце _ - 1 буква
SELECT nimi
FROM laps
WHERE nimi like '_a__'


-- OR - Выводит тех у кого в имени есть К или родились в TARTU 
SELECT nimi, synnilinn
FROM laps
WHERE nimi like '%K%'
OR synnilinn like 'Tartu';

-- AND - Выводит тех у кого в имени есть К и родились в TARTU 
SELECT nimi, synnilinn
FROM laps
WHERE nimi like '%K%'
AND synnilinn like 'Tartu';

--Agreegatfunktsioonid
SUM, AVG, MIN, MAX, COUNT
SELECT COUNT(nimi) AS 'laste Arv' -- Посчитать сколько людей в списке
FROM laps;

SELECT SUM(pikkus) AS 'summarne pikkus' -- Если хочешь знать суммарный рост детей
FROM laps;

SELECT AVG(pikkus) AS 'keskmine pikkus' -- Средний рост в таллинне
FROM laps
WHERE synnilinn= 'Tallinn';

--naita kesk pikkus linnade jargi
-- GROUP by 

SELECT AVG(pikkus) AS 'kesk pikkus', synnilinn
FROM laps
GROUP by synnilinn;

--Показать кол-во детей рождённых в конкретный год
SELECT synniaasta, COUNT(*) AS lasteArv -- Увидеть какие года есть в целом в таблице и посщитать их
FROM laps
GROUP by synniaasta;

--HAVING - piirang juba gruoeeritud andmete osas
--Ограничение для уже сгрупированных данных
--Keskmine pikkus iga synniaasta jargi
SELECT synniaasta, AVG(pikkus) AS keskmine
FROM laps
GROUP by synniaasta
HAVING AVG(pikkus)>150;
--Показывает средний рост во всех годах кроме 2001
SELECT synniaasta, AVG(pikkus) AS keskmine
FROM laps
WHERE NOT synniaasta = 2001
GROUP by synniaasta;

--seotud tabel
CREATE TABLE loom(
loomID int PRIMARY KEY identity(1,1),
loomNimi varchar(50),
lapsID int,
FOREIGN KEY (lapsID) REFERENCES laps(lapsID));

INSERT INTO loom(loomNimi, lapsID)
VALUES('kass Kott', 1),
('koer Bobik', 1),
('koer Tuzik', 2),
('kass Tuzik', 3),
('kass Mura', 3),
('kilpkonn', 3);

SELECT * FROM loom;
--select seotud tabelite pihjal
SELECT * FROM loom, laps; -- НЕ ПРАВИЛЬНЫЙ способ

SELECT * FROM loom -- Правельный способо
INNER JOIN laps
ON loom.lapsID = laps.lapsID;

SELECT * 
FROM loom, laps -- Правельный и простой способ 
WHERE loom.lapsID = laps.lapsID;


SELECT l.loomNimi, la.nimi, la.synniaasta
FROM loom l, laps la -- Работа с псевдонимами (можно переименовать таблицы внутри запроса)(Переименование в строчке FROM) 
WHERE l.lapsID = la.lapsID;
