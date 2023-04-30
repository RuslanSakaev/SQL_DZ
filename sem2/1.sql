/*
1. Используя операторы языка SQL, создайте таблицу “sales”. 
Заполните ее данными.
Справа располагается рисунок к первому заданию.
id	order_date	count_product
1	2022-01-01	156
2	2022-01-02	180
3	2022-01-03	21
4	2022-01-04	124
5	2022-01-05	341
*/
/*
CREATE DATABASE dz_sem2;
 
USE dz_sem2;
 
CREATE TABLE sales
(
    Id SERIAL PRIMARY KEY,
    order_date DATE NOT NULL,
    count_product INT
);

INSERT INTO sales(order_date, count_product)
VALUES
('2022-01-01', '156'),
('2022-01-02', '180'), 
('2022-01-03', '21'),
('2022-01-04', '124'),
('2022-01-05', '341');

SELECT * FROM sales;
/*
2.  Для данных таблицы “sales” укажите тип заказа в зависимости от кол-ва : 
меньше 100  -    Маленький заказ
от 100 до 300 - Средний заказ
больше 300  -     Большой заказ
*/
/*
SELECT id, 
CASE 
    WHEN count_product < 100 THEN 'Маленький заказ'
    WHEN count_product >= 100 AND count_product <= 300 THEN 'Средний заказ'
    ELSE 'Большой заказ'
END AS order_type
FROM sales;

-- Создайте таблицу “orders”, заполните ее значениями
/*
Выберите все заказы. 
В зависимости от поля order_status выведите столбец full_order_status:
OPEN – «Order is in open state» ; CLOSED - «Order is closed»; CANCELLED -  «Order is cancelled»
*/

USE dz_sem2;
 
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  employee_id VARCHAR(3) NOT NULL,
  amount DECIMAL(8,2) NOT NULL,
  order_status VARCHAR(10) NOT NULL
);
INSERT INTO orders (employee_id, amount, order_status)
VALUES 
  ('e03', 15.00, 'OPEN'),
  ('e01', 25.50, 'OPEN'),
  ('e05', 100.70, 'CLOSED'),
  ('e02', 22.18, 'OPEN'),
  ('e04', 9.50, 'CANCELLED');
SELECT * FROM orders;