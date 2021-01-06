-- 1. Create database called lab6
CREATE DATABASE lab6;

-- 2. Create following table «customers» and «orders»:
CREATE TABLE customers
(
    customer_id INTEGER PRIMARY KEY,
    cust_name   VARCHAR(255),
    city        VARCHAR(255),
    grade       INTEGER,
    salesman_id INTEGER
);

CREATE TABLE orders
(
    order_no    INTEGER PRIMARY KEY,
    purch_amt   REAL,
    ord_date    VARCHAR(255),
    customer_id INTEGER REFERENCES customers (customer_id),
    salesman_id INTEGER
);

INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id)
VALUES (3002, 'Nick Rimando', 'New York', 100, 5001);
INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id)
VALUES (3005, 'Graham Zusi', 'California', 200, 5002);
INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id)
VALUES (3001, 'Brad Guzan', 'London', NULL, 5005);
INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id)
VALUES (3004, 'Fabian Johns', 'Paris', 300, 5006);
INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id)
VALUES (3007, 'Brad Davis', 'New York', 200, 5001);
INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id)
VALUES (3009, 'Geoff Camero', 'Berlin', 100, 5003);
INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id)
VALUES (3008, 'Julian Green', 'London', 300, 5002);

INSERT INTO orders (order_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES (70001, 150.5, '2012-10-05', 3005, 5002);
INSERT INTO orders (order_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES (70009, 270.65, '2012-09-10', 3001, 5005);
INSERT INTO orders (order_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES (70002, 65.26, '2012-10-05', 3002, 5001);
INSERT INTO orders (order_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES (70004, 110.5, '2012-08-17', 3009, 5003);
INSERT INTO orders (order_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES (70007, 948.5, '2012-09-10', 3005, 5002);
INSERT INTO orders (order_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES (70005, 2004.6, '2012-07-27', 3007, 5001);
INSERT INTO orders (order_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES (70008, 5760, '2012-09-10', 3002, 5001);

-- 3. Select the total purchase amount of all orders.
SELECT sum(purch_amt)
FROM orders;
-- 4. Select the average purchase amount of all orders.
SELECT avg(purch_amt)
FROM orders;
-- 5. Select how many customer have listed their names.
SELECT count(cust_name)
FROM customers
WHERE cust_name IS NOT NULL;
-- 6. Select the minimum purchase amount of all the orders.
SELECT min(purch_amt)
FROM orders;
-- 7. Select customer with all information whose name ends with the
-- letter 'b'.
SELECT *
FROM customers
WHERE cust_name LIKE '%b %';
-- 8. Select orders which made by customers from ‘New York’.
SELECT *
FROM orders
WHERE customer_id IN (
    SELECT customer_id
    FROM customers
    WHERE city = 'New York'
);
-- 9. Select customers with all information who has order with
-- purchase amount more than 10.
SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE purch_amt > 10
);
-- 10. Select total grade of all customers.
SELECT sum(grade)
FROM customers;
-- 11. Select all customers who have listed their names.
SELECT *
FROM customers
WHERE cust_name IS NOT NULL;
-- 12. Select the maximum grade of all the customers.
SELECT max(grade)
FROM customers;
