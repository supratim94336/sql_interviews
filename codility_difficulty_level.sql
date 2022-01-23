-- Postgres 9.4
-- Question: Calculate difficulty level of a task
-- avg score of a task <= 20 then hard
-- avg score of a task > 20 and <= 60 then medium
-- avg score of a task anything else then easy
-- tasks
--    id | name
-- -----+-------------
--  101 | MinDist
--  123 | Equi
--  142 | Median
--  300 | Tricoloring

-- candidates performance
--   id | task_id  | candidate         | score
--  ----+----------+-------------------+--------
--   13 | 101      | John Smith        | 100
--   24 | 123      | Delaney Lloyd     | 34
--   37 | 300      | Monroe Jimenez    | 50
--   49 | 101      | Stanley Price     | 45
--   51 | 142      | Tanner Sears      | 37
--   68 | 142      | Lara Fraser       | 3
--   83 | 300      | Tanner Sears      | 0
   
--  results
--  task_id | task_name    | difficulty
-- ---------+--------------+------------
--      101 | MinDist      | Easy
--      123 | Equi         | Medium
--      142 | Median       | Hard
--      300 | Tricoloring  | Medium

SELECT
    t.id,
    t.name, 
    (CASE
        WHEN AVG(rp.score) <= 20 THEN 'Hard'
        WHEN AVG(rp.score) > 20 AND AVG(rp.score) <= 60 THEN 'Medium' 
        ELSE 'Easy'
    END) AS difficulty
FROM tasks t
JOIN reports rp
    ON t.id = rp.task_id
GROUP BY t.id, t.name
ORDER BY t.id, t.name;
