
with jumlah as (
  select c.customer_id,c.name, SUM(oi.quantity * oi.unit_price) as total_belanja from orders as o
  join customers as c on o.customer_id = c.customer_id   
  join order_items as oi on o.order_id = oi.order_id  
  where o.status = 'completed'
  group by c.customer_id
), dengan_kuartil as (
  select *, NTILE(4) over (order by total_belanja desc) as kuartil from jumlah
)

select kuartil, count(*) as jumlah_customer, ROUND(avg(total_belanja),.2) from dengan_kuartil GROUP BY kuartil