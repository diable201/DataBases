SELECT *
FROM categories;

SELECT *
FROM customers;

SELECT *
FROM orders;

SELECT *
FROM order_items;

SELECT *
FROM products;

SELECT
  product_name AS "p_name",
  list_price   AS "price"
FROM products;

SELECT
  lower(product_name) AS "Product name in lower",
  upper(product_name) AS "Product name in upper"
FROM products ORDER BY "Product name in lower";

SELECT
  2 + 3      AS sum,
  2 + 3 * 10 AS sum_and_product;


SELECT DISTINCT *
FROM products;


SELECT *
FROM public.products;

SELECT DISTINCT ON (brand_id)
  product_name,
  list_price
FROM products;


SELECT *
FROM products
WHERE list_price > 2000;


SELECT *
FROM products
WHERE model_year > 2017 OR
      (
        list_price > 2000 AND list_price < 5000
      );


SELECT *
FROM products
WHERE model_year > 2017 AND
      (
        list_price > 2000 AND list_price < 5000
      );

SELECT brand_id
FROM products
GROUP BY brand_id;


SELECT
  brand_id,
  sum(list_price),
  max(list_price),
  min(list_price),
  avg(list_price),
  count(*)
FROM products
GROUP BY brand_id;

SELECT
  brand_id,
  category_id,
  sum(list_price),
  max(list_price),
  min(list_price),
  avg(list_price),
  count(*)
FROM products
GROUP BY (brand_id, category_id);


SELECT *
FROM products;


SELECT
  brand_id,
  sum(list_price),
  max(list_price),
  min(list_price),
  avg(list_price),
  count(*)
FROM products
WHERE model_year >= 2017
GROUP BY brand_id
HAVING count(category_id) > 3;

SELECT *
FROM products
WHERE model_year >= 2018
UNION DISTINCT
SELECT *
FROM products
WHERE list_price >= 2000;

SELECT *
FROM products
WHERE model_year >= 2018
INTERSECT
SELECT *
FROM products
WHERE list_price >= 2000;

SELECT *
FROM products
INTERSECT
SELECT *
FROM products;


SELECT *
FROM products
WHERE model_year >= 2018
EXCEPT
SELECT *
FROM products
WHERE list_price >= 2000;


-- INSERT INTO products_tmp
--   SELECT *
--   FROM products
--   WHERE model_year >= 2018
--   EXCEPT
--   SELECT *
--   FROM products
--   WHERE list_price >= 2000;
