WITH ringkasan AS (
  SELECT
    c.customer_id,
    c.name,
    count(DISTINCT o.order_id) AS jumlah_order, -- distinct = anti double counting
    max(o.order_date) AS order_terakhir,
    sum(oi.quantity * oi.unit_price) AS total_belanja
  FROM
    orders AS o
    JOIN customers AS c ON o.customer_id = c.customer_id
    JOIN order_items AS oi ON oi.order_id = o.order_id
  WHERE
    o.status = 'completed'
  GROUP BY
    o.customer_id
),
dengan_kuartil AS (
  SELECT
    *,
    NTILE(4) OVER (ORDER BY total_belanja ASC) AS m,
    NTILE(4) OVER (ORDER BY jumlah_order ASC) AS f,
    NTILE(4) OVER (  ORDER BY JULIANDAY('2025-10-01') - JULIANDAY(order_terakhir) DESC) AS r
  FROM
    ringkasan
), hasil as (
SELECT
   customer_id,
   name,
   total_belanja,
   jumlah_order,
   order_terakhir,
   r,
   f,
   m,
   CASE
     WHEN r >= 3 and f >= 3 then 'Champions'
      WHEN r <= 2 and f >= 3 then 'At Risk'
      WHEN r = 1 then 'Lost'
      ELSE 'Others'
   END
   as RFM
       FROM
         dengan_kuartil
)

select RFM, count(*) as jumlah_customer
  from hasil
  group by RFM
  order by jumlah_customer desc