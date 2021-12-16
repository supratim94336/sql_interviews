/*
Find diagonally symmetric pairs
*/
-- MySQL
-- Result 1, 2
-- _____________
-- |  x |    y |
-- _____________
-- |  1 |    2 |
-- |  2 |    1 |
-- |  4 |    3 |
-- |  5 |    6 |
-- ________________________________

SELECT A.x, A.y
FROM FUNCTIONS A JOIN FUNCTIONS B ON
    A.x = B.y AND A.y = B.x
GROUP BY A.x, A.y
HAVING COUNT(A.x) > 1 OR A.x < A.y
ORDER BY A.x
