select p.category, SUM(oi.quantity * oi.unit_price) as revenue
from products as p
join order_items as oi on oi.product_id = p.product_id
join orders as o on oi.order_id = o.order_id
where o.status = 'completed'
group by p.category
order by revenue desc