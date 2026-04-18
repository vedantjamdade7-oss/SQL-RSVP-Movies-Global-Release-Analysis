-- RSVP Movies Global Analysis --

USE rsvp__movies_db;


-- Q1. Find the total number of rows in each table of the schema?
SELECT table_name,
table_rows
FROM information_schema.tables
WHERE table_schema = 'imdb';

-- Q2. Which columns in the movie table have null values?
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

-- Q3. Find the total number of movies released each year? How does the trend look month wise? (Output expected)
SELECT year ,COUNT(*) AS total_no_movie
FROM movie
group by year;

SELECT MONTH(date_published) AS month , COUNT(*) AS total_no_movie
FROM movie
GROUP BY MONTH(date_published)
ORDER BY total_no_movie DESC ;

-- Q4. How many movies were produced in the USA or India in the year 2019??
SELECT  COUNT(*) AS no_of_movie
FROM movie
WHERE country LIKE '%USA%' 
OR country LIKE '%INDIA%'
AND YEAR = 2019;

SELECT COUNT(*) AS number_of_movies 
FROM movie
WHERE year=2019
AND (Country LIKE '%USA%' OR country LIKE '%India%');


-- Q5. Find the unique list of the genres present in the data set?

SELECT DISTINCT genre FROM genre;


-- Q6.Which genre had the highest number of movies produced overall?
SELECT genre, COUNT(*) AS highest_no_genre
FROM genre
GROUP BY genre
ORDER BY highest_no_genre DESC
LIMIT 1;

-- Q7. How many movies belong to only one genre?
WITH summary AS (
SELECT movie_id, COUNT(*) AS movie
FROM genre
GROUP BY movie_id
HAVING COUNT(*)=1)
SELECT COUNT(movie_id) FROM summary;

-- Q8.What is the average duration of movies in each genre? 
SELECT genre, AVG(duration) AS Avg_duration 
FROM genre g
JOIN movie m 
ON g.movie_id=m.id
GROUP BY genre
ORDER BY Avg_duration DESC;
 

-- Q9.What is the rank of the ‘thriller’ genre of movies among all the genres in terms of number of movies produced? 
WITH summary AS (
SELECT genre , COUNT(*) AS movie,
RANK() OVER (ORDER BY count(*) DESC) AS gener_rank
FROM genre
GROUP BY genre)
SELECT * FROM summary
WHERE genre = "thriller";

-- Q10.  Find the minimum and maximum values in  each column of the ratings table except the movie_id column?
SELECT MIN(avg_rating) AS min_avg_rating, MAX(avg_rating) AS max_avg_rating,
MIN(total_votes) AS min_total_votes, MAX(total_votes) AS max_total_votes,
MIN(median_rating) AS min_median_rating, MAX(median_rating) AS max_median_rating
FROM ratings;

-- Q11. Which are the top 10 movies based on average rating?
WITH Top_movies_summary AS (
SELECT avg_rating, title,
RANK() OVER (ORDER BY avg_rating DESC) AS AVG_RANK
FROM ratings r
JOIN movie m
ON r.movie_id=m.id 
WHERE avg_rating>=8)
SELECT * FROM Top_movies_summary
WHERE AVG_RANK<=10;

-- Q12. Summarise the ratings table based on the movie counts by median ratings.
SELECT median_rating, COUNT(*) AS movie_count
FROM ratings
GROUP BY median_rating
ORDER BY movie_count DESC;

-- Q13. Which production house has produced the most number of hit movies (average rating > 8)??
WITH No_of_hit_movie AS (
SELECT production_company, COUNT(m.id) AS movie_count,
RANK() OVER (ORDER BY COUNT(m.id) DESC) AS prod_comp_rank
FROM ratings r
JOIN movie m
ON r.movie_id=m.id
WHERE avg_rating>8
AND production_company IS NOT NULL
GROUP BY production_company)
SELECT * FROM No_of_hit_movie
WHERE prod_comp_rank=1;


-- Q14. How many movies released in each genre during March 2017 in the USA had more than 1,000 votes?
SELECT genre, COUNT(m.id) AS movie_id 
FROM genre g
JOIN movie m
ON g.movie_id=m.id
JOIN ratings r
ON r.movie_id=m.id
WHERE date_published BETWEEN '2017-03-01' AND '2017-03-31'
AND country LIKE '%USA%'
AND total_votes>1000
GROUP BY genre
ORDER BY movie_id DESC;

-- Q15. Find movies of each genre that start with the word ‘The’ and which have an average rating > 8?

