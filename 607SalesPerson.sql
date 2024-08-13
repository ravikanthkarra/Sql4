# Write your MySQL query statement below

select name from
SalesPerson s
WHERE sales_id NOT IN
(
    Select o.sales_id
    FROM orders o
    JOIN Company c
    ON o.com_id = c.com_id
    where c.name = 'RED'
)
