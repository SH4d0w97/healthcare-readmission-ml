-- Schema definition for the healthcare readmission project.
-- This script drops the existing 'admissions' table if it exists and creates a new one
-- to store hospital encounter data including patient demographics, medical history, and outcomes.

DROP TABLE IF EXISTS admissions;

-- Main table for storing hospital admission records
-- Features include demographics, admission details, exam results, and diagnoses.
-- The target variable is 'readmitted'.

CREATE TABLE admissions (
    encounter_id BIGINT PRIMARY KEY,
    patient_nbr BIGINT,
    race VARCHAR(50),
    gender VARCHAR(20),
    age VARCHAR(20),
    admission_type_id INT,
    discharge_disposition_id INT,
    admission_source_id INT,
    time_in_hospital INT,
    num_lab_procedures INT,
    num_procedures INT,
    num_medications INT,
    number_outpatient INT,
    number_emergency INT,
    number_inpatient INT,
    diag_1 VARCHAR(20),
    diag_2 VARCHAR(20),
    diag_3 VARCHAR(20),
    number_diagnoses INT,
    max_glu_serum VARCHAR(20),
    A1Cresult VARCHAR(20),
    insulin VARCHAR(20),
    change VARCHAR(10),
    diabetesMed VARCHAR(10),
    readmitted VARCHAR(10)
);
