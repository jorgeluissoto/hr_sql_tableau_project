-- Data Analysis
SELECT 
    *
FROM
    hr;
 
-- 1. What is the gender breakdown of employees in the company?
SELECT 
    gender, COUNT(gender) AS GenderCount
FROM
    hr
WHERE
    age >= 18 AND termdate IS NULL
GROUP BY gender;
 
-- 2. What is the race/ ethinicity breakdown of employees in the company?
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
    age >= 18 AND termdate IS NULL;

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
SELECT 
    location, COUNT(*) AS NumberofEmp
FROM
    hr
WHERE
    age >= 18 AND termdate IS NULL
GROUP BY location;

-- 5. What is the average length of employment for employees who have been terminated?
SELECT 
    ROUND(AVG(DATEDIFF(termdate, hire_date) / 365),1) AS AvgLenghtofEmp
FROM
    hr
WHERE
    termdate <= CURDATE()
        AND termdate IS NOT NULL
        AND age >= 18;

-- 6. How does the gender distribution vary across departments?
SELECT 
	department, gender, COUNT(*) AS NumberofEmp
FROM
    hr
WHERE
    age >= 18 AND termdate IS NULL
GROUP BY department, gender
ORDER BY department;

-- 7. What is the distribution of job titles across the company?
SELECT 
    jobtitle, COUNT(*) AS NumberofEmp
FROM
    hr
WHERE
    age >= 18 AND termdate IS NULL
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- 8. Which department has the highest turnover rate?
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
SELECT 
    location_state, COUNT(*) AS NumberofEmp
FROM
    hr
WHERE
    age >= 18 AND termdate IS NULL
GROUP BY location_state
ORDER BY NumberofEmp DESC;

-- 10. How has the company's employee count changed over time based on hire and term dates?
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
SELECT
	department,
    ROUND(AVG(DATEDIFF(termdate, hire_date) / 365),1) AS AvgTenureofEmp
FROM hr
WHERE
    age >= 18 AND termdate IS NOT NULL AND termdate <= CURDATE()
GROUP BY department;
