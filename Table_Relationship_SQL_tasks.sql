-- ПОИСК ПРОПУСКОВ В ДАННЫХ
-- 1. Проверь, есть ли NULL в поле weight в таблице products. Выведи поля: name,units,weight.
SELECT
name,units,weight
FROM
	products
WHERE weight IS NULL; 

-- 2. Найди количество значений NULL в поле weight таблицы products.
SELECT
	COUNT (*) weight
FROM
	products
    WHERE 
    weight IS NULL; 

-- 3. Найди средний вес продукции, сгруппированный по единицам измерения (units). Сохрани его в поле с именем avg_weight.
SELECT
	   AVG( weight::real) AS avg_weight, units 
FROM 
	products
  Group by units

-- 4. Запросом с CASE-выражением замени NULL на среднее значение (округлённое до целого) в каждой группе units. Назови выборку weight_info.
SELECT
	name,
	 CASE WHEN units = '%' AND weight IS NULL THEN '72'
     WHEN units = 'кг' AND weight IS NULL THEN '1'
     WHEN units = 'л' AND weight IS NULL THEN '1'
     WHEN units = 'мл' AND weight IS NULL THEN '805'
     WHEN units = 'г' AND weight IS NULL THEN '402'
   ELSE weight END AS weight_info
FROM
	products;

-- ПОИСК ДАННЫХ В ТАБЛИЦЕ
-- 1. Найди строку с % в поле units. Выведи все столбцы.
SELECT
	*
FROM
	products
WHERE units LIKE '/%' ESCAPE '/'

-- 2. Найди продукты компаний Му и Му-му. Выведи все данные о них из таблицы products.
SELECT 
	 * 
FROM 
	products
 WHERE name LIKE '%Му%';

-- JOIN. INNER JOIN.
-- 1. Напиши запрос, который выведет: номер транзакции, название категории, название продукта.Условие присоединения: значения в полях products.id_product и transactions.id_product равны.
-- Названия полей результирующей таблицы: id_transaction, category, name. Выведи 10 строк. Отсортируй данные по возрастанию номера транзакции.
SELECT 
	transactions.id_transaction AS id_transaction,
    products.category AS category,
    products.name AS name
FROM
	transactions
INNER JOIN products ON products.id_product = transactions.id_product
ORDER BY 
id_transaction
LIMIT 10 	

-- 2. Данные о продажах и данные о погоде хранятся в разных таблицах. Получи данные каждой транзакции: уникальный день и время транзакции из таблицы transactions; температура из таблицы weather; наличие дождя из таблицы weather;
-- идентификатор транзакции из таблицы transactions. Выведи четыре поля результирующей таблицы: date, temp, rain и id_transaction. Отсортируй данные по убыванию даты покупки.
SELECT 
	DISTINCT CAST (transactions.date AS date) AS date, 
    weather.temp AS temp,
    weather.rain AS rain,
    transactions.id_transaction AS id_transaction
FROM
	transactions
INNER JOIN weather ON CAST(weather.date AS date) =  CAST(transactions.date AS date)
ORDER BY date DESC
	
-- 3. Напиши запрос, который выведет уникальные товары с ценой больше 300 рублей. Выбери уникальные названия товаров из таблицы products. Назови полученное поле name и выведи его.
-- Присоедини к products данные таблицы products_stores методом INNER JOIN по полю id_product. В блоке WHERE выбери продукты дороже 300 рублей из таблицы products_stores.
SELECT 
	DISTINCT products.name AS name
FROM
	products
INNER JOIN products_stores ON products_stores.id_product = products.id_product
WHERE 
	products_stores.price > 300;

-- 4. Выбери транзакции (покупки), при которых приобретались продукты категории 'масло сливочное и маргарин' 20 июня 2019 года.
-- Из таблиц transactions и products получи: день и время, номер транзакции, название категории, название продукта.
-- Присоедини к transactions данные таблицы products методом INNER JOIN по полю id_product. В результирующей таблице выведи четыре поля: date, id_transaction, category, name.
SELECT 
	transactions.date AS date,
    transactions.id_transaction AS id_transaction,
    products.category AS category,
    products.name AS name
