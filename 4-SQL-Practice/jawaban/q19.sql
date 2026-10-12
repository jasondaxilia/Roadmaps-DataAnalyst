with list_jumlah as (
  select orders.order_id, customers.customer_id, count(customers.customer_id) as order_berapa_kali from orders
  join customers on customers.customer_id = orders.customer_id
  where orders.status = 'completed'
  group by customers.customer_id
)

select 
  case when list_jumlah.order_berapa_kali == 1 then 'one-time' else 'repeat-buyer' end as customer,
  count(*) as list
  from list_jumlah
group by customer