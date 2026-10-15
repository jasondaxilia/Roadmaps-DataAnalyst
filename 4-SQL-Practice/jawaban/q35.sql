select * from customers as c where 
not exists (
  select * from orders as o
  where o.customer_id = c.customer_id and status = 'completed'
)
and 
exists(
  select * from orders as o
  where o.customer_id = c.customer_id
)