with 

source as (

    select * from {{ source('health_data', 'concept') }}

),

cleaned as (
    
    select

        -- ids
        IFNULL(concept_id, 0) as concept_id,
        domain_id,

        -- description
        concept_code,
        invalid_reason
            
    from source

)

select * from cleaned