/*
1. Создайте таблицу с мобильными телефонами (mobile_phones), 
используя графический интерфейс. 
Заполните БД данными. 
Добавьте скриншот на платформу в качестве ответа на ДЗ 
*/
-- Подключаемся с ранее созданной БД
USE dz_sem1;

-- 2. Выведите название, производителя и цену для товаров, количество которых превышает 2
SELECT product_name, manufacturer, price FROM dz_sem1.mobile_phones
WHERE product_count > 2; 

-- 3.  Выведите весь ассортимент товаров марки “Samsung”
SELECT * FROM dz_sem1.mobile_phones WHERE manufacturer = "Samsung";

/*
4. (по желанию)* С помощью регулярных выражений найти:
	4.1. Товары, в которых есть упоминание "Iphone"
	4.2. Товары, в которых есть упоминание "Samsung"
	4.3.  Товары, в которых есть ЦИФРЫ
	4.4.  Товары, в которых есть ЦИФРА "8"  
*/
SELECT * FROM dz_sem1.mobile_phones
WHERE product_name LIKE '%iPhone%';
SELECT * FROM dz_sem1.mobile_phones
WHERE manufacturer LIKE '%Samsung%';

SELECT * FROM dz_sem1.mobile_phones 
WHERE product_name LIKE '%0%'
OR product_name LIKE '%1%'
OR product_name LIKE '%2%'
OR product_name LIKE '%3%'
OR product_name LIKE '%4%'
OR product_name LIKE '%5%'
OR product_name LIKE '%6%'
OR product_name LIKE '%7%'
OR product_name LIKE '%8%'
OR product_name LIKE '%9%';

SELECT * FROM dz_sem1.mobile_phones 
WHERE product_name RLIKE '[0-9]';

SELECT * FROM dz_sem1.mobile_phones 
WHERE product_name LIKE '%8%';



