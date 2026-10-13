WITH list_customer AS (SELECT *, lag(order_date) OVER (PARTITION BY customer_id ORDER BY order_date, order_id) AS order_date_sebelumnya FROM orders) SELECT
  *,
  JULIANDAY(order_date) - JULIANDAY(order_date_sebelumnya) AS selisih_hari
FROM
  list_customer
  
ORDER BY customer_id ASC