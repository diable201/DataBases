CREATE TABLE movies(
	id serial PRIMARY KEY,
	title varchar(255) NOT NULL UNIQUE,
	rating integer,
	genre varchar(50) NOT NULL 
);

CREATE TABLE theaters(
	id serial PRIMARY KEY,
	name varchar(255) NOT NULL UNIQUE,
	size integer CHECK(size > 3) NOT NULL,
	city varchar(50) NOT NULL 
);

INSERT INTO movies(title, rating, genre) VALUES
	('Citizen Kane', 5, 'Drama'), 
	('Singin in the rain', 7, 'Comedy'),
	('The Wizard of Oz', 7, 'Fantasy'),
	('The Quiet Man', null, 'Comedy'),
	('North by Northwest', null, 'Thriller'),
	('The Last Tango in Paris', 9, 'Drama'),
	('Some Like It Hot', 4, 'Comedy'),
	('A Night at the Opera', null, 'Comedy');

INSERT INTO theaters(name, size, city) VALUES 
	('Kinopark Esentai', 15, 'Almaty'),
	('Star Cinema Mega', 7, 'Almaty'),
	('Kinopark 8', 9, 'Shymkent'),
	('Star Cinema 15', 11, 'Astana'),
	('Cinemax', 4, 'Aktau');

SELECT DISTINCT ON(genre) title FROM movies;
SELECT * FROM movies ORDER BY rating DESC NULLS LAST LIMIT 3;
SELECT * FROM theaters ORDER BY size LIMIT 1 OFFSET 2;
SELECT * FROM movies WHERE rating IS NULL;
SELECT * FROM theaters WHERE size > 7 AND (city = 'Almaty' OR city = 'Shymkent');
SELECT id AS MovieID, format('The genre of %s is %s', title, genre) AS MovieInfo FROM movies;

CREATE TABLE movietheaters(
	theater_id integer REFERENCES theaters,
	movie_id integer REFERENCES movies,
	rating integer, 
	PRIMARY KEY(theater_id, movie_id)
);

INSERT INTO movietheaters VALUES
	(1, 5, 5), 
	(3, 1, 7), 
	(1, 3, 9), 
	(4, 6, 6), 
	(2, 3, 5), 
	(4, 4, 7);

SELECT * FROM theaters WHERE id NOT IN (SELECT theater_id FROM movietheaters);
SELECT rating,
	CASE 
		WHEN rating >= 0 AND rating <= 3 THEN 'Low rating' 
		WHEN rating >= 4 AND rating <= 7 THEN 'Medium rating' 
		WHEN rating >= 8 AND rating <= 10 THEN 'High rating' 
		ELSE 'No rating'
	END
FROM movies;
UPDATE movies SET rating = 1 WHERE rating IS NULL RETURNING *;
DELETE FROM movies WHERE id NOT IN (SELECT movie_id FROM movietheaters) RETURNING *;	
SELECT * FROM movies WHERE title LIKE 'T_e%n';
SELECT genre, avg(rating) FROM movies GROUP BY genre;
SELECT * FROM theaters WHERE id IN 
	(SELECT theater_id FROM movietheaters 
	 GROUP BY theater_id 
	 HAVING count(theater_id) > 1);
	 