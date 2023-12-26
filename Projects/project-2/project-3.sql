USE CSE581projects


----	SP-1	----
CREATE PROCEDURE CountStudentsByStreamInaCourse
@CRN INT
AS
BEGIN
	DECLARE @AreaId INT
    DECLARE @StudentCount INT
	DECLARE @Stream VARCHAR(50)
	DECLARE @CRNCheck INT

    -- Declare and open the cursor
    DECLARE StreamCursor CURSOR FOR
    SELECT DISTINCT AreaID FROM AreaOfStudy

    OPEN StreamCursor
    FETCH NEXT FROM StreamCursor INTO @AreaId

	PRINT 'Result:'
	PRINT ''

	-- Check if the course exists in the course schedule
	SELECT @CRNCheck = Count(*) FROM CourseSchedule WHERE CRN = @CRN

	IF @CRNCheck = 0
	BEGIN
		PRINT 'Course not found.'
	END
	ELSE
	BEGIN

		-- Iterate through each stream and count the students
		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- Count students for the current stream
			SELECT @StudentCount = COUNT(*) FROM AreaOfStudy
			WHERE StudentID in (SELECT StudentID FROM CourseEnrollment WHERE EnrollmentStatusID = 1 AND CRN = @CRN)
			AND AreaID = @AreaId

			SELECT @Stream = Name
			FROM MajorMinor
			WHERE AreaOfStudyID = @AreaId

			-- Print the result
			PRINT 'Major: ' + @Stream
			PRINT 'StudentCount: '+ CAST(@StudentCount AS NVARCHAR(10))
			PRINT ''

			FETCH NEXT FROM StreamCursor INTO @AreaId
		END
	END
	-- Close and deallocate the cursor
	CLOSE StreamCursor
	DEALLOCATE StreamCursor
END;








EXEC CountStudentsByStreamInaCourse @CRN=1

EXEC CountStudentsByStreamInaCourse @CRN=10



----	SP-2	----

SELECT * FROM Employees
SELECT * FROM EmployeeAndJob
SELECT * FROM JobInformation


GO
CREATE PROCEDURE UpdateEmployeeSalary
@EmployeeId INT,
@NewSalary DECIMAL(10, 2)
AS
BEGIN
	DECLARE @MinSalary DECIMAL(10, 2)
    DECLARE @MaxSalary DECIMAL(10, 2)


	IF NOT EXISTS (SELECT 1 FROM Employees WHERE EmployeeID = @EmployeeId)
    BEGIN
        PRINT 'Invalid EmployeeID.';
        RETURN;
    END

	-- Get the salary range for the employee's department
    SELECT @MinSalary = MinPay, @MaxSalary = MaxPay
    FROM JobInformation
    WHERE JobCode = (SELECT JobCode FROM EmployeeAndJob WHERE EmployeeID = @EmployeeID);

    -- Update the salary based on the salary range
    UPDATE Employees
    SET AnnualSalary = 
        CASE
            WHEN @NewSalary > @MinSalary AND @NewSalary < @MaxSalary THEN @NewSalary
			ELSE AnnualSalary
        END
    WHERE EmployeeID = @EmployeeID;

END;


EXEC UpdateEmployeeSalary @EmployeeId=1, @NewSalary=95000
EXEC UpdateEmployeeSalary @EmployeeId=1, @NewSalary=105000
EXEC UpdateEmployeeSalary @EmployeeId=5, @NewSalary=105000

SELECT * FROM Employees



----	SP-3	----
CREATE PROCEDURE DeleteCourseEnrollmentWithInstructor
    @StudentID INT,
    @CRN INT,
    @InstructorEmployeeID INT
AS
BEGIN
    /* Checking invalid input */
    IF NOT EXISTS (
        SELECT 1
        FROM CourseEnrollment ce
        INNER JOIN CourseInstructor I ON ce.CRN = I.CRN
        WHERE ce.StudentID = @StudentID AND ce.CRN = @CRN AND I.EmployeeID = @InstructorEmployeeID
    )
    BEGIN
        PRINT 'Course enrollment record does not exist for the specified student, course, and instructor.';
        RETURN;
    END

    DELETE FROM CourseEnrollment
    WHERE StudentID = @StudentID AND CRN = @CRN;

    PRINT 'Course enrollment record deleted successfully.';
