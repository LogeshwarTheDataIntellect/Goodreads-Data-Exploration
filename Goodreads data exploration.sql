USE goodreads;

-- #TotalBookCount
SELECT COUNT(*) AS TotalBooks FROM goodreads_data;

-- #UniqueAuthors
SELECT DISTINCT authors FROM goodreads_data;

-- #AverageBookRating
SELECT AVG(average_rating) AS AverageRating FROM goodreads_data;

-- #TopRatedBooks
SELECT title, authors, average_rating 
FROM goodreads_data 
ORDER BY average_rating DESC 
LIMIT 10;

-- #BooksInEnglish
SELECT title, authors 
FROM goodreads_data 
WHERE language_code = 'eng';

-- #BooksOver500Pages
SELECT title, num_pages 
FROM goodreads_data 
WHERE num_pages > 500;

-- #MostReviewedBooks
SELECT title, text_reviews_count 
FROM goodreads_data 
ORDER BY text_reviews_count DESC 
LIMIT 10;

-- #BooksByAuthor
SELECT title, average_rating 
FROM goodreads_data 
WHERE authors LIKE '%J.K. Rowling%';

-- #AveragePagesPerBook
SELECT AVG(num_pages) AS AveragePages 
FROM goodreads_data;

-- #LeastPopularBooks
SELECT title, authors, average_rating 
FROM goodreads_data 
ORDER BY average_rating ASC 
LIMIT 10;

-- #HighlyRatedBooks
SELECT title, authors, ratings_count 
FROM goodreads_data 
WHERE ratings_count > 100000 
ORDER BY ratings_count DESC;

-- #BooksByPublisher
SELECT title, authors, year 
FROM goodreads_data 
WHERE publisher = 'Scholastic Inc.';

-- #AverageReviewCountPerYear
SELECT year, AVG(text_reviews_count) AS AverageReviewCount 
FROM goodreads_data 
GROUP BY year;

-- #BooksWithTitleKeyword
SELECT title, authors 
FROM goodreads_data 
WHERE title LIKE '%Harry%';

-- #BooksByLanguage
SELECT language_code, COUNT(*) AS NumberOfBooks 
FROM goodreads_data 
GROUP BY language_code;

-- #ShortestBooks
SELECT title, num_pages 
FROM goodreads_data 
ORDER BY num_pages ASC 
LIMIT 10;

-- #BooksBeforeYear
SELECT title, year 
FROM goodreads_data 
WHERE year < 2000;

-- #MostProlificAuthors
SELECT authors, COUNT(*) AS NumberOfBooks 
FROM goodreads_data 
GROUP BY authors 
ORDER BY NumberOfBooks DESC 
LIMIT 10;

-- #BooksInPageRange
SELECT title, num_pages 
FROM goodreads_data 
WHERE num_pages BETWEEN 200 AND 300;

-- #Identifying Best-Selling Authors
#Problem: Determine which authors have consistently high ratings and a significant number of ratings.
SELECT authors, AVG(average_rating) AS AvgRating, SUM(ratings_count) AS TotalRatings
FROM goodreads_data
GROUP BY authors
HAVING AvgRating > 4.0 AND TotalRatings > 10000;

-- #Trend Analysis by Publication Year
#Problem: Understand how the number of books published has changed over the years.
SELECT year, COUNT(*) AS BooksPublished
FROM goodreads_data
GROUP BY year;

-- #Market Demand for Different Languages
#Problem: Analyze the market demand for books in different languages.
SELECT language_code, COUNT(*) AS NumberOfBooks
FROM goodreads_data
GROUP BY language_code;

-- #Book Lengths and Their Popularity
#Problem: Investigate if there is a correlation between the number of pages in a book and its popularity.
SELECT num_pages, AVG(average_rating) AS AvgRating
FROM goodreads_data
GROUP BY num_pages;

-- #Assessing the Impact of Reviews
#Problem: Determine the relationship between the number of reviews and book ratings.
SELECT text_reviews_count, AVG(average_rating) AS AvgRating
FROM goodreads_data
GROUP BY text_reviews_count;

