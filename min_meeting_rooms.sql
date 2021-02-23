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

-- if you want to experiment in Redshift the temp table creation goes like this
-- output should look like
-- __________________________________________________
-- | id |      start_time     |       end_time      |
-- __________________________________________________
-- |  1 | 2021-02-07 08:00:00 | 2021-02-07 09:15:59 |  
-- |  2 | 2021-02-07 13:20:00 | 2021-02-07 15:20:59 |   
-- |  3 | 2021-02-07 10:00:00 | 2021-02-07 14:00:59 |   
-- |  4 | 2021-02-07 13:55:00 | 2021-02-07 16:25:59 |   
-- |  5 | 2021-02-07 14:00:00 | 2021-02-07 17:45:59 | 
-- |  6 | 2021-02-07 14:05:00 | 2021-02-07 17:45:59 | 
-- __________________________________________________
create temp table if not exists meetings(id int, start_time timestamp, end_time timestamp);
insert into meetings values
(1,to_timestamp('2021-02-07 08:00:00', 'YYYY-MM-DD HH24:MI:SS'),to_timestamp('2021-02-07 09:15:59', 'YYYY-MM-DD HH24:MI:SS')),
(2,to_timestamp('2021-02-07 13:20:00', 'YYYY-MM-DD HH24:MI:SS'),to_timestamp('2021-02-07 15:20:59', 'YYYY-MM-DD HH24:MI:SS')),
(3,to_timestamp('2021-02-07 10:00:00', 'YYYY-MM-DD HH24:MI:SS'),to_timestamp('2021-02-07 14:00:59', 'YYYY-MM-DD HH24:MI:SS')),
(4,to_timestamp('2021-02-07 13:55:00', 'YYYY-MM-DD HH24:MI:SS'),to_timestamp('2021-02-07 16:25:59', 'YYYY-MM-DD HH24:MI:SS')),
(5,to_timestamp('2021-02-07 14:00:00', 'YYYY-MM-DD HH24:MI:SS'),to_timestamp('2021-02-07 17:45:59', 'YYYY-MM-DD HH24:MI:SS')),
(6,to_timestamp('2021-02-07 14:05:00', 'YYYY-MM-DD HH24:MI:SS'),to_timestamp('2021-02-07 17:45:59', 'YYYY-MM-DD HH24:MI:SS'));

