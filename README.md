<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:000428,100:004e92&height=220&section=header&text=🎬RSVP%20Movies%20SQL%20Analysis&fontSize=50&fontColor=ffffff"/>
</p>

<h2>🚀 Project Preview</h2>

<p align="center">
  <img src="https://github.com/user-attachments/assets/2ba95091-2c36-47c8-96ea-e9830ef9064c" 
       alt="RSVP Movies Logo" 
       width="100%" />
</p>

<hr>

<h2>📌 Project Overview</h2>

<p>
This project delivers a <b>comprehensive SQL-based analysis</b> of a global movie dataset to uncover deep insights into the film industry.
</p>

<ul>
  <li>🎥 Movie performance tracking</li>
  <li>⭐ Audience ratings & engagement analysis</li>
  <li>🌍 Country-wise production trends</li>
  <li>🎭 Genre-based insights</li>
  <li>🏢 Production house evaluation</li>
  <li>🎬 Actor & director ranking</li>
</ul>

<hr>

<h2>🎯 Business Objective</h2>

<ul>
  <li>Identify <b>top-performing movies and genres</b></li>
  <li>Analyze <b>audience behavior using ratings & votes</b></li>
  <li>Evaluate <b>production house success</b></li>
  <li>Discover <b>high-performing actors & directors</b></li>
  <li>Support <b>data-driven decisions</b></li>
</ul>

<hr>

<h2>🗂️ Database Structure</h2>

<table border="1" cellpadding="8" cellspacing="0">
  <tr>
    <th>Table</th>
    <th>Columns</th>
  </tr>

  <tr>
    <td>🎬 movie</td>
    <td>
      id (PK), title, year, date_published, duration, country, 
      worlwide_gross_income, languages, production_company
    </td>
  </tr>

  <tr>
    <td>⭐ ratings</td>
    <td>
      movie_id (PK), avg_rating, total_votes, median_rating
    </td>
  </tr>

  <tr>
    <td>🎭 genre</td>
    <td>
      movie_id (PK), genre (PK)
    </td>
  </tr>

  <tr>
    <td>👤 names</td>
    <td>
      id (PK), name, height, date_of_birth, known_for_movies
    </td>
  </tr>

  <tr>
    <td>🎥 director_mapping</td>
    <td>
      movie_id (PK), name_id (PK)
    </td>
  </tr>

  <tr>
    <td>🎭 role_mapping</td>
    <td>
      movie_id (PK), name_id (PK), category
    </td>
  </tr>

</table>
<hr>

## 🗺️ Entity Relationship Diagram (ERD)

<p align="center">
  <img width="956" height="586" alt="Screenshot 2026-04-16 142010" src="https://github.com/user-attachments/assets/fa2bb95f-42b4-4100-afcf-43276b9e5c63" />
</p>


<h2>🛠️ Tools & Technologies</h2>

<p>
<img src="https://img.shields.io/badge/SQL-MySQL-blue?style=for-the-badge&logo=mysql"/>
<img src="https://img.shields.io/badge/Data%20Analysis-Advanced-green?style=for-the-badge"/>
<img src="https://img.shields.io/badge/Database-Relational-orange?style=for-the-badge"/>
</p>

<hr>

<h2>🔍 Data Exploration</h2>

```sql
USE rsvp__movies_db;

SHOW TABLES;

SELECT * FROM movie;
SELECT * FROM ratings;
SELECT * FROM genre;
SELECT * FROM names;
```


## 🧹 Data Cleaning

```sql
Q1. Find the total number of rows in each table of the schema?
SELECT table_name,
table_rows
FROM information_schema.tables
WHERE table_schema = 'rsvp__movies_db';
```

```sql
Q2. Which columns in the movie table have null values?
SELECT 
SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END ) AS id_null,
SUM(CASE  WHEN title IS NULL THEN 1 ELSE 0 END) AS title_null,
SUM(CASE WHEN YEAR IS NULL THEN 1 ELSE 0 END) AS year_null,
SUM(CASE WHEN date_published IS NULL THEN 1 ELSE 0 END) AS date_pub_null,
SUM(CASE WHEN duration IS NULL THEN 1 ELSE 0 END) AS duration_null,
SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS country_null,
SUM(CASE WHEN worlwide_gross_income IS NULL THEN 1 ELSE 0 END) AS worlwide_gross_income_null,
SUM(CASE WHEN languages IS NULL THEN 1 ELSE 0 END) AS languages_null,
SUM(CASE WHEN production_company IS NULL THEN 1 ELSE 0 END) AS product_company_null
FROM movie;
```

