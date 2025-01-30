-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Янв 30 2025 г., 11:02
-- Версия сервера: 10.4.32-MariaDB
-- Версия PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `tarxampp`
--

-- --------------------------------------------------------

--
-- Структура таблицы `fiml`
--

CREATE TABLE `fiml` (
  `filmID` int(11) NOT NULL,
  `filmNimetus` varchar(30) NOT NULL,
  `aasta` int(11) DEFAULT NULL,
  `eelarveHind` decimal(7,1) DEFAULT NULL,
  `zanrID` int(11) DEFAULT NULL,
  `rezID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `fiml`
--

INSERT INTO `fiml` (`filmID`, `filmNimetus`, `aasta`, `eelarveHind`, `zanrID`, `rezID`) VALUES
(1, 'Barby', 2023, 10000.5, 2, 2),
(2, 'Deadpuul', 2023, 999999.1, 1, 2),
(3, 'TudaSjudaMilioner', 2020, 1.1, 1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `kinokava`
--

CREATE TABLE `kinokava` (
  `kavaID` int(11) NOT NULL,
  `kuupaevAeg` datetime DEFAULT NULL,
  `saal` varchar(20) DEFAULT NULL,
  `koht` varchar(30) DEFAULT NULL,
  `filmID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `kinokava`
--

INSERT INTO `kinokava` (`kavaID`, `kuupaevAeg`, `saal`, `koht`, `filmID`) VALUES
(1, '2025-01-30 17:00:00', 'Saal nr 2', 'Coca Cola Plaza', 2),
(2, '2025-01-30 14:00:00', 'Saal nr 5', 'Coca Cola Plaza', 3),
(3, '2025-01-30 19:00:00', 'Saal nr 1', 'Coca Cola Plaza', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `rezisoor`
--

CREATE TABLE `rezisoor` (
  `rezID` int(11) NOT NULL,
  `nimi` varchar(50) NOT NULL,
  `synniaeg` date DEFAULT NULL,
  `riik` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `rezisoor`
--

INSERT INTO `rezisoor` (`rezID`, `nimi`, `synniaeg`, `riik`) VALUES
(1, 'Zhan Matros', '2001-05-15', 'France'),
(2, 'Zhan Batis', '1981-08-05', 'Estonia');

-- --------------------------------------------------------

--
-- Структура таблицы `zanr`
--

CREATE TABLE `zanr` (
  `zanrID` int(11) NOT NULL,
  `zanrNimetus` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `zanr`
--

INSERT INTO `zanr` (`zanrID`, `zanrNimetus`) VALUES
(2, 'detektiiv'),
(1, 'draama'),
(3, 'fantasy');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `fiml`
--
ALTER TABLE `fiml`
  ADD PRIMARY KEY (`filmID`),
  ADD KEY `fk_zanr` (`zanrID`),
  ADD KEY `fk_rezID` (`rezID`);

--
-- Индексы таблицы `kinokava`
--
ALTER TABLE `kinokava`
  ADD PRIMARY KEY (`kavaID`),
  ADD KEY `fk_filmID` (`filmID`);

--
-- Индексы таблицы `rezisoor`
--
ALTER TABLE `rezisoor`
  ADD PRIMARY KEY (`rezID`);

--
-- Индексы таблицы `zanr`
--
ALTER TABLE `zanr`
  ADD PRIMARY KEY (`zanrID`),
  ADD UNIQUE KEY `zanrNimetus` (`zanrNimetus`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `fiml`
--
ALTER TABLE `fiml`
  MODIFY `filmID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `kinokava`
--
ALTER TABLE `kinokava`
  MODIFY `kavaID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `rezisoor`
--
ALTER TABLE `rezisoor`
  MODIFY `rezID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `zanr`
--
ALTER TABLE `zanr`
  MODIFY `zanrID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `fiml`
--
ALTER TABLE `fiml`
  ADD CONSTRAINT `fk_rezID` FOREIGN KEY (`rezID`) REFERENCES `rezisoor` (`rezID`),
  ADD CONSTRAINT `fk_zanr` FOREIGN KEY (`zanrID`) REFERENCES `zanr` (`zanrID`);

--
-- Ограничения внешнего ключа таблицы `kinokava`
--
ALTER TABLE `kinokava`
  ADD CONSTRAINT `fk_filmID` FOREIGN KEY (`filmID`) REFERENCES `fiml` (`filmID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
