/*
-In this question I will extract a job posting for 'Data Scientist' roles in the Philippines
-My main goal is to find the month and year it was posted 
-Also to identify the Salary provided for each job postings

*/
SELECT
	job_title_short,
    salary_year_avg,
	job_location,
	EXTRACT(MONTH FROM job_posted_date) AS job_posted_month,
	EXTRACT(YEAR FROM job_posted_date) AS job_posted_year
FROM
	job_postings_fact

WHERE job_title_short = 'Data Scientist'
AND
job_location = 'Philippines'
AND
salary_year_avg IS NOT NULL

LIMIT 10
;

