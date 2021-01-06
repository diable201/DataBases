-- Create database called «lab10»
CREATE DATABASE lab10;

-- Create a new table with 3-4 columns and 10 filled rows.
CREATE TABLE universities
(
    id              INTEGER,
    university_name VARCHAR(255),
    country         VARCHAR(255),
    rating          INTEGER
);

INSERT INTO universities
VALUES (1, 'KBTU', 'KAZAKHSTAN', 90),
       (2, 'SDU', 'KAZAKHSTAN', 90),
       (3, 'IT', 'KAZAKHSTAN', 89),
       (4, 'KIMEP', 'KAZAKHSTAN', 89),
       (5, 'STANFORD', 'USA', 98),
       (6, 'HARVARD', 'USA', 97),
       (7, 'OXFORD', 'UK', 95),
       (8, 'YALE UNIVERSITY', 'USA', 93),
       (9, 'MIT', 'USA', 100),
       (10, 'CAMBRIDGE', 'UK', 94);


-- 1. Create a function that takes two parameters (text and the letter "l" or "u") 
-- and returns text as upper or lower depending on the second parameter.
CREATE OR REPLACE FUNCTION change_text(s TEXT, x CHAR) RETURNS TEXT AS
$$
BEGIN
    CASE
        WHEN x = 'l' THEN
            s := lower(s);
        WHEN x = 'u' THEN
            s := upper(s);
        END CASE;
    RETURN s;
END;
$$
    LANGUAGE plpgsql;

SELECT *
FROM change_text('KBTU', 'l');
SELECT *
FROM change_text('kimep', 'u');


-- 2. Create a stored function that will add a new row to the table.
CREATE FUNCTION insert_data(a INTEGER, b VARCHAR(255),
                            c VARCHAR(255), d INTEGER)
    RETURNS VOID AS
$$
BEGIN
    INSERT INTO universities(id, university_name, country, rating)
    VALUES (a, b, c, d);
END
$$
    LANGUAGE plpgsql;

SELECT insert_data(11, 'AITU', 'KAZAKHSTAN', '93');


-- 3. Create a stored function that take IN parameter(University name) and will return all columns’ values
-- from table (Hint: OUT).
CREATE OR REPLACE FUNCTION return_info(IN university_name_u VARCHAR(255), OUT id_u INTEGER, OUT name_u VARCHAR(255),
                                       OUT country_u VARCHAR(255), OUT rating_u INTEGER)
AS
$$
BEGIN
    SELECT id, university_name, country, rating
    INTO id_u, name_u, country_u, rating_u
    FROM universities
    WHERE university_name_u = university_name;
END;
$$ LANGUAGE plpgsql;

SELECT *
FROM return_info('OXFORD');


-- 4. Create a stored function that takes IN parameters(list of numbers) and will returns max and min value
-- from list
CREATE OR REPLACE FUNCTION max_min_value(IN a NUMERIC, IN b NUMERIC, IN c NUMERIC,
                                         OUT max_value NUMERIC, OUT min_value NUMERIC) AS
$$
BEGIN
    max_value := greatest(a, b, c);
    min_value := least(a, b, c);
END
$$ LANGUAGE plpgsql;

SELECT *
FROM max_min_value(67, 45, 783);


-- 5. Create a stored function that takes a 1 number parameter and returns square value. Use “INOUT”
CREATE FUNCTION square(INOUT a NUMERIC) AS
$$
BEGIN
    a := a * a;
END
$$ LANGUAGE plpgsql;

SELECT *
FROM square(13);


-- 6. Create a stored function that take(s) IN parameter(s) and will return 1 column values from table.
CREATE OR REPLACE FUNCTION get_value_pattern(pattern VARCHAR(255))
    RETURNS TABLE
            (
                country_u VARCHAR(255),
                rating_u  INTEGER
            )
AS
$$
BEGIN
    RETURN QUERY SELECT country, rating FROM universities WHERE country ILIKE pattern;
END ;
$$ LANGUAGE plpgsql;

SELECT *
FROM get_value_pattern('U_');

-- Defence
CREATE OR REPLACE FUNCTION f1(s TEXT) RETURNS BOOLEAN AS
$$
BEGIN
    CASE
        WHEN s = lower(s) THEN
            RETURN TRUE;
        WHEN s = upper(s) THEN
            RETURN TRUE;
        ELSE RETURN FALSE;
        END CASE;
END;
$$
    LANGUAGE plpgsql;

SELECT *
FROM f1('ABC');
SELECT *
FROM f1('abC');

CREATE OR REPLACE FUNCTION get_value_pattern(pattern INTEGER)
    RETURNS TABLE
            (
                department_u   INTEGER,
                department_u_2 TEXT
            )
AS
$$
BEGIN
    RETURN QUERY SELECT department_id, department_name FROM lab7.public.departments LIMIT pattern;
END ;
$$ LANGUAGE plpgsql;

SELECT *
FROM get_value_pattern(2);
