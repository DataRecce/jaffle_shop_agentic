-- Daily sales report
select
    date_trunc('day', order_date) as order_date,
    count(*) as total_orders,
    sum(amount) as total_revenue
from {{ source('jaffle_shop', 'orders') }}
group by 1
order by 1 desc
