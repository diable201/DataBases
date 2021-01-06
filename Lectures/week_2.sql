CREATE TABLE student(
--     id INT,
    id SERIAL,
    name VARCHAR(255),
    gpa NUMERIC
);

DROP TABLE student;

ALTER TABLE student
    ADD COLUMN phone VARCHAR(15);

ALTER TABLE student
    DROP COLUMN phone  RESTRICT ;
--     DROP COLUMN phone  CASCADE;

ALTER TABLE student
    ALTER COLUMN name TYPE VARCHAR(512);



-- INSERT INTO student(id, name, gpa)
--     VALUES (1, 'Student 1', 3.8);
--
-- INSERT INTO student(id, name, gpa)
--     VALUES (2, 'Student 2', 4.0);
--
-- INSERT INTO student VALUES (3, 'Student 3', 3.2);

INSERT INTO student
    VALUES (DEFAULT, 'Student 1', 3.8);

INSERT INTO student
    VALUES (DEFAULT, 'Student 2', 4.0);

INSERT INTO student VALUES (DEFAULT, 'Student 3', 3.2);

UPDATE student SET name='Student 11' WHERE id=1;

DELETE FROM student WHERE id=3;

-- SELECT * FROM student;
