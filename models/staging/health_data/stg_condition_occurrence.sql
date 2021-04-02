with 

source as (

    select * from {{ source('health_data', 'condition_occurrence') }}

),

cleaned as (
    
    select

        -- ids
        condition_occurrence_id,
        condition_source_value_id,
        person_id   
         
    from source

)

select * from cleaned