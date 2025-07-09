/*Top paying data analyst skills in the market*/
with top_paying_job AS (
SELECT 
    job_title,
    salary_year_avg,
    job_id,
    job_location,
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
)

SELECT 
    top_paying_job.*,
    skills_dim.skills
FROM
    top_paying_job
INNER JOIN skills_job_dim AS skill_id
ON skill_id.job_id=top_paying_job.job_id
INNER JOIN skills_dim 
ON skills_dim.skill_id=skill_id.skill_id
ORDER BY
    salary_year_avg DESC

/*
Most Common Skills: SQL, Python, Tableau, and R are the most in-demand for data analyst roles.

Highest Paying Skills: Technologies like Databricks, Jupyter, Pyspark, and PowerPoint (yes, surprisingly) are linked to the highest average salaries.

Cloud Tools Matter: AWS, Azure, and Snowflake all appear in both high-salary and high-frequency lists.

Visualization & Reporting Tools: Power BI, Tableau, and Excel remain essential.*/