SELECT
  status,
  count(status) AS jumlah_per_status,
  round(count(*) * 100.00 / (select count(*) from orders),2) as persen
FROM
  orders
GROUP BY
  status