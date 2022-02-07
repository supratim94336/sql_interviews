-- Orders by Weekday
/* Write your T-SQL query statement below */
select * FROM (SELECT it.item_category AS CATEGORY,
    sum(
        case
            when DATENAME(dw, od.order_date) = 'Monday' then od.quantity
            else 0
        end) as MONDAY,
    sum(
        case
            when DATENAME(dw, od.order_date) = 'Tuesday' then od.quantity
            else 0
        end) as TUESDAY,
    sum(
        case
            when DATENAME(dw, od.order_date) = 'Wednesday' then od.quantity
            else 0
        end) as WEDNESDAY,
    sum(
        case
            when DATENAME(dw, od.order_date) = 'Thursday' then od.quantity
            else 0
        end) as THURSDAY,
    sum(
        case
            when DATENAME(dw, od.order_date) = 'Friday' then od.quantity
            else 0
        end) as FRIDAY,
    sum(
        case
            when DATENAME(dw, od.order_date) = 'Saturday' then od.quantity
            else 0
        end) as SATURDAY,
    sum(
        case
            when DATENAME(dw, od.order_date) = 'Sunday' then od.quantity
            else 0
        end) as SUNDAY
FROM Items as it
LEFT JOIN Orders as od
    ON od.item_id = it.item_id
GROUP BY it.item_category
) temp
ORDER BY CATEGORY ASC
