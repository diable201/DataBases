SELECT * FROM student;

-- line comment

/*
    multiline
    comment
 */

CREATE TABLE category (
    id SERIAL,
    name VARCHAR(255)
);

SELECT * FROM category;

INSERT INTO category(name)
    VALUES ('category 1');

INSERT INTO category AS c
    VALUES (DEFAULT, 'category 2');

ALTER TABLE category
    ALTER COLUMN id SET DEFAULT 0;

ALTER TABLE category
    ALTER COLUMN name SET DEFAULT 'default';

INSERT INTO category DEFAULT VALUES;

ALTER TABLE category
    ADD COLUMN last_update TIMESTAMP DEFAULT now();

INSERT INTO category (name, last_update)
    VALUES ('category 3', now());

CREATE TABLE category_tmp (LIKE category);

INSERT INTO category_tmp
    SELECT * FROM category WHERE id > 0;

-- INSERT INTO category_tmp (name)
--     SELECT name FROM category WHERE id > 0;

SELECT * FROM category_tmp;

UPDATE category_tmp
SET name = 'category 1 updated'
WHERE id = 1;

UPDATE category_tmp
SET (name, last_update) = ('category 12', now())
WHERE id = 2;

-- UPDATE category_tmp
-- SET name = 'category 12', last_update = now()
-- WHERE id = 2;

UPDATE category_tmp
SET name = 'new category' FROM category
WHERE category_tmp.id = category.id AND category.name = 'category 2'
RETURNING id, name;

-- UPDATE category_tmp AS c_tmp
-- SET name = 'new category' FROM category AS c
-- WHERE c_tmp.id = c.id AND c.name = 'category 2';

INSERT INTO category_tmp VALUES (3, 'category 3', now());

UPDATE category_tmp AS c_tmp
    SET name = 'new category 1'
    WHERE id = (SELECT id FROM category WHERE id = 3)
    RETURNING *;

DELETE FROM category_tmp
WHERE name = 'category 3';

SELECT * FROM category_tmp;

DELETE FROM category_tmp AS c_tmp
USING category AS c WHERE c_tmp.name = c.name;