## 📊 Business Questions & SQL Analysis

The following business questions were solved using SQL queries.

```sql
Q3. Find the total number of movies released each year? How does the trend look month wise? (Output expected)
SELECT MONTH(date_published) AS month , COUNT(*) AS total_no_movie
FROM movie
GROUP BY MONTH(date_published)
ORDER BY total_no_movie DESC ;
```

```sql
Q4. How many movies were produced in the USA or India in the year 2019??
SELECT COUNT(*) AS number_of_movies 
FROM movie
WHERE year=2019
AND (Country LIKE '%USA%' OR country LIKE '%India%');
```

```sql
Q5. Find the unique list of the genres present in the data set?

SELECT DISTINCT genre FROM genre;
```

```sql
Q6.Which genre had the highest number of movies produced overall?
SELECT genre, COUNT(*) AS highest_no_genre
FROM genre
GROUP BY genre
ORDER BY highest_no_genre DESC
LIMIT 1;
```

```sql
-- Q7. How many movies belong to only one genre?
WITH movie_summary AS (
SELECT movie_id, COUNT(*) AS no_of_genres
FROM genre
GROUP BY movie_id
HAVING COUNT(*)=1)
SELECT COUNT(movie_id) FROM movie_summary;
```

```sql
-- Q8.What is the average duration of movies in each genre? 
SELECT genre, AVG(duration) AS avg_duration 
FROM genre g
JOIN movie m ON g.movie_id=m.id
GROUP BY genre
ORDER BY avg_duration DESC;
```

```sql
-- Q9.What is the rank of the ‘thriller’ genre of movies among all the genres in terms of number of movies produced? 
WITH summary AS (
SELECT genre, COUNT(*) AS no_of_movies,
RANK() OVER(ORDER BY COUNT(*) DESC) AS genre_rank
FROM genre
GROUP BY genre)
SELECT * FROM summary
WHERE genre='Thriller';
```

```sql
-- Q10.  Find the minimum and maximum values in  each column of the ratings table except the movie_id column?
SELECT MIN(avg_rating) AS min_avg_rating,
MAX(avg_rating) AS max_avg_rating,
MIN(total_votes) AS min_total_votes,
MAX(total_votes) AS max_total_votes,
MIN(median_rating) AS min_median_rating,
MAX(median_rating) AS max_median_rating
FROM ratings;
```

```sql
-- Q11. Which are the top 10 movies based on average rating?
WITH movie_summary AS (
SELECT title, avg_rating, 
RANK() OVER(ORDER BY avg_rating DESC) AS movie_rank
FROM movie m 
JOIN ratings r ON m.id=r.movie_id)
SELECT * FROM movie_summary
WHERE movie_rank<=10;
```

```sql
-- Q12. Summarise the ratings table based on the movie counts by median ratings.
SELECT median_rating, COUNT(*) AS movie_count FROM ratings
GROUP BY median_rating
ORDER BY movie_count DESC;
```

```sql
-- Q13. Which production house has produced the most number of hit movies (average rating > 8)??
WITH prod_summary AS (
SELECT production_company, COUNT(m.id) AS movie_count,  
RANK() OVER(ORDER BY COUNT(m.id) DESC) AS prod_comp_rank
FROM movie m 
JOIN ratings r ON m.id=r.movie_id
WHERE avg_rating>8
AND production_company IS NOT NULL
GROUP BY production_company)
SELECT * FROM prod_summary
WHERE prod_comp_rank=1;
```

```sql
-- Q14. How many movies released in each genre during March 2017 in the USA had more than 1,000 votes?
SELECT genre, COUNT(m.id) AS movie_count FROM movie m
JOIN genre g ON m.id=g.movie_id
JOIN ratings r ON r.movie_id=m.id
WHERE (date_published BETWEEN '2017-03-01' AND '2017-03-31')
AND country LIKE '%USA%'
AND total_votes>1000
GROUP BY genre
ORDER BY movie_count DESC;
```

