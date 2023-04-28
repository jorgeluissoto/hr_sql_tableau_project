 -- Data Analysis
 SELECT *
 FROM hr;
 
 -- What is the gender breakdown of employees in the company?
SELECT gender, COUNT(gender) AS GenderCount
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY gender;
 
 -- What is the race/ ethinicity breakdown of employees in the company?
 SELECT race, COUNT(race) AS RaceCount
 FROM hr
 WHERE age >= 18 AND termdate IS NULL
 GROUP BY race
 ORDER BY RaceCount DESC;
 
 -- What is the age distribution of employees in the company? 