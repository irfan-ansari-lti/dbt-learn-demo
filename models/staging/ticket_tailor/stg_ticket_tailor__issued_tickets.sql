with source as (

    select * from {{ source('ticket_tailor', 'issued_tickets') }}

),

renamed as (

    select
        -- keys
        id as ticket_id,
        ticket_type_id,
        event_id,
        order_id,

        -- descriptions
        object,
        barcode,
        barcode_url,

        -- status
        status,

        -- timestamps
        to_timestamp(created_at) as created_at,
        to_timestamp(updated_at) as updated_at,
        to_timestamp(voided_at) as voided_at

    from source

)

select * from renamed