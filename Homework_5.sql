USE semimar_4;

-- 1. Создайте представление, в которое попадет информация о пользователях 
-- 	(имя, фамилия, город и пол), которые не старше 20 лет.
CREATE OR REPLACE VIEW adult_users AS
SELECT U.firstname, U.lastname, P.hometown, 
	CASE (P.gender)
		WHEN 'm' THEN 'мужчина'
		WHEN 'f' THEN 'женщина'
		ELSE 'нет'
	END AS gender
FROM users AS U
JOIN profiles AS P ON U.id = P.user_id
WHERE (YEAR(CURRENT_DATE)-YEAR(birthday))-(TIMEDIFF(CURRENT_DATE, birthday) < 0) > 20;

SELECT * FROM adult_users;

-- 2. Найдите кол-во, отправленных сообщений каждым пользователем и выведите ранжированный 
-- 	список пользователей, указав имя и фамилию пользователя, количество отправленных сообщений 
-- 	и место в рейтинге (первое место у пользователя с максимальным количеством сообщений). 
-- 	(используйте DENSE_RANK)
WITH count_messages AS
	(
		SELECT U.firstname, U.lastname, 
			COUNT(M.from_user_id) OVER(PARTITION BY M.from_user_id) AS 'count'
		FROM users AS U
		JOIN messages AS M ON U.id = M.from_user_id
	)
    
SELECT *, 
	DENSE_RANK() OVER(ORDER BY count DESC) AS 'dense_rank'
FROM count_messages;

-- 3. Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления (created_at)
-- 	и найдите разницу дат отправления между соседними сообщениями, получившегося списка. 
-- 	(используйте LEAD или LAG)
SELECT body, created_at,
	DATEDIFF(LEAD(created_at) OVER w, 
		LAG(created_at) OVER w) AS days_diff,
	TIMEDIFF(LEAD(created_at) OVER w, 
		LAG(created_at) OVER w) AS time_diff
FROM messages
WINDOW w AS (ORDER BY created_at)

