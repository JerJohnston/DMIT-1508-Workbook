-- Stored Procedures (Sprocs)
-- File: C - Stored Procedures.sql

USE [A01-School]
GO

-- Take the following queries and turn them into stored procedures.

-- 1.   Selects the studentID's, CourseID and mark where the Mark is between 70 and 80
SELECT  StudentID, CourseId, Mark
FROM    Registration
WHERE   Mark BETWEEN 70 AND 80 -- BETWEEN is inclusive
--      Place this in a stored procedure that has two parameters,
--      one for the upper value and one for the lower value.
--      Call the stored procedure ListStudentMarksByRange

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'ListStudentMarksByRange')
    DROP PROCEDURE ListStudentMarksByRange
GO

CREATE PROCEDURE ListStudentMarksByRange

    @Lower decimal,
    @Upper decimal

AS

    SELECT StudentID, CourseId, Mark
    FROM Registration
    WHERE Mark BETWEEN 70 AND 80

RETURN
GO

EXEC ListStudentMarksByRange 70, 80
GO

ALTER PROCEDURE ListStudentMarksByRange

    @Lower decimal,
    @Upper decimal
AS
    IF @Lower IS NULL OR @Upper IS NULL
        RAISERROR('Parameters Lower and Upper cannot be NULL!', 16, 1)
    ELSE IF @Lower > @Upper
        RAISERROR('Lower Paramater cannot be greater then higher parameter!', 16, 1)
    ELSE IF @Lower < 0 
        RAISERROR('Lower Paramater cannot be less then 0!', 16, 1)
    ELSE IF @Upper > 100
        RAISERROR('ALL YOUR BASE ARE BELONG TO US!!', 16, 1)
    ELSE 
        SELECT StudentID, CourseId, Mark
        FROM Registration
        WHERE Mark BETWEEN 70 AND 80

RETURN
GO

EXEC ListStudentMarksByRange 65, 100
GO


/* ----------------------------------------------------- */

-- 2.   Selects the Staff full names and the Course ID's they teach.
SELECT  DISTINCT -- The DISTINCT keyword will remove duplate rows from the results
        FirstName + ' ' + LastName AS 'Staff Full Name',
        CourseId
FROM    Staff S
    INNER JOIN Registration R
        ON S.StaffID = R.StaffID
ORDER BY 'Staff Full Name', CourseId
--      Place this in a stored procedure called CourseInstructors.


IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'CourseInstructors')
    DROP PROCEDURE CourseInstructors
GO

CREATE PROCEDURE CourseInstructors

AS
    SELECT  DISTINCT 
        FirstName + ' ' + LastName AS 'Staff Full Name',
        CourseId
    FROM    Staff S
        INNER JOIN Registration R
            ON S.StaffID = R.StaffID
    ORDER BY 'Staff Full Name', CourseId

RETURN
GO

EXEC CourseInstructors
GO

/* ----------------------------------------------------- */

-- 3.   Selects the students first and last names who have last names starting with S.
SELECT  FirstName, LastName
FROM    Student
WHERE   LastName LIKE 'S%'
--      Place this in a stored procedure called FindStudentByLastName.
--      The parameter should be called @PartialName.
--      Do NOT assume that the '%' is part of the value in the parameter variable;
--      Your solution should concatenate the @PartialName with the wildcard.

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'FindStudentByLastName')
    DROP PROCEDURE FindStudentByLastName
GO

CREATE PROCEDURE FindStudentByLastName

@PartialName AS varchar(max)  

AS

    SELECT  FirstName, LastName
    FROM    Student
    WHERE   Lastname LIKE @PartialName + '%'

RETURN
GO

EXEC FindStudentByLastName 'S'
GO

/* ----------------------------------------------------- */

-- 4.   Selects the CourseID's and Coursenames where the CourseName contains the word 'programming'.
SELECT  CourseId, CourseName
FROM    Course
WHERE   CourseName LIKE '%programming%'
--      Place this in a stored procedure called FindCourse.
--      The parameter should be called @PartialName.
--      Do NOT assume that the '%' is part of the value in the parameter variable.

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'FindCourse')
    DROP PROCEDURE FindCourse
