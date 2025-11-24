select x, y, z,
    case
        when x > 0 && y > 0 && z > 0 && x + y > z && y + z > x && z + x > y then 'Yes'
        else 'No'
    end as triangle
from Triangle