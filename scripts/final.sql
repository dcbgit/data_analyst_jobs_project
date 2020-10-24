--1.	How many rows are in the data_analyst_jobs table?
SELECT Count(*) FROM data_analyst_jobs;
-- 1793

--2.	Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
SELECT * FROM data_analyst_jobs LIMIT 10;
-- ExxonMobil

--3.	How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
SELECT COUNT(title) FROM data_analyst_jobs WHERE location = 'TN';
-- 21 

/*
SELECT COUNT(*) 
FROM data_analyst_jobs 
WHERE location IN ('TN');

SELECT location, COUNT(title)
FROM data_analyst_jobs 
WHERE location = 'TN' OR location = 'KY';
GROUP BY location;

*/
--3. 	How many are there in either Tennessee or Kentucky?
SELECT COUNT(title) FROM data_analyst_jobs WHERE (location = 'TN' OR location = 'KY');
-- 27

--4.	How many postings in Tennessee have a star rating above 4?
SELECT COUNT(title) 
FROM data_analyst_jobs 
WHERE location = 'TN' 
AND star_rating > 4;
--3

--5.	How many postings in the dataset have a review count between 500 and 1000?
SELECT COUNT(review_count) 
FROM data_analyst_jobs 
WHERE review_count 
BETWEEN 500 AND 1000;
-- 151
-- Can also use SELECT COUNT(*) 
/*
6.	Show the average star rating for companies in each state. 
The output should show the state as `state` and the average rating for the state as `avg_rating`. 
Which state shows the highest average rating?
*/

SELECT AVG(star_rating) AS avg_rating, location AS state 
FROM data_analyst_jobs 
WHERE (location IS NOT NULL AND star_rating IS NOT NULL)
GROUP BY location 
ORDER BY avg_rating DESC; 
-- NE

--7.	Select unique job titles from the data_analyst_jobs table. How many are there?
SELECT COUNT (DISTINCT title) 
FROM data_analyst_jobs;
--881

--8.	How many unique job titles are there for California companies?
SELECT COUNT (DISTINCT title) 
FROM data_analyst_jobs 
WHERE location = 'CA';
-- 230

/*
9.	Find the name of each company and its average star rating 
for all companies that have more than 5000 reviews across all locations. 
How many companies are there with more that 5000 reviews across all locations?
*/

SELECT AVG(star_rating) AS avg_star, company
FROM data_analyst_jobs 
WHERE review_count > 5000 
AND (company IS NOT NULL AND location IS NOT NULL) 
GROUP BY company;
-- 40
/*
from dj:
SELECT company,round(avg(star_rating),2) as star_rating,sum(review_count)as review_count
NOTE: the "2" represents 2 decimal places
FROM data_analyst_jobs
  GROUP BY company
 HAVING sum(review_count)>5000
 ORDER BY star_rating desc;
*/

/*
10.	Add the code to order the query in #9 from highest to lowest 
average star rating. Which company with more than 5000 reviews across 
all locations in the dataset has the highest star rating? 
What is that rating?
*/

SELECT AVG(star_rating) AS avg_star,company
FROM data_analyst_jobs 
WHERE review_count > 5000
GROUP BY company
ORDER BY avg_star DESC;

/* 
"General Motors"
"Unilever"
"Microsoft"
"Nike"
"American Express"
"Kaiser Permanente"
4.199999809 */

/*
11.	Find all the job titles that contain the word ‘Analyst’. 
How many different job titles are there? 
*/

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs 
WHERE LOWER(title) LIKE '%analyst%';
-- 774
-- ILIKE will also yeild the same results
/*
12.	How many different job titles do not contain either the 
word ‘Analyst’ or the word ‘Analytics’? 
What word do these positions have in common?
*/

SELECT title
FROM data_analyst_jobs
WHERE (title NOT LIKE '%Analyst%' 
	  AND title NOT LIKE '%ANALYST%' 
	  AND title NOT LIKE '%analyst%'
	  AND title NOT LIKE '%analysts%'
	  AND title NOT LIKE '%Analytics%'
	  AND title NOT LIKE '%ANALYTICS%'
	  AND title NOT LIKE '%analytics%');

/*
SELECT title
FROM data_analyst_jobs
WHERE LOWER (title) NOT LIKE '%analy%'

-- Tableau
*/

/*
***BONUS:**
You want to understand which jobs requiring SQL are hard to fill. 
Find the number of jobs by industry (domain) that require SQL 
and have been posted longer than 3 weeks. 
 - Disregard any postings where the domain is NULL. 
 - Order your results so that the domain with the greatest number of `hard to fill` 
 jobs is at the top. 
  - Which three industries are in the top 4 on this list? 
  How many jobs have been listed for more than 3 weeks for each of the top 4?
  */
  
SELECT COUNT(*) AS jobs, domain AS industry
FROM data_analyst_jobs
WHERE skill LIKE '%SQL%'
AND days_since_posting > 21
AND domain is NOT NULL
GROUP BY industry
ORDER BY jobs DESC;

/*
"Internet and Software" - 62
"Banks and Financial Services" - 61
"Consulting and Business Services" - 57
"Health Care" - 52

Mahaesh's solution:
SELECT domain, COUNT(title) AS job_count
FROM data_analyst_jobs
WHERE UPPER(skill) LIKE '%SQL%'
AND days_since_posting > 21
AND domain IS NOT NULL
GROUP BY domain
ORDER BY job_count DESC
LIMIT 4;

*/