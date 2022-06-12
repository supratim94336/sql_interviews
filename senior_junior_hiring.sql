-- structure of the table
-- id | position | salary
-- -----------------------
--   1|    junior|  10000
--   2|    junior|  10000
--   3|    junior|  10000
--   4|    senior|  20000
--   5|    senior|  20000

-- problem: hire as many senior developers first and then junior developers, where budget is 50000

-- create a table
DROP TABLE IF EXISTS candidates;
CREATE TABLE candidates (
  id       INTEGER PRIMARY KEY,
  position TEXT NOT NULL,
  salary   INTEGER NOT NULL
);

-- insert some values
INSERT INTO candidates VALUES (1, 'junior', 10000);
INSERT INTO candidates VALUES (2, 'junior', 10000);
INSERT INTO candidates VALUES (3, 'junior', 10000);
INSERT INTO candidates VALUES (4, 'senior', 20000);
INSERT INTO candidates VALUES (5, 'senior', 20000);

-- solution
WITH salary_run_total AS (
    SELECT
        c.*,
        sum(salary) OVER (PARTITION BY c.position ORDER BY c.salary, c.id) AS rolling_sum
    FROM candidates c
), senior_hiring AS (
SELECT
    'senior' AS experience,
    COUNT(*) AS accepted_candidates,
    CASE
        WHEN count(*) = 0 THEN 50000
        ELSE 50000 - MAX(srt.rolling_sum)
    END AS remaining_budget
FROM salary_run_total AS srt
WHERE srt.position = 'senior'
    AND srt.rolling_sum <= 50000
), junior_hiring AS (
SELECT
    'junior' AS experience,
    COUNT(*) AS accepted_candidates
FROM salary_run_total srt
WHERE srt.position = 'junior'
    AND srt.rolling_sum <= (
        SELECT
            remaining_budget
        FROM senior_hiring
    )
)
SELECT
    jh.accepted_candidates as juniors,
    sh.accepted_candidates as seniors
FROM junior_hiring jh
INNER JOIN senior_hiring sh
    ON TRUE
