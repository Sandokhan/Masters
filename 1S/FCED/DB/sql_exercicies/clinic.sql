-- 1. List the physicians working in the clinic. (name)

SELECT
    name
FROM physician;

/* Result
     name      
---------------
 Luca Moore
 Tommy Cooke
 Joshua Bailey */

-- 2. List the names and addresses of the patients. (name, address)

SELECT
    name,
    address
FROM patient;

/* Result
      name       |      address      
-----------------+-------------------
 Xander Gibbs    | 45 Petworth Rd
 Tatiana Barber  | 16 Vicar Lane
 Amelie Harrison | 32 Thompsons Lane
 Kathryn Savege  | 67 Cosworth Rd */

-- 3. List the dates of all appointments of patient 12345. (date)

SELECT 
    DISTINCT date
FROM appointment a
JOIN patient p ON a.code = p.code
WHERE p.code = '12345';

/* Result
    date    
------------
 2007-01-01
 2007-01-02
 2007-01-03 */

-- 4. What are the existing conditions in the database in alphabetical order? (designation)

SELECT
    designation
FROM condition
ORDER BY 1;

/* Result
     designation      
----------------------
 Anxious Sleepwalking
 Arachnid Hepatitis
 Wizard Plague
 */

-- 5. What patients were seen on January 1, 2007? (number, name)

SELECT 
    DISTINCT p.code,
    p.name
FROM appointment a
JOIN patient p ON a.code = p.code
WHERE date = '2007-01-01';

/* Result
 code  |      name       
-------+-----------------
 12345 | Xander Gibbs
 23613 | Amelie Harrison
 45643 | Tatiana Barber */

-- 6. What conditions were diagnosed in appointment number 456? (designation)

SELECT 
   DISTINCT designation
FROM condition c
JOIN diagnosed d ON c.ref = d.ref
WHERE d.num = '456';

/* Result
    designation     
--------------------
 Arachnid Hepatitis
 Wizard Plague */

-- 7. How many appointments took place on January 1, 2007? (number)

SELECT 
    COUNT(DISTINCT num) number
FROM appointment a
WHERE date = '2007-01-01';

/* Result
 number 
--------
      8 */

-- 8. How many times was each room used? (room, number)

SELECT 
    room,
    COUNT(*) number
FROM appointment a
GROUP BY 1
ORDER BY 2 DESC;

/* Result
 room | number 
------+--------
  190 |      8
  187 |      4
  204 |      1 */

-- 9. How many times was each room used by the physician with the number 99030? (room, number)

SELECT 
    room,
    COUNT(*) number
FROM appointment a
WHERE
a.number = '99030'
GROUP BY 1
ORDER BY 2 DESC;

/* Result
 room | number 
------+--------
  187 |      3
  190 |      3 */

-- 10. How many times was each room used by the physician Luca Moore? (room, number)

SELECT 
    room,
    COUNT(*) number
FROM appointment a
JOIN physician p ON a.number = p.number
WHERE
p.name = 'Luca Moore'
GROUP BY 1
ORDER BY 2 DESC;

/* Result
 room | number 
------+--------
  187 |      3
  190 |      3 */

-- 11. What rooms were used more than twice on 1 January 2007? (room)

SELECT room
FROM
(SELECT 
    room,
    COUNT(*) number
FROM appointment a
WHERE date = '2007-01-01'
GROUP BY 1
HAVING COUNT(*) > 2) AS rooms;

/* Result
 room 
------
  187
  190 */

-- 12. What are the three most used rooms on that same day? (room)

SELECT room
FROM
(SELECT 
    room,
    COUNT(*) number
FROM appointment a
WHERE date = '2007-01-01'
GROUP BY 1) AS rooms;

/* Result
 room 
------
  187
  190
  204 */
-- 13. What conditions have been diagnosed for patient 12345? (designation)

SELECT 
   DISTINCT designation
FROM condition c
JOIN diagnosed d ON c.ref = d.ref
JOIN appointment a ON a.num = d.num
WHERE a.code = '12345';

/* Result
     designation      
----------------------
 Anxious Sleepwalking
 Arachnid Hepatitis
 Wizard Plague */

-- 14. What patients have been diagnosed with conditions that have also been diagnosed for patient 12345? (name)
