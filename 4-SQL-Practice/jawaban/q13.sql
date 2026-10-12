select p.name, oi.product_id, p.product_id from products as p
left join order_items as oi on oi.product_id = p.product_id
where oi.product_id is null