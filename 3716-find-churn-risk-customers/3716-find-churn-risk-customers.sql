WITH last AS (
    SELECT 
        user_id,
        event_type,
        plan_name,
        monthly_amount
    FROM (
        SELECT
            user_id,
            event_type,
            plan_name,
            monthly_amount,
            ROW_NUMBER() OVER (
                PARTITION BY user_id
                ORDER BY event_date DESC, event_id DESC
            ) AS rn
        FROM subscription_events
    ) x
    WHERE rn = 1
)

SELECT
    t1.user_id,
    t2.plan_name AS current_plan,
    t2.monthly_amount AS current_monthly_amount,
    MAX(t1.monthly_amount) AS max_historical_amount,
    DATEDIFF(MAX(t1.event_date), MIN(t1.event_date)) AS days_as_subscriber
FROM (
    SELECT *
    FROM subscription_events
) t1
JOIN last t2
  ON t1.user_id = t2.user_id
GROUP BY
    t1.user_id, t2.plan_name, t2.monthly_amount, t2.event_type
HAVING
    t2.event_type != 'cancel'
    AND SUM(CASE WHEN t1.event_type = 'downgrade' THEN 1 END) > 0
    AND DATEDIFF(MAX(t1.event_date), MIN(t1.event_date)) >= 60
    AND t2.monthly_amount < 0.5 * MAX(t1.monthly_amount)
ORDER BY
    days_as_subscriber DESC,
    t1.user_id ASC;