-- postgres
-- problem: Indirect managers who do not earn more than or equals to double the salary of the employee
-- input should look like
-- ________________________________
-- | id | name | manager | salary |
-- ________________________________
-- |  1 |    A |       2 |     50 |
-- |  2 |    B |       3 |    150 |
-- |  3 |    C |       4 |    200 |
-- |  4 |    D |    null |    350 |
-- ________________________________

with recursive t1 as ( -- traverse employees all the way up in the manager chain
  select id, name, salary, manager, salary indsalary, manager indirect, 1 as level
  from emp 
  union all
  select t1.id, t1.name, t1.salary, e.manager, e.salary, t1.manager, t1.level + 1
  from emp e, t1 
  where t1.manager = e.id
), t2 as ( -- check salary condition more than equals to two
  select *
  from t1
  where  indsalary >= 2 * salary
), t3 as ( -- get the row numbers 
  select t2.*, row_number() over (partition by id order by level) rn  
  from t2
), t4 as ( -- retain only first row per emp
  select * from t3
  where rn = 1
)
-- add emps that has no manager or don't fullfill the salary condition (user inner join if you want it to satisfy)
select e.id, t4.indirect manager
from emp e
left join t4
  on (e.id = t4.id);
