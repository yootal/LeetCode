select person_name
from (
    select 
        person_name, 
        sum(weight) over (order by turn) as cumulative
    from Queue
    order by cumulative desc
) a
where cumulative <= 1000
limit 1 
