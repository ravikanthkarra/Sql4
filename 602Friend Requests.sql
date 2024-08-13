# Write your MySQL query statement below
with cte as(
    select requester_id as id, count(requester_id) as frndCount
    from RequestAccepted
    group by requester_id
    UNION ALL
    select accepter_id as id, count(accepter_id) as frndCount
    from RequestAccepted
    group by accepter_id
)

select id, sum(frndCount) as num from cte
group by id
order by sum(frndCount) desc limit 1