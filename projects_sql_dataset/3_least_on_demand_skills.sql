/* Least In demand skills that are most frequently looked for in job postings 

- Join job postings to inner join table similar to query 2
- Identify the top 10 least in-demand skills.
- Focus on all job postings.
- Why? Retrieves the top 10 skills with the lowest demand in the job market, 
    providing insights into the least valuable skills for job seekers.

*/

SELECT
  skills_dim.skills,
  COUNT(skills_job_dim.job_id) AS demand_count

FROM
  job_postings_fact

  INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
  INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id


	
GROUP BY
  skills_dim.skills

  ORDER BY
  demand_count
LIMIT 10;


