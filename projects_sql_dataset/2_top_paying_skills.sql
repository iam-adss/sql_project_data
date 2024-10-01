/* In this instance I will show the top 10 skills required for top paying Data Scientist roles
Question:

1.What skills are required for the top paying Data Scientist jobs from first query?
2. Add specific skills required for these roles
3. Why? - To provide a detailed look at which high paying jobs demand certain skills,
and to help job seekers understand which skills to develop that align with top salary*/


WITH top_paying_jobs AS (
    SELECT 
        job_id,
        company_dim.name AS name,
        salary_year_avg AS salary,
        job_title
        
    FROM
        job_postings_fact

    LEFT JOIN 
        company_dim ON job_postings_fact.company_id = company_dim.company_id

    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND 
        job_location = 'Anywhere'

    ORDER BY
        Salary DESC

    LIMIT 15
    )

    SELECT top_paying_jobs.*,
           skills
    FROM top_paying_jobs

    INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

    ORDER BY
    Salary DESC
    
    ;






