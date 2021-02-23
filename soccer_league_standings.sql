
-- redshift
-- create dataset for soccer_league_standings.sql problem
-- matches table
-- _________________________________________________________________________________________________________
-- | match_id |      host_team     |       guest_team      |       host_goals      |       away_goals      |
-- _________________________________________________________________________________________________________
-- |        1 |                  1 |                     2 |                     4 |                     3 |
-- |        2 |                  3 |                     1 |                     2 |                     1 |
-- |        3 |                  2 |                     3 |                     1 |                     0 |
-- |        4 |                  2 |                     1 |                     5 |                     4 |
-- |        5 |                  1 |                     3 |                     3 |                     2 |
-- |        6 |                  3 |                     2 |                     5 |                     0 |
-- _________________________________________________________________________________________________________

-- teams table
-- _________________________________
-- |  team_id |      team_name     |
-- _________________________________
-- |        1 |               'MU' |
-- |        2 |               'CL' |
-- |        3 |               'AR' |
-- _________________________________

-- output should look like
____________________________________________________________________
-- |  team |      gf     |      ga     |      gd     |    points   |
____________________________________________________________________
-- |    CL |           9 |          13 |          -4 |           6 |
-- |    MU |          12 |          12 |           0 |           6 |
-- |    AR |           9 |           5 |           4 |           6 |
____________________________________________________________________
with cte_host_points as (
  select
    host_team as team,
    host_goals as goals_for,
    guest_goals as goals_aganist,
    host_goals - guest_goals as goal_diff,
    case
      when host_goals > guest_goals then 3
      when host_goals = guest_goals then 1
      else 0
    end as points
  from matches
 ),
cte_guest_points as (
  select
    guest_team as team,
    guest_goals as goals_for,
    host_goals as goals_aganist,
    guest_goals - host_goals as goal_diff,
    case
      when guest_goals > host_goals THEN 3
      when guest_goals = host_goals THEN 1
      else 0
    end as points
  from matches
),
cte_total as (
  select
    team,
    goals_for,
    goals_aganist,
    goal_diff,
    points
  from cte_host_points
  union all
  select
    team,
    goals_for,
    goals_aganist,
    goal_diff,
    points
  from cte_guest_points
),
stats as (
	select
	  team,
	  coalesce(sum(goals_for), 0) as home_goals,
	  coalesce(sum(goals_aganist), 0) as away_goals,
	  coalesce(sum(goal_diff), 0) as goal_diff,
	  coalesce(sum(points), 0) as points
	from cte_total
	group by team
)
select
	t.team_name as TEAM,
	st.home_goals as GF,
	st.away_goals as GA,
	st.goal_diff as GD,
	st.points as POINTS
from stats st
inner join teams t
	on st.team = t.team_id
order by st.points, st.goal_diff, st.away_goals, st.home_goals
