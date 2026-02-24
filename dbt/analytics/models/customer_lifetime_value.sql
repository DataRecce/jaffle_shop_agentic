-- Customer Lifetime Value (CLV) analysis
-- Segments customers by purchase behavior and calculates lifetime value

{{ config(materialized='table') }}

with customer_orders as (
    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as last_order_date,
        count(*) as total_orders,
        sum(amount) as total_spent
    from {{ source('jaffle_shop', 'orders') }}
    group by 1
),

customer_metrics as (
    select
        customer_id,
        first_order_date,
        last_order_date,
        total_orders,
        total_spent,
        total_spent / nullif(total_orders, 0) as avg_order_value,
        datediff('day', first_order_date, last_order_date) as customer_lifespan_days
    from customer_orders
)

select
    customer_id,
    first_order_date,
    last_order_date,
    total_orders,
    total_spent as lifetime_value,
    avg_order_value,
    customer_lifespan_days,
    case
        when total_spent >= 100 then 'high_value'
        when total_spent >= 50 then 'medium_value'
        else 'low_value'
    end as customer_segment
from customer_metrics
