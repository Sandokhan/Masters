-- 1. What are the names and locations of all airports in Portugal? (name, city)

SELECT 
    name,
    city
FROM airport
WHERE country = 'Portugal';

/* Result
     name      |   city    
---------------+-----------
 Sa Carneiro   | Porto
 Portela       | Lisboa
 Faro          | Faro
 Madeira       | Funchal
 Ponta Delgada | S. Miguel */

 -- 2. What are the names of all planes of the DC-10 version? (name)

 SELECT 
    name
 FROM plane AS p
 JOIN model AS m ON p.modelcod = m.modelcod
 WHERE m.version = 'DC-10';

/*  Result
      name      
---------------
 Scott Adams
 Milo Manara
 Douglas Adams */

 -- 3. How many engines does each plane have? (plane_name, number)

 SELECT 
    name, engines
 FROM plane AS p
 JOIN model AS m ON p.modelcod = m.modelcod;

/* Result
      name      | engines 
---------------+---------
 Scott Adams   |       3
 Milo Manara   |       3
 Henki Bilal   |       4
 Gary Larson   |       2
 Bill Waterson |       2
 J R R Tolkien |       4
 Franquin      |       4
 Douglas Adams |       3
 Serpieri      |       4 */

 -- 4. How many flights with a 2 or 3-hour duration are there in the database? (number)

 SELECT
    COUNT(flightcod)
 FROM flight
 WHERE duration IN (2,3);
 
/*  Result 
 count 
-------
     7 */

-- 5. What plane models have a version starting with A3? (modelcod, version)

SELECT 
    modelcod, version
FROM model
WHERE version LIKE 'A3%';

/* Result
 modelcod | version 
----------+---------
        4 | A300
        5 | A340 */

-- 6. What is the code and duration of all flights? Sort the answer from longest to shortest flight. 
-- If two flights have the same duration, sort them by flight code from smallest to largest (flightcod, duration).

SELECT
    flightcod, duration
FROM flight 
ORDER BY duration DESC, flightcod;

/* Result
 flightcod | duration 
-----------+----------
      1004 |        3
      1008 |        3
      1010 |        3
      1001 |        2
      1003 |        2
      1005 |        2
      1111 |        2
      1002 |        1
      1006 |        1
      1007 |        1
      1009 |        1 */

-- 7. Knowing that there are no direct flights from airport 1 (Porto) to airport 12 (London), which 2-legged flights can we use to 
--    travel between those airports? (flightcod1, flightcod2, intermediate_airport_code) 
--    Note: Use the airports codes (1 and 12) instead of the airport names in your query.

SELECT 
    origin.flightcod AS flightcod1,
    destin.flightcod AS flightcod2,
    airport.airportcod AS intermediate_airport_code
FROM flight AS origin
JOIN (SELECT * FROM flight WHERE toairportcod = 12) 
AS destin ON origin.toairportcod = destin.fromairportcod
JOIN airport ON destin.fromairportcod = airportcod
WHERE origin.fromairportcod = 1;

/* Result

 flightcod1 | flightcod2 | intermediate_airport_code 
------------+------------+---------------------------
       1001 |       1003 | Madeira
       1009 |       1008 | Portela
       1111 |       1008 | Portela */

-- 8.  How many airports are there in each country? Sort the answer in ascending order. (country, number)?

SELECT 
    country,
    COUNT(airportcod) AS number
FROM airport
GROUP BY country
ORDER BY number;

/* Result

    country     | number 
----------------+--------
 France         |      2
 United Kingdom |      2
 Portugal       |      5 */

 -- 9. What is the flight code, origin city and destination city of all flights in the database?
 -- Sort the answer by flight code. (flightcod, origin, destination)

SELECT
    DISTINCT f.flightcod,
    a.city AS origin,
    airport.city AS destination
FROM flight f
JOIN (SELECT * FROM flight) AS destin 
ON f.toairportcod = destin.fromairportcod
JOIN airport ON destin.fromairportcod = airport.airportcod
JOIN airport a ON f.fromairportcod = a.airportcod
ORDER BY 1;

/* Result
 flightcod |  origin   | destination 
-----------+-----------+-------------
      1001 | Porto     | Funchal
      1002 | Funchal   | Lisboa
      1003 | Funchal   | Londres
      1004 | S. Miguel | Lisboa
      1005 | Paris     | Funchal
      1007 | Faro      | Porto
      1008 | Lisboa    | Londres
      1009 | Porto     | Lisboa
      1010 | Londres   | S. Miguel
      1111 | Porto     | Lisboa    */

-- 10. What are the flight codes of all flights from Porto to Lisboa?
--  (flightcod)? Note: Your query should use the city names, not the airport codes.

SELECT 
    flightcod
FROM flight
WHERE 
fromairportcod IN (SELECT airportcod FROM airport WHERE city = 'Porto')
AND
toairportcod  IN (SELECT airportcod FROM airport WHERE city = 'Lisboa');

/* Result
 flightcod 
-----------
      1009
      1111 */

-- 11. How many airports are there in each country? (country, number); show only countries with more than 2 airports.

SELECT 
    country,
    COUNT(airportcod) AS number
FROM airport
GROUP BY country
HAVING COUNT(airportcod) > 2;

/* Result

 country  | number 
----------+--------
 Portugal |      5 */

-- 12. What country, or countries, has more airports and how many? (country, number)

SELECT 
    country,
    COUNT(airportcod) AS number
FROM airport
GROUP BY country
ORDER BY number DESC
LIMIT 1;


/* Result
 country  | number 
----------+--------
 Portugal |      5 */

--  13. How many actual planes are there for each plane model? 
--  Sort the result so that the least frequent models appear last (make, version, number). 
--  Note: You do not need to show models that do not have planes.

SELECT
    make,
    version,
    COUNT(*) AS number
FROM model m
JOIN plane USING (modelcod)
GROUP BY 1,2
ORDER BY 3 DESC,1,2;

/* Result

  make   | version | number 
---------+---------+--------
 Airbus  | A340    |      3
 Boeing  | 747     |      3
 Boeing  | 737     |      2
 Airbus  | A300    |      1
 Douglas | DC-10   |      1  */

-- 14. How many actual planes are there for each plane model? 
-- Sort the result so that the least frequent models appear last (make, version, number).
-- Note: Also show models that do not have planes.

SELECT
    make,
    version,
    COUNT(*) AS number
FROM model m
JOIN plane f ON m.modelcod = f.modelcod
GROUP BY 1,2
ORDER BY 3,1,2;

/* Result
  make   | version | number 
---------+---------+--------
 Airbus  | A300    |      1
 Douglas | DC-10   |      1
 Boeing  | 737     |      2
 Airbus  | A340    |      3
 Boeing  | 747     |      3 */