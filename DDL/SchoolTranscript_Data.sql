/* **************
 * SchoolTranscript_Data.sql
 * Jeremy Johnston
 **************** */

 USE SchoolTranscript
 GO

INSERT INTO Students(GivenName, Surname, DateOfBirth) -- Notice no Enrolled Column
VALUES  ('Jeremy','Johnston','19811211 10:23:04 AM'),
		('Charles','Kuhn','19990806 00:00:00 AM'),
		('Ramona','Berry','19910202 00:00:00 AM'),
		('Edwardo','Soto','19700704 00:00:00 AM'),
		('Felecia','Hopkins','19650611 00:00:00 AM')



SELECT GivenName, Surname
FROM Students
WHERE Surname LIKE 'H%'

INSERT INTO Courses(Number, [Name], Credits, [Hours],Cost)
VALUES	   ('DMIT1508','Database Fundamentals','4.5','180','1150'),
		   ('ORGB1320','Organizational Behaviour','3','150','950'),
		   ('COMP1180','Computer Sciences','4.5','180','1260'), 
		   ('DMIT1346','Design Fundamentals','3','150','1040'),
		   ('SOCB1200','Social Behavior','3','150','1260')

SELECT Number, [Name], Credits, [Hours]
FROM   Courses
WHERE  [NAME] LIKE '%Fundamentals%' 

/* ------ Select Statement Commands ------

SELECT		- The Data/Comuns to retrieve
FROM		- The table(s) to search
WHERE		- Filters to apply in the search
GROUP BY	- Re-Organizing Results into groups (Aggregation)
HAVING		- Filter for grouping
ORDER BY	- Sorting Results 

*			- Do not use

*/


