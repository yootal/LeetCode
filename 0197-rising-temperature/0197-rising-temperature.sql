select b.id
from Weather a
join Weather b 
on datediff(b.recordDate, a.recordDate) = 1 
    and a.temperature < b.temperature 
