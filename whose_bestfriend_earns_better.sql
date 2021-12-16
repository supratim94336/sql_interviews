/*
People whose best friends got better salaries: MySQL
*/
with cte (id, frnd_id, sal, frnd_sal) as (
    select Friends.ID as id, Friends.Friend_ID as frnd_id, Packages_ID.Salary as sal, Packages_Friend_ID.Salary as frnd_sal
    from Friends
    inner join Packages as Packages_ID
        on Packages_ID.ID = Friends.ID
    inner join Packages as Packages_Friend_ID
        on Packages_Friend_ID.ID = Friends.Friend_ID
)
select Students.Name
from Students
inner join cte
    on cte.id = Students.ID
    and cte.frnd_sal - cte.sal > 0
order by cte.frnd_sal asc;
