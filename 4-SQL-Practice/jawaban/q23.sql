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
),
lag AS (SELECT *,bulan,lag(revenue) OVER (ORDER BY bulan) AS revenue_bulan_lalu FROM revenue_per_bulan)


select bulan as Bulan, revenue as 'Revenue Per Bulan Ini', revenue_bulan_lalu as 'Revenue Bulan Kemarin',ROUND((revenue-revenue_bulan_lalu) * 100.00 / revenue_bulan_lalu,2) as 'Growth Percentage from Last Month' from lag 