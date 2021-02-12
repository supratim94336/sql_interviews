SELECT MAX(overlap) as solution FROM (
    SELECT COUNT(t) as overlap FROM (
        SELECT * FROM (
            SELECT start_time AS t
            FROM meetings
            UNION SELECT end_time AS t
            FROM meetings
        ) as times
        JOIN meetings AS m
        ON times.t >= m.start_time AND times.t < m.end_time
    )
    GROUP BY t
);