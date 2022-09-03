-- 1. Выбери столбцы id_product, name, category, name_store из таблицы products_data_all.
SELECT id_product, name, category, name_store FROM products_data_all

-- 2. Выбери все столбцы из таблицы products_data_all:
SELECT * FROM products_data_all;

-- 3. Магазин собрал информацию из чеков в таблице transactions. Выбери и изучи все столбцы таблицы в базе.
SELECT * FROM transactions;

-- 4. Запрос, который вернёт выборку всех данных из таблицы weather.
SELECT * FROM weather;

-- СРЕЗЫ ДАННЫХ В SQL
-- 1. В таблице products_data_all есть информация, как обновлялся каталог товаров каждый день.
-- Выбери поля: название продукта; цена; название магазина; дата. Сделай срез по категории 'молоко и сливки' и дате '2019-06-01'.
SELECT name, price, name_store, date_upd FROM products_data_all WHERE category = 'молоко и сливки' and date_upd = '2019-06-01';

-- 2. Выгрузи поля name, price, name_store, date_upd категории 'молоко и сливки' за 8, 15, 22 и 29 июня 2019 года. 
-- При выборке дат используй конструкцию IN
SELECT 
	name, 
	price, 
	name_store, 
	date_upd 
FROM 
	products_data_all 
WHERE 
	category ='молоко и сливки' AND 
date_upd in ('2019-06-08', '2019-06-15', '2019-06-22', '2019-06-29');

-- 3. Выгрузи все данные о покупках молока и сливок за 1 июня 2019 года. 
-- Напиши ограничение, которое позволит выбрать покупки, которые сделали в период с 1 июня (включительно) по 2 июня (не включительно).
-- В таблице transactions нет информации о категории товара, но есть список c уникальными идентификаторами товаров категории «молоко и сливки». 
SELECT 
	* 
FROM 
	transactions
WHERE 
date >= '2019-06-01' and date < '2019-06-02'
AND id_product in (0, 1, 2, 3, 4, 6, 7, 8, 9, 10, 11, 12, 13, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 28, 29, 30, 31,
32, 34, 35, 36, 37, 38, 39, 40, 42, 43, 44, 45, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60,
61, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75,76, 77, 78, 80, 81, 82, 83, 84, 86, 88, 89, 90,
91, 92, 93, 95, 96, 97, 98, 99, 100, 102, 103, 104, 105,106, 107, 108, 109, 110, 111, 112, 113, 114,
115, 116, 118, 119, 5, 14, 27, 33, 41, 46, 62, 79, 85, 87, 94, 101, 117);

-- АГРЕГИРУЮЩИЕ ФУНКЦИИ
-- 1.Напиши запрос, который посчитает общее количество строк в таблице products_data_all. Назови поле cnt.
SELECT 
	COUNT(*) AS cnt
FROM
	products_data_all;

-- 2. Напиши запрос, который посчитает количество строк в таблице products_data_all; количество строк в столбце name и количество уникальных продуктов в столбце name.
-- Сохрани результаты в полях cnt, name_cnt и name_uniq_cnt соответственно.
SELECT 
	COUNT(*) AS cnt,
    COUNT(name) AS name_cnt,
    COUNT(DISTINCT name) AS name_uniq_cnt
FROM
	products_data_all;

-- 3. Напиши запрос, который посчитает среднюю цену по всем продуктам из таблицы products_data_all. 
-- Стоимость указана в столбце price. Результирующее поле назови average.
SELECT 
	AVG(price) AS average
FROM
	products_data_all;

-- 4. Напиши запрос, который посчитает среднюю цену товара с названием (name) 'Молоко пастеризованное Домик в деревне 2,5%, 
-- 930 мл' в магазине (name_store) 'Семёрочка'. Результирующее поле назови average.
SELECT 
	  AVG(price) AS average
FROM
	products_data_all
WHERE name = 'Молоко пастеризованное Домик в деревне 2,5%, 930 мл'and name_store = 'Семёрочка';

-- 5. Напиши запрос, который посчитает сумму стоимости всех продуктов в магазине 'Молочные вкусности'. Назови поле summa.
SELECT 
	 SUM(price) AS summa
FROM
	products_data_all
WHERE name_store = 'Молочные вкусности';

-- 6. Найди цену самого дорогого товара таблицы products_data_all. Назови поле max_price.
SELECT 
	MAX(price) AS max_price
FROM
	products_data_all;

