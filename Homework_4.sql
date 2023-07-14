USE semimar_4;

-- Подсчитать общее количество лайков, которые получили пользователи младше 12 лет.
SELECT COUNT(*) AS like_count 
FROM likes AS L
JOIN profiles AS P ON L.user_id = P.user_id
WHERE (YEAR(CURRENT_DATE)-YEAR(birthday))-(RIGHT(CURRENT_DATE,5)<RIGHT(birthday,5)) < 12;


-- Определить кто больше поставил лайков (всего): мужчины или женщины.
SELECT gender FROM
	(
	SELECT 
		CASE(gender)
			WHEN 'm' THEN 'мужчины'
			WHEN 'f' THEN 'женщины'
			ELSE 'нет'
		END AS gender, 
		COUNT(L.id) AS like_count 
	FROM profiles AS P
	JOIN likes AS L ON P.user_id = L.user_id
	GROUP BY P.gender
	ORDER BY like_count DESC
	LIMIT 1
	) AS gender_max_like;


-- Вывести всех пользователей, которые не отправляли сообщения.
SELECT U.firstname, U.lastname FROM users AS U
WHERE U.id NOT IN
	(
	SELECT U.id 
	FROM users AS U
	JOIN messages AS M ON U.id = M.from_user_id
	GROUP BY U.id
	);


-- (по желанию)* Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех написал ему сообщений.
SELECT U.firstname, U.lastname FROM users AS U
JOIN
	( 
	SELECT M.from_user_id AS id, 
		COUNT(M.from_user_id) AS message_count  
	FROM messages AS M
	WHERE M.to_user_id = 1
	GROUP BY M.from_user_id
	ORDER BY message_count DESC
	LIMIT 1
	) AS best_friend 
ON U.id = best_friend.id;
