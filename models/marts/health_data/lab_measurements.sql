with 

labs as (
    select * from {{ ref('stg_labs') }}
),

patients as (
    select * from {{ ref('stg_patient_clean') }}
),

valid_measurements as (
    select * from {{ ref('int_valid_measurements') }}
),

providers as (
    select * from {{ ref('stg_provider_clean') }}
),

condition_occurences as (
    select * from {{ ref('stg_condition_occurrence') }}
),

final as (

    SELECT DISTINCT 
        {{ dbt_utils.surrogate_key([
            'patients.Person_ID',
            'providers.ProvID',
            'labs.test_at',
            'labs.lab',
            'labs.Test_Units'
        ]) }} as lab_measurement_id,
        patients.Person_ID,
        valid_measurements.concept_id,
        labs.test_at,
        providers.ProvID,
        labs.Min_Norm,
        labs.Max_Norm,
        labs.lab,
        labs.Test_Units,
        condition_occurences.condition_occurrence_id
    FROM
        labs
        JOIN patients
            ON labs.patient_id = patients.Patient_ID
        LEFT JOIN valid_measurements
            ON valid_measurements.concept_code = labs.Loinc
        LEFT JOIN providers
            ON providers.Provider_ID = patients.Provider_ID
        LEFT JOIN condition_occurences
            ON patients.Person_ID = condition_occurences.Person_ID
            AND condition_occurences.condition_source_value_id = labs.Diagnosis_ID
)

select * from final
