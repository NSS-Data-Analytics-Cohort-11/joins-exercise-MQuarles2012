-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.

SELECT movie_id, film_title, release_year, worldwide_gross
FROM specs
INNER JOIN revenue
USING (movie_id)
ORDER BY worldwide_gross;

--answer: semi-tough, release year of 1977, worldwide gross of $37,187,139
--I would like to figure out how to answer this without querying all 430 records. How do I only get the one record I'm looking for? I tried to filter using HAVING but it did not work

-- 2. What year has the highest average imdb rating?

SELECT release_year, AVG(imdb_rating) AS avg_rating
FROM specs
INNER JOIN rating
USING(movie_id)
GROUP BY release_year
ORDER BY avg_rating DESC;

--answer: 1991

-- 3. What is the highest grossing G-rated movie? Which company distributed it?

SELECT film_title, company_name, MAX(worldwide_gross) AS highest_grossing
FROM revenue
JOIN specs AS s
USING(movie_id)
JOIN distributors AS d
ON s.domestic_distributor_id = d.distributor_id
WHERE mpaa_rating = 'G'
GROUP BY film_title, company_name
ORDER BY highest_grossing DESC;

--answer: Toy Story 4, Walt Disney, $1,073,394,593

-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.

SELECT d.company_name, COUNT(s.film_title) AS num_of_movies
FROM distributors AS d
LEFT JOIN specs AS s
ON d.distributor_id = s.domestic_distributor_id
GROUP BY d.company_name
ORDER BY num_of_movies DESC;

--answer: There are 23 distributors, including two with 0 movies in the specs table. Disney is the top distributor with 76 movies. 

-- 5. Write a query that returns the five distributors with the highest average movie budget.
--Logic: dist (comapny name) --> ON dist id --> specs --> ON movie_id --> revenue (AVG(film_budget)). 
--I used a left join to make sure all distributors are pulled from left table, then inner join to ignore distributors that have no values in the revenue table. 

SELECT d.company_name, AVG(film_budget) AS avg_budget
FROM distributors AS d
LEFT JOIN specs AS s
ON d.distributor_id = s.domestic_distributor_id
INNER JOIN revenue AS r
USING(movie_id)
GROUP BY d.company_name
ORDER BY avg_budget DESC
LIMIT 5;

--answer: Walt Disney, Sony Picture, Lionsgate, DreamWorks, and Warner Bros. have the highest average film budgets


-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?

-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?