-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, 
-- в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
-- с 18:00 до 00:00 — "Добрый вечер", 
-- с 00:00 до 6:00 — "Доброй ночи".

USE semimar_4;

DELIMITER //

DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello(input_data TIME)
RETURNS TEXT DETERMINISTIC
BEGIN
	DECLARE hello_string VARCHAR(20);
	IF (input_data >= '12:00:00' AND  input_data < '18:00:00') THEN 
		SET hello_string = 'Добрый день';
	ELSEIF (input_data >= '06:00:00' AND  input_data < '12:00:00') THEN 
		SET hello_string = 'Доброе утро';
	ELSEIF (input_data >= '00:00:00' AND  input_data < '06:00:00') THEN 
		SET hello_string = 'Доброй ночи';
	ELSE SET hello_string = 'Добрый вечер';
    END IF;
    RETURN hello_string;
END//

DELIMITER ;

SELECT hello(CURRENT_TIME) AS greetings;