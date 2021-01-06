SELECT * FROM products;

SELECT format('ID: %s, name: %s', product_id, product_name) AS name
FROM products;

SELECT format('INSERT INTO %I VALUES(%L)', 'products', E'test');

SELECT * FROM products
WHERE product_name LIKE 'Trek 820 - 2016';

SELECT * FROM products
WHERE product_name LIKE 'Tr%';

SELECT * FROM products
WHERE product_name LIKE 'Tr%';

SELECT * FROM products
WHERE product_name LIKE '_r%';

SELECT * FROM products
WHERE product_name LIKE '%T%';

SELECT * FROM products
WHERE product_name LIKE 'Trek_R%16';

SELECT product_name,
    char_length(product_name),
    CASE
        WHEN char_length(product_name) < 16
            THEN 'short size'
        WHEN char_length(product_name) BETWEEN 16 AND 30
            THEN 'medium size'
        ELSE 'long size'
    END
FROM products;

SELECT product_name,
    char_length(product_name),
    CASE char_length(product_name)
    WHEN 15 THEN 'short size'
    ELSE 'long size'
    END AS "Product name size"
FROM products;

SELECT customer_id, coalesce(phone, 'NOT SET')
FROM customers;

SELECT nullif(1, 1);
SELECT nullif(1, 4);

SELECT greatest(1, 2, 3, 4), least(1, 2, 3, 4);

SELECT ARRAY [1, 2, 4] <> ARRAY [1, 2, 3, 4];

SELECT ARRAY [1, 2, 3, 4] @> ARRAY [1, 2, 3, 4];

SELECT ARRAY [1, 3, 4] || ARRAY [ 5, 6, 2];

SELECT numrange(2, 3) = numrange(2, 3);

SELECT numrange(2, 3) < numrange(3, 4);

SELECT numrange(2, 3) @> numrange(1, 4);

SELECT
    count(*),
    min(list_price),
    max(list_price),
    avg(list_price),
    to_char(avg(list_price), '999.999')
FROM products
WHERE brand_id = 1;

SELECT *
FROM products
WHERE exists (
    SELECT *
    FROM products
    WHERE list_price > 2000
);

SELECT *
FROM products
WHERE product_id IN (
    SELECT product_id
    FROM products
    WHERE list_price > 1000
);

SELECT *
FROM products
WHERE product_id NOT IN (
    SELECT product_id
    FROM products
    WHERE list_price > 1000
);

SELECT *
FROM products
WHERE product_id = ANY (
    SELECT product_id
    FROM products
    WHERE list_price > 6000
);

SELECT *
FROM products
WHERE product_id < ALL (
    SELECT product_id
    FROM products
    WHERE list_price > 6000
);
