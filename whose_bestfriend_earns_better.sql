/*
People whose best friends got better salaries: MySQL
*/
-- Students
-- _____________
-- | id | name |
-- _____________
-- |  1 |    A |
-- |  2 |    B |
-- |  3 |    C |
-- |  4 |    D |
-- _____________
-- Friends
-- __________________
-- | id | friend_id |
-- __________________
-- |  1 |         4 |
-- |  2 |         3 |
-- |  3 |         2 |
-- |  4 |         1 |
-- __________________
-- Packages
-- _______________
-- | id | salary |
-- _______________
-- |  1 |     10 |
-- |  2 |     20 |
-- |  3 |     30 |
-- |  4 |     40 |
-- _______________
with cte (id, frnd_id, sal, frnd_sal) as (
    select Friends.ID as id, Friends.Friend_ID as frnd_id, Packages_ID.Salary as sal, Packages_Friend_ID.Salary as frnd_sal
    from Friends
    inner join Packages as Packages_ID
        on Packages_ID.ID = Friends.ID
    inner join Packages as Packages_Friend_ID
        on Packages_Friend_ID.ID = Friends.Friend_ID
)
select Students.Name
from Students
inner join cte
    on cte.id = Students.ID
    and cte.frnd_sal - cte.sal > 0
order by cte.frnd_sal asc;
