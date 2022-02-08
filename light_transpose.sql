/* Write your T-SQL query statement below */

-- Input: 
-- Student table:
-- +--------+-----------+
-- | name   | continent |
-- +--------+-----------+
-- | Jane   | America   |
-- | Pascal | Europe    |
-- | Xi     | Asia      |
-- | Jack   | America   |
-- +--------+-----------+
-- Output: 
-- +---------+------+--------+
-- | America | Asia | Europe |
-- +---------+------+--------+
-- | Jack    | Xi   | Pascal |
-- | Jane    | null | null   |
-- +---------+------+--------+

select
    max(case when continent='America' then name end) America,
    max(case when continent='Asia' then name end) Asia,
    max(case when continent='Europe' then name end) Europe
from
(
    select *, row_number() over(partition by continent order by name) rn
    from student
) a
group by rn
