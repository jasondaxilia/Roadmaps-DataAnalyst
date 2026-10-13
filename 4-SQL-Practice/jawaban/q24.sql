WITH revenue_per_bulan AS (
  SELECT
    STRFTIME('%Y-%m', o.order_date) AS bulan,
    sum(oi.quantity * oi.unit_price) AS revenue
  FROM
    orders AS o
    JOIN order_items AS oi ON o.order_id = oi.order_id
  WHERE
    o.status = 'completed'
  GROUP BY
    bulan
) SELECT
  bulan AS Bulan,
  revenue AS 'Revenue Per Bulan Ini',
  sum(revenue) over (order by bulan) AS 'Total Revenue'
FROM
  revenue_per_bulan