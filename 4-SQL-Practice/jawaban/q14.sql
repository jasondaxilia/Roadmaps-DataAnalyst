select distinct c.name, o.customer_id, c.customer_id from customers as c
left join orders as o on o.customer_id = c.customer_id
where o.customer_id is null