-- Weekly Performance Dashboard
-- KPIs with week-over-week comparison for executive reporting

{{ config(materialized='table') }}

with weekly_metrics as (
    select
        date_trunc('week', order_date) as week_start,
        count(*) as total_orders,
        sum(amount) as total_revenue,
        count(distinct customer_id) as unique_customers
    from {{ source('jaffle_shop', 'orders') }}
    group by 1
),

with_comparisons as (
    select
        week_start,
        total_orders,
        total_revenue,
        unique_customers,
        total_revenue / nullif(unique_customers, 0) as revenue_per_customer,
        lag(total_revenue) over (order by week_start) as prev_week_revenue,
        lag(total_orders) over (order by week_start) as prev_week_orders
    from weekly_metrics
)

select
    week_start,
    total_orders,
    total_revenue,
    unique_customers,
    revenue_per_customer,
    prev_week_revenue,
    case
        when prev_week_revenue > 0
        then round((total_revenue - prev_week_revenue) / prev_week_revenue * 100, 2)
        else null
    end as revenue_wow_change_pct,
    case
        when prev_week_orders > 0
        then round((total_orders - prev_week_orders)::float / prev_week_orders * 100, 2)
        else null
    end as orders_wow_change_pct
from with_comparisons
order by week_start desc
