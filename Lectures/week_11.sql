CREATE VIEW view1 AS
SELECT 'Hello';

SELECT *
FROM view1;

SELECT *
FROM categories;

CREATE VIEW children_bicycles AS
SELECT *
FROM products
WHERE category_id = 1;

SELECT *
FROM children_bicycles;

CREATE OR REPLACE VIEW children_bicycles_2016 AS
SELECT *
FROM children_bicycles
WHERE model_year = 2016
-- Check Year
        WITH LOCAL CHECK OPTION;

CREATE OR REPLACE VIEW children_bicycles_2016 AS
SELECT *
FROM children_bicycles
WHERE model_year = 2016
-- Check Year
        WITH CASCADED CHECK OPTION;

DROP VIEW children_bicycles_2016;

SELECT *
FROM children_bicycles_2016;

INSERT INTO children_bicycles_2016 (product_id, product_name, brand_id, category_id, model_year, list_price)
VALUES (500, 'test 2', 1, 1, 2016, 1000);

SELECT *
FROM pg_roles;

SELECT *
FROM products;


CREATE TABLE test
(
    a INTEGER
);

INSERT INTO test (a)
VALUES (4),
       (5);

SELECT *
FROM test;

CREATE VIEW v1
AS
SELECT a
FROM test
WHERE a > 4;

SELECT *
FROM v1;

CREATE VIEW v2
AS
SELECT a
FROM v1
WHERE a < 10
WITH CASCADED CHECK OPTION;

DROP VIEW v2;

SELECT *
FROM v2;

INSERT INTO v2 (a)
VALUES (1);

SELECT *
FROM test;


SELECT *
FROM test;

CREATE MATERIALIZED VIEW mv1
AS
SELECT a
FROM test
WHERE a >= 5
WITH DATA;

SELECT *
FROM test;

DELETE
FROM test
WHERE a = 5;

SELECT *
FROM mv1;

REFRESH MATERIALIZED VIEW mv1;

SELECT *
FROM test;


CREATE MATERIALIZED VIEW mv2
AS
SELECT a
FROM test
WHERE a < 10
WITH NO DATA;

SELECT *
FROM mv2;

REFRESH MATERIALIZED VIEW mv2;

SELECT *
FROM orders;

SELECT *
FROM order_items;


SELECT o.order_id,
       o.order_status,
       o.order_date,
       c.first_name || ' ' || c.last_name AS full_name,
       oi.total_price
FROM orders AS o
         JOIN customers AS c ON o.customer_id = c.customer_id
         JOIN (
    SELECT order_id,
           sum(list_price * quantity * (1 - discount))
               AS total_price
    FROM order_items
    GROUP BY order_id
) AS oi ON oi.order_id = o.order_id
ORDER BY order_id;

-- res = list_price - list_price * discount ---> product price with discount
-- res = res * quantity ---> total price for item

SELECT 999.99 + 599.99; -- = 1599.98

CREATE MATERIALIZED VIEW order_more_info
AS
SELECT o.order_id,
       o.order_status,
       o.order_date,
       c.first_name || ' ' || c.last_name AS full_name,
       oi.total_price
FROM orders AS o
         JOIN customers AS c ON o.customer_id = c.customer_id
         JOIN (
    SELECT order_id,
           sum(list_price * quantity * (1 - discount))
               AS total_price
    FROM order_items
    GROUP BY order_id
) AS oi ON oi.order_id = o.order_id
ORDER BY order_id
WITH NO DATA;

SELECT *
FROM order_more_info;

REFRESH MATERIALIZED VIEW order_more_info;

EXPLAIN ANALYSE
SELECT *
FROM order_more_info;

CREATE UNIQUE INDEX order_more_info_order_id
    ON order_more_info (order_id);


CREATE OR REPLACE VIEW v3
AS
SELECT *
FROM products
WHERE list_price >= 2000;

DROP VIEW IF EXISTS v3_new;

ALTER VIEW v3
    RENAME TO v3_new;


SELECT *
FROM pg_roles;
CREATE ROLE test SUPERUSER CREATEROLE
    CREATEDB LOGIN REPLICATION PASSWORD '123123123';
DROP ROLE test;

ALTER ROLE test WITH PASSWORD 'asdasdasd';
