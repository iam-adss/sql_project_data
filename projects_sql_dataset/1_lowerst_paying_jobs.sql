/* 
Here we have a list of top 10 lowest paying Data Analyst jobs per country

1. Identify the country that offers data analyst roles

2. Then obtain the average by using salary_year_avg

3. LIMIT 10 rows of data 

4. Make sure to issue a ORDER BY 
*/


SELECT 
    AVG(salary_year_avg) AS salary,
    job_country AS country_name
   
    FROM job_postings_fact

    WHERE 
        job_title_short = 'Data Analyst'
    
    GROUP BY country_name
    
    ORDER BY salary
    
    LIMIT 10  ;