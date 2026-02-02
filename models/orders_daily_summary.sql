{{ config(materialized='incremental', unique_key=['order_date', 'customer_id']) }}

with daily_orders as (

    select
        order_date,
        customer_id,
        count(*) as order_count,
        sum(amount) as total_amount,
        avg(amount) as avg_order_amount

    from {{ ref('orders') }}

    where order_date >= '2021-06-01'

    {% if is_incremental() %}
    and order_date > (select max(order_date) from {{ this }})
    {% endif %}

    group by order_date, customer_id

)

select * from daily_orders
