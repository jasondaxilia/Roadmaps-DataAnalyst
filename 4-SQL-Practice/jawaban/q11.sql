select c.name, c.city, SUM(oi.quantity * oi.unit_price) as total_belanja from orders as o
join customers as c on o.customer_id = c.customer_id   
join order_items as oi on o.order_id = oi.order_id  
where o.status = 'completed'
group by c.customer_id
order by SUM(oi.quantity * oi.unit_price) desc
limit 10