```sql
-- Q15. Find movies of each genre that start with the word ‘The’ and which have an average rating > 8?
SELECT title, avg_rating, genre  FROM movie m
JOIN genre g ON m.id=g.movie_id
JOIN ratings r ON r.movie_id=m.id
WHERE title LIKE 'The%'
AND avg_rating>8;
```

```sql
-- Q16. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?
SELECT COUNT(m.id) AS movie_count FROM movie m
JOIN ratings r ON r.movie_id=m.id
WHERE (date_published BETWEEN '2018-04-01' AND '2019-04-01')
AND median_rating=8;
```

```sql
-- Q17. Do German movies get more votes than Italian movies? 
WITH languages_summary AS (
SELECT languages, SUM(total_votes) AS total_votes FROM movie m
JOIN ratings r ON r.movie_id=m.id
WHERE languages LIKE '%German%'
UNION
SELECT languages, SUM(total_votes) AS total_votes FROM movie m
JOIN ratings r ON r.movie_id=m.id
WHERE languages LIKE '%Italian%'), final_summary AS (
SELECT * FROM languages_summary
ORDER BY total_votes DESC
LIMIT 1)
SELECT IF(languages LIKE 'German','Yes','No') AS final_result
FROM final_summary;
```

```sql
-- Q18. Which columns in the names table have null values??
SELECT
SUM( CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS name_id,
SUM( CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS name,
SUM( CASE WHEN height IS NULL THEN 1 ELSE 0 END) AS height,
SUM( CASE WHEN date_of_birth IS NULL THEN 1 ELSE 0 END) AS date_of_birth,
SUM( CASE WHEN known_for_movies IS NULL THEN 1 ELSE 0 END) AS known_for_movies
FROM names;
```

```sql
-- Q19. Who are the top three directors in the top three genres whose movies have an average rating > 8?
-- (Hint: The top three genres would have the most number of movies with an average rating > 8.)
WITH top_three_genres AS (
SELECT genre, COUNT(m.id) AS movie_count FROM movie m
JOIN ratings r ON r.movie_id=m.id
JOIN genre g ON m.id=g.movie_id
WHERE avg_rating>8
GROUP BY genre
ORDER BY movie_count DESC
LIMIT 3), director_summary AS (
SELECT n.name, COUNT(m.id) AS movie_count, 
RANK() OVER(ORDER BY COUNT(m.id) DESC) AS director_rank
FROM movie m
JOIN ratings r ON r.movie_id=m.id
JOIN genre g ON m.id=g.movie_id
JOIN director_mapping dm ON m.id=dm.movie_id
JOIN names n ON n.id=dm.name_id
JOIN top_three_genres ttg ON g.genre=ttg.genre
WHERE avg_rating>8
GROUP BY n.name)
SELECT name AS director_name, movie_count FROM director_summary
WHERE director_rank<=3;
```

```sql
-- Q20. Who are the top two actors whose movies have a median rating >= 8?
WITH actor_summary AS (
SELECT n.name AS actor_name, COUNT(m.id) AS movie_count,
RANK() OVER(ORDER BY COUNT(m.id) DESC) AS actor_rank
FROM movie m
JOIN ratings r ON r.movie_id=m.id
JOIN role_mapping rm ON rm.movie_id=m.id
JOIN names n ON n.id=rm.name_id
WHERE median_rating>=8
AND category='actor'
GROUP BY n.name)
SELECT actor_name, movie_count FROM actor_summary
WHERE actor_rank<=2;
```

```sql
-- Q21. Which are the top three production houses based on the number of votes received by their movies?
WITH prod_summary AS (
SELECT production_company, SUM(total_votes) AS vote_count, 
RANK() OVER(ORDER BY SUM(total_votes) DESC) AS prod_comp_rank
FROM movie m
JOIN ratings r ON r.movie_id=m.id
WHERE production_company IS NOT NULL
GROUP BY production_company)
SELECT * FROM prod_summary
WHERE prod_comp_rank<=2;
```

