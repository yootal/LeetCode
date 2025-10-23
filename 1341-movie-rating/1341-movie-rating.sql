SELECT *
FROM (
    SELECT u.name AS results
    FROM MovieRating m
    JOIN Users u ON u.user_id = m.user_id
    GROUP BY u.user_id, u.name
    ORDER BY COUNT(*) DESC, u.name ASC
    LIMIT 1
) t1

UNION ALL

SELECT results
FROM (
    SELECT mo.title AS results
    FROM MovieRating mr
    JOIN Movies mo ON mo.movie_id = mr.movie_id
    WHERE mr.created_at >= '2020-02-01' AND mr.created_at < '2020-03-01'
    GROUP BY mo.movie_id, mo.title
    ORDER BY AVG(mr.rating) DESC, mo.title ASC
    LIMIT 1
) t2;