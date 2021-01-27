-- trying to show 11 tickets sold in last 4 weeks, 23 tickets sold previous period, 52% decrease

with issued_tickets as (
    select * from {{ ref('stg_ticket_tailor__issued_tickets') }}
),

issued_tickets_with_date_markers as (
    select
        datediff('day', created_at, current_timestamp()) as days_since_sale,
        mod(days_since_sale, 28) as four_week_period_ago,
        *
    from issued_tickets
    order by created_at 

    
),

aggregated as (
    select
        days_since_sale,
        count(*)
    from issued_tickets_with_date_markers
    -- where four_week_period_ago in (1, 2)
    group by 1   
)

select * from aggregated
order by 1

