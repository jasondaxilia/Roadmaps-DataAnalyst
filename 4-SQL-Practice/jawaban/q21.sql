WITH unik AS (
  SELECT DISTINCT
    p.category AS category,
    o.order_id AS order_id,
    o.status AS status
  FROM
    order_items AS oi
    JOIN orders AS o ON o.order_id = oi.order_id
    JOIN products AS p ON oi.product_id = p.product_id
) SELECT
  category,
  sum(CASE WHEN status = 'returned' THEN 1 ELSE 0 END) AS total_returned,
  count(*) AS total_order,
  round((100.00 * sum(CASE WHEN status = 'returned' THEN 1 ELSE 0 END) / count(*)),2) AS return_rate
FROM
  unik
GROUP BY category
ORDER BY return_rate DESC