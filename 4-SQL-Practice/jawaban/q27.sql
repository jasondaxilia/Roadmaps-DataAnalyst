WITH aktivitas AS (SELECT DISTINCT o.customer_id, strftime('%Y-%m', o.order_date) AS bulan_pembelian FROM orders AS o WHERE o.status = 'completed'),
cohort AS (SELECT a.customer_id, min(bulan_pembelian) AS bulan_pembelian_pertama FROM aktivitas AS a GROUP BY a.customer_id),
gabung AS (
  SELECT DISTINCT
    a.customer_id,
    c.bulan_pembelian_pertama,
    a.bulan_pembelian,
    (
      CAST (substr(bulan_pembelian, 1, 7) AS integer) - CAST (substr(bulan_pembelian_pertama, 1, 7) as integer)
    ) * 12 + 
    (
      CAST ((substr(bulan_pembelian, 6, 2)) AS integer) - CAST (substr(bulan_pembelian_pertama, 6, 2) AS integer)
    ) AS bulan_selisih
  FROM
    aktivitas AS a
    JOIN cohort AS c ON c.customer_id = a.customer_id
)
SELECT
  bulan_pembelian_pertama as cohort,
  count(distinct case when bulan_selisih = 0 then customer_id end) AS ukuran,
  round(100.0 * count(distinct case when bulan_selisih = 1 then customer_id end) / count(distinct case when bulan_selisih = 0 then customer_id end), 1) AS bulan_1,
  round(100.0 * count(distinct case when bulan_selisih = 2 then customer_id end) / count(distinct case when bulan_selisih = 0 then customer_id end), 1) AS bulan_2,
  round(100.0 * count(distinct case when bulan_selisih = 3 then customer_id end) / count(distinct case when bulan_selisih = 0 then customer_id end), 1) AS bulan_3
FROM
  gabung
group by bulan_pembelian_pertama
order by cohort