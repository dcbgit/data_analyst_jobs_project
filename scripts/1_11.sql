SELECT Count(*) FROM data_analyst_jobs;
-- 1793

SELECT * FROM data_analyst_jobs LIMIT 10;
-- ExxonMobil

SELECT COUNT(title) FROM data_analyst_jobs WHERE location = 'TN';
-- 21 
SELECT COUNT(title) FROM data_analyst_jobs WHERE (location = 'TN' OR location = 'KY');
-- 27

SELECT COUNT(title) FROM data_analyst_jobs WHERE location = 'TN' AND star_rating > 4;
--3

SELECT COUNT(review_count) FROM data_analyst_jobs WHERE review_count BETWEEN 500 AND 1000;
-- 151

SELECT AVG(star_rating) AS avg_rating, location AS state 
FROM data_analyst_jobs 
WHERE (location IS NOT NULL AND star_rating IS NOT NULL)
GROUP BY location ORDER BY avg_rating DESC; 
-- NE

SELECT COUNT (DISTINCT title) FROM data_analyst_jobs;
--881

SELECT COUNT (DISTINCT title) FROM data_analyst_jobs WHERE location = 'CA';
-- 230

SELECT AVG(star_rating) AS avg_star, company, location
FROM data_analyst_jobs 
WHERE review_count > 5000 
AND (company IS NOT NULL AND location IS NOT NULL) 
GROUP BY company, location;
-- 79

SELECT COUNT(company) FROM data_analyst_jobs WHERE review_count > 5000;
-- 184

SELECT AVG(star_rating) AS avg_star, company, location
FROM data_analyst_jobs 
WHERE review_count > 5000
GROUP BY company, location ORDER BY avg_star DESC;

/* "Kaiser Permanente"
"General Motors"
"American Express"
"Microsoft"
"American Express"
"American Express"
"Kaiser Permanente"
"Unilever"
"Nike" 
4.199999809 */

SELECT DISTINCT title
FROM data_analyst_jobs 
WHERE title LIKE '%Analyst' OR title LIKE 'Analyst%' 
OR title LIKE '%Analyst%';
-- 754

SELECT DISTINCT title
FROM data_analyst_jobs
WHERE title NOT LIKE '%Analyst' AND title NOT LIKE 'Analyst%';
--
SELECT title
FROM data_analyst_jobs
WHERE (title NOT LIKE '%Analyst%' 
	   AND title NOT LIKE '%ANALYST%' 
	   AND title NOT LIKE '%analyst%'
	   AND title NOT LIKE '%analysts%'
	   AND title NOT LIKE '%Analytics%'
	  AND title NOT LIKE '%ANALYTICS%'
	  AND title NOT LIKE '%analytics%');

