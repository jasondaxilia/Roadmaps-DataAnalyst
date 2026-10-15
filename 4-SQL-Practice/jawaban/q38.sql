WITH data AS (
  SELECT
    c.customer_id as customer_id,
    c.name as customer_name,
    p.name as product_name,
    DENSE_RANK() over (PARTITION by o.customer_id order by order_date, o.order_id) as urutan
  FROM
    orders AS o
    JOIN customers AS c ON c.customer_id = o.customer_id
    JOIN order_items AS oi ON oi.order_id = o.order_id
    JOIN products AS p ON p.product_id = oi.product_id
    where o.status = 'completed'
) SELECT
  *
FROM
  data
where urutan = 1