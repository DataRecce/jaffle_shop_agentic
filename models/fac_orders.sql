
with orders as (
    select * from {{ ref('stg_orders') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

payments as (
    select 
        *
    from {{ ref('stg_payments') }}
)

select
    orders.order_id,
    orders.customer_id,
    customers.first_name as customer_first_name,
    customers.last_name as customer_last_name,
    orders.order_date,
    orders.status,
    1 as payment_count,
    payments.amount as total_amount
from orders
left join customers 
    on orders.customer_id = customers.customer_id
left join payments
    on orders.order_id = payments.order_id
