## Introduction
💡 Dive into this repository  where I showcase the current job market and my specific findings from the dataset provided which details the current job market. In the following query I will provide my findings along a the visualization

🔎 For the SQL queries check them out here 
- [project_sql_dataset folder](/projects_sql_dataset/)

## Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid, in-demand skills and some of the lowest paying jobs, streamlining others work to find optimal jobs.


📉 - 10 Lowest paying Data Analyst jobs per country

💰 - Top Paying Companies For Data Scientist Jobs

👻 - Least Demanded Skills 

😎 - Top Paying Skills

📅 - Extracting Data Scientist Roles Posting From The Philippines

## Tools I Used

For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

## The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst/data scientist job market. Here’s how I approached each question:


### 1. Top 10 Lowest Paying Data Analyst Roles Per Country
In order to identify the lowest paying jobs per country I have to obtain the AVG salary and initiate a GROUP BY as the AVG is an aggrigate function and will need a group by. Then following then follows

1. Identify the country that offers data analyst roles

2. Then obtain the average by using salary_year_avg

3. LIMIT 10 rows of data 

4. Make sure to issue a ORDER BY 


```sql
SELECT 
    AVG(salary_year_avg) AS salary,
    job_country AS country_name
   
    FROM 
        job_postings_fact

    WHERE 
        job_title_short = 'Data Analyst'

    GROUP BY 
        country_name

    ORDER BY 
        salary

    LIMIT 10;
```


![Top 10 Lowest Paying Country](/images/1_top_10_lowest_paying.png)


*This bar graph shows the 'Top 10 Lowest Paying Data Analyst Roles Per Country' where the lowest seems to be Algeria with a value of $44100 and China with the highest of $68590*

![Map Graph ](/images/salary_by_country_map_chart.png)
*A map graph visualization of the same data pull from above.*




### 2. Top Highest Paying Companies For Data Scientist Jobs 
In this instance I identified the highest paying roles for Data Scientist roles along with the companies that are posting them this would help job seekers identify the roles and companies that are seeking for new hires. 

1. Identify at the WHERE function that this is specific to 'Data Scientist' roles only

2. To narrow the search I strictly excluded NULL values from the query

3. Conduct a LEFT JOIN to the company_dim table as it consist the list of the companies. This is doable with the job postings table as they have a relation with company_id

4. Identify the salary average range


```sql
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

LIMIT 10
    ;

```

![Highest Paying Companies](/images/highest_paying_companies.png)



*Here we have an example of an Area Chart to explain the highest salary thats being paid out for Data Scientist roles by companies. We have Selby Jennings offering $550,000 and Walmart with lowest of $300,000*

### 3. Least On Demand Skill 
In this question I will identify the least demanded skill or the least wanted skill based on the data set that I was working on. To achieve this objective I conducted the following

1.Identify the top 10 least in-demand skills.

2.Focus on all job postings


3.Why? Retrieves the top 10 skills with the lowest demand in the job market,  providing insights into the least valuable skills for job seekers.

4. Inner join all 3 tables as the skill table is in relation of company table and the company table is in relation to job postings table.


``` sql
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
```

### Least Demanded Skills



![Least Demanded Skills](images\least_demand.PNG)



*Here is the list of the least wanted skills by according to this Data. I could only obtain the skill list by joining all 3 tables together with INNER JOIN. Then the identifying part was simple by conducting an ORDER BY of the demand count. Lowest would be the count of 1 and highest in the list is 3*

### 4. Top 10 Highest Paying Skills Per Company For Data Scientist Roles 
In this question I identified the highest paying companies according to skills of a Data Scientist just like the previous questions before where I identified the highest paying company but this time in accordance to the skills. 

```sql
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
        job_title_short = 'Data Scientist' AND
        salary_year_avg IS NOT NULL AND 
        job_location = 'Anywhere'

    ORDER BY
        Salary DESC

    LIMIT 10
    )

    SELECT top_paying_jobs.*,
           skills
    FROM top_paying_jobs

    INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

    ORDER BY
    Salary DESC

    LIMIT 10
    
    ;
```


![Highest Paying Skill Per Company](images\skill_highest_pay.png)



*The most sought out skill for Data Scientist seems to be SQL and Python and there are only 2 companies that are willing to pay top dollar for those skills Selby Jennings and Algo Capital Group*

### 5.Extracting Data Scientist Job Postings In The Philippines
This is a very specific query for me as I was curious to see how many Data Scientist roles were posted within the year in the Philippines

1. Since I are using Month Date and Year, I will identify this by using the EXTRACT function to filter down the specific job roles that Im looking for

2. Identify the Data Scientist roles 

3. Within the year (how ever old this data set is)
``` sql
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
```


![Data Scientist Roles postings within the year](images\philippines_job_postings.PNG)




*As shown above only 3 postings occured within the year its 2 in November 2023 and 1 in January 2023** 



## What I Learned

Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- **🧩 Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
- **📊 Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- **💡 Analytical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

## Conclusion 

From the analysis, several general insights emerged:

1. Even a considered 'Low' amount for a salary on the listed countries it was more then enough for someone to live off

2. I found that companies are willing to offset so much for a Data Scientist, given the role is very demanding I figure that companies would be willing to pay high salaries

3. Least demanded skills came to me as a shock because I always wondered what the data set would entail if I requested this query. Majority of these skills I never even heard of.

4. Top paying skills taught me that SQL and Python go hand in hand really well and its a very useful tool due to its flexibility and wide reach of data extraction. 

5. Just a fun question that I had if Data Scientist roles did exist in a specific country like the Philippines. And to my shock once again this data set has it. 


## Closing Thought

This project has been very amazing and fun I never had this much fun into researching a new language let alone building a project off it. Im very determined that I will keep learning and build projects to further my learning as a Data Analyst no tool will remain unturned !

Amazing insight 

Thank you for following my README