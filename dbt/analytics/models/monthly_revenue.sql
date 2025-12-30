-- Monthly revenue summary for analytics
-- This is a test model for monorepo setup

{{ config(materialized='table') }}

with orders as (
    select
        date_trunc('month', order_date) as month,
        sum(amount) as total_revenue,
        count(*) as order_count
    from {{ source('jaffle_shop', 'orders') }}
    group by 1
)

select
    month,
    total_revenue,
    order_count,
    total_revenue / nullif(order_count, 0) as avg_order_value
from orders
order by month desc
