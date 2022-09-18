-- 1. What riders belong to the team 'Os Velozes'? (name)


SELECT 
    name
FROM rider
WHERE team = 'Os Velozes';

/* Result
      name       
-----------------
 João Meireles
 Carlos Meireles
 Miguel Meireles
 Tiago Meireles */


-- 2. What rider won the 'Porto – Aveiro' stage? (name)

SELECT
    r.name
FROM rider r
JOIN classification c ON c.ref = r.ref
JOIN stage s ON c.num = s.num
WHERE position = 1 
AND description = 'Porto - Aveiro';

/* Result
       name       
------------------
 Henrique Barbosa */

-- 3. What riders raced the 'Coimbra – Lisboa' stage and what was their final position? 
-- Order the answer by their position. (name, position)

SELECT
    r.name,
    c.position
FROM rider r
JOIN classification c ON c.ref = r.ref
JOIN stage s ON c.num = s.num
WHERE 1 = 1 
AND description = 'Coimbra - Lisboa'
ORDER BY 2;

/* Result

           name           | position 
--------------------------+----------
 Miguel Meireles          |        1
 Henrique Barbosa         |        2
 Tiago Meireles           |        3
 Filipe Barbosa           |        4
 Francisco Lopes da Silva |        5
 João Meireles            |        6
 Bernardo Barbosa         |        7
 Carlos Meireles          |        8
 Joaquim Lopes da Silva   |        9 */

-- 4. How many riders are there on each team? (team, total)


SELECT 
    team,
    COUNT(ref) AS total
FROM rider
GROUP BY 1;

/* Result

    team     | total 
-------------+-------
 Os Melhores |     2
 Os Velozes  |     4
 Os Rápidos  |     3 */

-- 5. What is the total sum of times of each rider? (name, total)

SELECT
    r.name,
   SUM (c.time) AS total
FROM rider r
JOIN classification c ON c.ref = r.ref
GROUP BY 1;

/* Result
           name           |  total   
--------------------------+----------
 Tiago Meireles           | 05:13:54
 João Meireles            | 05:20:24
 Joaquim Lopes da Silva   | 05:21:13
 Henrique Barbosa         | 05:12:49
 Carlos Meireles          | 05:22:31
 Miguel Meireles          | 05:17:37
 Francisco Lopes da Silva | 05:20:00
 Filipe Barbosa           | 05:18:42
 Bernardo Barbosa         | 05:16:59 */

-- 6. What team, or teams, has a smaller sum of its riders' total time? (team)

SELECT
    r.team,
   SUM (c.time) AS total
FROM rider r
JOIN classification c ON c.ref = r.ref
GROUP BY 1
ORDER BY 2 
LIMIT 1;

/* Result

    team     |  total   
-------------+----------
 Os Melhores | 10:41:13 */

-- 7. What is the average time in each stage? (description, average)

SELECT
    s.description,
   AVG (c.time) AS average
FROM stage s
JOIN classification c ON c.num = s.num
GROUP BY 1;

/* Result

   description    |     average     
------------------+-----------------
 Aveiro - Coimbra | 01:16:46.888889
 Porto - Aveiro   | 01:25:32.111111
 Coimbra - Lisboa | 02:35:55.333333*/

-- 8. What stage, or stages, had the smaller average time? (description)
SELECT smaller.description
FROM (
    SELECT
        s.description,
        AVG (c.time) AS average
    FROM stage s
    JOIN classification c ON c.num = s.num
    GROUP BY 1
    ORDER BY 2) AS smaller
LIMIT 1;

/* Result
   description    
------------------
 Aveiro - Coimbra */

-- 9. What was the time difference between the first and second riders in each stage? (description, difference)

WITH firstplace AS (
    SELECT num, position as first, time as ftime
    FROM classification
    WHERE position = 1
), secondplace AS (
    SELECT num, position as second, time as stime
    FROM classification
    WHERE position = 2
)
SELECT description,(ftime - stime) AS difference
FROM firstplace f
JOIN secondplace s ON f.num = s.num
JOIN stage ss ON ss.num = s.num;

/* Result

   description    | difference 
------------------+------------
 Porto - Aveiro   | -00:00:06
 Aveiro - Coimbra | -00:00:29
 Coimbra - Lisboa | -00:00:01 */


-- 10. What stage had the biggest time difference between the first and second rider to finish it, 
--     what rider won that stage and with how much lead time. (description, name, difference).

WITH firstplace AS (
    SELECT num, position as first, time as ftime
    FROM classification
    WHERE position = 1
), secondplace AS (
    SELECT num, position as second, time as stime
    FROM classification
    WHERE position = 2
)
SELECT description,(ftime - stime) AS difference
FROM firstplace f
JOIN secondplace s ON f.num = s.num
JOIN stage ss ON ss.num = s.num
ORDER BY 2
LIMIT 1;

/* Result

   description    | difference 
------------------+------------
 Aveiro - Coimbra | -00:00:29 */