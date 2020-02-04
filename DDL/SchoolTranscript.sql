/* ******************
* File: SchoolTranscript.sql
* Author: Jeremy Johnston
*
* CREATE DATABASE SchoolTranscript
****************** */
USE SchoolTranscript
GO
/* === Drop Statements === */
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'StudentCourses')
    DROP TABLE StudentCourses
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Courses')
    DROP TABLE Courses
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Students')
    DROP TABLE Students

/* === Create Tables === */
CREATE TABLE Students
(
    StudentID       int             NOT NULL, 
    GivenName       varchar(50)     NOT NULL,
    Surname         varchar(50)     NOT NULL,
    DateOfBirth     datetime        NOT NULL,
    Enrolled        bit             NOT NULL
)

CREATE TABLE Courses
(
    Number      varchar(10)         NOT NULL,
    [Name]      varchar(50)         NOT NULL,
    Credits     decimal(3,1)        NOT NULL,
    [Hours]     tinyint             NOT NULL,
    Active      bit                 NOT NULL,
    Cost        money               NOT NULL
)

CREATE TABLE StudentCourses
(
    StudentID       int                 NOT NULL,
    CourseNumber    varchar(10)         NOT NULL,
    [Year]          tinyint             NOT NULL,
    Term            char(3)             NOT NULL,
    FinalMark       tinyint                 Null,
    [Status]        char(1)             NOT NULL
)

-- table definition is a set of column declarations