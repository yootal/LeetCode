select player_id, event_date as first_login
from(
    select player_id, event_date,
        rank() over (partition by player_id order by event_date) as rn
    from Activity
) a
where rn = 1