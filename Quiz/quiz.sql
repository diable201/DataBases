CREATE TABLE quiz_tbl
(
    location_id    NUMERIC(4, 0),
    street_address CHARACTER VARYING(40),
    postal_code    CHARACTER VARYING(12),
    city           CHARACTER VARYING(30),
    state_province CHARACTER VARYING(25),
    country_id     CHARACTER VARYING(2),
    region_id      INTEGER
);

ALTER TABLE quiz_tbl
    ALTER COLUMN country_id SET DATA TYPE TEXT USING quiz_tbl.country_id::text,
    DROP COLUMN IF EXISTS name;

CREATE TABLE departments
(
    code   INTEGER PRIMARY KEY,
    name   VARCHAR(255) NOT NULL,
    budget DECIMAL      NOT NULL
);

CREATE TABLE employees
(
    ssn        SERIAL PRIMARY KEY,
    name       VARCHAR(255) NOT NULL,
    lastname   VARCHAR(255) NOT NULL,
    department INTEGER      NOT NULL,
    city       VARCHAR(255),
    FOREIGN KEY (department) REFERENCES departments (code)
);

CREATE TABLE customers
(
    id       SERIAL PRIMARY KEY,
    name     VARCHAR(255) NOT NULL,
    lastname VARCHAR(255) NOT NULL,
    city     VARCHAR(255)
);

create table department
(
    dept_id     serial primary key,
    dept_name   varchar(255) not null,
    description varchar(255),
    location    varchar(50)
);

insert into department (dept_name, location)
values ('research', 'newyork'),
       ('accounting', 'boston'),
       ('operations', 'florida'),
       ('sales', 'chicago');


INSERT INTO departments(code, name, budget)
VALUES (14, 'IT', 65000);
INSERT INTO departments(code, name, budget)
VALUES (37, 'Accounting', 15000);
INSERT INTO departments(code, name, budget)
VALUES (59, 'Human Resources', 240000);
INSERT INTO departments(code, name, budget)
VALUES (77, 'Research', 55000);
INSERT INTO departments(code, name, budget)
VALUES (45, 'Management', 155000);
INSERT INTO departments(code, name, budget)
VALUES (11, 'Sales', 85000);

INSERT INTO employees(name, lastname, department, city)
VALUES ('Asan', 'Olzhas', 14, 'Almaty');
INSERT INTO employees(name, lastname, department, city)
VALUES ('Anar', 'Sabit', 14, 'Shymkent');
INSERT INTO employees(name, lastname, department, city)
VALUES ('Bekbol', 'Saken', 37, 'Astana');
INSERT INTO employees(name, lastname, department, city)
VALUES ('Daulet', 'Nurlan', 37, 'Almaty');
INSERT INTO employees(name, lastname, department, city)
VALUES ('Erkin', 'Bekbolsyn', 14, 'Astana');
INSERT INTO employees(name, lastname, department, city)
VALUES ('Eset', 'Nurzhan', 77, 'Astana');
INSERT INTO employees(name, lastname, department, city)
VALUES ('Dana', 'Dastan', 59, 'Shymkent');
INSERT INTO employees(name, lastname, department, city)
VALUES ('Ayana', 'Dastan', 77, 'Almaty');
INSERT INTO employees(name, lastname, department, city)
VALUES ('Eset', 'Saken', 59, 'Almaty');
INSERT INTO employees(name, lastname, department, city)
VALUES ('Anar', 'Samat', 37, 'Atyrau');
INSERT INTO employees(name, lastname, department, city)
VALUES ('Asan', 'Sultan', 14, 'Almaty');
INSERT INTO employees(name, lastname, department, city)
VALUES ('Kumar', 'Olzhas', 37, 'Almaty');

INSERT INTO customers(name, lastname, city)
VALUES ('Eset', 'Dastan', 'Almaty');
INSERT INTO customers(name, lastname, city)
VALUES ('Manas', 'Sultan', 'London');
INSERT INTO customers(name, lastname, city)
VALUES ('Abay', 'Anuar', 'Almaty');
INSERT INTO customers(name, lastname, city)
VALUES ('Omar', 'Dulat', 'Tokyo');
INSERT INTO customers(name, lastname, city)
VALUES ('Dana', 'Bolat', 'Almaty');
INSERT INTO customers(name, lastname, city)
VALUES ('Ayana', 'Nurlan', 'Astana');
INSERT INTO customers(name, lastname, city)
VALUES ('Asan', 'Sultan', 'Shymkent');
INSERT INTO customers(name, lastname, city)
VALUES ('Ernur', 'Bekbol', 'Almaty');
INSERT INTO customers(name, lastname, city)
VALUES ('Ernur', 'Talgat', 'Astana');

UPDATE department
SET description=format('The %s department located in %s', dept_name, location)
RETURNING *;

-- 5
-- a
SELECT name, count(*) AS "Repeated times"
FROM (
         SELECT name
         FROM customers
         UNION ALL
         SELECT name
         FROM employees
     ) AS cust_and_employees
GROUP BY name;

-- b
SELECT city, count(*) AS "works here"
FROM (
         SELECT city
         FROM customers
         UNION ALL
         SELECT city
         FROM employees
     ) AS cust_and_employees
GROUP BY city;

-- c
SELECT lastname, count(*) || ' from employees' AS description
FROM employees
GROUP BY lastname
UNION
SELECT lastname, count(*) || ' from customers' AS description
FROM customers
GROUP BY lastname;

SELECT name
FROM employees
GROUP BY name
UNION
SELECT name
FROM customers
GROUP BY name;
SELECT city, count(*)
FROM employees
GROUP BY city;
SELECT lastname
FROM employees
GROUP BY lastname
UNION
SELECT lastname
FROM customers
GROUP BY lastname;

SELECT *
FROM employees
WHERE department = 37
    AND (lastname LIKE '%n%' OR lastname LIKE '%s%')
   OR name LIKE '%r%';

    (SELECT name FROM employees EXCEPT SELECT name FROM customers)
    UNION
    (SELECT name FROM customers EXCEPT SELECT name FROM employees);



SELECT *
FROM departments
WHERE code % 7 = 0
   OR code % 9 = 0;

SELECT *
FROM customers
WHERE name LIKE 'E%'
  and name LIKE '%a_';
