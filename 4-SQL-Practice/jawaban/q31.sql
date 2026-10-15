with customer_tanpa_kota as (
select count(*) as customer_tanpa_kota from customers where city is null
), order_anomali as (
select count(*) as jumlah_order_anomali from orders as o join customers as c on c.customer_id = o.customer_id
where o.order_date < c.signup_date
), order_after as (
select count(*) as 'order setelah 1 oktober 2025' from orders where order_date > '2025-10-01'
), item_mahal as (
select count(*) as 'lebih mahal dari produk' from order_items as oi join products as p on p.product_id = oi.product_id
where oi.unit_price > p.price
)

select * from customer_tanpa_kota,order_anomali,order_after, item_mahal