WITH first_positive AS (
    SELECT
        patient_id,
        MIN(test_date) AS first_pos_date
    FROM covid_tests
    WHERE result = 'Positive'
    GROUP BY patient_id
),
first_negative_after AS (
    SELECT
        c.patient_id,
        MIN(c.test_date) AS first_neg_date
    FROM covid_tests c
    JOIN first_positive p
      ON c.patient_id = p.patient_id
     AND c.result = 'Negative'
     AND c.test_date > p.first_pos_date
    GROUP BY c.patient_id
)
SELECT
    p.patient_id,
    pt.patient_name,
    pt.age,
    DATEDIFF(n.first_neg_date, p.first_pos_date) AS recovery_time
FROM first_positive p
JOIN first_negative_after n
  ON p.patient_id = n.patient_id
JOIN patients pt
  ON pt.patient_id = p.patient_id
ORDER BY
    recovery_time ASC,
    patient_name ASC;