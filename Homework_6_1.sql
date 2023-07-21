-- Создайте таблицу users_old, аналогичную таблице users. Создайте процедуру, с помощью которой 
-- можно переместить любого (одного) пользователя из таблицы users в таблицу users_old. 
-- (использование транзакции с выбором commit или rollback – обязательно).

USE semimar_4;

DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамилия',
    email VARCHAR(120) UNIQUE
);

DELIMITER //

DROP PROCEDURE IF EXISTS move_user//
CREATE PROCEDURE move_user(IN user_id INT)
BEGIN
	-- Делаем откат транзакции если выпадет исключение SQL
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
	END;

	START TRANSACTION;
		SELECT * INTO @user_id, @firstname, @lastname, @email
		FROM users
		WHERE id = user_id;

		INSERT INTO users_old (id, firstname, lastname, email)
		VALUES (@user_id, @firstname, @lastname, @email);

		DELETE FROM users
		WHERE id = user_id;
	COMMIT;
END//

DELIMITER ;

CALL move_user(2);

SELECT * FROM semimar_4.users;
SELECT * FROM semimar_4.users_old;