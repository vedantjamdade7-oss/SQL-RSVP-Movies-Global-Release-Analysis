🎬 RSVP Movies Global Analysis (SQL Project)
<p align="center"> <img src="https://capsule-render.vercel.app/api?type=waving&color=0:000428,100:004e92&height=200&section=header&text=RSVP%20Movies%20Analysis&fontSize=40&fontColor=ffffff" /> </p>
📌 Project Overview

This project focuses on analyzing a global movie dataset using SQL to extract deep insights into the film industry.

The analysis simulates real-world business scenarios such as:

🎥 Movie performance analysis
⭐ Ratings & audience behavior
🌍 Country-wise production trends
🎭 Genre-based insights
🏢 Production house performance
🎬 Actor & director ranking

----------

## 🎯 Business Objective

Identify top-performing movies and genres
Analyze audience preferences using ratings & votes
Evaluate production house success
Discover high-performing actors & directors
Support data-driven movie production decisions

----------

🗂️ Database Structure

The dataset consists of multiple relational tables:

🎬 movie → Movie details (title, year, duration, country, income)
⭐ ratings → Ratings (avg_rating, total_votes, median_rating)
🎭 genre → Movie genres
👤 names → Actors, actresses, directors
🎥 director_mapping → Director–movie relationship
🎭 role_mapping → Actor/actress–movie relationship
🛠️ Tools & Technologies

----------

🔍 Data Exploration
USE imdb;

SHOW TABLES;

SELECT * FROM movie;
SELECT * FROM ratings;
SELECT * FROM genre;
SELECT * FROM names;

----------

## 📊 Key Analysis & Insights

🎥 Movie Trends
Total movies analyzed year-wise and month-wise
Identified growth trends in movie releases

🌍 Country Analysis
Compared movie production in USA vs India (2019)
Found key production hubs

🎭 Genre Insights
Identified most popular genre
Ranked genres using RANK() window function
Found average movie duration per genre

⭐ Ratings Analysis
Top 10 movies based on average rating ≥ 8
Distribution of movies by median ratings
Identified superhit, hit, and flop movies

🏢 Production House Insights
Found top production houses with most hit movies
Ranked based on total votes and ratings

🎬 Actor & Director Analysis
Top actors with median rating ≥ 8
Best actresses in Hindi movies
Top directors in high-performing genres

💰 Revenue Analysis
Highest grossing movies by year & genre
Cleaned currency data using SQL transformations

----------

🔥 Advanced SQL Concepts Used
✅ JOIN (Multiple Tables)
✅ GROUP BY & Aggregations
✅ Window Functions (RANK, LEAD)
✅ CTE (Common Table Expressions)
✅ CASE Statements (Classification)
✅ Data Cleaning (REPLACE, CAST)
✅ Date Functions
📈 Market Recommendations

----------

Based on the analysis:

🎯 Content Strategy
Focus on Drama, Thriller, and Action genres (high production & engagement)
Produce high-rating content (>8) for better audience response

⭐ Talent Investment
Collaborate with top-rated directors and actors
Invest in actors with consistent high median ratings

🌍 Market Expansion
Target USA and India markets for higher production success
Invest in multilingual movies for global reach

🏢 Production Strategy
Partner with top production houses with proven hit records
Focus on quality over quantity

📊 Audience Insights
Prioritize movies with high votes + high ratings
Use data-driven decisions for content creation

----------

🚀 Project Highlights

✔ Real-world business case study
✔ Complex SQL queries (Advanced Level)
✔ Industry-level insights
✔ Clean & structured analysis
✔ Strong portfolio project


