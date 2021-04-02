with 

source as (

    select * from {{ source('health_data', 'labs') }}

),

cleaned as (
    
    select
    
        -- ids
        patient_id,
        diagnosis_id,
        loinc,

        -- descriptions
        panel,
        test,
        test_units,
        min_norm,
        max_norm,
        'Panel: ' || IFNULL(panel, '') || ' | Test: ' || IFNULL(test, '') || ' | Loinc: ' || IFNULL(loinc, '') lab,

        -- timestamps
        test_date as test_at,
        transaction_timestamp as transaction_at

    from source

)

select * from cleaned