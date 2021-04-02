SELECT DISTINCT Pat.Person_ID,
      IFNULL(Meas.concept_id, 0) Concept_id,
      Test_Date,
      try_to_decimal(Test_Result) Test,
      Prov.ProvID,
      Min_Norm,
      Max_Norm,
      'Panel: ' || IFNULL(L.Panel, '') || ' | Test: ' || IFNULL(L.Test, '') || ' | Loinc: ' || IFNULL(L.Loinc, '') lab,
      Test_Units,
      Test_Result,
      condition_occurrence_id
    FROM
      raw.health_data.Labs L
      JOIN raw.health_data.PatientClean Pat 
          ON L.patient_id = Pat.Patient_ID
      LEFT JOIN raw.health_data.concept Meas 
          ON Meas.concept_code = L.Loinc
          AND Meas.domain_id = 'Measurement'
          AND IFNULL(Meas.invalid_reason, '') = ''
      LEFT JOIN raw.health_data.ProvClean Prov 
          ON Prov.Provider_ID = Pat.Provider_ID
      LEFT JOIN raw.health_data.CONDITION_OCCURRENCE C 
          ON pat.Person_ID = c.Person_ID
      AND C.condition_source_value_id = L.Diagnosis_ID