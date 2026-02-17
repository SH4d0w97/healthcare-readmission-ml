-- Load data from the diabetic_data.csv file into the admissions table.
-- Make sure to update the file path to the correct location of your CSV file.

COPY admissions
FROM '/absolute/path/to/diabetic_data.csv'
DELIMITER ','
CSV HEADER;
