with customer_behavior as (
  select *, min(orders.order_date) as min, max(orders.order_date) as max from orders
  where orders.status = 'completed'
  group by orders.customer_id
)

select *, (julianday(customer_behavior.max) - julianday(customer_behavior.min)) as selisih_hari from customer_behavior
order by selisih_hari desc