-- Input

-- user_id | product_id | transaction_date
-- 1 | 101 | 2/12/20
-- 2 | 105 | 2/13/20
-- 1 | 111 | 2/14/20
-- 3 | 121 | 2/15/20
-- 1 | 101 | 2/16/20
-- 2 | 105 | 2/17/20
-- 4 | 101 | 2/16/20
-- 3 | 105 | 2/15/20

-- Output
-- user_id | superuser_date
-- 1 | 2/14/20
-- 2 | 2/13/20
-- 3 | 2/15/20
-- 4 | NULL


WITH 
  users (user_id, product_id, transaction_date) AS (
    VALUES 
      (1, 101, CAST('2-12-20' AS date)), 
      (2, 105, CAST('2-13-20' AS date)), 
      (1, 111, CAST('2-14-20' AS date)), 
      (3, 121, CAST('2-15-20' AS date)), 
      (1, 101, CAST('2-16-20' AS date)), 
      (2, 105, CAST('2-17-20' AS date)),
      (4, 101, CAST('2-16-20' AS date)), 
      (3, 105, CAST('2-15-20' AS date))
  ),
  t1 AS (
    SELECT 
       *, 
       ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date) AS transaction_number
    FROM users
  ),
  t2 AS (
    SELECT 
       user_id, 
       transaction_date
    FROM t1
    WHERE transaction_number = 2 
  ), 
  t3 AS (
    SELECT DISTINCT user_id
    FROM users 
  )
SELECT 
   t3.user_id, 
   transaction_date AS superuser_date
FROM t3
LEFT JOIN t2
ON t3.user_id = t2.user_id
ORDER BY 2
