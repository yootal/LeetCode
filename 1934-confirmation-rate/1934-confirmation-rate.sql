select s.user_id, ifnull(confirmation_rate, 0) as confirmation_rate
from Signups s
left join (
    select 
        user_id,
        round(sum(case when action = 'confirmed' then 1 else 0 end) / count(*), 2) as confirmation_rate
    from Confirmations
    group by user_id
) c on s.user_id = c.user_id

