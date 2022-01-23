/*
Find num of passengers for a particular bus,
where it is provided when a bus departs and when a passenger arrives,
and when passenger arrives at the bus station for a origin to destination journey
if the origin and destination is same, then the passenger can only board a bus if he arrived before time or the exact time
*/
-- Postgres
-- Buses
-- ________________________________________
-- |  id|    origin|   destination|   time|
-- ________________________________________
-- |  1 |   berlin |         paris|  10:12|
-- |  2 |   paris  |        berlin|  10:15|
-- |  3 |   berlin |         paris|  10:18|
-- |  4 |   milan  |         paris|  10:20|
-- ________________________________________
-- Passengers
-- ________________________________________
-- |  id|    origin|   destination|   time|
-- ________________________________________
-- |  1 |   berlin |         paris|  10:11|
-- |  2 |   paris  |        berlin|  10:14|
-- |  3 |   berlin |         paris|  10:12|
-- |  4 |   milan  |         paris|  10:21|
-- ________________________________________
-- Results
-- __________________________
-- |  id|  num_of_passengers|
-- __________________________
-- |  1 |                  2|
-- |  2 |                  1|
-- |  3 |                  0|
-- |  4 |                  0|
-- __________________________
SELECT
    b.id,
    COUNT(p.id) AS num_passengers
FROM (
    SELECT
        b.*,
        LAG(time) OVER (PARTITION BY origin, destination ORDER BY time) AS prev_time
    FROM buses b
) b
LEFT JOIN passengers p 
    ON p.origin = b.origin AND p.destination = b.destination
    AND (p.time > b.prev_time OR b.prev_time IS NULL)
    AND (p.time <= b.time)
GROUP BY b.id, b.origin, b.destination, b.time
ORDER BY b.id ASC;
