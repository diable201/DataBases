CREATE FUNCTION inc(cnt INTEGER)
    RETURNS INTEGER AS
$$
BEGIN
    RETURN cnt + 1;
END
$$ LANGUAGE PLPGSQL; -- 'plpgsql'

SELECT inc(10);

CREATE FUNCTION my_sum(a NUMERIC, b NUMERIC)
    RETURNS NUMERIC AS
$$
BEGIN
    RETURN a + b;
END
$$ LANGUAGE plpgsql;

SELECT my_sum(2.4, 10);

CREATE OR REPLACE FUNCTION my_max_min(a NUMERIC, b NUMERIC, c NUMERIC,
                                      OUT my_max NUMERIC, OUT my_min NUMERIC) AS
$$
BEGIN
    my_max := greatest(a, b, c);
    my_min := least(a, b, c);
END
$$ LANGUAGE plpgsql;

SELECT my_max_min(10, 4, 32);

SELECT *
FROM my_max_min(10, 4, 32);

CREATE FUNCTION square(INOUT a NUMERIC) AS
$$
BEGIN
    a := a * a;
END
$$ LANGUAGE plpgsql;

SELECT square(10);

CREATE OR REPLACE FUNCTION my_sumS(VARIADIC nums NUMERIC[], OUT total_sum NUMERIC)
AS
$$
BEGIN
    SELECT INTO total_sum sum(nums[i]) FROM generate_subscripts(nums, 1) i;
END
$$ LANGUAGE plpgsql;

SELECT i
FROM generate_subscripts(ARRAY [10, 22, 33], 1) i;

SELECT my_sumS(1, 1, 2, 3); -- 6

SELECT *
FROM orders;

SELECT o.order_id,
       o.order_status,
       o.order_date,
       c.first_name || ' ' || c.last_name AS full_name,
       oi.total_price
FROM orders AS o
         JOIN customers AS c ON o.customer_id = c.customer_id
         JOIN (
    SELECT order_id,
           sum(list_price * quantity * (1 - discount))
               AS total_price
    FROM order_items
    GROUP BY order_id
) AS oi ON oi.order_id = o.order_id
ORDER BY order_id;


CREATE OR REPLACE FUNCTION get_total_by_customer(
    user_id INTEGER
)
    RETURNS NUMERIC AS
$$
DECLARE
    total_orders_price NUMERIC;
BEGIN
    SELECT INTO total_orders_price sum(oi.total_price)
    FROM orders AS o
             JOIN (
        SELECT order_id,
               sum(list_price * quantity * (1 - discount))
                   AS total_price
        FROM order_items
        GROUP BY order_id
    ) AS oi ON oi.order_id = o.order_id
    WHERE customer_id = user_id;

    RETURN total_orders_price;
END;
$$ LANGUAGE plpgsql;

SELECT *
FROM orders;
-- 259 523 175

SELECT get_total_by_customer(523);


CREATE OR REPLACE FUNCTION get_total_by_customer(user_id INTEGER,
                                                 s_id INTEGER)
    RETURNS NUMERIC AS
$$
DECLARE
    total_orders_price NUMERIC;
BEGIN
    SELECT INTO total_orders_price sum(oi.total_price)
    FROM orders AS o
             JOIN (
        SELECT order_id,
               sum(list_price * quantity * (1 - discount))
                   AS total_price
        FROM order_items
        GROUP BY order_id
    ) AS oi ON oi.order_id = o.order_id
    WHERE customer_id = user_id
      AND store_id = s_id;

    RETURN total_orders_price;
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION get_total_by_customer(INTEGER);

SELECT get_total_by_customer(259, 1);


SELECT *
FROM products;

DROP FUNCTION get_products(VARCHAR);

CREATE OR REPLACE FUNCTION get_products(p_pattern VARCHAR)
    RETURNS TABLE
            (
                id    INTEGER,
                title VARCHAR,
                price NUMERIC
            )
AS
$$
BEGIN
    RETURN QUERY SELECT product_id,
                        product_name,
                        list_price
                 FROM products
                 WHERE product_name ILIKE p_pattern;
END;
$$
    LANGUAGE 'plpgsql';


SELECT *
FROM products;

SELECT *
FROM get_products('S%');


CREATE OR REPLACE FUNCTION show()
    RETURNS VOID AS
$$
<< block1 >>
    DECLARE
    cnt INTEGER := 0;
BEGIN
    cnt := cnt + 1;
    RAISE NOTICE 'block1 cnt value = %', cnt;

    DECLARE
        cnt INTEGER := 0;
    BEGIN
        cnt := cnt + 10;
        RAISE NOTICE 'cnt value in sub block = %', cnt;
        RAISE NOTICE 'cnt value in from block1 = %', block1.cnt;
    END;

END block1;
$$ LANGUAGE plpgsql;

SELECT show();
