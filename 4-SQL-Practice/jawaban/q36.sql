select * from (
select p.category as category,sum(oi.unit_price * oi.quantity) as revenue_per_kategori from order_items as oi join products as p on p.product_id = oi.product_id join orders as o on o.order_id = oi.order_id where o.status = 'completed' GROUP BY p.category
union ALL
select 'Total', sum(oi.unit_price * oi.quantity) as total from order_items as oi join orders as o on oi.order_id = o.order_id where o.status = 'completed'
)order by 
  case when category = 'Total' then 1 else 0 end,
  revenue_per_kategori desc