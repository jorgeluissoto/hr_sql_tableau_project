-- Data Analysis
SELECT 
    *
FROM
    hr;
 
-- 1. What is the gender breakdown of employees in the company?
-- Select the "gender" column and count the number of occurrences of each gender in the "hr" table
-- Only include records where the "age" is greater than or equal to 18 and the "termdate" is NULL
-- Group the results by gender
SELECT
    gender, COUNT(gender) AS GenderCount
FROM
    hr
WHERE
    age >= 18 AND termdate IS NULL
GROUP BY gender;
 
-- 2. What is the race/ ethinicity breakdown of employees in the company?
-- Select the "race" column and count the number of occurrences of each race in the "hr" table
-- Only include records where the "age" is greater than or equal to 18 and the "termdate" is NULL
-- Group the results by race
-- Order the results by the count of each race, in descending order
SELECT 
    race, COUNT(race) AS RaceCount
FROM
    hr
WHERE
    age >= 18 AND termdate IS NULL
GROUP BY race
ORDER BY RaceCount DESC;
 
-- 3. What is the age distribution of employees in the company?
-- First find the youngest and oldest age
 SELECT 
    MIN(age) AS youngest, MAX(age) AS oldest
FROM
    hr
WHERE
    age >= 18 AND termdate IS NULL;

/*
SELECT 
    SUM(IF(age BETWEEN 18 AND 24, 1, 0)) AS '20 - 25',
    SUM(IF(age BETWEEN 25 AND 34, 1, 0)) AS '26 - 29',
    SUM(IF(age BETWEEN 35 AND 44, 1, 0)) AS '30 - 35',
    SUM(IF(age BETWEEN 45 AND 54, 1, 0)) AS '36 - 39',
    SUM(IF(age BETWEEN 55 AND 64, 1, 0)) AS '40 - 45',
    SUM(IF(age >= 65, 1, 0)) AS 'Over 65'
FROM
    hr
WHERE
    age >= 18 AND termdate IS NULL; */

-- Select a calculated "age_group" column that groups ages into pre-defined ranges
-- Count the number of occurrences of each age group in the "hr" table
-- Only include records where the "age" is greater than or equal to 18 and the "termdate" is NULL
-- Group the results by age group
-- Order the results by age group
SELECT 
    CASE
        WHEN age >= 18 AND age <= 24 THEN '18-24'
        WHEN age >= 25 AND age <= 34 THEN '25-34'
        WHEN age >= 35 AND age <= 44 THEN '35-44'
        WHEN age >= 45 AND age <= 54 THEN '45-54'
        WHEN age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
    END AS age_group,
    COUNT(age) AS count
FROM
    hr
WHERE
    age >= 18 AND termdate IS NULL
GROUP BY age_group
ORDER BY age_group;

-- 3a. How gender is distributed among age group?
-- Select a calculated "age_group" column that groups ages into pre-defined ranges
-- Select the "gender" column to include in the results
-- Count the number of occurrences of each age group and gender combination in the "hr" table
-- Only include records where the "age" is greater than or equal to 18 and the "termdate" is NULL
-- Group the results by age group and gender
-- Order the results by age group and gender
SELECT 
    CASE
        WHEN age >= 18 AND age <= 24 THEN '18-24'
        WHEN age >= 25 AND age <= 34 THEN '25-34'
        WHEN age >= 35 AND age <= 44 THEN '35-44'
        WHEN age >= 45 AND age <= 54 THEN '45-54'
        WHEN age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
    END AS age_group,
    gender,
    COUNT(age) AS count
FROM
    hr
WHERE
    age >= 18 AND termdate IS NULL
GROUP BY age_group , gender
ORDER BY age_group , gender;

-- 4. How many employees work at headquarters versus remote locations?
-- Select the "location" column to include in the results
-- Count the number of occurrences of each distinct location in the "hr" table
-- Only include records where the "age" is greater than or equal to 18 and the "termdate" is NULL
-- Group the results by location
SELECT 
    location, COUNT(*) AS NumberofEmp
FROM
    hr
WHERE
    age >= 18 AND termdate IS NULL
GROUP BY location;

-- 5. What is the average length of employment for employees who have been terminated?
-- Select the average length of employment in years, rounded to one decimal point
-- Calculate the difference in years between the "termdate" and "hire_date" columns and take the average
-- Only include records where "termdate" is not null, is less than or equal to the current date, and the "age" is greater than or equal to 18

