WITH data_revenue AS (
  SELECT
    p.category AS kategori,
    p.name AS nama_produk,
    sum(oi.unit_price * oi.quantity) AS revenue
  FROM
    products AS p
    JOIN order_items AS oi ON p.product_id = oi.product_id
    JOIN orders AS o ON o.order_id = oi.order_id
  WHERE
    o.status = 'completed'
  GROUP BY
    p.product_id
  ORDER BY
    Revenue DESC
),
ranking_produk AS (
  SELECT 
    *, 
    rank() OVER (PARTITION BY kategori ORDER BY revenue DESC) AS ranking
  FROM data_revenue
)
select * from ranking_produk where ranking <=2