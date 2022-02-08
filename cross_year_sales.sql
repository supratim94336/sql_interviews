WITH Years (year) AS (SELECT 2018 UNION ALL SELECT 2019 UNION ALL SELECT 2020)
SELECT
    CAST(Product.product_id AS NVARCHAR(255)) AS product_id,
    Product.product_name,
    CAST(Years.year AS NCHAR(4)) AS report_year,
    SUM(average_daily_sales * (1 +
        DATEDIFF(DAY,
            CASE WHEN DATEPART(YEAR, period_start) < year THEN DATEFROMPARTS(year, 1, 1) ELSE period_start END,
            CASE WHEN DATEPART(YEAR, period_end) > year THEN DATEFROMPARTS(year, 12, 31) ELSE period_end END))
    ) AS total_amount
FROM Years
CROSS JOIN Sales
INNER JOIN Product ON Product.product_id = Sales.product_id
WHERE DATEPART(YEAR, period_start) <= year AND year <= DATEPART(YEAR, period_end)
GROUP BY Product.product_id, Product.product_name, Years.year
ORDER BY CAST(Product.product_id AS NVARCHAR(255)), CAST(Years.year AS NCHAR(4)) 
