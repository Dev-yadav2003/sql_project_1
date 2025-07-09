# Introduction

In today’s data-driven job market, understanding the dynamics of roles, required skills, and compensation is critical for aspiring and current data analysts. This project uses SQL to explore job posting data and answer key questions around **salary trends** and **in-demand skills** in the field of data analytics.

# Background

In today's data-centric world, organizations across industries are hiring Data Analysts to turn raw data into actionable insights. However, the job market is highly dynamic—salary levels and skill requirements vary significantly depending on industry trends, location, and technological adoption.

This project was created to explore those questions using real-world job data. By querying job postings with SQL, I aimed to uncover patterns in salary, demand, and skill relevance to help guide data professionals—whether beginners or experienced analysts—toward smarter skill development.

## The goal of the project is to:

- Identify **top-paying Data Analyst roles**
- Uncover which **skills are associated with those roles**
- Determine the **most in-demand skills** across the industry
- Analyze which skills **command higher salaries**
- Recommend the **most optimal skills to learn** for maximizing career growth

# 🛠️ Tools I Used

- **SQL (PostgreSQL)** – Used to write queries and extract meaningful insights from the job and skill datasets.
- **VS Code** – My code editor for writing and organizing SQL scripts efficiently.
- **Git & GitHub** – For version control, collaboration, and hosting the project online.

# The Analysis

Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

### 1. 💰 Top Paying Data Analyst Jobs

This query retrieves the **top 10 highest-paying remote Data Analyst jobs** from the dataset. It filters job postings with non-null salary data, limits results to roles labeled “Data Analyst,” and only considers **remote positions** (where `job_location = 'Anywhere'`).

#### ✅ SQL Query Used:

```sql
SELECT
    job_title,
    salary_year_avg,
    job_location,
    job_posted_date::DATE,
    name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim
    ON company_dim.company_id = job_postings_fact.company_id
WHERE
    salary_year_avg IS NOT NULL AND
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere'
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```

## 🔍 Insights

From the analysis, several general insights emerged:

1. **💸 Top-Paying Data Analyst Jobs**  
   Remote data analyst jobs offer a wide salary range, with the highest reaching **$650,000**, highlighting the lucrative potential in remote tech roles.

2. **🧠 Skills for Top-Paying Jobs**  
   Jobs that pay the most consistently require advanced proficiency in **SQL**, establishing it as a critical skill for earning top-tier salaries.

3. **📈 Most In-Demand Skill**  
   **SQL** stands out not only for salary potential but also for its demand across job listings, making it an essential skill for aspiring data analysts.

4. **💼 Skills with Higher Salaries**  
   Specialized technologies like **SVN** and **Solidity** are linked to higher average salaries, showing that niche technical expertise is highly valued in the job market.

5. **🏆 Optimal Skill for Market Value**  
   Among all analyzed skills, **SQL** strikes the best balance between demand and compensation, making it the most strategic skill to master for maximizing job market value.

![Top Paying Data Analyst Jobs](/assets/top_paying_data_analyst_jobs_2023.png)

# 2.💼 Top-Paying Data Analyst Skills

This project explores the **highest-paying skills** required in remote data analyst job postings using SQL queries on job datasets. It identifies which skills are most frequently demanded and which ones offer the highest salary potential.

---

## 🧠 Objective

To determine which **skills** are:

- Most common among top-paying data analyst jobs
- Associated with the highest average salaries
- Critical to securing lucrative remote opportunities

---

## 🧾 SQL Query

```sql

WITH top_paying_job AS (
  SELECT
      job_title,
      salary_year_avg,
      job_id,
      job_location,
      name AS company_name
  FROM job_postings_fact
  LEFT JOIN company_dim
      ON company_dim.company_id = job_postings_fact.company_id
  WHERE
      salary_year_avg IS NOT NULL AND
      job_title_short = 'Data Analyst' AND
      job_location = 'Anywhere'
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
    ON skill_id.job_id = top_paying_job.job_id
INNER JOIN skills_dim
    ON skills_dim.skill_id = skill_id.skill_id
ORDER BY
    salary_year_avg DESC;
```

![Average Salary by Skill](/assets/top_paying_skills%20_avg_salary.png)

## 📌 3. In-Demand Skills for Data Analysts

This section identifies the most in-demand skills for **remote Data Analyst** positions based on frequency across job listings.

---

### 🧾 SQL Query

```sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact

INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id

INNER JOIN skills_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id

WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE

GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```

### 📈 Top 5 In-Demand Skills for Remote Data Analyst Roles

| 🔢 Rank | 🛠️ Skill | 📊 Demand Count |
| ------: | -------- | --------------: |
|       1 | SQL      |           7,291 |
|       2 | Excel    |           4,611 |
|       3 | Python   |           4,330 |
|       4 | Tableau  |           3,745 |
|       5 | Power BI |           2,609 |

> 💡 **Insight**: SQL leads as the most in-demand skill by a large margin. Excel and Python remain fundamental, while Tableau and Power BI dominate in visualization and reporting.

## 4.💰 Skills Based on Salary

This section highlights the **top-paying skills** for Data Analysts by analyzing average salaries associated with each skill in job postings.

---

### 🧾 SQL Query

