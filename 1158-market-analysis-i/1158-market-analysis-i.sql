SELECT 
  u.user_id AS buyer_id,
  u.join_date,
  SUM(o.order_date >= '2019-01-01' AND o.order_date < '2020-01-01') AS orders_in_2019
FROM Users u
LEFT JOIN Orders o
  ON o.buyer_id = u.user_id
GROUP BY u.user_id, u.join_date;