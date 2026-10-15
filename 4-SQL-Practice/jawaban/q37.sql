WITH data_bulan AS (
  SELECT
    STRFTIME('%Y-%m', o.order_date) AS bulan,
    sum(oi.quantity * oi.unit_price) AS revenue_bulanan
  FROM
    order_items AS oi
    JOIN orders AS o ON o.order_id = oi.order_id
  WHERE
    o.status = 'completed'
  GROUP BY
    bulan
) SELECT
  bulan,
  revenue_bulanan,
  ROUND(avg(revenue_bulanan) OVER (order by bulan ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 3)
  AS moving_average_3_bulan
FROM
data_bulan