```sql
/* Top paying skills for Data Analyst */

SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS salary_avg
FROM job_postings_fact

INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id

INNER JOIN skills_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id

WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL

GROUP BY
    skills
ORDER BY
    salary_avg DESC
LIMIT 15;
```

### 💼 Top 15 Highest Paying Skills for Data Analysts

| 🔢 Rank | 🛠️ Skill  | 💰 Avg Salary (USD) |
| ------: | --------- | ------------------: |
|       1 | SVN       |            $400,000 |
|       2 | Solidity  |            $179,000 |
|       3 | Couchbase |            $160,515 |
|       4 | DataRobot |            $155,486 |
|       5 | Golang    |            $155,000 |
|       6 | MXNet     |            $149,000 |
|       7 | dplyr     |            $147,633 |
|       8 | VMware    |            $147,500 |
|       9 | Terraform |            $146,734 |
|      10 | Twilio    |            $138,500 |
|      11 | GitLab    |            $134,126 |
|      12 | Kafka     |            $129,999 |
|      13 | Puppet    |            $129,820 |
|      14 | Keras     |            $127,013 |
|      15 | PyTorch   |            $125,226 |

> 💡 **Insight**: High-paying skills tend to be more specialized and technical, often tied to **cloud computing**, **DevOps**, and **machine learning** frameworks.

## 5. 🚀 Most Optimal Skills to Learn

This analysis identifies the **most optimal skills** for Data Analysts based on two critical factors:

1. 📈 **High Average Salary**
2. 📊 **Strong Market Demand**

These are the best-value skills for job seekers aiming to **maximize their marketability and income**.

---

### 🧾 SQL Query

```sql
SELECT
  skills,
  COUNT(skills_job_dim.job_id) AS demand_count,
  ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact

INNER JOIN skills_job_dim
  ON job_postings_fact.job_id = skills_job_dim.job_id

INNER JOIN skills_dim
  ON skills_dim.skill_id = skills_job_dim.skill_id

WHERE job_title_short = 'Data Analyst'
  AND job_work_from_home = TRUE
  AND salary_year_avg IS NOT NULL

GROUP BY skills
HAVING COUNT(skills_job_dim.job_id) > 15
ORDER BY
  avg_salary DESC,
  demand_count DESC
LIMIT 15;
```

### 🧠 Top 15 Most Optimal Skills to Learn (High Salary + High Demand)

| 🔢 Rank | 🛠️ Skill   | 💰 Avg Salary (USD) | 📊 Demand Count |
| ------: | ---------- | ------------------: | --------------: |
|       1 | Go         |            $115,320 |              27 |
|       2 | Hadoop     |            $113,193 |              22 |
|       3 | Snowflake  |            $112,948 |              37 |
|       4 | Azure      |            $111,225 |              34 |
|       5 | AWS        |            $108,317 |              32 |
|       6 | Java       |            $106,906 |              17 |
|       7 | Jira       |            $104,918 |              20 |
|       8 | Oracle     |            $104,534 |              37 |
|       9 | Looker     |            $103,795 |              49 |
|      10 | Python     |            $101,397 |             236 |
|      11 | R          |            $100,499 |             148 |
|      12 | Redshift   |             $99,936 |              16 |
|      13 | Tableau    |             $99,288 |             230 |
|      14 | SAS        |             $98,902 |             126 |
|      15 | SQL Server |             $97,786 |              35 |

> 💡 **Insight**: Tools like **Go**, **Snowflake**, and **Azure** are high-paying emerging skills, while staples like **Python**, **R**, and **Tableau** offer the best blend of salary and job opportunities.

## 📚 What I Learned

Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- 🧩 **Complex Query Crafting**  
  Mastered the art of advanced SQL — merging tables like a pro, and wielding `WITH` clauses for ninja-level temp table maneuvers.

- 📊 **Data Aggregation**  
  Got cozy with `GROUP BY` and turned aggregate functions like `COUNT()` and `AVG()` into my data-summarizing sidekicks.

- 💡 **Analytical Wizardry**  
  Leveled up my real-world puzzle-solving skills — transforming ambiguous questions into clear, actionable, and insightful SQL queries.

> 🛠️ This project sharpened both my **technical SQL abilities** and my **data storytelling mindset**, preparing me to solve real business problems with confidence.

# Conclusions

## 📈 Insights

From the analysis, several key takeaways emerged:

- 💼 **Top-Paying Data Analyst Jobs**  
  Remote-friendly data analyst roles can reach **salaries as high as $650,000**, especially in leadership or niche positions.

- 🧠 **Skills for Top-Paying Jobs**  
  High-paying jobs consistently demand advanced **SQL** skills — making it a non-negotiable for maximizing income.

- 🔥 **Most In-Demand Skills**  
  **SQL** tops the list of most frequently required skills across job listings, solidifying its place as a foundational tool for analysts.

- 💸 **Skills with Higher Salaries**  
  Specialized skills like **SVN** and **Solidity** command **premium average salaries**, reflecting demand for niche expertise.

- 🎯 **Optimal Skills for Market Value**  
  **SQL** offers the rare combination of **high demand** and **strong average salary**, making it the **most optimal skill** for aspiring data analysts to learn.

> 🧭 **Conclusion**: To stand out in the job market and unlock top-paying roles, focus on mastering core skills like SQL, while exploring high-value niches in cloud, DevOps, and AI.

### Closing Thoughts

This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.

```

```
