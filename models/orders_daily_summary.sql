{{ config(materialized='incremental', unique_key=['order_date', 'customer_id']) }}

with daily_orders as (

    select
        order_date,
        customer_id,
        count(*) as order_count,
        sum(amount) as total_amount

    from {{ ref('orders') }}

    {% if is_incremental() %}
    where order_date > (select max(order_date) from {{ this }})
    {% endif %}

    group by order_date, customer_id

)

select * from daily_orders