-- 7. Напиши запрос, который посчитает разницу между максимальной и минимальной ценой продукта 'Масло топленое Ecotavush 99%, 500 г' в магазине 'ВкусМилк'. Назови поле max_min_diff.
SELECT 
	MAX(price) - MIN(price) AS max_min_diff
FROM
	products_data_all
   WHERE  name = 'Масло топленое Ecotavush 99%, 500 г' AND name_store = 'ВкусМилк';

-- ИЗМЕНЕНИЕ ТИПОВ
-- 1. Напиши запрос, который найдёт средний вес (weight) товаров из таблицы products_data_all в граммах (где units='г'). Назови поле average. 
-- Измени тип данных в столбце weight на число с плавающей точкой.
SELECT 
	AVG(weight :: real) AS average
FROM
	products_data_all
    WHERE units='г';

-- 2. Напиши запрос, который посчитает максимальный вес продукта в категории (category) «молоко и сливки». Примени конструкцию CAST AS и назови поле max_weight.
SELECT 
	MAX (CAST (weight AS real)) AS max_weight
FROM
	products_data_all
    WHERE category = 'молоко и сливки';

-- ГРУППИРОВКА ДАННЫХ
-- 1.Напиши запрос, который посчитает общее количество уникальных продуктов в каждом магазине (name_store). Выведи название магазина, 
-- общее количество продуктов, количество уникальных продуктов. Назови поля с количеством name_cnt и name_uniq_cnt соответственно.
SELECT name_store,
	 COUNT(name) AS name_cnt,
     COUNT(DISTINCT name) AS name_uniq_cnt
FROM
	products_data_all
GROUP BY
	name_store 

-- 2. Напиши запрос, который подсчитает значение максимального веса в каждой категории (category). Назови поле max_weight. Выведи категорию и максимальный вес.
SELECT category,
	 MAX(weight :: real) AS max_weight
FROM
	products_data_all
GROUP BY category

-- 3. Напиши запрос, который посчитает среднюю, максимальную и минимальную цены (price) товаров каждого магазина (name_store) в таблице products_data_all. Назови переменные соответственно average_price, max_price, min_price.
-- Выведи название магазина, а также среднюю, максимальную и минимальную цены.
SELECT name_store,
	AVG(price) AS average_price,
    MAX(price) AS max_price,
    MIN(price) AS min_price
FROM
	products_data_all
GROUP BY
	name_store

-- 4. Напиши запрос, который посчитает разницу максимальной и минимальной цены каждого продукта в категории 'масло сливочное и маргарин' на 10 июня 2019 года. Назови переменную max_min_diff. Переведи строковые значения дат в формат даты.
-- Выведи название продукта, разницу между максимальной и минимальной ценами.
SELECT 
	name,
    MAX(price) - MIN(price) AS max_min_diff
FROM
	products_data_all
WHERE
	category = 'масло сливочное и маргарин' AND
    date_upd :: date =  '2019-06-10'
GROUP BY name

-- СОРТИРОВКА ДАННЫХ 
-- 1. Напиши запрос, который посчитает количество товаров в каждой категории (category) на дату '2019-06-05'. Назови переменную name_cnt и отсортируй данные по возрастанию количества товаров. Выведи дату, категорию, количество товаров. Назови выбранную дату update_date.
-- Обрати внимание: дату нужно перевести из строкового типа в date.
SELECT category,
	COUNT(name) AS name_cnt, 
    date_upd AS update_date
FROM
	products_data_all
WHERE
 date_upd::date='2019-06-05'
GROUP BY 
category, update_date
ORDER BY 
	name_cnt

-- 2. Напиши запрос, который посчитает количество уникальных продуктов в каждой категории в магазине 'Lentro' на '2019-06-30'. Назови переменную uniq_name_cnt и отсортируй количество уникальных продуктов по убыванию. Приведи дату к формату date и назови поле update_date. 
-- Выведи дату, название магазина, название категории, количество уникальных продуктов.
SELECT 
	date_upd AS update_date,
    name_store, category,
   COUNT(DISTINCT name) AS uniq_name_cnt
FROM
	products_data_all
WHERE 
	date_upd::date='2019-06-30' AND name_store='Lentro'
GROUP BY 
	update_date, name_store, category
ORDER BY 
	 uniq_name_cnt DESC;

-- 3. Напиши запрос, который выведет топ-5 самых дорогих продуктов по убыванию. Выведи название продукта и стоимость. Дай переменной имя max_price.
SELECT 
	name, MAX(price) AS max_price
FROM
	products_data_all
GROUP BY 
name
ORDER BY max_price DESC
LIMIT 5