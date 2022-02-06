with t1 as (
    select num,
           lag(num, 1) over(order by id) num1, 
           lag(num, 2) over(order by id) num2 
    from logs)
select distinct num ConsecutiveNums 
from t1 
where num = num1 and num = num2
