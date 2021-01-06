SELECT DISTINCT ON(city) * FROM theaters;
SELECT DISTINCT ON(size) * FROM theaters ORDER BY size DESC NULLS LAST LIMIT 3;
SELECT * FROM movies ORDER BY rating DESC NULLS LAST LIMIT 1 OFFSET 2;
SELECT * FROM movies WHERE rating IS NOT NULL;
SELECT * FROM movies WHERE rating IS NOT NULL AND (genre = 'Comedy' OR genre = 'Fantasy');
SELECT id AS MovieID, 
	CASE 
		WHEN rating BETWEEN 0 AND 3 THEN 'The rating of ' || title || ' is Low'
		WHEN rating BETWEEN 4 AND 7 THEN 'The rating of ' || title || ' is Medium'
		WHEN rating BETWEEN 8 AND 10 THEN 'The rating of ' || title || ' is High'
		ELSE title || ' has no rating'
	END AS MovieInfo
FROM movies;
SELECT * FROM movies WHERE id NOT IN (SELECT movie_id FROM movietheaters);
SELECT upper(title), overlay(title placing '' from 1 for 3), char_length(title) FROM movies;
UPDATE movies SET rating = 1 WHERE rating IS NULL RETURNING *;
DELETE FROM movies WHERE id NOT IN (SELECT movie_id FROM movietheaters) RETURNING *;
SELECT * FROM movies WHERE title LIKE 'S%o_';
SELECT city, avg(size) FROM theaters GROUP BY city;
SELECT * FROM movies WHERE id IN (SELECT movie_id FROM movietheaters GROUP BY movie_id HAVING count(movie_id) > 2);
