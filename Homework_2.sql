# 1. Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными
CREATE DATABASE homework_2;
USE homework_2;
CREATE TABLE sales
(
id int auto_increment primary key,
order_date date,
count_product int
);
INSERT INTO sales (order_date, count_product)
VALUES
("2022-01-01", 156), 
("2022-01-02", 180),
("2022-01-03", 21),
("2022-01-04", 124),
("2022-01-05", 341);
SELECT * FROM sales;

# 2. Сгруппируйте значений количества в 3 сегмента — меньше 100, 100-300 и больше 300.
SELECT id,
	IF (count_product < 100, "Маленький заказ",
		IF (count_product BETWEEN 100 AND 300, "Средний заказ", 
			IF (count_product > 300, "Большой заказ", "Не определено"))) AS order_type
FROM homework_2.sales;

# 3. Создайте таблицу “orders”, заполните ее значениями. Покажите “полный” статус заказа, используя оператор CASE
CREATE TABLE homework_2.orders
(
id int auto_increment primary key,
employee_id varchar(3),
amount decimal(5, 2),
order_status varchar(10)
);
INSERT INTO homework_2.orders (employee_id, amount, order_status)
VALUES
("e03", 15, "OPEN"),
("e01", 25.50, "OPEN"),
("e05", 100.70, "CLOSED"),
("e02", 22.18, "OPEN"),
("e04", 9.50, "CANCELLED");
SELECT id, employee_id, amount,
	CASE
		WHEN order_status = "OPEN"
			THEN "Order is in open state"
		WHEN order_status = "CLOSED"
			THEN "Order is closed"
		WHEN order_status = "CANCELLED"
			THEN "Order is cancelled"
    END AS full_order_status
FROM homework_2.orders;

# 4. Чем NULL отличается от 0?
/* 
"0" - это числовое значение атрибута
NULL - это отсутствие значения у атрибута
*/