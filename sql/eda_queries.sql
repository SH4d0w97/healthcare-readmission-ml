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