FROM
	transactions
INNER JOIN products ON products.id_product = transactions.id_product
WHERE CAST(transactions.date as date) = '2019-06-20' AND products.category = 'масло сливочное и маргарин';

-- 5. Выведи цену товаров на 13 июня 2019 года, у которых единица измерения — 'мл'. Получи:название товара, категорию, единицы измерения, вес, цену. 
-- Соедини методом INNER JOIN таблицы products_stores и products по полю id_product. Выведи переменные: name, category, units, weight, price.
SELECT 
	products.name AS name,
    products.category AS category,
    products.units AS units,
    products.weight AS weight,
    products_stores.price AS price
FROM
	products
INNER JOIN products_stores ON products_stores.id_product = products.id_product
WHERE CAST (products_stores.date_upd as date)= '2019-06-13' AND  products.units = 'мл';
	
-- ВНЕШНЕЕ ОБЪЕДИНЕНИЕ ТАБЛИЦ. LEFT JOIN
-- Напиши запрос, который выберет: id_product из таблицы products;name из таблицы products;id_store из таблицы products_stores.
-- Присоедини таблицу products_stores к таблице products методом LEFT JOIN по полю id_product. Полям результирующей таблицы нужно дать имена: id_product, name, id_store.
SELECT 
	products.id_product AS id_product,
    products.name AS name,
    products_stores.id_store AS id_store
FROM
	products 
LEFT JOIN products_stores ON products_stores.id_product = products.id_product;

-- ВНЕШНЕЕ ОБЪЕДИНЕНИЕ ТАБЛИЦ. RIGHT JOIN
-- Получи дату (date) из таблицы weather. Обрати внимание: дату нужно привести к правильному типу конструкцией CAST.
-- Присоедини таблицу weather к таблице transactions методом RIGHT JOIN по полю date.
-- Составь срез данных в блоке WHERE: выбери только пустые даты из таблицы transactions конструкцией IS NULL. Выведи поле date результирующей таблицы.
SELECT 
	CAST(weather.date AS date) AS date
FROM
	transactions
RIGHT JOIN weather ON CAST(weather.date AS date) = CAST(transactions.date AS date)
WHERE transactions.date IS NULL;

-- ОБЪЕДИНЕНИЕ НЕСКОЛЬКИХ ТАБЛИЦ
-- 1. За 5 июня 2019 года выведи номер транзакции; название магазина, где она произошла; категорию и название приобретённого продукта.
-- Методом JOIN соедини таблицу transactions с таблицей products по полю id_product; затем соедини transactions со stores по полю id_store.
SELECT 
	transactions.id_transaction AS id_transaction,
    stores.name_store AS name_store,
    products.category AS category,
    products.name AS name
FROM
	transactions
INNER JOIN products ON transactions.id_product = products.id_product
INNER JOIN stores ON transactions.id_store = stores.id_store
WHERE CAST(transactions.date AS date) = '2019-06-05'

-- 2. Найди информацию о погоде и названиях купленных товаров за все дни (включая те, когда покупок не было). 
-- Отсортируй данные по убыванию даты и выведи первые 30 строк. Способом LEFT JOIN присоедини к weather таблицу transactions по полю date. Затем присоедини к transactions и таблицу products по полю id_product.
SELECT
	CAST(weather.date AS date) AS date,
    weather.temp AS temp,
    weather.rain AS rain,
    products.name AS name
FROM 
	weather
LEFT JOIN transactions ON CAST(transactions.date AS date) = CAST(weather.date AS date)
LEFT JOIN products ON transactions.id_product = products.id_product
ORDER BY 
	CAST(weather.date AS date) DESC
LIMIT 30;

-- 3. Напиши запрос, который выведет все данные о транзакциях, совершённых в те дни, когда не было дождя, включая названия продуктов. Сделай срез данных в блоке WHERE. Ограничение среза: weather.rain = False
SELECT 
	transactions.id_transaction AS id_transaction,
    products.name AS name
FROM
	transactions
INNER JOIN products ON products.id_product = transactions.id_product
INNER JOIN weather ON CAST(weather.date AS date) = CAST(transactions.date AS date)
WHERE weather.rain = False
