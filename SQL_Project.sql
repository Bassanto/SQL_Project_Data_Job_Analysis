SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST'  AS date_time ,
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    EXTRACT (YEAR FROM job_posted_date) AS date_year
FROM 
    job_postings_fact
LIMIT 5;



SELECT 
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS month 
FROM
   job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY month
ORDER BY job_posted_count DESC;


SELECT 
    job_title_short AS title,
   -- EXTRACT(MONTH FROM job_posted_date) BETWEEN 6 AND 12 AS month,
    AVG(salary_year_avg) AS salary_year_avg
FROM 
    job_postings_fact
WHERE 
    EXTRACT(MONTH FROM job_posted_date)BETWEEN 6 AND 12
    AND EXTRACT(YEAR FROM job_posted_date) = 2023
    AND salary_year_avg IS NOT NULL 
GROUP BY 
    title
ORDER BY 
    salary_year_avg DESC;

CREATE TABLE january_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;


CREATE TABLE feburary_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;


CREATE TABLE march_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;


SELECT job_posted_date
FROM march_jobs;

SELECT COUNT(job_id) AS job_count,
job_posted_date :: DATE AS date
FROM job_postings_fact
-- WHERE job_title_short = 'Data Analyst'
GROUP BY date,job_posted_date
ORDER BY date
;

SELECT 
    job_title_short,
    job_location,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact;

WITH january_job AS (
 SELECT *
 FROM job_postings_fact
 WHERE EXTRACT (MONTH FROM job_posted_date) = 1
)

 SELECT *
 FROM january_job;


 SELECT
    company_id,
    name AS company_name
 FROM 
    company_dim
 WHERE company_id IN (
    SELECT 
            company_id
    FROM 
            job_postings_fact
    WHERE 
        job_no_degree_mention = true
    ORDER BY 
        company_id
 )
;


WITH company_job_count AS (
SELECT
        company_id,
        count(*) AS total_jobs
FROM
        job_postings_fact
GROUP BY
        company_id
)

SELECT company_dim.name AS company_name,
company_job_count.total_jobs
 FROM company_dim
 LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
;

 SELECT name
 FROM company_dim
 LEFT JOIN company_job_count 
;

 
WITH company_job_counts AS (
SELECT
        company_id,
        count(*) AS total_jobs
FROM
        job_postings_fact
GROUP BY
        company_id
)

SELECT company_dim.name AS company_name,
        company_job_counts.total_jobs
FROM company_dim
LEFT JOIN company_job_counts ON company_job_counts.company_id = company_dim.company_id
ORDER BY 
        total_jobs  DESC
;


WITH remote_job_skills AS (
    SELECT 
        skill_id,
        count(*) AS skill_count
       -- job_postings.job_work_from_home
    FROM skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE job_postings.job_work_from_home = true AND 
            job_postings.job_title_short = 'Data Analyst'
    GROUP BY skill_id
   -- ORDER BY job_postings.job_id
)

SELECT
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY skill_count DESC
LIMIT 5;

SELECT 
    job_title_short,
    company_id,
    job_location
FROM 
    january_jobs

UNION 

SELECT 
    job_title_short,
    company_id,
    job_location
FROM 
    feburary_jobs

UNION 

SELECT 
    job_title_short,
    company_id,
    job_location
FROM 
    march_jobs;


SELECT 
    job_title_short,
    company_id,
    job_location
FROM 
    january_jobs

UNION ALL

SELECT 
    job_title_short,
    company_id,
    job_location
FROM 
    feburary_jobs

UNION ALL

SELECT 
    job_title_short,
    company_id,
    job_location
FROM 
    march_jobs;

SELECT 
    quarter1_job_postings.job_title_short,
    quarter1_job_postings.job_location,
    quarter1_job_postings.job_via,
    quarter1_job_postings.job_posted_date::DATE,
    quarter1_job_postings.salary_year_avg
FROM (
        SELECT *
        FROM january_jobs
        UNION ALL 
        SELECT*
        FROM feburary_jobs
        UNION ALL
        SELECT *
        FROM march_jobs
) AS quarter1_job_postings
WHERE 
 quarter1_job_postings.salary_year_avg > 70000 AND
 quarter1_job_postings.job_title_short = 'Data Analyst'
ORDER BY quarter1_job_postings.salary_year_avg DESC