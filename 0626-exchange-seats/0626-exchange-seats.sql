select 
    a.id,
    case
        when a.id % 2 = 1 then
            case
                when b.id is null then a.student
                else b.student
            end
        when a.id % 2 = 0 then c.student
    end as student
from Seat a
left join Seat b on a.id = b.id - 1
left join Seat c on a.id = c.id + 1