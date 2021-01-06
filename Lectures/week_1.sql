CREATE TABLE student
(
    id   SERIAL,
    name CHAR(255),
    gpa  NUMERIC
);

DROP TABLE student;

ALTER TABLE student
    ADD COLUMN phone VARCHAR(15);

ALTER TABLE student
    DROP COLUMN phone RESTRICT;

ALTER TABLE student
    ALTER COLUMN name TYPE VARCHAR(500);



-- INSERT INTO student (id, name, gpa)
--     VALUES (1, 'Student 1', 3.8);
--
-- INSERT INTO student (id, name, gpa)
--     VALUES (2, 'Student 2', 4.0);
--
-- INSERT INTO student VALUES (3, 'Student 3', 3.5);


INSERT INTO student
VALUES (DEFAULT, 'Student 1', 3.8);

INSERT INTO student
VALUES (DEFAULT, 'Student 2', 4.0);

INSERT INTO student
VALUES (DEFAULT, 'Student 3', 3.5);

UPDATE student
SET name='Student 11'
WHERE id = 1;

DELETE
FROM student
WHERE id = 3;

INSERT INTO student
VALUES (DEFAULT, 'Student 4', 3.6);

SELECT *
FROM student;


-- DDL - Data definition language

--   CREATE
--   ALTER
--   DROP

-- DML - Data manipulation language

--   select 
--   insert
--   update
--   delete

-- DCL -  Data control language

--   grant
--   deny

-- TCL - Transaction control language

--   begin transaction
--   rollback transaction
--   commit transaction
--   save transaction

SELECT *
FROM student;

-- line comment

/*
  multi
  line
  comment
 */

CREATE TABLE category
(
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

INSERT INTO category DEFAULT
VALUES;

ALTER TABLE category
    ADD COLUMN last_update TIMESTAMP DEFAULT now();

INSERT INTO category (name, last_update)
VALUES ('category 3', now());

CREATE TABLE category_tmp
(
    LIKE category
);


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
SET name = 'new category'
FROM category AS c
WHERE c_tmp.id = c.id
  AND c.name = 'category 2'
RETURNING id, name;

UPDATE category_tmp AS c_tmp
SET name = 'new category 1'
WHERE id = (SELECT id
            FROM category
            WHERE id = 3)
RETURNING *;


DELETE
FROM category_tmp
WHERE name = 'category 3';

SELECT *
FROM category_tmp;

DELETE
FROM category_tmp AS c_tmp
    USING category AS c
WHERE c_tmp.name = c.name;

-- DELETE FROM account
-- USING attendance WHERE account.id=attendance.user_id
-- AND attendance.count >= 7;
