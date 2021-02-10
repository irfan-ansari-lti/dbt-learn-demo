with source as (

    select * from {{ source('ticket_tailor', 'orders') }}

),

renamed as (

    select
        id as order_id,

        txn_id as transaction_id,
        event_summary:id::string as event_id,

        
        currency:base_multiplier::integer as currency_base_multiplier,
        currency:code::string as currency_code,

        -- amounts
        subtotal / currency_base_multiplier as subtotal_amount,
        tax / currency_base_multiplier as tax_amount,
        total / currency_base_multiplier as total_amount,
        refund_amount / currency_base_multiplier as refund_amount, -- why are all tickets refunded?

        event_summary,
        
        line_items,
        object,
        
        status,

        
        to_timestamp(created_at) as created_at

    from source

)

select * from renamed