-- # Identifying Niche Publishers
#Problem: Find niche publishers that specialize in highly rated books.
SELECT publisher, AVG(average_rating) AS AvgRating, COUNT(*) AS NumberOfBooks
FROM goodreads_data
GROUP BY publisher
HAVING AvgRating > 4.0 AND NumberOfBooks < 50;

-- #Books with High Ratings but Low Review Counts
#Problem: Identify books that are highly rated but have not received much attention in terms of reviews.
SELECT title, average_rating, text_reviews_count
FROM goodreads_data
WHERE average_rating > 4.0 AND text_reviews_count < 100;

-- #Author Popularity Trends Over Time
#Problem: Analyze how the popularity of authors has changed over the years.
SELECT authors, year, AVG(average_rating) AS AvgRating
FROM goodreads_data
GROUP BY authors, year;

#Publisher Market Share Analysis
-#Problem: Determine the market share of each publisher based on the number of books published.
SELECT publisher, COUNT(*) AS NumberOfBooks, (COUNT(*) / (SELECT COUNT(*) FROM goodreads_data)) * 100 AS MarketSharePercentage
  FROM goodreads_data
  GROUP BY publisher;
  
-- #Identifying Potential Books for Reprints
#Find older books with high ratings that could be candidates for reprinting.
SELECT title, year, average_rating
  FROM goodreads_data
  WHERE year < 2000 AND average_rating > 4.0;
  
-- #Analyzing Reader Preferences Over Decades
#Problem: Understand how reader preferences in terms of book ratings have changed over decades.
SELECT FLOOR(year/10)*10 AS Decade, AVG(average_rating) AS AvgRating
  FROM goodreads_data
  GROUP BY Decade;
  
/*Business Problem: Optimizing Book Recommendations to Increase User Engagement and Sales
Context: Goodreads can boost revenue by increasing user engagement on the platform. A key way to achieve this is by providing highly personalized and relevant book recommendations to users. The more users engage with the platform through these recommendations, the more likely they are to purchase books through affiliated links or advertisements, thus increasing revenue.

Problem Statement: How can we optimize the book recommendation system using the existing dataset to increase user engagement, thereby driving more sales and revenue?*/

#MySQL Query Approach:
#Find the Most Highly Rated Books:
SELECT title, authors, average_rating 
FROM goodreads_data 
ORDER BY average_rating DESC 
LIMIT 10;

#Discover Popular Books Based on Ratings Count:
SELECT title, authors, ratings_count 
FROM goodreads_data 
ORDER BY ratings_count DESC 
LIMIT 10;

#Identify Books with the Most Text Reviews:
SELECT title, text_reviews_count 
FROM goodreads_data 
ORDER BY text_reviews_count DESC 
LIMIT 10;

#Analyze Average Book Length by Language:
SELECT language_code, AVG(num_pages) AS average_length 
FROM goodreads_data 
GROUP BY language_code;

#Find Books Published in a Specific Year (e.g., 2000):
SELECT title, authors, year 
FROM goodreads_data 
WHERE year = 2000;

#Explore the Distribution of Books by Language:
SELECT language_code, COUNT(*) AS number_of_books 
FROM goodreads_data 
GROUP BY language_code;

#Books with High Ratings and Low Page Counts:
SELECT title, average_rating, num_pages 
FROM goodreads_data 
WHERE average_rating > 4.0 AND num_pages < 300;

#Authors with the Highest Average Ratings:
SELECT authors, AVG(average_rating) AS avg_rating 
FROM goodreads_data 
GROUP BY authors 
ORDER BY avg_rating DESC 
LIMIT 10;

#Trends in Book Publications Over Years:
SELECT year, COUNT(*) AS number_of_books 
FROM goodreads_data 
GROUP BY year 
ORDER BY year;

#Explore Books by a Specific Publisher (e.g., 'Scholastic Inc.'):
SELECT title, authors, year 
FROM goodreads_data 
WHERE publisher = 'Scholastic Inc.';

#Identifying Seasonal Trends in Book Publishing
#Problem: Determine if there are particular times of the year when more books are published.
SELECT MONTH(STR_TO_DATE(publication_date, '%Y-%m-%d')) AS Month, COUNT(*) AS BooksPublished
FROM goodreads_data
GROUP BY Month
ORDER BY Month;