```sql
-- Q22. Rank actors with movies released in India based on their average ratings. Which actor is at the top of the list?
-- Note: The actor should have acted in at least five Indian movies. 
SELECT n.name AS actor_name, 
SUM(total_votes) AS total_votes,
COUNT(m.id) AS movie_count,
ROUND(SUM(avg_rating*total_votes)/SUM(total_votes),2) AS actor_avg_rating,
RANK() OVER(ORDER BY ROUND(SUM(avg_rating*total_votes)/SUM(total_votes),2) DESC) AS actor_rank
FROM movie m
JOIN ratings r ON r.movie_id=m.id
JOIN role_mapping rm ON rm.movie_id=m.id
JOIN names n ON n.id=rm.name_id
WHERE country LIKE '%India%'
AND category='actor'
GROUP BY n.name
HAVING COUNT(m.id) >=5;
```

```sql
-- Q23.Find out the top five actresses in Hindi movies released in India based on their average ratings? 
-- Note: The actresses should have acted in at least three Indian movies. 
SELECT n.name AS actress_name, 
SUM(total_votes) AS total_votes,
COUNT(m.id) AS movie_count,
ROUND(SUM(avg_rating*total_votes)/SUM(total_votes),2) AS actress_avg_rating,
RANK() OVER(ORDER BY ROUND(SUM(avg_rating*total_votes)/SUM(total_votes),2) DESC) AS actress_rank
FROM movie m
JOIN ratings r ON r.movie_id=m.id
JOIN role_mapping rm ON rm.movie_id=m.id
JOIN names n ON n.id=rm.name_id
WHERE country LIKE '%India%'
AND languages LIKE '%Hindi%'
AND category='actress'
GROUP BY n.name
HAVING COUNT(m.id) >=3;
```

```sql
/* Q24. Select thriller movies as per avg rating and classify them in the following category
             Rating>8: Superhit movies
             Rating between 7 and 8: Hit movies
             Rating between 5 and 7: One-time-watch movies
             Rating<5: Flop movies  */
             
 
SELECT title, avg_rating,
CASE
     WHEN avg_rating>8 THEN "Superhit Movie"
     WHEN avg_rating BETWEEN 7 AND 8 THEN "Hit Movies"
     WHEN avg_rating BETWEEN 5 AND 7 THEN "One-time-watch movies"
     ELSE "Flop Movies"
END AS ratings
FROM genre g
JOIN movie m ON g.movie_id=m.id
JOIN ratings r ON g.movie_id=r.movie_id
WHERE genre = "thriller";
```


```sql
-- Q25. What is the genre-wise running total and moving average of the average movie duration? 
SELECT genre, AVG(duration) AS avg_duration,
SUM(AVG(duration)) OVER(ORDER BY genre ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total_duration,
AVG(AVG(duration)) OVER(ORDER BY genre ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS moving_avg_duration 
FROM movie m 
JOIN genre g ON m.id=g.movie_id
GROUP BY genre;
```

```sql
-- Q26. Which are the five highest-grossing movies of each year that belong to the top three genres? 
-- (Note: The top 3 genres would have the most number of movies.)
WITH Top_three_movie AS (
SELECT genre, COUNT(m.id) AS movie_count
FROM genre g 
JOIN movie m ON g.movie_id=m.id
GROUP BY genre
ORDER BY movie_count DESC
LIMIT 3), income_summary AS (
SELECT g.genre, year, title,
CAST(REPLACE(REPLACE(IFNULL(worlwide_gross_income,0),'$',''),'INR','') AS DECIMAL(10)) AS worldwide_gross_income,
RANK() OVER(PARTITION BY year ORDER BY CAST(REPLACE(REPLACE(IFNULL(worlwide_gross_income,0),'$',''),'INR','') AS DECIMAL(10)) DESC) AS movie_rank
FROM movie m
JOIN genre g ON g.movie_id=m.id
JOIN Top_three_movie ttm ON ttm.genre=g.genre)
SELECT * FROM income_summary
WHERE movie_rank<=5;
```

```sql
-- Q27.  Which are the top two production houses that have produced the highest 
-- number of hits (median rating >= 8) among multilingual movies?
WITH production_company_summary AS (
SELECT production_company, COUNT(m.id) AS movie_count,
RANK() OVER(ORDER BY  COUNT(m.id) DESC) AS movie_rank
FROM movie m
JOIN ratings r ON m.id=r.movie_id
WHERE median_rating>=8 
AND POSITION(','IN languages)>0
AND production_company IS NOT NULL
GROUP BY production_company)
SELECT * FROM production_company_summary
WHERE movie_rank<=2;
```

