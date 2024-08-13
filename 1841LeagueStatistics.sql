# Write your MySQL query statement below
with cte as(
    select m1.home_team_id as team_id, m1.home_team_goals as goals_for, m1.away_team_goals as goals_against
    , (CASE WHEN m1.home_team_goals > m1.away_team_goals  THEN 3 WHEN m1.home_team_goals < m1.away_team_goals  THEN 0 else 1 END) as points
    from Matches m1
    UNION ALL
    select m2.away_team_id as team_id, m2.away_team_goals as goals_for, m2.home_team_goals as goals_against
    , (CASE WHEN m2.away_team_goals  < m2.home_team_goals THEN 0 WHEN m2.away_team_goals  > m2.home_team_goals THEN 3 else 1 END) as points
    from Matches m2
)


select team_name , sub_q.matches_played, sub_q.points,sub_q.goal_for, sub_q.goal_against, sub_q.goal_diff
from Teams t
JOIN 
(select team_id, count(team_id) as matches_played
, SUM(points) as points
, sum(cte.goals_for) as goal_for, sum(cte.goals_against) as goal_against, (sum(cte.goals_for) - sum(cte.goals_against)) as goal_diff
from cte
group by team_id
) as sub_q
ON t.team_id = sub_q.team_id
order by sub_q.points desc, sub_q.goal_diff desc, t.team_name