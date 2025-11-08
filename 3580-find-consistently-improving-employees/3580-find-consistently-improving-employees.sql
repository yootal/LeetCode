with temp as (
    select
        *,
        row_number() over (partition by employee_id order by review_date desc) as rn
    from performance_reviews
)

select a.employee_id, b.name, 
    max(case when rn = 1 then rating end) - max(case when rn = 3 then rating end) as improvement_score
from temp a
join employees b on a.employee_id = b.employee_id
group by employee_id
having count(*) >= 3
    and max(case when rn = 1 then rating end) > max(case when rn = 2 then rating end)
    and max(case when rn = 2 then rating end) > max(case when rn = 3 then rating end)
order by improvement_score desc, b.name