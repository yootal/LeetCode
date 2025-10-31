with s as(
    select student_id, subject
    from Scores
    group by student_id, subject
    having count(*) >= 2
) 
select s.student_id, s.subject, s1.score as first_score, s2.score as latest_score
from s
join (
    select 
        student_id,
        subject,
        score,
        rank() over (partition by student_id, subject order by exam_date) as rn
    from Scores
) s1 on s1.rn = 1 and s.student_id = s1.student_id and s.subject = s1.subject
join (
    select 
        student_id,
        subject,
        score,
        rank() over (partition by student_id, subject order by exam_date desc) as rn
    from Scores
) s2 on s2.rn = 1 and s.student_id = s2.student_id and s.subject = s2.subject
where s1.score < s2.score