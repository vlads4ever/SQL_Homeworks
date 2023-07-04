USE homework_1;

# 1.1 Создайте таблицу с мобильными телефонами.
CREATE TABLE mobile_phones (id_phone int auto_increment primary key,
							product_name varchar(45),
							manufacturer varchar(45),
							product_count int, 
							price int);

# 1.2 Заполните БД данными                            
INSERT INTO mobile_phones (product_name, manufacturer, product_count, price)
VALUES
("iPhone X", "Apple", 3, 76000),
("iPhone 8", "Apple", 2, 51000),
("Galaxy S9", "Samsung", 2, 56000),
("Galaxy S8", "Samsung", 1, 41000),
("P20 Pro", "Huawei", 5, 36000);

# 2 Выведите название, производителя и цену для товаров, количество которых превышает 2
SELECT product_name, manufacturer, price FROM mobile_phones
WHERE product_count > 2;

# 3 Выведите весь ассортимент товаров марки “Samsung”
SELECT product_name FROM mobile_phones
WHERE manufacturer = "Samsung";

# 4.1 Выведите товары, в которых есть упоминание "iPhone"
SELECT product_name FROM mobile_phones
WHERE product_name LIKE "iPhone%";

# 4.2 Выведите товары, в которых есть упоминание "Samsung"
SELECT product_name FROM mobile_phones
WHERE manufacturer LIKE "Samsung%";

# 4.3 Выведите товары, в названии которых есть цифры
SELECT product_name FROM mobile_phones
WHERE product_name RLIKE "[0-9]";

# 4.4 Выведите товары, в названии которых есть цифра "8"
SELECT product_name FROM mobile_phones
WHERE product_name RLIKE "[8]";