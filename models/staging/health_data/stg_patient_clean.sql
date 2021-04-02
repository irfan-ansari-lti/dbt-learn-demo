with 

source as (

    select * from {{ source('health_data', 'patientclean') }}

),

cleaned as (
    
    select

        -- ids
        patient_id,
        person_id,
        provider_id

    from source

)

select * from cleaned