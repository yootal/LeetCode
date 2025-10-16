select b.product_id, ifnull(a.new_price,10) as price
from(
    select 
        product_id,
        new_price,
        rank() over (partition by product_id order by change_date desc) as rk
    from Products
    where change_date <= '2019-08-16'
) a
right join (select distinct product_id from Products) b 
on a.product_id = b.product_id and a.rk = 1