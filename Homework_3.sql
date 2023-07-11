CREATE DATABASE homework_3;
USE homework_3;

CREATE TABLE customers
(
id int auto_increment primary key,
customer_name varchar(30) not null,
city varchar(30) not null,
rating int not null
);
INSERT INTO customers (customer_name, city, rating)
VALUES
("Григорий", "Москва", 10),
("Анатолий", "Москва", 7),
("Павел", "Санкт-Петербург", 6),
("Геннадий", "Анапа", 8),
("Тимофей", "Саратов", 9),
("Александр", "Санкт-Петербург", 10),
("Антон", "Омск", 8),
("Николай", "Саратов", 7);

CREATE TABLE orders
(
id int auto_increment primary key,
customer_id int not null,
order_date date not null,
order_cost decimal not null,
foreign key(customer_id) references customers(id)  
);
INSERT INTO orders (customer_id, order_date, order_cost)
VALUES
(1, "2016-01-01", 10000),
(2, "2016-03-20", 15000),
(2, "2016-04-21", 30000),
(3, "2016-01-01", 25000),
(4, "2016-05-15", 17000),
(5, "2016-07-06", 40000),
(6, "2016-01-01", 10000),
(6, "2016-09-16", 45000),
(7, "2016-02-26", 39000),
(8, "2016-01-03", 20000),
(8, "2016-08-07", 28000);


-- 1. Напишите запрос, который сосчитал бы все суммы заказов, выполненных 1 января 2016 года.
SELECT sum(order_cost) AS orders_sum FROM orders
WHERE order_date = "2016-01-01";

-- 2. Напишите запрос, который сосчитал бы число различных, отличных от NULL значений поля city в таблице заказчиков.
SELECT count(DISTINCT city) AS city_count FROM customers
WHERE city IS NOT null;

-- 3. Напишите запрос, который выбрал бы наименьшую сумму для каждого заказчика.
SELECT customer_id, min(order_cost) AS min_cost FROM orders
GROUP BY customer_id;

-- 4*. Напишите запрос, который бы выбирал заказчиков чьи имена начинаются с буквы Г. 
-- Используется оператор "LIKE": https://dev.mysql.com/doc/refman/8.0/en/string-comparison-functions.html
SELECT customer_name FROM customers
WHERE customer_name LIKE "Г%";

-- 5. Напишите запрос, который выбрал бы высший рейтинг в каждом городе.
SELECT city, max(rating) AS max_rating FROM customers
GROUP BY city;

-- Задание №2.
CREATE TABLE staff
(
id int auto_increment primary key,
firstname varchar(30) not null,
lastname varchar(30) not null,
post varchar(50) not null,
seniority int,
salary int,
age int not null
);
INSERT INTO staff (firstname, lastname, post, seniority, salary, age)
VALUES
('Вася',	'Петров',	'Начальник',	40,	100000,	60),
('Петр',	'Власов',	'Начальник',	8,	70000,	30),
('Катя',	'Катина',	'Инженер',	2,	70000,	25),
('Саша',	'Сасин',	'Инженер',	12,	50000,	35),
('Иван',	'Иванов',	'Рабочий',	40,	30000,	59),
('Петр',	'Петров',	'Рабочий',	20,	25000,	40),
('Сидр',	'Сидоров',	'Рабочий',	10,	20000,	35),
('Антон',	'Антонов',	'Рабочий',	8,	19000,	28),
('Юрий',	'Юрков',	'Рабочий',	5,	15000,	25),
('Максим',	'Максимов',	'Рабочий',	2,	11000,	22),
('Юрий',	'Галкин',	 'Рабочий', 	3,	12000,	24),
('Людмила',	'Маркина',	'Уборщик',	10,	10000,	49);

-- Отсортируйте поле “сумма” в порядке убывания и возрастания
SELECT post, sum(salary) AS sal_sum FROM staff
GROUP BY post
ORDER BY sal_sum;
 
SELECT post, sum(salary) AS sal_sum FROM staff
GROUP BY post
ORDER BY sal_sum DESC;

-- Отсортируйте по возрастанию поле “Зарплата”
SELECT * FROM staff
ORDER BY salary;

-- Выведите 5 строк с наибольшей заработной платой
SELECT salary FROM staff
ORDER BY salary DESC
LIMIT 5;

-- Выполните группировку всех сотрудников по специальности “рабочий”, зарплата которых превышает 20000
SELECT post, count(*) FROM staff
WHERE salary > 20000
GROUP BY post
HAVING post = 'Рабочий';
