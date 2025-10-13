select customer_id
from (
    select distinct * 
    from Customer
    group by customer_id, product_key
) a
group by a.customer_id
having count(*) = (select count(*) from Product)