END;





Select * from CourseEnrollment;

Select * from CourseInstructor;


EXEC DeleteCourseEnrollmentWithInstructor
    @StudentID = 2,
    @CRN = 4,
    @InstructorEmployeeID = 2;

EXEC DeleteCourseEnrollmentWithInstructor
    @StudentID = 2,
    @CRN = 2,
    @InstructorEmployeeID = 2;




----	SP-4	----
SELECT * FROM CourseSchedule
SELECT * FROM CourseDailySchedule
SELECT * FROM CourseEnrollment
SELECT * FROM EnrollmentStatus

CREATE PROCEDURE CheckScheduleOverlap
    @StudentID INT,
    @CRN INT
AS
BEGIN
    DECLARE @ExistingCourseCount INT;
	DECLARE @CurrentEnrollmentStatus INT;

	SELECT @CurrentEnrollmentStatus = COUNT(*)
	FROM CourseEnrollment
	WHERE StudentID = @StudentID AND CRN = @CRN

	IF NOT EXISTS (SELECT 1 FROM Students WHERE StudentID = @StudentID)
        OR NOT EXISTS (SELECT 1 FROM CourseSchedule WHERE CRN = @CRN)
    BEGIN
        PRINT 'Invalid StudentID or CRN. Please provide valid inputs.';
        RETURN;
    END

	IF @CurrentEnrollmentStatus = 1
	BEGIN
		PRINT 'Student already Enrolled in this course.'
	END
	ELSE
	BEGIN

		-- Check if the student is already enrolled in another course with overlapping schedule
		SELECT @ExistingCourseCount = COUNT(*)
		FROM CourseEnrollment ce
		JOIN CourseSchedule cs ON ce.CRN = cs.CRN
		JOIN CourseDailySchedule cds ON ce.CRN = cds.CRN
		WHERE ce.StudentID = @StudentID
			AND cs.CRN <> @CRN -- Exclude the course to be enrolled
			AND (
				(cds.StartTime <= (SELECT EndTime FROM CourseDailySchedule WHERE CRN = @CRN))
				AND
				(cds.EndTime >= (SELECT StartTime FROM CourseDailySchedule WHERE CRN = @CRN))
				AND
				(cds.Day != (SELECT Day FROM CourseDailySchedule WHERE CRN = @CRN))
			);

		IF @ExistingCourseCount = 0
		BEGIN
			PRINT 'No overlap with the current schedule of student.';
		END
		ELSE
		BEGIN
			PRINT 'Student could not be enrolled due to schedule overlap with existing courses.';
		END

	END
END;


EXEC CheckScheduleOverlap @StudentID=1, @CRN=1
EXEC CheckScheduleOverlap @StudentID=1, @CRN=3
EXEC CheckScheduleOverlap @StudentID=1, @CRN=5
EXEC CheckScheduleOverlap @StudentID=10, @CRN=1
EXEC CheckScheduleOverlap @StudentID=1, @CRN=10

SELECT * FROM CourseEnrollment



----	VIEW	----
CREATE VIEW BenefitsView
AS
SELECT emp.EmployeeID, p.NTID, CONCAT(p.FirstName, ' ', ISNULL(p.MiddleName + ' ', ''), p.LastName) AS EmployeeName, 
ben.BenefitID, ins.InsuranceDescription, bcov.BenefitCoverageDescription, ben.EmployeePremiumAmount, ben.EmployerPremiumAmount 
FROM Employees emp
JOIN Persons p ON emp.PersonID = p.PersonID
JOIN Benefits ben ON emp.EmployeeID = ben.EmployeeID
JOIN BenefitCoverage bcov ON ben.BenefitCoverageID = bcov.BenefitCoverageID
JOIN InsuranceType ins ON ben.InsuranceTypeID = ins.InsuranceTypeID

