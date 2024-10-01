/* 
Question: What are the top 15 paying Data Scientist jobs? 
- No Null values to focus on postings where salaries are available 
- Identify the top 15 paying jobs that are remote
- Why? to offer insights as a Data analyst 
*/

SELECT 
    job_id,
    company_dim.name AS name,
    salary_year_avg AS salary,
    job_title,
    job_location,
    job_schedule_type,
    job_posted_date
    

FROM
    job_postings_fact

LEFT JOIN 
    company_dim ON job_postings_fact.company_id = company_dim.company_id

WHERE
    job_title_short = 'Data Scientist' AND
    salary_year_avg IS NOT NULL AND 
    job_location = 'Anywhere'

ORDER BY
    Salary DESC

LIMIT 15
    ;
