/* How to calculate percentage in one line:
   1. COUNT(*)                     -> Count rows in the CURRENT group (e.g., 'Readmitted')
   2. SUM(COUNT(*)) OVER ()        -> Get the TOTAL rows for the entire table (101,766)
   3. 100.0 * (Group / Total)      -> Divide them and multiply by 100 to get a decimal percentage
   4. ROUND(..., 2)                -> Keep only 2 numbers after the decimal (e.g., 46.33)
*/

SELECT 
    readmitted, 
    COUNT(*) AS count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM admissions
GROUP BY readmitted;

/

/* Race Distribution
   Purpose : Check what racial groups are present in the dataset and how
             many records belong to each — including missing/unknown values.

   Key fact : Missing race is encoded as '?' (a literal question mark string),
              NOT as SQL NULL. This is common in older healthcare datasets
              exported from legacy EMR systems.

   Why it matters:
     - A large '?' group can skew demographic analysis.
     - Knowing the distribution early informs fairness checks later:
       does the model perform equally well across racial groups?
     - We do NOT blindly drop '?' rows — we flag and document them first.
*/
SELECT race, COUNT(*)
FROM admissions
GROUP BY race
ORDER BY COUNT(*) DESC;

/

/* Count Missing Race Values
   Purpose : Quantify exactly how many rows have an unknown race ('?').
             This is a follow-up to the race distribution query above.

   What this tells you:
     - The raw number of affected rows (e.g., ~2,273 out of 101,766)
     - Whether the missingness is small enough to ignore, or large enough
       to require a dedicated "Unknown" category in features

   Decision guide:
     - < 1% missing  → safe to drop or impute
     - 1–5% missing  → create an "Unknown" flag column; do not drop
     - > 5% missing  → must investigate cause; could introduce bias if dropped

   Note: We use WHERE race = '?' (string match), NOT WHERE race IS NULL,
         because the dataset stores missing values as a literal '?' character.
*/
SELECT COUNT(*) 
FROM admissions
WHERE race = '?';

/

-- Distribution of hospital stay duration (in days).
-- Groups patients by number of days spent in hospital and counts occurrences.
-- Ordered ascending to reveal the spread from shortest to longest stays.
SELECT 
    time_in_hospital,       -- Number of days the patient was hospitalized
    COUNT(*) AS count       -- Number of admissions with that stay duration
FROM admissions
GROUP BY time_in_hospital
ORDER BY time_in_hospital;  -- Sort by stay length for easy trend analysis

/

-- Analyze average hospital stay duration by readmission outcome.
-- Helps identify whether readmitted patients tend to have longer or shorter
-- initial stays, which may indicate premature discharge or inadequate care.
SELECT 
    readmitted,                              -- Readmission category (e.g., '<30', '>30', 'NO')
    AVG(time_in_hospital) AS avg_stay        -- Mean number of days spent in hospital per group
FROM admissions
GROUP BY readmitted;

/

-- Compare prior inpatient visit history across readmission groups.
-- Patients with more previous inpatient encounters may have chronic conditions
-- that increase their risk of readmission, making this a key predictive signal.
SELECT 
    readmitted,                                        -- Readmission category (e.g., '<30', '>30', 'NO')
    AVG(number_inpatient) AS avg_prior_inpatient       -- Mean number of inpatient visits in the year before this admission
FROM admissions
GROUP BY readmitted;

/

-- Identify patients with multiple admissions (repeat visitors).
-- High visit counts may signal chronic or poorly managed conditions,
-- and these patients are strong candidates for readmission prediction.
SELECT 
    patient_nbr,                    -- Unique patient identifier
    COUNT(*) AS visit_count         -- Total number of admission records for this patient
FROM admissions
GROUP BY patient_nbr
HAVING COUNT(*) > 1                 -- Retain only patients with more than one admission
ORDER BY visit_count DESC;          -- Show most frequently admitted patients first

/

-- Examine the distribution of discharge dispositions across all admissions.
-- Discharge destination (e.g., home, skilled nursing, expired) is strongly
-- linked to patient severity and readmission risk, making it a valuable feature.
SELECT 
    discharge_disposition_id,      -- Coded discharge destination (maps to IDs defined by CMS/UCI dataset)
    COUNT(*) AS admission_count    -- Number of admissions ending with this disposition
FROM admissions
GROUP BY discharge_disposition_id
ORDER BY COUNT(*) DESC;            -- Most common discharge outcomes appear first