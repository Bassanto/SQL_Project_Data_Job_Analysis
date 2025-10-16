# Introduction
  Dive into the data job market! Focusing on data analystg roles, this project explores top-paying job, in-demand skills, and where high demand meets high salary in data analystics.

  SQL queries? Check them out here: [2_project_sql](/2_project_sql/)
# Background
Driven by a quest to navigate the data analyst job market more efficently, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others to find optimal jobs.

### The questions l wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs.
3. What skills are most in demand in data for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I used
For my deep dive into the data analyst market, i harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL**: The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git and Github:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.
# The Analysis
Each query for this analysis aimed at investigating specific aspect of the data analyst job market. Here's how i approached the question:

### 1. Top paying Data Analsyt Jobs
To identify the highest- paying roles, I filtered data analsyts positions by average yearly salary and location,focusing on remote jobs. This query highlights the high paying opportunities in the field.
~~~sql
SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL 
ORDER BY salary_year_avg DESC 
LIMIT 10
~~~
Here's the breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000 indicating significant salary potential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta ,and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a  high diversity in job titles, from Data Analyst to Director of Analsytics, reflecting varied roles and specializations within data analytics.
# What I learned
Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- **Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clause for nija-level temp table manueuvers.
- **Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT( ) and AVG( ) into my data summarizing sidekicks.
- **Analytical Wizardry:** Leveled up my real-word puzzle-solving skills,turning questions into actionable, insigtful SQL queries.
# Conclusion 

### Insights
From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest-paying job for data analyst that allows remote work offer a wide range of salaries, the hoghest at $650,000.
2. **Skills for Top-Paying Jobs**: High-paying data analyst job require advanced proficiency in SQL, suggesting it's a critical skill for earning a top salary.
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market,thus making it essential for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, such as SVN and solidarity, are associated with the highest salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as onr of the most optimal skills for data analysts for learn to maximize their market value.

### Closing Thoughts 

This prpject enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysts serve as a search efforts.Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continous learning and adptation to emerging trends in the field of data analystics
