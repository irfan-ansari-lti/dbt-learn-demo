with 

concepts as (
    select * from {{ ref('stg_concepts') }}
),

final as (
    
    select 
        *
    
    from concepts

    where domain_id = 'Measurement'
    and coalesce(invalid_reason, '') = ''
    
)

select * from final