SELECT 
    ROUND(AVG(DATEDIFF(termdate, hire_date) / 365),1) AS AvgLenghtofEmp
FROM
    hr
WHERE
    termdate <= CURDATE()
        AND termdate IS NOT NULL
        AND age >= 18;

-- 6. How does the gender distribution vary across departments?
-- Select the "department", "gender", and count of employees in each department/gender combination
-- Only include records where the "age" is greater than or equal to 18 and the "termdate" is NULL
-- Group the results by department and gender
-- Order the results by department
SELECT 
	department, gender, COUNT(*) AS NumberofEmp
FROM
    hr
WHERE
    age >= 18 AND termdate IS NULL
GROUP BY department, gender
ORDER BY department;

-- 7. What is the distribution of job titles across the company?
-- Select the job title and count of employees in each job title
-- Only include records where the "age" is greater than or equal to 18 and the "termdate" is NULL
-- Group the results by job title
-- Order the results by job title in descending order
SELECT 
    jobtitle, COUNT(*) AS NumberofEmp
FROM
    hr
WHERE
    age >= 18 AND termdate IS NULL
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- 8. Which department has the highest turnover rate?
-- Select the department, total count of employees, terminated count of employees, and termination rate for each department
-- Total count of employees is the count of all employees with age greater than or equal to 18 in each department
-- Terminated count of employees is the count of all employees with age greater than or equal to 18 who have a non-null termdate that is less than or equal to the current date (i.e., they have been terminated)
-- Calculate termination rate by dividing the terminated count by the total count for each department
-- Group the records by department
-- Order the records by termination rate in descending order
SELECT
	department,
    total_count,
    terminated_count,
    terminated_count/ total_count AS termination_rate
FROM(
	SELECT
		department,
        COUNT(*) AS total_count,
        SUM(CASE WHEN termdate IS NOT NULL AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminated_count
        FROM hr
        WHERE age >= 18
        GROUP BY department
) AS subquery
ORDER BY termination_rate DESC;
	
-- 9. What is the distribution of employees across locations by city and state?
-- This SQL code selects the count of employees grouped by their state of location. 
-- It only includes employees who are 18 years old or older and whose termination date is null. 
-- The result set is ordered in descending order based on the number of employees in each state.
SELECT 
    location_state, COUNT(*) AS NumberofEmp
FROM
    hr
WHERE
    age >= 18 AND termdate IS NULL
GROUP BY location_state
ORDER BY NumberofEmp DESC;

-- 10. How has the company's employee count changed over time based on hire and term dates?
/* This query is selecting the year, number of hires, number of terminations, net change (difference between hires and terminations), 
and net change percentage (net change divided by hires, multiplied by 100 and rounded to two decimal points) for each 
year where there are employees aged 18 or above. 

The subquery first selects the year from the hire_date column, counts the number of hires in each year, 
and sums up the number of terminations (where the termdate is not null and less than or equal to the current date) 
in each year. The main query then calculates the net change by subtracting the number of terminations from the number 
of hires, and the net change percentage by dividing the net change by the number of hires, multiplying by 100 and rounding 
to two decimal points. The results are then ordered by year. */

SELECT
	year,
    hires, 
    terminations,
    hires - terminations AS net_change,
    ROUND((hires - terminations)/hires* 100,2) AS net_change_percent
FROM (
	SELECT 
		YEAR(hire_date) AS Year,
        COUNT(*) as hires,
        SUM(CASE WHEN termdate IS NOT NULL AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminations
        FROM hr
        WHERE age >= 18
        GROUP BY year
) AS sub_query
ORDER BY Year;

-- 11. What is the tenure distribution for each department?
/* This query calculates the average tenure (in years) of employees who have left the company for each department.

It selects the department and calculates the average tenure using the AVG() and DATEDIFF() functions. The DATEDIFF() function 
calculates the difference between the hire date and termination date in days, which is then divided by 365 to convert it to 
years. The result is rounded to one decimal point using the ROUND() function.

The WHERE clause filters for employees who are at least 18 years old, have a termination date that is not null and is 
on or before the current date, and groups the results by department. */
SELECT
	department,
    ROUND(AVG(DATEDIFF(termdate, hire_date) / 365),1) AS AvgTenureofEmp
FROM hr
WHERE
    age >= 18 AND termdate IS NOT NULL AND termdate <= CURDATE()
GROUP BY department;
