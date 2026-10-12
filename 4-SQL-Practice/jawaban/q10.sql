select strftime('%m',o.order_date) AS month_year, SUM(oi.quantity * oi.unit_price) from order_items as oi
join orders as o on o.order_id = oi.order_id
where strftime('%Y', o.order_date ) = '2025' and o.status == 'completed'
group by month_year