```sql
-- Q28. Who are the top 3 actresses based on number of Super Hit movies (average rating >8) in drama genre?
WITH actresses_summary AS (
SELECT name AS Actress_name,
SUM(total_votes) AS total_votes,
COUNT(m.id) movie_count,
SUM(avg_rating*total_votes)/SUM(total_votes) AS actress_avg_rating,
RANK() OVER(ORDER BY COUNT(m.id) DESC ) AS movie_rank
FROM movie m
JOIN genre g ON m.id=g.movie_id
JOIN ratings r ON r.movie_id=g.movie_id
JOIN role_mapping rm ON rm.movie_id=m.id
JOIN names n ON n.id=rm.name_id
WHERE avg_rating>8
AND category = 'actress'
AND genre = 'Drama'
GROUP BY name)
SELECT * FROM actresses_summary
WHERE movie_rank<=3;
```

```sql
/* Q29. Get the following details for top 9 directors (based on number of movies)
Director id
Name
Number of movies
Average inter movie duration in days
Average movie ratings
Total votes
Min rating
Max rating
total movie durations */

WITH director_summary AS (
SELECT dm.name_id AS director_id,
name AS director_name,
m.id AS movie_id,
avg_rating, total_votes, duration,
date_published,
LEAD(date_published) OVER(PARTITION BY n.name ORDER BY date_published) AS next_publish_date
FROM movie m
JOIN ratings r ON m.id=r.movie_id
JOIN director_mapping dm ON dm.movie_id=m.id
JOIN names n ON n.id=dm.name_id)
SELECT director_id, director_name,
COUNT(movie_id) AS Number_of_movies,
ROUND(SUM(DATEDIFF(date_published, next_publish_date))/ (COUNT(movie_id)-1)) AS avg_inter_movie_day,
SUM(avg_rating*total_votes)/SUM(total_votes) AS avg_movie_ratings,
SUM(total_votes) AS total_votes,
MIN(avg_rating) AS min_rating,
MAX(avg_rating) AS max_rating,
SUM(duration) AS total_duration
FROM director_summary
GROUP BY director_id, director_name
ORDER BY COUNT(movie_id) DESC
LIMIT 9;
```


<h2>🔥 Advanced SQL Concepts Used</h2>

<ul>
  <li>✅ JOIN (Multi-table)</li>
  <li>✅ GROUP BY & Aggregation</li>
  <li>✅ Window Functions (RANK, LEAD)</li>
  <li>✅ CTE (Common Table Expressions)</li>
  <li>✅ CASE Statements</li>
  <li>✅ Data Cleaning (REPLACE, CAST)</li>
  <li>✅ Date Functions</li>
</ul>

<hr>

<h2>📈 Market Recommendations</h2>

<h3>🎯 Content Strategy</h3>
<ul>
  <li>Focus on Drama, Thriller, Action</li>
  <li>Target movies with rating > 8</li>
</ul>

<h3>⭐ Talent Investment</h3>
<ul>
  <li>Work with top-rated actors & directors</li>
  <li>Invest in consistent performers</li>
</ul>

<h3>🌍 Market Expansion</h3>
<ul>
  <li>Target USA & India markets</li>
  <li>Invest in multilingual content</li>
</ul>

<h3>🏢 Production Strategy</h3>
<ul>
  <li>Partner with successful production houses</li>
  <li>Focus on quality content</li>
</ul>

<h3>📊 Audience Insights</h3>
<ul>
  <li>Prioritize high votes + high ratings</li>
  <li>Use data-driven decisions</li>
</ul>

<hr>

<h2>🚀 Project Highlights</h2>

<ul>
  <li>✔ Real-world case study</li>
  <li>✔ Advanced SQL queries</li>
  <li>✔ Business insights</li>
  <li>✔ Portfolio-ready project</li>
</ul>

<hr>

<h2>🧑‍💻 Author</h2>

<p><b>Vedant Jamdade</b><br>
📊 Data Analyst | SQL Specialist</p>

<hr>

<p align="center"><b>💡 This project showcases real Data Analyst skills 🚀</b></p>
