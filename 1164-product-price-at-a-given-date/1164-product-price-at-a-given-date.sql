SELECT p.product_id,
       COALESCE((
         SELECT pr.new_price
         FROM Products pr
         WHERE pr.product_id = p.product_id
           AND pr.change_date <= DATE('2019-08-16')
         ORDER BY pr.change_date DESC
         LIMIT 1
       ), 10) AS price
FROM (SELECT DISTINCT product_id FROM Products) AS p;