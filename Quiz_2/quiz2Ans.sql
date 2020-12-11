CREATE OR REPLACE FUNCTION quiz21(in_order_id INTEGER)
    RETURNS TABLE
            (
                productname  TEXT,
                price        NUMERIC,
                unit         TEXT,
                quantity     INTEGER,
                suppliername TEXT
            )
AS
$$
BEGIN
    RETURN QUERY
        SELECT p.productname, p.price, p.unit, o2.quantity, s.suppliername
        FROM orders o
                 INNER JOIN orderdetails o2 ON o.orderid = o2.orderid
                 INNER JOIN products p ON o2.productid = p.productid
                 INNER JOIN suppliers s ON p.supplierid = s.supplierid
        WHERE o.orderid = in_order_id;
END;
$$ LANGUAGE plpgsql;

SELECT *
FROM quiz21(10258);

CREATE OR REPLACE VIEW quiz22 AS
SELECT count(o.orderId), extract(year FROM o.orderdate)
FROM orders o
GROUP BY extract(year FROM o.orderdate);

SELECT *
FROM quiz22;

SELECT sum(p.price * o2.quantity)
FROM orders o
         INNER JOIN orderdetails o2 ON o.orderid = o2.orderid
         INNER JOIN products p ON o2.productid = p.productid
         INNER JOIN customers c ON o.customerid = c.customerid
WHERE c.customername = 'Ernst Handel'
GROUP BY o.orderid
ORDER BY o.orderid
    DESC
LIMIT 1;


CREATE OR REPLACE FUNCTION quiz24(iNshipperName TEXT)
    RETURNS TABLE
            (
                orderid INTEGER,
                summa   NUMERIC,
                name    TEXT,
                address TEXT
            )
AS
$$
BEGIN
    RETURN QUERY
        SELECT o.orderid, sum(p.price * o2.quantity), c.customername, c.address
        FROM shippers s
                 INNER JOIN orders o ON s.shipperid = o.shipperid
                 INNER JOIN orderdetails o2 ON o.orderid = o2.orderid
                 INNER JOIN products p ON o2.productid = p.productid
                 INNER JOIN customers c ON o.customerid = c.customerid
        WHERE s.shippername = iNshipperName
        GROUP BY o.orderid, c.customername, c.address
        ORDER BY o.orderid DESC
        LIMIT 5;
END ;
$$ LANGUAGE plpgsql;

SELECT *
FROM quiz24('United Package');

CREATE ROLE quiz25;
GRANT ALL PRIVILEGES ON DATABASE quiz2 TO quiz25;
