select t1.id, t1.num, SUM(t2.num) as sum
from table t1
inner join table t2 on t1.id >= t2.id
group by t1.id, t1.num
order by t1.id