#Exploring the Relationship Between Book Length and Popularity
#Problem: Analyze if there's a correlation between the length of a book (number of pages) and its popularity (ratings count).
SELECT num_pages, AVG(ratings_count) AS AverageRatingsCount
FROM goodreads_data
GROUP BY num_pages
ORDER BY AverageRatingsCount DESC;

#Impact of Author Collaboration on Book Ratings
#Problem: Examine whether books written by multiple authors tend to have higher average ratings than those written by single authors.
SELECT IF(CHAR_LENGTH(authors) - CHAR_LENGTH(REPLACE(authors, '/', '')) >= 1, 'Multiple Authors', 'Single Author') AS AuthorType, 
       AVG(average_rating) AS AvgRating
FROM goodreads_data
GROUP BY AuthorType;

#Analysis of Book Ratings Over Time
#Problem: Understand how the average ratings of books have changed over the years.
SELECT year, AVG(average_rating) AS AvgRating
FROM goodreads_data
GROUP BY year
ORDER BY year;

#Exploring Book Availability by Language
#Problem: Determine the availability of books in various languages and identify languages with limited book options.
SELECT language_code, COUNT(*) AS NumberOfBooks
FROM goodreads_data
GROUP BY language_code
ORDER BY NumberOfBooks ASC;

#Evaluating the Longevity of Books in Terms of Popularity
#Problem: Determine if older books maintain popularity over time, as evidenced by a high number of ratings.
SELECT year, AVG(ratings_count) AS AvgRatingsCount
FROM goodreads_data
GROUP BY year
ORDER BY year;

#Assessing the Impact of Page Count on Reader Engagement
#Problem: Analyze if there's a relationship between the length of a book (number of pages) and reader engagement (text reviews count).
SELECT num_pages, AVG(text_reviews_count) AS AvgTextReviews
FROM goodreads_data
GROUP BY num_pages
ORDER BY AvgTextReviews DESC;

#Identifying Niche Areas for New Publications
#Problem: Find gaps in the market by identifying languages or genres (if genre data is available) that have fewer publications but high average ratings.
SELECT language_code, AVG(average_rating) AS AvgRating, COUNT(*) AS NumberOfBooks
FROM goodreads_data
GROUP BY language_code
HAVING AvgRating > 4.0 AND NumberOfBooks < 100
ORDER BY NumberOfBooks;

/*### Conclusion of MySQL Project on Goodreads Dataset

The MySQL project with the Goodreads dataset has provided substantial insights into the world of books and publishing, highlighting various aspects of reader preferences, publishing trends, and the overall landscape of the literary market. Through a series of tailored SQL queries, we have explored diverse business problems, ranging from identifying best-selling authors and seasonal publishing trends to understanding the impact of book length on popularity and uncovering niche areas for new publications. 

Key Findings:
1. **Popularity and Ratings**: The analysis revealed trends in book popularity and ratings, highlighting how factors like author reputation, book length, and language impact reader preferences.
2. **Publishing Trends**: We observed temporal patterns in book publishing, identifying specific periods when book releases peak and how reader preferences have evolved over the years.
3. **Market Gaps and Opportunities**: The project also uncovered niche markets and languages that present opportunities for new publications, based on the demand for high-quality content.

### Next Steps: Tableau Dashboard Implementation

To further enhance the utility and accessibility of these insights, the next phase of the project involves creating an interactive Tableau dashboard. This dashboard will visually represent the data and findings from the MySQL analysis, making it easier for users to explore and interact with the information.

**Tableau Dashboard Goals**:
- **Interactive Visualizations**: Develop dynamic charts and graphs that allow users to delve into specific aspects of the dataset, such as book ratings over time, top authors, and language distribution.
- **User-Friendly Interface**: Create a dashboard that is intuitive and easy to navigate, catering to both casual readers and industry professionals.
- **Real-Time Data Exploration**: Enable users to filter and sort data in real-time, providing a more personalized analysis experience.
- **Insightful Summaries**: Include summary sections that highlight key trends and observations, aiding in quick understanding and decision-making.

In conclusion, this project has not only deepened our understanding of the book industry through MySQL analysis but also sets the stage for a more interactive and engaging exploration with the upcoming Tableau dashboard. This progression from data analysis to visualization represents a comprehensive approach to data-driven decision-making in the literary market.*/









  





