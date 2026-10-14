WITH ringkasan AS (
  SELECT
    c.customer_id,
    c.name,
    count(DISTINCT o.order_id)        AS jumlah_order, -- distinct = anti double counting
    max(o.order_date)                 AS order_terakhir,
    sum(oi.quantity * oi.unit_price)  AS total_belanja
  FROM
    orders AS o
    JOIN customers AS c ON o.customer_id = c.customer_id
    JOIN order_items AS oi ON oi.order_id = o.order_id
  WHERE
    o.status = 'completed'
  group by o.customer_id
)


SELECT
  *
FROM
  ringkasan
WHERE
  jumlah_order >= 3 
  and 
  order_terakhir < '2025-06-03'
  