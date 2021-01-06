-- 1. Create database called «lab9»
CREATE DATABASE lab9;

-- 2. Create following tables «salesman», «customers» and «orders»:
CREATE TABLE salesman
(
    salesman_id INTEGER PRIMARY KEY,
    name        VARCHAR(255),
    city        VARCHAR(255),
    commission  REAL
);

CREATE TABLE customers
(
    customer_id INTEGER PRIMARY KEY,
    cust_name   VARCHAR(255),
    city        VARCHAR(255),
    grade       INTEGER,
    salesman_id INTEGER REFERENCES salesman
);

CREATE TABLE orders
(
    ord_no      INTEGER PRIMARY KEY,
    purch_atm   REAL,
    ord_date    DATE,
    customer_id INTEGER REFERENCES customers,
    salesman_id INTEGER REFERENCES salesman
);

INSERT INTO salesman
VALUES (5001, 'James Hoog', 'New York', 0.15);
INSERT INTO salesman
VALUES (5002, 'Nail Knite', 'Paris', 0.13);
INSERT INTO salesman
VALUES (5005, 'Pit Alex', 'London', 0.11);
INSERT INTO salesman
VALUES (5006, 'Mc Lyon', 'Paris', 0.14);
INSERT INTO salesman
VALUES (5003, 'Lauson Hen', NULL, 0.12);
INSERT INTO salesman
VALUES (5007, 'Paul Adam', 'Rome', 0.13);

INSERT INTO customers
VALUES (3002, 'Nick Rimando', 'New York', 100, 5001);
INSERT INTO customers
VALUES (3005, 'Graham Zusi', 'California', 200, 5002);
INSERT INTO customers
VALUES (3001, 'Brad Guzan', 'London', NULL, 5005);
INSERT INTO customers
VALUES (3004, 'Fabian Johns', 'Paris', 300, 5006);
INSERT INTO customers
VALUES (3007, 'Brad Davis', 'New York', 200, 5001);
INSERT INTO customers
VALUES (3009, 'Geoff Camero', 'Berlin', 100, 5003);
INSERT INTO customers
VALUES (3008, 'Julian Green', 'London', 300, 5002);

INSERT INTO orders
VALUES (70001, 150.5, '2012-10-05', 3005, 5002);
INSERT INTO orders
VALUES (70009, 270.65, '2012-09-10', 3001, 5005);
INSERT INTO orders
VALUES (70002, 65.26, '2012-10-05', 3002, 5001);
INSERT INTO orders
VALUES (70004, 110.5, '2012-08-17', 3009, 5003);
INSERT INTO orders
VALUES (70007, 948.5, '2012-09-10', 3005, 5002);
INSERT INTO orders
VALUES (70005, 2400.6, '2012-07-27', 3007, 5001);
INSERT INTO orders
VALUES (70008, 5760, '2012-09-10', 3002, 5001);

-- 3. Create role named «junior_dev» with login privilege.
CREATE ROLE junior_dev LOGIN;

-- 4. Create a view for those salesmen belongs to the city New York.
CREATE VIEW salesman_from_NY AS
SELECT name
FROM salesman
WHERE city = 'New York';
SELECT *
FROM salesman_from_NY;

-- 5. Create a view that shows for each order the salesman and
-- customer by name. Grant all privileges to «junior_dev»
CREATE VIEW customer_salesman_names AS
SELECT o.ord_no, c.cust_name, s.name
FROM orders AS o
         JOIN customers c ON o.customer_id = c.customer_id
         JOIN salesman s ON o.salesman_id = s.salesman_id;
SELECT *
FROM customer_salesman_names;
GRANT ALL PRIVILEGES ON customer_salesman_names TO junior_dev;

-- 6. Create a view that shows all of the customers who have the
-- highest grade. Grant only select statements to «junior_dev»
CREATE VIEW highest_grade AS
SELECT cust_name, grade
FROM customers
WHERE grade = (SELECT max(grade) FROM customers);
SELECT *
FROM highest_grade;
GRANT SELECT ON highest_grade TO junior_dev;

-- 7. Create a view that shows the number of the salesman in each
-- city.
CREATE VIEW each_city_salesman AS
SELECT count(salesman_id), city
FROM salesman
GROUP BY city;
SELECT *
FROM each_city_salesman;

-- 8. Create a view that shows each salesman with more than one
-- customers.
CREATE VIEW cust_salesman AS
SELECT name
FROM salesman
WHERE salesman_id IN
      (SELECT salesman_id FROM customers AS c GROUP BY(c.salesman_id) HAVING (count(cust_name) > 1));
SELECT *
FROM cust_salesman;

-- 9. Create role «intern» and give all privileges of «junior_dev».
CREATE ROLE intern;
GRANT intern to junior_dev;
-- Or we can use this but it changes owner
REASSIGN OWNED BY junior_dev TO intern;

-- Defence
SELECT DISTINCT e2.*, d.*
FROM employees e
         RIGHT JOIN employees e2 ON (e.manager_id = e2.employee_id)
         LEFT JOIN departments d on e.manager_id = d.manager_id
WHERE e.manager_id IS NOT NULL
  AND d.manager_id IS NULL;

SELECT DISTINCT e.*
FROM employees e
         JOIN departments d on e.employee_id = d.manager_id
         LEFT JOIN employees e2 ON e2.manager_id = d.manager_id
WHERE e.manager_id IS NOT NULL
  AND e2.manager_id IS NULL;

SELECT DISTINCT e2.*
FROM employees e
         INNER JOIN employees e2 ON (e.manager_id = e2.employee_id)
         INNER JOIN departments d on e.manager_id = d.manager_id;
