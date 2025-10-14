select product_id, year as first_year, quantity, price
from (
    select
        product_id,
        year,
        quantity,
        price,
        rank() over (partition by product_id order by year) as rn
    from Sales
) s
where rn = 1