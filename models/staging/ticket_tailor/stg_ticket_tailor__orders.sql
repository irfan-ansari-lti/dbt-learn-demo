with source as (

    select * from {{ source('ticket_tailor', 'orders') }}

),

renamed as (

    select
        -- ids
        id as order_id,
        event_summary:id::string as event_id,
        txn_id as transaction_id,
        
        currency:base_multiplier as currency_base_multiplier,
        currency:code::text as currency_code,

        round(total / currency_base_multiplier, 2) as total_amount_usd,
        round(tax / currency_base_multiplier, 2) as tax_amount_usd,
        round(refund_amount /currency_base_multiplier, 2) as refund_amount_usd, -- this seeems wrong :/ 
        round(subtotal /currency_base_multiplier, 2) as subtotal_amount_usd, -- total - refund
        

        line_items,
        object,

        status,

        -- epoch
        to_timestamp(created_at) as created_at 
    

    from source

)

select * from renamed
