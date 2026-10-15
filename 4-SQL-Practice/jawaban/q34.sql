-- select customer_id from orders as o join order_items as oi on oi.order_id = o.order_id join products as p on p.product_id = oi.product_id where o.status = 'completed' AND p.category = 'Fashion'
-- INTERSECT
-- select customer_id from orders as o join order_items as oi on oi.order_id = o.order_id join products as p on p.product_id = oi.product_id where o.status = 'completed' AND p.category = 'Elektronik'

select customer_id from customers as c where 
EXISTS(
  select customer_id from orders as o join order_items as oi on oi.order_id = o.order_id join products as p on p.product_id = oi.product_id where p.category = 'Elektronik' and o.status = 'completed' and c.customer_id = o.customer_id
)
and
EXISTS(
  select customer_id from orders as o join order_items as oi on oi.order_id = o.order_id join products as p on p.product_id = oi.product_id where p.category = 'Fashion' and o.status = 'completed' and c.customer_id = o.customer_id
)