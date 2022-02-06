CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      select coalesce(
          (select salary
          from (
            select distinct salary, dense_rank() over(order by salary desc) as r from Employee
          ) t
          where r=N), NULL
      )
  );
END