SELECT title, avg_rating, genre
FROM genre g
JOIN movie m
ON g.movie_id=m.id
JOIN ratings r
ON r.movie_id=m.id
WHERE title LIKE 'The%'
AND avg_rating > 8
ORDER BY avg_rating DESC;


-- Q16. which Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?

-- with name
SELECT title, median_rating  FROM movie m
JOIN ratings r
ON m.id=r.movie_id
WHERE date_published BETWEEN '2018-04-01' AND '2019-04-01'
AND median_rating = 8;

-- with number
SELECT COUNT(m.id) AS movie_count FROM movie m
JOIN ratings r ON r.movie_id=m.id
WHERE (date_published BETWEEN '2018-04-01' AND '2019-04-01')
AND median_rating=8;

SHOW VARIABLES LIKE 'sql_mode';
SET GLOBAL sql_mode='';

-- Q17. Do German movies get more votes than Italian movies?
WITH summary AS ( 
SELECT languages, total_votes FROM movie m
JOIN ratings r
ON m.id=r.movie_id
WHERE languages LIKE "%German%"
UNION ALL
SELECT languages, SUM(total_votes) AS total_votes FROM movie m
JOIN ratings r
ON m.id=r.movie_id
WHERE languages LIKE "%Italian%"), final_summary AS (
SELECT * FROM summary
ORDER BY total_votes DESC
LIMIT 1)
SELECT IF( languages LIKE 'italian' , 'yes','no') 
FROM final_summary;

-- Q18. Which columns in the names table have null values??

SELECT
SUM( CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS name_id,
SUM( CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS name,
SUM( CASE WHEN height IS NULL THEN 1 ELSE 0 END) AS height,
SUM( CASE WHEN date_of_birth IS NULL THEN 1 ELSE 0 END) AS date_of_birth,
SUM( CASE WHEN known_for_movies IS NULL THEN 1 ELSE 0 END) AS known_for_movies
FROM names;



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

-- Q21. Which are the top three production houses based on the number of votes received by their movies?

WITH top_three_prod_house AS (
SELECT production_company, SUM(total_votes) AS vote_count,
RANK() OVER(ORDER BY SUM(total_votes) DESC) AS rank_vote_count
FROM movie m 
JOIN ratings r ON m.id=r.movie_id
WHERE production_company IS NOT NULL
GROUP BY production_company)
SELECT * FROM top_three_prod_house
WHERE rank_vote_count<=3;

-- Q22. Rank actors with movies released in India based on their average ratings. Which actor is at the top of the list?
-- Note: The actor should have acted in at least five Indian movies. 
SELECT name AS actor_name,
SUM(total_votes) AS total_vote,
COUNT(m.id) AS movie_count,
SUM(avg_rating*total_votes)/SUM(total_votes) AS actor_avg_rating,
RANK() OVER(ORDER BY SUM(avg_rating*total_votes)/SUM(total_votes)  DESC) AS actor_rank
FROM names n 
JOIN role_mapping rm ON n.id=rm.name_id
JOIN ratings r ON r.movie_id=rm.movie_id
JOIN movie m ON m.id=r.movie_id
WHERE country LIKE '%India%'
AND category = 'actor'
GROUP BY name
HAVING movie_count>=5;


-- Q23.Find out the top five actresses in Hindi movies released in India based on their average ratings? 
-- Note: The actresses should have acted in at least three Indian movies.

SELECT name AS actress_name,
SUM(total_votes) AS total_vote,
COUNT(m.id) AS movie_count,
SUM(avg_rating*total_votes)/SUM(total_votes) AS actress_avg_rating,
RANK() OVER(ORDER BY SUM(avg_rating*total_votes)/SUM(total_votes)  DESC) AS actress_rank
FROM names n 
JOIN role_mapping rm ON n.id=rm.name_id
JOIN ratings r ON r.movie_id=rm.movie_id
JOIN movie m ON m.id=r.movie_id
WHERE languages LIKE '%Hindi%'
AND country LIKE '%india%'
AND category = "actress"
GROUP BY name
HAVING movie_count>=3;


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

-- Q25. What is the genre-wise running total and moving average of the average movie duration? 

SELECT genre, AVG(duration),
SUM(AVG(duration)) OVER(ORDER BY genre ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total,
AVG(AVG(duration)) OVER(ORDER BY genre ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS moving_average
FROM movie m
JOIN genre g ON m.id=g.movie_id
GROUP BY genre;

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

