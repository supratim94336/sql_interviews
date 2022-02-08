SELECT
    id,
    company, 
    salary
FROM (
    SELECT
        id,
        company, 
        salary,
        ROW_NUMBER() OVER (PARTITION BY salary, company ORDER BY salary, company) as rn
    FROM (
        SELECT
            id,
            company, 
            salary, 
            ROW_NUMBER() OVER (PARTITION BY company ORDER BY salary ASC) AS ROWASC, 
            ROW_NUMBER() OVER (PARTITION BY company ORDER BY salary DESC) AS ROWDESC 
        FROM Employee
    ) X 
    WHERE ROWASC IN (ROWDESC, ROWDESC - 1, ROWDESC + 1)
) tmp
WHERE rn = 1
ORDER BY company, salary;
