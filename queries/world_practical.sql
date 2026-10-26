-- =====================================================================
-- World database practical
-- Bootcamp Week 3, Day 4 Task 1. Run in Supabase (PostgreSQL) against the
-- World sample database (city and country tables).
--
-- These are the queries as I submitted them in my Week 3 workbook. Only
-- the layout and keyword case have been tidied for readability. Results
-- come from the sample data, which uses old figures.
-- A screenshot of each result is in images/world-results/.
-- =====================================================================

-- Q1. Number of cities in the USA (result: 274)
SELECT COUNT(*)
FROM city
WHERE countrycode = 'USA';

-- Q2. Country with the highest life expectancy (top row: Andorra, 83.5)
SELECT lifeexpectancy, name
FROM country
WHERE lifeexpectancy IS NOT NULL
GROUP BY lifeexpectancy, name
ORDER BY lifeexpectancy DESC;

-- Q3. Cities whose name includes "New", with their country
SELECT country.name AS country_name, city.name AS city_name
FROM city
JOIN country
  ON city.countrycode = country.code
WHERE city.name LIKE '%New%';

-- Q4. The 10 most populous cities (top: Mumbai (Bombay))
SELECT name, countrycode, population
FROM city
ORDER BY population DESC
LIMIT 10;

-- Q5. Cities with more than 2,000,000 people
SELECT name, countrycode, population
FROM city
WHERE population > 2000000;

-- Q6. Cities beginning with "Be"
SELECT DISTINCT name, countrycode
FROM city
WHERE name LIKE 'Be%';

-- Q7. Cities with 500,000 to 1,000,000 people
SELECT name, countrycode, population
FROM city
WHERE population BETWEEN 500000 AND 1000000;

-- Q8. All cities in alphabetical order
SELECT name, countrycode, population
FROM city
ORDER BY name ASC;

-- Q9. The most populated city (result: Mumbai (Bombay), 10,500,000)
SELECT name, countrycode, population
FROM city
ORDER BY population DESC
LIMIT 1;

-- Q10. Each city name with the number of times it appears, A to Z
SELECT name, COUNT(*) AS name_count
FROM city
GROUP BY name
ORDER BY name ASC;

-- Q11. The city with the lowest population (result: Adamstown, 42)
SELECT name, countrycode, population
FROM city
ORDER BY population ASC
LIMIT 1;

-- Q12. The country with the largest population (result: China)
SELECT name, code, population
FROM country
ORDER BY population DESC
LIMIT 1;

-- Q13. Capital of Spain (result: Madrid)
SELECT country.name AS country_name, city.name AS capital_city
FROM country
JOIN city
  ON city.id = country.capital
WHERE country.name = 'Spain';

-- Q14. Cities in Europe (result: 841 rows)
SELECT country.name AS country_name, city.name AS city_name
FROM country
JOIN city
  ON city.countrycode = country.code
WHERE continent = 'Europe';

-- Q15. Average city population for each country, largest first
-- (232 rows; top: Singapore)
SELECT AVG(city.population) AS avg_city_population,
       city.countrycode     AS country_code,
       country.name         AS country_name
FROM city
JOIN country
  ON country.code = city.countrycode
GROUP BY city.countrycode, country.name
ORDER BY AVG(city.population) DESC;

-- Q16. Capital cities ranked by population (top: Seoul)
SELECT country.name AS country_name, city.name AS capital_city, city.population
FROM country
JOIN city
  ON city.id = country.capital
ORDER BY city.population DESC;

-- Q17. The 10 least densely populated countries (top: Greenland)
SELECT name, population, population / surfacearea AS density
FROM country
WHERE population > 0
ORDER BY density ASC
LIMIT 10;

-- Q18. Cities ranked 31st to 40th by population
SELECT name, countrycode, population
FROM city
ORDER BY population DESC
LIMIT 10 OFFSET 30;