GO

CREATE PROCEDURE FindCourse

@PartialName varchar(max)

AS

	SELECT  CourseId, CourseName
	FROM    Course
	WHERE   CourseName LIKE '%' + @PartialName + '%'
	
RETURN
GO

EXEC FindCourse 'Programming'
GO 


/* ----------------------------------------------------- */

-- 5.   Selects the Payment Type Description(s) that have the highest number of Payments made.
SELECT PaymentTypeDescription
FROM   Payment 
    INNER JOIN PaymentType 
        ON Payment.PaymentTypeID = PaymentType.PaymentTypeID
GROUP BY PaymentType.PaymentTypeID, PaymentTypeDescription 
HAVING COUNT(PaymentType.PaymentTypeID) >= ALL (SELECT COUNT(PaymentTypeID)
                                                FROM Payment 
                                                GROUP BY PaymentTypeID)
--      Place this in a stored procedure called MostFrequentPaymentTypes.

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'MostFrequentPaymentTypes')
    DROP PROCEDURE MostFrequentPaymentTypes
GO

CREATE PROCEDURE MostFrequentPaymentTypes

AS

	SELECT PaymentTypeDescription
	FROM   Payment 
		INNER JOIN PaymentType 
		 ON Payment.PaymentTypeID = PaymentType.PaymentTypeID
	GROUP BY PaymentType.PaymentTypeID, PaymentTypeDescription 
	HAVING COUNT(PaymentType.PaymentTypeID) >= ALL (SELECT COUNT(PaymentTypeID)
													FROM Payment 
													GROUP BY PaymentTypeID)

RETURN
GO

EXEC MostFrequentPaymentTypes
GO

	

/* ----------------------------------------------------- */

-- 6.   Selects the current staff members that are in a particular job position.
SELECT  FirstName + ' ' + LastName AS 'StaffFullName'
FROM    Position P
    INNER JOIN Staff S ON S.PositionID = P.PositionID
WHERE   DateReleased IS NULL
  AND   PositionDescription = 'Instructor'
--      Place this in a stored procedure called StaffByPosition

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'StaffByPosition')
    DROP PROCEDURE StaffByPosition
GO

CREATE PROCEDURE StaffByPosition

@StaffPosition AS varchar(max)

AS

	SELECT  FirstName + ' ' + LastName AS 'StaffFullName'
	FROM    Position P
		INNER JOIN Staff S ON S.PositionID = P.PositionID
	WHERE   DateReleased IS NULL
	  AND   PositionDescription LIKE '%' + @StaffPosition + '%'

RETURN
GO

EXEC StaffbyPosition 'Instructor'
GO 



/* ----------------------------------------------------- */

-- 7.   Selects the staff members that have taught a particular course (e.g.: 'DMIT101').
SELECT  DISTINCT FirstName + ' ' + LastName AS 'StaffFullName',
        CourseId
FROM    Registration R
    INNER JOIN Staff S ON S.StaffID = R.StaffID
WHERE   DateReleased IS NULL
  AND   CourseId = 'DMIT101'
--      This select should also accommodate inputs with wildcards. (Change = to LIKE)
--      Place this in a stored procedure called StaffByCourseExperience

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'StaffByCourseExperience')
    DROP PROCEDURE StaffByCourseExperience
GO

CREATE PROCEDURE StaffByCourseExperience

@SelectedCourse AS varchar(max)

AS

	SELECT  DISTINCT FirstName + ' ' + LastName AS 'StaffFullName',
			CourseId
	FROM    Registration R
		INNER JOIN Staff S ON S.StaffID = R.StaffID
	WHERE   DateReleased IS NULL
	  AND   CourseId LIKE '%' + @SelectedCourse + '%'

RETURN
GO

EXEC StaffByCourseExperience 'DMIT101'
GO

