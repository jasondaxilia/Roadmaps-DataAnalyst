WITH revenue_completed AS (
  SELECT
    sum(oi.unit_price * oi.quantity) AS revenue_total
  FROM
    order_items AS oi
    JOIN orders AS o ON o.order_id = oi.order_id
  WHERE
    o.status = 'completed'
),
revenue_per_kategori AS (
  SELECT
    sum(oi.unit_price * oi.quantity) as total_masing_kategori
  FROM
    order_items AS oi
    JOIN products AS p ON p.product_id = oi.product_id
    join orders as o on o.order_id = oi.order_id
  where o.status = 'completed'
  GROUP BY
    p.category
) 

 SELECT
   sum(total_masing_kategori) AS total_rev_kategori,
   revenue_total as total_rev,
   CASE
     WHEN sum(rpk.total_masing_kategori) != rc.revenue_total THEN 'MISMATCH' ELSE 'OK'
   END
   as result
 FROM
   revenue_per_kategori as rpk,
   revenue_completed as rc