CREATE TABLE test (
    id INTEGER,
    content VARCHAR(255)
);

SELECT * FROM test;

SELECT content FROM test WHERE id = 1;
CREATE INDEX test_id_index ON test(id);
CREATE INDEX hash ON test USING hash(id);
DROP INDEX test_id_index;

ANALYSE;

SELECT * FROM pg_statistic;
SELECT * FROM pg_indexes;
CREATE UNIQUE INDEX t ON test(id DESC);

SELECT * FROM test WHERE lower(content) = 'content 1';

CREATE INDEX test_content_index ON test(lower(content));

DROP INDEX t, test_id_index;

SELECT generate_series(1, 10, 1);

TRUNCATE test;

INSERT INTO test(id, content)
SELECT i, 'content_' || i AS "content" FROM generate_series(1, 100) i;

SELECT * FROM test;

EXPLAIN ANALYZE SELECT * FROM test WHERE id = 436123;

CREATE INDEX test_id_index ON test(id);


ANALYZE;

EXPLAIN ANALYSE SELECT * FROM test WHERE id = 4;

EXPLAIN ANALYZE SELECT * FROM test WHERE lower(content) = 'content_30';

CREATE INDEX test_2 ON test(lower(content));
ANALYSE;

SELECT * FROM pg_indexes;
