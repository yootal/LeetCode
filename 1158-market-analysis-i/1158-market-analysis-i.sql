select u.user_id as buyer_id, u.join_date, ifnull(o.c,0) as orders_in_2019
from Users u
left join (
    select buyer_id, count(*) as c
    from Orders
    where year(order_date) = 2019
    group by buyer_id
) o on u.user_id = o.buyer_id

