with 

source as (

    select * from {{ source('health_data', 'provclean') }}

),

cleaned as (
    
    select

        -- ids
        provider_id,
        provid
        
    from source

)

select * from cleaned