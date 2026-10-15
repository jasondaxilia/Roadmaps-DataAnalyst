with revenue_per_produk as (
  select p.name as nama_produk,p.category as kategori_produk, sum(oi.unit_price * oi.quantity) as rev from products as p join order_items as oi on oi.product_id = p.product_id join orders as o on o.order_id = oi.order_id
  where o.status = 'completed'
  GROUP BY p.product_id
)

select nama_produk,kategori_produk,ROUND(100.00 * rev/(sum(rev) over (PARTITION by kategori_produk)),2) as kontribusi_terhadap_revenue from revenue_per_produk
