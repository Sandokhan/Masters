-- 1. What cities were visited on the 24th of May 2007 trip? (name)

SELECT
    name
FROM stop
WHERE day = '2007-05-24';

/* Result
   name    
-----------
 Porto
 Barcelona
 London
 Lyon */

-- 2. What countries were visited on the 2nd of March 2008 trip? Don't show the same country twice. (name)

-- 3. How many cities were visited on each trip? Order the answer starting with the trip with more cities visited. 
-- If two trips have the same number of visited cities, show the most recent first. (day, number)
-- 4. What is the average city score for each country? (name, average)
-- 5. What countries have cities that are not the capital but are the highest scoring city in the country? (name)
-- 6. List all pairs of cities from different countries where the spoken language is the same. 
-- Don't show the same pair twice even if in a different order.