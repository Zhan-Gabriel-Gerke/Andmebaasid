CREATE TABLE `fiml` (
  `filmID` int(11) NOT NULL,
  `filmNimetus` varchar(30) NOT NULL,
  `aasta` int(11) DEFAULT NULL,
  `eelarveHind` decimal(7,1) DEFAULT NULL,
  `zanrID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `fiml`
--

INSERT INTO `fiml` (`filmID`, `filmNimetus`, `aasta`, `eelarveHind`, `zanrID`) VALUES
(1, 'Barby', 2023, 10000.5, NULL),
(2, 'Deadpuul', 2023, 999999.1, NULL),
(3, 'TudaSjudaMilioner', 2020, 1.1, 1);

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
  ADD KEY `fk_zanr` (`zanrID`);

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
  ADD CONSTRAINT `fk_zanr` FOREIGN KEY (`zanrID`) REFERENCES `zanr` (`zanrID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
