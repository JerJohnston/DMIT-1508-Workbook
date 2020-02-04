/* **************
 * SchoolTranscript_Data.sql
 * Jeremy Johnston
 **************** */

 USE SchoolTranscript
 GO

 INSERT INTO Students(GivenName, Surname, DateOfBirth) -- Notice no Enrolled Column
 VALUES ('Jeremy', 'Johnston', '19811211 10:23:04 AM')

 SELECT * FROM Students