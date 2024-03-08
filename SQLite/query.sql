SELECT first_name, last_name FROM people;

-- WHERE
SELECT *  
FROM people 
WHERE state_code = 'CO';

SELECT *  
FROM people 
WHERE shirt_or_hat = 'hat';

SELECT last_name, first_name, shirt_or_hat
FROM people
WHERE shirt_or_hat = 'shirt';


-- AND
SELECT last_name, first_name, shirt_or_hat, state_code, team
FROM people
WHERE shirt_or_hat='shirt' AND state_code='AL' AND team!= 'Angry Ants';


-- IS NOT, <>
SELECT last_name, first_name, shirt_or_hat, state_code, team
FROM people
WHERE shirt_or_hat IS'shirt' AND state_code IS NOT 'AL' AND team <> 'Angry Ants';


-- OR, IS, use of ()
SELECT last_name, first_name, shirt_or_hat, state_code
FROM people
WHERE (state_code IS'CA' OR state_code IS 'CO') AND shirt_or_hat IS 'shirt';


-- LIKE % 
SELECT *
FROM people
WHERE state_code LIKE 'C%';

SELECT *
FROM people
WHERE state_code LIKE '%N';


-- LIMIT, OFFSET
SELECT *
FROM people
WHERE first_name LIKE 'B%N'
LIMIT 5 OFFSET 5;


-- ORDER BY, ASC, DESC
SELECT first_name, last_name
FROM people
ORDER BY first_name DESC;


-- LENGTH FUNCTION
SELECT first_name, length(first_name)
FROM people;


-- DISTINCT FUNCTION
SELECT DISTINCT(first_name)
FROM people
ORDER BY first_name;


-- COUNT FUNCTION
SELECT COUNT(*)
FROM people
WHERE state_code IS 'CA';


-- QUIZ
SELECT team, shirt_or_hat, first_name, last_name
FROM people
WHERE state_code IS 'CO'
ORDER BY 	team, shirt_or_hat, last_name DESC;


-- JOIN
SELECT * 
FROM states;

SELECT people.first_name, people.state_code, states.division
FROM people
JOIN states ON people.state_code=states.state_abbrev;

SELECT ppl.first_name, ppl.state_code, st.division
FROM people ppl, states st
WHERE ppl.state_code=st.state_abbrev;


-- LEFT JOIN
SELECT people.first_name, people.last_name,  people.state_code, states.state_name
FROM states
LEFT JOIN people ON people.state_code=states.state_abbrev;


-- GROUP BY
SELECT first_name, COUNT(first_name)
FROM people
GROUP BY first_name;

SELECT state_code, COUNT(state_code)
FROM people
GROUP BY state_code;

SELECT state_code, quiz_points, COUNT(quiz_points)
FROM people
GROUP BY state_code, quiz_points;


-- QUIZ
SELECT states.region, people.team, COUNT(people.team)
FROM states
JOIN people ON states.state_abbrev=people.state_code
GROUP BY states.region, people.team;

SELECT states.region,  COUNT(people.id_number)
FROM states
JOIN people ON states.state_abbrev=people.state_code
GROUP BY states.region;


-- MATH
SELECT 1/3; -- returns 0
SELECT 1/3.0; -- returns 0.3333
SELECT 1>9; -- returns 0, meaning false
SELECT 1!=0; -- returns 1, meaning true

SELECT first_name, quiz_points
FROM people
WHERE quiz_points > 70
ORDER BY quiz_points DESC;

--MIN, MAX 
SELECT min(quiz_points), max(quiz_points)
FROM people;

-- SUM
SELECT SUM(quiz_points)
FROM people;

--AVG
SELECT team, COUNT(team), SUM(quiz_points), AVG(quiz_points)
FROM people
GROUP BY team;


-- SUB QUERY/SUBSELECT
SELECT first_name, last_name, quiz_points
FROM people
WHERE quiz_points=(
				SELECT MAX(quiz_points) FROM people
				);
				
SELECT *
FROM people
WHERE state_code=(
				SELECT state_abbrev FROM states WHERE state_name='Minnesota'
				);
				

--LOWER, UPPER
SELECT LOWER(first_name), UPPER(last_name)
FROM people;		


-- SUBSTR
SELECT first_name, substr(last_name, 1, 5)
FROM people;

SELECT first_name, substr(last_name, -4) --last letters
FROM people;


-- REPLACE / case sensitive
SELECT REPLACE(first_name, "a", "-")
FROM people;


-- CAST (order by sequence 1,2,3)
SELECT quiz_points
FROM people
ORDER 	BY	CAST(quiz_points AS CHAR);


-- returns the max 99 instead of 100
SELECT MAX(CAST(quiz_points AS CHAR))
FROM people;


-- AS
SELECT first_name AS firstname, UPPER(last_name) AS surname
FROM people;


-- QUIZ 
SELECT 
	states.state_name AS STATE, 
	MAX(people.quiz_points) AS MAXPOINTS, 
	AVG(people.quiz_points) AS AVGPOINTS
FROM 
	people
	JOIN 
		states 
			ON states.state_abbrev=people.state_code
GROUP BY 
	state_code
ORDER BY 
	AVGPOINTS DESC;
	
	
-- INSERT
INSERT INTO people (first_name) VALUES ('Marcela');

INSERT INTO people 
(first_name, last_name) 
VALUES 
('Marcela', 'Mejia'),
('Ruben', NULL);

SELECT first_name, last_name
FROM people;


-- UPDATE
UPDATE people
SET last_name='Morrison'
WHERE first_name='Carlos' AND city='Houston';

SELECT *
FROM people
WHERE id_number=175;

UPDATE people
SET last_name='Mejia'
WHERE id_number=175;


-- DELETE
DELETE FROM people WHERE id_number=1001;
DELETE FROM people WHERE quiz_points IS NULL;


--QUIZ / find Alice, from FL, Cobras team
SELECT id_number, first_name, state_code, team
FROM people
WHERE first_name='Alice' 
	AND 
		state_code= 'FL' 
	AND
		team LIKE '%Cobras';
