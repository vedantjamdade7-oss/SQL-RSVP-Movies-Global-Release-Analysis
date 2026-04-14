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

<h2>🎯 Business Objectives</h2>

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
    <th>Description</th>
  </tr>
  <tr>
    <td>🎬 movie</td>
    <td>Movie details (title, year, duration, country, income)</td>
  </tr>
  <tr>
    <td>⭐ ratings</td>
    <td>Ratings (avg_rating, total_votes, median_rating)</td>
  </tr>
  <tr>
    <td>🎭 genre</td>
    <td>Movie genres</td>
  </tr>
  <tr>
    <td>👤 names</td>
    <td>Actors, actresses, directors</td>
  </tr>
  <tr>
    <td>🎥 director_mapping</td>
    <td>Director–movie relationship</td>
  </tr>
  <tr>
    <td>🎭 role_mapping</td>
    <td>Actor/actress–movie relationship</td>
  </tr>
</table>

<hr>

<h2>🛠️ Tools & Technologies</h2>

<p>
<img src="https://img.shields.io/badge/SQL-MySQL-blue?style=for-the-badge&logo=mysql"/>
<img src="https://img.shields.io/badge/Data%20Analysis-Advanced-green?style=for-the-badge"/>
<img src="https://img.shields.io/badge/Database-Relational-orange?style=for-the-badge"/>
</p>

<hr>

<h2>🔍 Data Exploration</h2>

<pre>
USE rsvp__movies_db;

SHOW TABLES;

SELECT * FROM movie;
SELECT * FROM ratings;
SELECT * FROM genre;
SELECT * FROM names;
</pre>


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

```sql
-- Q3. Find the total number of movies released each year? How does the trend look month wise? (Output expected)
SELECT MONTH(date_published) AS month , COUNT(*) AS total_no_movie
FROM movie
GROUP BY MONTH(date_published)
ORDER BY total_no_movie DESC ;
```

```sql
-- Q4. How many movies were produced in the USA or India in the year 2019??
SELECT COUNT(*) AS number_of_movies 
FROM movie
WHERE year=2019
AND (Country LIKE '%USA%' OR country LIKE '%India%');
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
