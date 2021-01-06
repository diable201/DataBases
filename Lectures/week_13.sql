-- Week 13 PQSL Transactions
CREATE TABLE accounts
(
    id      SERIAL,
    name    VARCHAR(255),
    balance NUMERIC
);

INSERT INTO accounts (name, balance)
VALUES ('Alice', 10000);

SELECT *
FROM accounts;

BEGIN;
INSERT INTO accounts (name, balance)
VALUES ('Bob', 10000);
COMMIT;


BEGIN;
UPDATE accounts
SET balance = balance - 1000
WHERE id = 1;

UPDATE accounts
SET balance = balance + 1000
WHERE id = 2;

SELECT *
FROM accounts;
COMMIT;

INSERT INTO accounts (name, balance)
VALUES ('John', 0);

SELECT *
FROM accounts;

BEGIN;
UPDATE accounts
SET balance = balance - 1500
WHERE id = 1;

UPDATE accounts
SET balance = balance + 1500
WHERE id = 3;

ROLLBACK;

SELECT *
FROM accounts;

BEGIN;
UPDATE accounts
SET balance = balance - 1500
WHERE id = 1;

SAVEPOINT save_point_1;

UPDATE accounts
SET balance = balance + 1500
WHERE id = 3;

ROLLBACK TO save_point_1;

UPDATE accounts
SET balance = balance + 1500
WHERE id = 2;

COMMIT;
