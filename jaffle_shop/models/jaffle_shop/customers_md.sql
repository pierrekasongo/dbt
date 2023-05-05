with customers_tbl as (

    select
        id as customer_id,
        first_name,
        last_name

    from customers

),

orders_tbl as (

    select
        id as order_id,
        user_id as customer_id,
        order_date

    from orders

),

customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders

    from orders_tbl

    group by 1

),

final as (

    select
        customers_tbl.customer_id,
        customers_tbl.first_name,
        customers_tbl.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders

    from customers_tbl

    left join customer_orders using (customer_id)

)

select * from final