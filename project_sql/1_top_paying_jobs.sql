/* Top 10 high paying remote data analyst jobs */

SELECT 
    job_title,
    salary_year_avg,
    job_location,
    job_posted_date::DATE,
    name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim
    on company_dim.company_id=job_postings_fact.company_id
WHERE 
    salary_year_avg IS NOT NULL AND 
    job_title_short = 'Data Analyst' AND 
    job_location ='Anywhere'
ORDER BY
    salary_year_avg DESC
LIMIT 10


