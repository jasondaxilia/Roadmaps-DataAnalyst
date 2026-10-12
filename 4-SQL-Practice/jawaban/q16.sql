select ifnull(c.city,'Unknown'), (SUM(oi.quantity*oi.unit_price)/count(distinct o.order_id)) as aov from customers as c
join orders as o on o.customer_id = c.customer_id
join order_items as oi on oi.order_id = o.order_id
where o.status = 'completed'
group by c.city
order by aov desc