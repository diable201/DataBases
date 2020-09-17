SELECT *
FROM student;

-- line comment

/*
  multi
  line
  comment
 */

CREATE TABLE category (
  id   SERIAL,
  name VARCHAR(255)
);

SELECT *
FROM category;

INSERT INTO category AS c
VALUES (DEFAULT, 'category 2');

ALTER TABLE category
  ALTER COLUMN id SET DEFAULT 0;

ALTER TABLE category
  ALTER COLUMN name SET DEFAULT 'default category';

INSERT INTO category DEFAULT VALUES;

ALTER TABLE category
  ADD COLUMN last_update TIMESTAMP DEFAULT now();

INSERT INTO category (name, last_update)
VALUES ('category 3', now());

CREATE TABLE category_tmp (LIKE category);


INSERT INTO category_tmp
  SELECT *
  FROM category
  WHERE id > 0;

SELECT *
FROM category_tmp;


UPDATE category_tmp
SET name = 'category 1 updated'
WHERE id = 1;

UPDATE category_tmp
SET (name, last_update) = ('category 2', now())
WHERE id = 2;

-- UPDATE category_tmp
-- SET name = 'category 22', last_update = now()
-- WHERE id = 2;

UPDATE category_tmp AS c_tmp
SET name = 'new category' FROM category AS c
WHERE c_tmp.id = c.id AND
      c.name = 'category 2'
RETURNING id, name;

UPDATE category_tmp AS c_tmp
SET name = 'new category 1'
WHERE id = (SELECT id
            FROM category
            WHERE id = 3)
RETURNING *;


DELETE FROM category_tmp
WHERE name = 'category 3';

SELECT *
FROM category_tmp;

DELETE FROM category_tmp AS c_tmp
USING category AS c
WHERE c_tmp.name = c.name;

-- DELETE FROM account
-- USING attendance WHERE account.id=attendance.user_id
-- AND attendance.count >= 7;



