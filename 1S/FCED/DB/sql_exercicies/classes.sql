-- 1. List the students in the database. (num, name)
SELECT * FROM student;

/* Result
 num |   name    
-----+-----------
   1 | Jacob
   2 | William
   3 | Olivia
   4 | Alexander
   5 | Michael
   6 | Charlotte
   7 | Emily
   8 | Emma
   9 | Noah
  10 | Isabella
  11 | Benjamin */
-- 2. In which courses did the student with number 4 enroll? (ref, year, name)
SELECT 
    e.ref,
    year,
    name
FROM enrollment e
JOIN course c ON e.ref = c.ref
WHERE num = 4;

/* Result
 ref | year | name 
-----+------+------
   1 | 2007 | SINF
   2 | 2007 | SIBD
   3 | 2007 | SIEM */

-- 3. In which courses did Michael enroll? (ref, year, name)
SELECT 
    e.ref,
    year,
    c.name
FROM enrollment e
JOIN course c ON e.ref = c.ref
JOIN student s ON e.num = s.num
WHERE s.name = 'Michael';

/* Result
 ref | year | name 
-----+------+------
   1 | 2007 | SINF
   2 | 2007 | SIBD
   3 | 2007 | SIEM */

-- 4. How many students are enrolled in the 2007 edition of the SINF course? (total)
SELECT 
    COUNT(num) AS total
FROM enrollment e
JOIN course c ON e.ref = c.ref
WHERE c.name = 'SINF'
AND e.year = 2007;

/* Result
 total 
-------
     5 */

-- 5. What was the average grade in the first exam of the 2008 edition of the SINF course? (average)
SELECT 
    AVG(grade1) AS average
FROM enrollment e
JOIN course c ON e.ref = c.ref
WHERE c.name = 'SINF'
AND e.year = 2008;

/* Result
       average       
---------------------
 13.2000000000000000 */


-- 6. Which students went to the first SINF exam but did not go to the second one in 2007? (num, name)

SELECT 
    s.num,
    s.name
FROM enrollment e
JOIN course c ON e.ref = c.ref
JOIN student s ON e.num = s.num
WHERE c.name = 'SINF'
AND e.year = 2007
AND grade1 IS NOT NULL
AND grade2 IS NULL;

/* Result
 num |  name   
-----+---------
   5 | Michael */


-- 7. Which students scored higher in the second exam than in the first one in the 2007 edition of the SINF course? (num, name)

-- not considering NULL as 0
SELECT 
    s.num,
    s.name
FROM enrollment e
JOIN course c ON e.ref = c.ref
JOIN student s ON e.num = s.num
WHERE c.name = 'SINF'
AND e.year = 2007
AND grade1 < grade2;

/* Result
 num |  name   
-----+---------
   1 | Jacob
   2 | William */

--  considering NULL as 0
SELECT 
    s.num,
    s.name
FROM enrollment e
JOIN course c ON e.ref = c.ref
JOIN student s ON e.num = s.num
WHERE c.name = 'SINF'
AND e.year = 2007
AND COALESCE(grade1, 0) < COALESCE(grade2, 0);


/* Result 

 num |  name   
-----+---------
   1 | Jacob
   2 | William
   3 | Olivia */

-- 8. For each course, list the average grade of both exams in all editions. (ref, name, average1, average2)

SELECT 
    e.ref,
    name,
    AVG(grade1) AS average1,
    AVG(grade2) AS average2
FROM enrollment e
JOIN course c ON e.ref = c.ref
GROUP BY 1,2;

/* Result
 ref | name |      average1       |      average2       
-----+------+---------------------+---------------------
   1 | SINF | 12.5555555555555556 | 12.7500000000000000
   3 | SIEM | 13.0000000000000000 | 12.2500000000000000
   2 | SIBD | 12.1111111111111111 | 12.7777777777777778 */

-- 9. For each course and year, list the average grade of both exams. (ref, name, year, average1, average2)

SELECT 
    e.ref,
    name,
    year,
    AVG(grade1) AS average1,
    AVG(grade2) AS average2
FROM enrollment e
JOIN course c ON e.ref = c.ref
GROUP BY 1,2,3
ORDER BY 3;

/* Result

 ref | name | year |      average1       |      average2       
-----+------+------+---------------------+---------------------
   1 | SINF | 2007 | 11.7500000000000000 | 13.5000000000000000
   2 | SIBD | 2007 | 12.1666666666666667 | 13.4000000000000000
   3 | SIEM | 2007 | 13.3333333333333333 | 11.4000000000000000
   1 | SINF | 2008 | 13.2000000000000000 | 12.0000000000000000
   2 | SIBD | 2008 | 12.0000000000000000 | 12.0000000000000000
   3 | SIEM | 2008 | 12.6000000000000000 | 13.6666666666666667 */

-- 10. What was the higher grade, considering both exams, obtained in the SINF course? (grade)

-- Version 1
SELECT 
    CASE WHEN max1 > max2 THEN max1
    WHEN max1 < max2 THEN max2
    ELSE NULL END AS grade
FROM (SELECT 
    MAX(grade1) AS max1,
    MAX(grade2) AS max2
FROM enrollment e
JOIN course c ON e.ref = c.ref
WHERE c.name = 'SINF') AS maxG;

-- Version 2
SELECT 
    GREATEST(grade1, grade2) grade
FROM enrollment e
JOIN course c ON e.ref = c.ref
WHERE c.name = 'SINF'
ORDER BY 1 DESC
LIMIT 1;

/* Result
 grade 
-------
    16 */

-- 11. Who got that grade? (num, name)
SELECT
    num,
    name
FROM
(SELECT 
    s.num,
    s.name,
    GREATEST(grade1, grade2) 
FROM enrollment e
JOIN course c ON e.ref = c.ref
JOIN student s ON e.num = s.num
WHERE c.name = 'SINF'
ORDER BY 3 DESC) greaterG
LIMIT 1;

/* Result

 num |  name  
-----+--------
   3 | Olivia */