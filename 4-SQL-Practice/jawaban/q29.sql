WITH list AS (
  SELECT
    oi.order_id AS orderId,
    oi.product_id AS produk_a,
    o.product_id AS produk_b
  FROM
    order_items AS o
    INNER JOIN order_items AS oi ON oi.order_id = o.order_id
    JOIN products AS p ON o.product_id = p.product_id
  WHERE
    oi.product_id < o.product_id
  ORDER BY
    produk_a ASC
) SELECT
-- produk_a as id_produk_a,
pa.name as nama_produk_a,
-- produk_b as id_produk_b,
pb.name as nama_produk_b,
count(*) as berapa_kali
FROM
  list
join 
  products as pa on pa.product_id = list.produk_a
JOIN
  products as pb on pb.product_id = list.produk_b
  GROUP BY produk_a, produk_b
  order by berapa_kali desc
  limit 10