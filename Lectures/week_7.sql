CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name TEXT,
--     They do the same thing
--     name TEXT NOT NULL,
--     name TEXT CONSTRAINT asd CHECK (name IS NOT NULL),
    price NUMERIC DEFAULT 0.0 CHECK (price > 0)
);

INSERT INTO products (name, price) VALUES ('p1', 100);

SELECT * FROM products;

SELECT * FROM products_id_seq;

ALTER TABLE products
ADD CONSTRAINT name_len CHECK (char_length(name) >= 2);

INSERT INTO products (name, price) VALUES ('p 2', 90)
RETURNING *;

SELECT * FROM products;

INSERT INTO products(name, price)
VALUES ('p3', 120), ('p4', 105)
RETURNING *;

ALTER TABLE products DROP CONSTRAINT name_len;

ALTER TABLE products
ADD COLUMN discounted_price NUMERIC
CONSTRAINT positive_discount_price
CHECK (discounted_price > 0);

SELECT * FROM products;

ALTER TABLE products
ADD CONSTRAINT price_greater
CHECK (price > discounted_price);

INSERT INTO products(name, price, discounted_price)
VALUES ('p4', 120, 100)
RETURNING *;

ALTER TABLE products
ADD COLUMN is_in_stock BOOLEAN
DEFAULT TRUE;

ALTER TABLE products
ALTER COLUMN name SET NOT NULL;

INSERT INTO products(name, price) VALUES  ('p6', 100);

SELECT * FROM products;

ALTER TABLE products
ADD CONSTRAINT price_not_null
CHECK (price IS NOT NULL);

-- Same version
-- ALTER TABLE products
-- ALTER COLUMN price
-- SET NOT NULL

ALTER TABLE products
ADD COLUMN test INTEGER UNIQUE;

SELECT * FROM products;

INSERT INTO products(name, price, test)
VALUES ('p7', 130, 1)
RETURNING *;

ALTER TABLE products
DROP COLUMN test;

SELECT * FROM products;

CREATE TABLE orders(
    id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES products,
    quantity INTEGER
);

SELECT * FROM orders;

INSERT INTO orders(product_id, quantity)
VALUES (2, 5), (5, 3), (9, 4);

INSERT INTO orders (product_id, quantity)
VALUES (15, 3);

SELECT * FROM orders;

CREATE TABLE tags (
  id   SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE product_tag (
  product_id INTEGER REFERENCES products,
  tag_id     INTEGER REFERENCES tags
);

DROP TABLE orders;

CREATE TABLE orders (
  id      SERIAL PRIMARY KEY,
  address TEXT NOT NULL
);

CREATE TABLE order_items (
  product_id INTEGER REFERENCES products ON DELETE RESTRICT,
  order_id   INTEGER REFERENCES orders ON DELETE CASCADE,
--   order_id   INTEGER REFERENCES orders ON DELETE SET DEFAULT DEFAULT 1,
--   order_id   INTEGER REFERENCES orders ON DELETE SET NULL NULL,
  quantity   INTEGER,
  PRIMARY KEY (product_id, order_id)
);

SELECT *
FROM products;

SELECT *
FROM orders;

INSERT INTO orders (address)
VALUES ('Tole bi 59'), ('Abaya 109');

INSERT INTO order_items (product_id, order_id, quantity)
VALUES
  (2, 1, 4),
  (5, 1, 3),
  (9, 1, 2),
  (5, 2, 6);

SELECT *
FROM products;

SELECT *
FROM orders;

SELECT *
FROM order_items;

DELETE FROM products
WHERE id = 9;

DELETE FROM orders
WHERE id = 1;

SELECT *
FROM orders;

INSERT INTO order_items (product_id, order_id, quantity)
VALUES
  (2, 2, 4),
  (9, 2, 2);

SELECT *
FROM order_items;
