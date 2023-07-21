-- (по желанию)* Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
-- communities и messages в таблицу logs помещается время и дата создания записи, название таблицы, 
-- идентификатор первичного ключа.

USE semimar_4;

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	-- В таблице типа ARCHIVE отсутствует первичный ключ.
	log_date_time DATETIME DEFAULT NOW(),
    log_table_name VARCHAR(50) NOT NULL,    
    log_entry_id BIGINT UNSIGNED NOT NULL
) ENGINE = ARCHIVE;

-- Создаем тригеры логирования для требуемых по условию таблиц
DROP TRIGGER IF EXISTS users_log;
CREATE TRIGGER  users_log
AFTER INSERT ON users FOR EACH ROW 
INSERT INTO logs SET log_table_name = 'users', log_entry_id = NEW.id;

DROP TRIGGER IF EXISTS communities_log;
CREATE TRIGGER  communities_log
AFTER INSERT ON communities FOR EACH ROW 
INSERT INTO logs SET log_table_name = 'communities' , log_entry_id = NEW.id;

DROP TRIGGER IF EXISTS messages_log;
CREATE TRIGGER  messages_log
AFTER INSERT ON messages FOR EACH ROW 
INSERT INTO logs SET log_table_name = 'messages' , log_entry_id = NEW.id;

-- Создаем новые записи в логируемых таблицах
INSERT INTO users (firstname, lastname, email) VALUES ('John', 'Snow', 'j_snow@mail.com');
INSERT INTO communities (name) VALUES ('pusan');
INSERT INTO messages (from_user_id,to_user_id,body) VALUES (3, 4, 'Hello guy!');

-- Выводим содержимое логов
SELECT * FROM logs;