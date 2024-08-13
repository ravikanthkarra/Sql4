# Write your MySQL query statement below

with cte_sr as
(
    select *
    , SUM(salary) OVER (PARTITION BY experience ORDER BY experience, salary, employee_id) as 'CumSal'
    ,(70000 - (SUM(salary) OVER (ORDER BY experience, salary, employee_id))) as 'RemBudget'
    FROM
    CANDIDATES
    WHERE experience = "Senior"
),

cte_jr as
(
    select *
    , SUM(salary) OVER (PARTITION BY experience ORDER BY experience, salary, employee_id) as 'CumSal'
    , IFNULL((SELECT MIN(RemBudget) from cte_sr csr where csr.RemBudget >= 0),70000) - SUM(salary) OVER (PARTITION BY experience ORDER BY experience, salary, employee_id) as RemBudget
    FROM
    CANDIDATES
    WHERE experience = "Junior"
)

select "Senior" as experience, count(*) as accepted_candidates from cte_sr where RemBudget >=0
UNION
select "Junior" as experience, count(*) as accepted_candidates from cte_jr where RemBudget >=0

