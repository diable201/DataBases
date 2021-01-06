-- 1) Create db lab5
CREATE DATABASE lab5;

-- 2) Create table Person
-- (personid serial,
-- Qualification varchar(255), Age integer(0<age<=100), Hours integer(4<=hours<=56), Income integer,
-- Marital varchar(255),
-- Ethnicity varchar(255))
CREATE TABLE Person
(
    Personid      SERIAL,
    Gender        VARCHAR(255),
    Qualification VARCHAR(255),
    Age           INTEGER CHECK (Age BETWEEN 1 AND 100),
    Hours         INTEGER CHECK (Hours BETWEEN 4 AND 56),
    Income        INTEGER,
    Marital       VARCHAR(255),
    Ethnicity     VARCHAR(255)
);

-- And fill it with data 
INSERT INTO Person (Gender, Qualification, Age, Hours, Income, Marital, Ethnicity)
VALUES ('female', 'school', 15, 4, 87, 'never', 'European');
INSERT INTO Person (Gender, Qualification, Age, Hours, Income, Marital, Ethnicity)
VALUES ('female', 'vocational', 40, 42, 596, 'married', 'European');
INSERT INTO Person (Gender, Qualification, Age, Hours, Income, Marital, Ethnicity)
VALUES ('male', 'none', 38, 40, 497, 'married', 'Maori');
INSERT INTO Person (Gender, Qualification, Age, Hours, Income, Marital, Ethnicity)
VALUES ('female', 'vocational', 34, 8, 299, 'never', 'European');
INSERT INTO Person (Gender, Qualification, Age, Hours, Income, Marital, Ethnicity)
VALUES ('female', 'school', 45, 16, 301, 'married', 'European');
INSERT INTO Person (Gender, Qualification, Age, Hours, Income, Marital, Ethnicity)
VALUES ('male', 'degree', 45, 50, 1614, 'married', 'European');

-- 3) Select all person who earns more than 450$ and age over 37 
-- or works less than 40hours and earns more than 250$
SELECT *
FROM Person
WHERE Income > 450 AND Age > 37
   OR Hours < 40 AND Income > 250;

-- 4) Create table users and add constraint for email that checks for existing @
CREATE TABLE Users
(
    first_name VARCHAR(255),
    last_name  VARCHAR(255),
    email      VARCHAR(255)
        CONSTRAINT checker CHECK (email LIKE '%@%')
);

-- And fill it with data 
INSERT INTO Users (first_name, last_name, email)
VALUES ('Debra', 'Burks', 'debra.burks@yahoo.com');
INSERT INTO Users (first_name, last_name, email)
VALUES ('Kasha', 'Todd', 'kasha.todd@yahoo.com');
INSERT INTO Users (first_name, last_name, email)
VALUES ('Tameka', 'Fisher', 'tameka.fisher@aol.com');
INSERT INTO Users (first_name, last_name, email)
VALUES ('Daryl', 'Spence', 'daryl.spence@aol.com');
INSERT INTO Users (first_name, last_name, email)
VALUES ('Charlotte', 'Rice', 'charlotte.rice@msn.com');
INSERT INTO Users (first_name, last_name, email)
VALUES ('Lyndsey', 'Bean', 'lyndsey.bean@hotmail.com');
INSERT INTO Users (first_name, last_name, email)
VALUES ('Latasha', 'Hays', 'latasha.hays@hotmail.com');
INSERT INTO Users (first_name, last_name, email)
VALUES ('Jacquline', 'Duncan', 'jacquline.dunkan@yahoo.com');
INSERT INTO Users (first_name, last_name, email)
VALUES ('Genoveva', 'Baldwin', 'genoveva.baldwin@msn.com');
INSERT INTO Users (first_name, last_name, email)
VALUES ('Pamelia', 'Newman', 'pamelia.newman@gmail.com');
INSERT INTO Users (first_name, last_name, email)
VALUES ('Deshawn', 'Mendoza', 'deshawn.mendoza@yahoo.com');
INSERT INTO Users (first_name, last_name, email)
VALUES ('Robby', 'Sykes', 'robby.sykes@hotmail.com');

-- 5) Find all users with “gmail.com” emails
SELECT *
FROM Users
WHERE email LIKE '%gmail.com%';
-- 6) Find those whose name begins with the letter “D”
-- and contains letter “r”
SELECT *
FROM Users
WHERE first_name LIKE 'D%r%';
-- 7) Delete from table person those 
-- who never married and age over 30
DELETE
FROM Person
WHERE Marital = 'never'
  AND Age > 30;
-- 8) Write a select where full name(upper name, lower lastname) of
-- user as “fio” and emails without “.com and name”
SELECT concat(upper(first_name), ' ', lower(last_name)) AS "FIO",
       substring(email FROM '\.[a-z]+@[a-z]+\.')        AS "Without com and name"
FROM Users;

-- 9) Select all persons with all data and new column “category”, if age
-- between 0 and 20 “A” category, between 21 and 35 “B” category, between 36 and 40 “C”,
-- others “D”
SELECT *,
       CASE
           WHEN Age BETWEEN 0 AND 20
               THEN 'A'
           WHEN Age BETWEEN 21 AND 35
               THEN 'B'
           WHEN Age BETWEEN 36 AND 40
               THEN 'C'
           ELSE 'D'
           END AS "Category"
FROM Person;
-- 10) Delete all users with yahoo email or users who have letter “s” on last name
DELETE
FROM Users
WHERE email LIKE '%yahoo%'
   OR last_name LIKE '%s%'
   OR last_name LIKE '%S%';
-- 11) Drop all tables and db
DROP TABLE Person;
DROP TABLE Users;
DROP DATABASE lab5;
