with p as (
    select 
        patient_id,
        test_date,
        result,
        row_number() over (partition by patient_id order by test_date) as rn
    from covid_tests
    where result = 'Positive'
),
n as (
    select 
        c.patient_id,
        c.test_date,
        c.result,
        row_number() over (partition by patient_id order by test_date) as rn
    from covid_tests c
    join p 
        on p.patient_id = c.patient_id
        and p.rn = 1
    where c.result = 'Negative'
        and c.test_date > p.test_date
)

select p.patient_id, pa.patient_name, pa.age, datediff(n.test_date, p.test_date) as recovery_time
from p
join n on 
    p.patient_id = n.patient_id
    and p.rn = 1 
    and n.rn = 1
join patients pa on p.patient_id = pa.patient_id  
where datediff(n.test_date, p.test_date) > 0
order by recovery_time asc, patient_name asc
