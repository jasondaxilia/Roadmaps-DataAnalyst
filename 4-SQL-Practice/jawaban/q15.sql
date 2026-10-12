select p.product_id, p.name, p.price, count(p.price) as sering_diskon from products as p
join order_items as oi on oi.product_id = p.product_id
where oi.unit_price < p.price
group by p.name
order by sering_diskon desc