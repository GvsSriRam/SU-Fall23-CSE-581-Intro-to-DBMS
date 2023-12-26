USE CSE581labs;
GO

CREATE PROCEDURE EnrollStudent (
  @CourseId INT,
  @StudentId VARCHAR(20)
) AS
BEGIN
  DECLARE @EnrollStatus INT, @AssignFaculty VARCHAR(20), @OutPrint VARCHAR(MAX), @LeftSeat INT;

  SELECT @EnrollStatus = (SELECT EnrollmentId
                         FROM CourseEnrollment
                         WHERE CourseId = @CourseId AND StudentId = @StudentId);

  IF @EnrollStatus IS NOT NULL
  BEGIN
    SET @OutPrint = 'The student is already enrolled';
  END
  ELSE
  BEGIN
    SELECT @AssignFaculty = (SELECT Faculty
                             FROM Courses
                             WHERE CourseId = @CourseId);
    SELECT @LeftSeat = (SELECT OpenSeats
                       FROM Courses
                       WHERE CourseId = @CourseId);

    IF @LeftSeat > 0
    BEGIN
      INSERT INTO CourseEnrollment (StudentId, CourseId)
      VALUES (@StudentId, @CourseId);

      UPDATE Courses
      SET OpenSeats = @LeftSeat - 1
      WHERE CourseId = @CourseId;

      SET @OutPrint = 'Student enrolled';
    END
    ELSE
    BEGIN
      SET @OutPrint = 'No seat available. Student not enrolled';
    END
  END

  PRINT @OutPrint;
END;
GO

-- Select data from the Courses and CourseEnrollment tables
SELECT * FROM Courses;
SELECT * FROM CourseEnrollment;

-- Execute the stored procedure with sample data
EXEC EnrollStudent 1, '01-HJPotter';
EXEC EnrollStudent 6, '01-HJPotter';
EXEC EnrollStudent 7, '01-HJPotter';
EXEC EnrollStudent 2, '03-HJGranger';
EXEC EnrollStudent 7, '03-HJGranger';

-- Select data from the Courses and CourseEnrollment tables
SELECT * FROM Courses;
SELECT * FROM CourseEnrollment;