SELECT * FROM BenefitsView




----	Function ----
CREATE FUNCTION CheckAssistantshipEligibility (@StudentID INT)
RETURNS VARCHAR(500)
AS
BEGIN
	DECLARE @Result VARCHAR(500)
    DECLARE @IsEligible INT = 1; -- Default to eligible

	IF NOT EXISTS(
		SELECT 1 FROM Students WHERE StudentID = @StudentID
	)
	BEGIN
		SET @Result = 'Invalid StudentId.';
		RETURN @Result;
	END

    -- Declare a cursor to loop through core courses in CourseSchedule
    DECLARE course_cursor CURSOR FOR
    SELECT CRN
    FROM CourseSchedule
    WHERE CourseNo >= 550; -- Assuming CourseNumber is used for checking core courses

    OPEN course_cursor;

    --DECLARE @CourseCode NVARCHAR(20);
	DECLARE @CRN INT;

    -- Fetch the first course
    FETCH NEXT FROM course_cursor INTO @CRN;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @FinalGrade VARCHAR(2);

        -- Check if the student has enrolled in the core course
        SELECT @FinalGrade = CE.FinalTermGrade
        FROM CourseEnrollment CE
        JOIN CourseSchedule C ON C.CRN = CE.CRN
        WHERE CE.StudentID = @StudentID
            AND C.CRN = @CRN;

        IF @FinalGrade IS NOT NULL
        BEGIN
            -- Check if the final grade is 'A' and the course is core
            IF @FinalGrade <> 'A'
            BEGIN
                SET @IsEligible = 0; -- Set eligibility to false
            END
        END
        ELSE
        BEGIN
            -- Student is not enrolled in the core course, no action needed
			SET @IsEligible = -1
        END

        -- Fetch the next course
        FETCH NEXT FROM course_cursor INTO @CRN;
    END

    CLOSE course_cursor;
    DEALLOCATE course_cursor;

	
	IF @IsEligible = 1
	BEGIN
		SET @Result = 'Eligible for Assistantship'
	END
	ELSE
	BEGIN
		IF @IsEligible = 0
		BEGIN
			SET @Result = 'Not Eligible (Core Course Grade Requirement)'
		END

		ELSE
		BEGIN
			SET @Result = 'Not Eligible for Assistantship (No Core Courses)'
		END
	END

    -- Check if the student is eligible for TA role
    RETURN @Result;
END;



DECLARE @StudentID INT = 1;
DECLARE @Eligibility NVARCHAR(50);

SET @Eligibility = vgiduthu.CheckAssistantshipEligibility(@StudentID);
PRINT @Eligibility;


DECLARE @StudentID INT = 2;
DECLARE @Eligibility NVARCHAR(50);

SET @Eligibility = vgiduthu.CheckAssistantshipEligibility(@StudentID);
PRINT @Eligibility;


DECLARE @StudentID INT = 3;
DECLARE @Eligibility NVARCHAR(50);

SET @Eligibility = vgiduthu.CheckAssistantshipEligibility(@StudentID);
PRINT @Eligibility;


DECLARE @StudentID INT = 4;
DECLARE @Eligibility NVARCHAR(50);

SET @Eligibility = vgiduthu.CheckAssistantshipEligibility(@StudentID);
PRINT @Eligibility;


SELECT * FROM CourseEnrollment
SELECT * FROM CourseSchedule


---- Graders Access Grant	----
GRANT execute on vgiduthu.CountStudentsByStreamInaCourse TO GRADERS;
GRANT execute on vgiduthu.UpdateEmployeeSalary TO GRADERS;
GRANT execute on vgiduthu.DeleteCourseEnrollmentWithInstructor TO GRADERS;
GRANT execute on vgiduthu.CheckScheduleOverlap TO GRADERS;
GRANT select on vgiduthu.BenefitsView TO GRADERS;
GRANT execute on vgiduthu.CheckAssistantshipEligibility TO GRADERS;
