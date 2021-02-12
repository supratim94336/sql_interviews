-- postgres
-- problem: Min number of meetings needed in order to suffice all meeting timings
-- input should look like
-- ______________________________
-- | id | start_time | end_time |
-- ______________________________
-- |  1 |   02:00:00 | 02:59:59 |  
-- |  2 |   03:00:00 | 03:59:59 |   
-- |  3 |   04:00:00 | 04:59:59 |   
-- |  4 |   03:00:00 | 04:59:59 |   
-- ______________________________
select max(overlap) as solution from (
    select count(t) as overlap from (
        select * from (
            select start_time as t
            from meetings
            union select end_time as t
            from meetings
        ) as times
        join meetings as m
        on times.t >= m.start_time and times.t < m.end_time
    )
    group by t
);
