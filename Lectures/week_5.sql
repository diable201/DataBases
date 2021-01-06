SELECT *
FROM products
ORDER BY list_price;

SELECT *
FROM customers
ORDER BY phone NULLS LAST;

SELECT *
FROM products
WHERE model_year > 2017
  AND list_price < 3000
ORDER BY list_price DESC;

SELECT item_id,
       product_id,
       quantity,
       list_price,
       quantity * list_price AS "TOTAL"
FROM order_items
ORDER BY "TOTAL" DESC;

-- PAGINATION
SELECT *
FROM products
WHERE list_price > 2000
  AND list_price < 4000
LIMIT 3 OFFSET 3;

SELECT *
FROM products
ORDER BY list_price
    USING >;

SELECT *
FROM products
WHERE brand_id != 9;

SELECT *
FROM products
WHERE list_price BETWEEN 2000 AND 5000
ORDER BY list_price;

SELECT *
FROM products
WHERE brand_id IS NOT DISTINCT FROM 9;

SELECT *
FROM customers
WHERE phone IS NOT NULL;

SELECT abs(-10),
       ceil(2.4456),
       floor(2.4456),
       round(2.4456),
       round(2.543, 2),
       trunc(2.534),
       sqrt(9),
       trunc(random() * 100);

SELECT product_id || ': ' || product_name AS new_name
FROM products;

SELECT product_name, char_length(product_name) AS len
FROM products
ORDER BY len DESC;

SELECT product_name, overlay(product_name PLACING 'ASD' FROM 1 FOR 3)
FROM products;

SELECT product_name,
       trim(BOTH 'TR6' FROM product_name)
FROM products;
