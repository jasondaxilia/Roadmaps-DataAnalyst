with jumlah as (
  select c.customer_id,c.name, SUM(oi.quantity * oi.unit_price) as total_belanja from orders as o
  join customers as c on o.customer_id = c.customer_id   
  join order_items as oi on o.order_id = oi.order_id  
  where o.status = 'completed'
  group by c.customer_id
)

select jumlah.customer_id, jumlah.total_belanja from jumlah
where  jumlah.total_belanja > (
    select AVG(jumlah.total_belanja) from jumlah
  )
group by jumlah.customer_id