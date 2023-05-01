USE dz_sem5;

CREATE TABLE  Cars (       
	Id INT PRIMARY KEY, 
	Name VARCHAR(10), 
	Cost INT
	);
    
INSERT INTO Cars ( Id, Name, Cost) VALUES 
(1, 'Audi', 52642),
(2, 'Mercedes', 57127),
(3, 'Skoda', 9000),
(4, 'Volvo', 29000),
(5, 'Bentley', 350000),
(6, 'Citroen', 21000),
(7, 'Hummer', 41400),
(8, 'Volkswagen', 21600);
select * from Cars;
/*
1.	Создайте представление, 
в которое попадут автомобили стоимостью  до 25 000 долларов
*/

CREATE VIEW CheapCars AS
SELECT * FROM Cars WHERE Cost <= 25000;

SELECT * FROM CheapCars;

/*
2.	Изменить в существующем представлении порог для стоимости: 
пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW) 
*/

ALTER VIEW CheapCars AS
SELECT * FROM Cars
WHERE Cost < 30000;

SELECT * FROM CheapCars;

-- 3.Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”

CREATE VIEW SkodaAndAudiCars AS
SELECT * FROM Cars
WHERE Name IN ('Skoda', 'Audi');

SELECT * FROM SkodaAndAudiCars;

/*
Вывести название и цену для всех анализов, 
которые продавались 5 февраля 2020 и всю следующую неделю.
*/

CREATE TABLE  Analysis (       
	an_id INT AUTO_INCREMENT PRIMARY KEY, 
	an_name VARCHAR(50), -- название анализа
	an_cost INT, -- себестоимость анализа
    an_price INT, -- розничная цена анализа
    an_group VARCHAR(20) -- группа анализов
	);

INSERT INTO Analysis (an_name, an_cost, an_price, an_group) VALUES 
('Complete Blood Count', 100, 200, 'Hematology'),
('Lipid Panel', 120, 250, 'Cardiology'),
('Liver Function Tests', 80, 150, 'Gastroenterology'),
('Thyroid Stimulating Hormone', 70, 130, 'Endocrinology'),
('Urinalysis', 50, 100, 'Nephrology'),
('Electrolyte Panel', 90, 180, 'Nephrology'),
('Chest X-Ray', 150, 300, 'Radiology'),
('Computed Tomography', 500, 1000, 'Radiology'),
('Mammogram', 200, 400, 'Radiology'),
('Lipid Panel', 120, 250, 'Cardiology'),
('Liver Function Tests', 80, 150, 'Gastroenterology'),
('Thyroid Stimulating Hormone', 70, 130, 'Endocrinology'),
('Urinalysis', 50, 100, 'Nephrology'),
('Electrolyte Panel', 90, 180, 'Nephrology'),
('Chest X-Ray', 150, 300, 'Radiology'),
('Computed Tomography', 500, 1000, 'Radiology'),
('Mammogram', 200, 400, 'Radiology'),
('Colonoscopy', 800, 1500, 'Gastroenterology');

SELECT * FROM Analysis;

CREATE TABLE `Groups` (       
	gr_id INT AUTO_INCREMENT PRIMARY KEY, 
	gr_name VARCHAR(50) NOT NULL, -- название группы
	gr_temp VARCHAR(50) -- температурный режим хранения
);

INSERT INTO `Groups` (gr_name, gr_temp) VALUES
('Группа 1', -20),
('Группа 2', -15),
('Группа 3', -10),
('Группа 4', - 5),
('Группа 5', 0),
('Группа 6', 5),
('Группа 7', 10),
('Группа 8', 15),
('Группа 9', 20),
('Группа 10', ' от -2 до +2');

SELECT * FROM `Groups`;
    
CREATE TABLE Orders (       
	ord_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	ord_datetime DATETIME NOT NULL, -- дата и время заказа
	ord_an INT NOT NULL -- ID анализа
	);
    
CREATE TABLE SortedOrders (
    ord_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ord_datetime DATETIME NOT NULL,
    ord_an INT NOT NULL
);
/*
INSERT INTO SortedOrders (ord_datetime, ord_an)
SELECT 
    CONCAT(DATE_ADD('2020-02-01', INTERVAL FLOOR(RAND() * 15) DAY), ' ', SEC_TO_TIME(FLOOR(RAND() * 86400))),
    FLOOR(RAND() * 900) + 100
FROM
	(SELECT t1.n FROM (SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3) t1
	CROSS JOIN (SELECT 0 AS n UNION ALL SELECT 4 UNION ALL SELECT 8 UNION ALL SELECT 12) t2) t3
WHERE
    DATE_ADD('2020-02-01', INTERVAL t3.n DAY) BETWEEN '2020-02-01' AND '2020-02-16';
    */

INSERT INTO SortedOrders (ord_datetime, ord_an)
SELECT 
    CONCAT(DATE_ADD('2020-02-01', INTERVAL FLOOR(RAND() * 15) DAY), ' ', SEC_TO_TIME(FLOOR(RAND() * 86400))),
    an_id FROM Analysis
WHERE
    DATE_ADD('2020-02-01', INTERVAL FLOOR(RAND() * 15) DAY) BETWEEN '2020-02-01' AND '2020-02-16';

INSERT INTO Orders (ord_datetime, ord_an)
SELECT ord_datetime, ord_an
FROM SortedOrders
ORDER BY ord_datetime;

SELECT * FROM Orders;

/*
Вывести название и цену для всех анализов, 
которые продавались 5 февраля 2020 и всю следующую неделю.
*/

SELECT an_name, an_price, ord_datetime
FROM Analysis
INNER JOIN Orders ON Analysis.an_id = Orders.ord_an
WHERE ord_datetime BETWEEN '2020-02-05' AND '2020-02-16';

/*
Добавьте новый столбец под названием «время до следующей станции». 
Чтобы получить это значение, мы вычитаем время станций для пар смежных станций. 
Мы можем вычислить это значение без использования оконной функции SQL, но это может быть очень сложно. 
Проще это сделать с помощью оконной функции LEAD . 
Эта функция сравнивает значения из одной строки со следующей строкой, чтобы получить результат. 
В этом случае функция сравнивает значения в столбце «время» для станции со станцией сразу после нее.
*/

CREATE TABLE Train(
	train_id INT,
    station  VARCHAR(20),
	station_time TIME
);

INSERT INTO Train(train_id, station, station_time)
VALUES
(110, 'San Francisco', '10:00:00'),
(110, 'Redwood City', '10:54:00'),
(110, 'Palo Alto', '11:02:00'),
(110, 'San Jose', '12:35:00'),
(120, 'San Francisco', '11:00:00'),
(120, 'Palo Alto', '12:49:00'),
(120, 'San Jose',  '13:30:00');

SELECT * FROM Train;

SELECT *,
SUBTIME (LEAD (station_time, 1) OVER (PARTITION BY train_id ORDER BY train_id), station_time)
AS 'time to next station'
FROM Train;

SELECT *,
    COALESCE(TIMEDIFF(LEAD(station_time) OVER (PARTITION BY train_id ORDER BY station_time), station_time), '00:00:00') 
    AS time_to_next_station
FROM Train;

