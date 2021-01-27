with source as (

    select * from {{ source('ticket_tailor', 'events') }}

),

renamed as (

    select
        -- keys
        id as event_id,

        -- descriptions
        name,
        description,
        object,
        payment_methods,
        images,
        ticket_types,
        currency,
        timezone,
        url,
        venue,
        call_to_action,

        -- status
        status,
        total_issued_tickets,
        total_orders,  

        -- booleans
        online_event as is_online_event,
        private as is_private,
        tickets_available as are_tickets_available,

        -- timestamps
        to_timestamp(created_at) as created_at


    from source

)

select * from renamed