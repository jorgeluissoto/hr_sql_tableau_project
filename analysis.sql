-- Data Analysis
 SELECT *
 FROM hr;
 
-- 1. What is the gender breakdown of employees in the company?
SELECT gender, COUNT(gender) AS GenderCount
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY gender;
 
-- 2. What is the race/ ethinicity breakdown of employees in the company?
 SELECT race, COUNT(race) AS RaceCount
 FROM hr
 WHERE age >= 18 AND termdate IS NULL
 GROUP BY race
 ORDER BY RaceCount DESC;
 
-- 3. What is the age distribution of employees in the company?
-- First find the youngest and oldest age
SELECT MIN(age) AS youngest, MAX(age) AS oldest
FROM hr
WHERE age >= 18 AND termdate IS NULL;

SELECT 
	SUM(IF(age BETWEEN 18 and 24,1,0)) AS '20 - 25',
    SUM(IF(age BETWEEN 25 and 34,1,0)) AS '26 - 29',
    SUM(IF(age BETWEEN 35 and 44,1,0)) AS '30 - 35',
    SUM(IF(age BETWEEN 45 and 54,1,0)) AS '36 - 39',
    SUM(IF(age BETWEEN 55 and 64,1,0)) AS '40 - 45',
    SUM(IF(age >= 65,1,0)) AS 'Over 65'
FROM hr
WHERE age >= 18 AND termdate IS NULL;

SELECT
	CASE
		WHEN age >= 18 AND age <= 24 THEN '18-24'
        WHEN age >= 25 AND age <= 34 THEN '25-34'
        WHEN age >= 35 AND age <= 44 THEN '35-44'
        WHEN age >= 45 AND age <= 54 THEN '45-54'
        WHEN age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
	END AS age_group,
    COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY age_group
ORDER BY age_group;

-- 4. How many employees work at headquarters versus remote locations?


-- 5. What is the average length of employment for employees who have been terminated?

-- 6. How does the gender distribution vary across departments and job titles?


-- 7. What is the distribution of job titles across the company?


-- 8. Which department has the highest turnover rate?


-- 9. What is the distribution of employees across locations by city and state?


-- 10. How has the company's employee count changed over time based on hire and term dates?

-- 11. What is the tenure distribution for each department?