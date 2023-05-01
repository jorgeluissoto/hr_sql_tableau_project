CREATE DATABASE projects;

USE projects;

SELECT 
    *
FROM
    hr;
    
-- Change the column name "id" to "emp_id" in the "hr" table
-- Set the data type of the "emp_id" column to VARCHAR(20)
-- Allow NULL values in the "emp_id" column
ALTER TABLE hr
CHANGE id emp_id VARCHAR(20) NULL;

-- check all data types
DESCRIBE hr;

-- change birthdate data type since some date are 06-04-91 or 9/14/1982
-- Change the data type of the "birthdate" column in the "hr" table to DATE
ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

SELECT 
    birthdate
FROM
    hr;

SET sql_safe_updates = 0;

-- Update the "birthdate" column in the "hr" table
-- Use a CASE statement to handle two different date formats: MM/DD/YYYY and MM-DD-YYYY
-- Convert the date values to the YYYY-MM-DD format using the DATE_FORMAT function
UPDATE hr 
SET 
    birthdate = CASE
        WHEN
            birthdate LIKE '%/%'
        THEN
            DATE_FORMAT(STR_TO_DATE(birthdate, '%m/%d/%Y'),
                    '%Y-%m-%d')
        WHEN
            birthdate LIKE '%-%'
        THEN
            DATE_FORMAT(STR_TO_DATE(birthdate, '%m-%d-%Y'),
                    '%Y-%m-%d')
        ELSE NULL
    END;

-- Do the same thing for the hire date
SELECT 
    hire_date
FROM
    hr;

UPDATE hr 
SET 
    hire_date = CASE
        WHEN
            hire_date LIKE '%/%'
        THEN
            DATE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'),
                    '%Y-%m-%d')
        WHEN
            hire_date LIKE '%-%'
        THEN
            DATE_FORMAT(STR_TO_DATE(hire_date, '%m-%d-%Y'),
                    '%Y-%m-%d')
        ELSE NULL
    END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

-- Update term date
SELECT 
    termdate
FROM
    hr;

-- Update the "termdate" column in the "hr" table
-- Convert empty strings to NULL using the IF function
-- Convert non-empty strings to dates using the STR_TO_DATE function
-- Filter only non-NULL values using the WHERE clause
UPDATE hr 
SET
    termdate = IF(termdate = '',
        NULL,
        STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE
    termdate IS NOT NULL;

-- Change the data type of the "termdate" column in the "hr" table to DATE
ALTER TABLE hr
MODIFY COLUMN termdate DATE;

-- Add age column to data
ALTER TABLE hr ADD COLUMN age INT;

-- This SQL statement updates the 'age' column in the 'hr' table to reflect the current age of each employee.
-- It uses the TIMESTAMPDIFF function to calculate the number of years between the 'birthdate' column and the current date, 
-- and sets the result as the new value of the 'age' column.
UPDATE hr 
SET 
    age = TIMESTAMPDIFF(YEAR,
        birthdate,
        CURDATE());

SELECT 
    birthdate, age
FROM
    hr;

SELECT 
    MIN(age) AS youngest, MAX(age) AS oldest
FROM
    hr;

-- We only want to count poeple over 18 years old so this WHERE statement will be included in most of our queires 
SELECT 
    COUNT(*)
FROM
    hr
WHERE
    age < 18;