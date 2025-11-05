select season, category, t2.q as total_quantity, t2.p as total_revenue
from (
    select season, category, sum(quantity) as q, sum(r) as p,
        rank() over (partition by season order by sum(quantity) desc, sum(r) desc) as rn
    from (
        select
            p.category, s.quantity, s.price * s.quantity as r,
            CASE
                WHEN MONTH(s.sale_date) IN (12,1,2) THEN 'Winter'
                WHEN MONTH(s.sale_date) IN (3,4,5) THEN 'Spring'
                WHEN MONTH(s.sale_date) IN (6,7,8) THEN 'Summer'
                ELSE 'Fall'
            END AS season
        from sales s
        join products p on s.product_id = p.product_id
    ) t1
    group by season, category
) t2
where rn = 1