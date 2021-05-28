with orders as (

    select * from {{ ref('stg_orders') }}

),

payments as (

    select * from {{ ref('stg_payments') }}

),

final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        sum(case when payments.status = 'success' then payments.amount else 0 end) as amount
    from orders
    left join payments on orders.order_id = payments.order_id
    group by 1, 2, 3

)

select * from final