USE CSE581projects

---- Gender - Creation ----

CREATE TABLE Gender(
GenderID Int PRIMARY KEY IDENTITY (1,1),
Name VARCHAR(50) NOT NULL
)

---- Race - Creation ----

CREATE TABLE Race(
RaceID Int PRIMARY KEY IDENTITY (1,1),
Name VARCHAR(50) NOT NULL
)

---- State - Creation ----

CREATE TABLE State(
StateID Int PRIMARY KEY IDENTITY (1,1),
Name VARCHAR(50) NOT NULL
)

---- Country - Creation ----

CREATE TABLE Country(
CountryID Int PRIMARY KEY IDENTITY (1,1),
Name VARCHAR(50) NOT NULL
)

---- Address - Creation ----

CREATE TABLE Address(
AddressID Int PRIMARY KEY IDENTITY (1,1),
Apartment VARCHAR(100) NOT NULL,
Street VARCHAR(100),
City VARCHAR(50) NOT NULL,
StateID Int NOT NULL,
FOREIGN KEY (StateID) REFERENCES State(StateID),
ZIPCode Int NOT NULL,
CountryID Int NOT NULL,
FOREIGN KEY (CountryID) REFERENCES Country(CountryID),
)

---- Persons - Creation ----

CREATE TABLE Persons(
PersonID Int PRIMARY KEY IDENTITY (1,1),
NTID CHAR(8) NOT NULL,
Password VARCHAR(50) NOT NULL,
SSN VARCHAR(10),
FirstName VARCHAR(50) NOT NULL,
MiddleName VARCHAR(20),
LastName VARCHAR(20) NOT NULL,
DateOfBirth DATE,
GenderID Int NOT NULL,
FOREIGN KEY (GenderID) REFERENCES Gender(GenderID),
RaceID Int NOT NULL,
FOREIGN KEY (RaceID) REFERENCES Race(RaceID),
EmailID VARCHAR(50) NOT NULL,
HomeAddressID Int NOT NULL,
FOREIGN KEY (HomeAddressID) REFERENCES Address(AddressID),
MailingAddressID Int NOT NULL,
FOREIGN KEY (MailingAddressID) REFERENCES Address(AddressID),
MobileNo VARCHAR(10)
)

---- Gender - Data Insertion ----

INSERT INTO Gender (Name)
VALUES
('Male'), 
('Female'), 
('Others'), 
('Prefer not to say')

---- Race - Data Insertion ----

INSERT INTO Race (Name)
VALUES
('American Indian'), 
('Asian'), 
('Black or African American'), 
('Hispanic or Latino'), 
('Native Hawaiian or Other Pacific Islander'), 
('White')

---- State - Data Insertion ----

INSERT INTO State (Name)
VALUES
('New York'), 
('New Jersey'), 
('California'), 
('Texas'),
('Washington'),
('Ohio'),
('Andhra Pradesh'),
('Telangana'),
('Other')

---- Country - Data Insertion ----

INSERT INTO Country (Name)
VALUES
('United States'), 
('India'), 
('China'), 
('South Korea'), 
('North Korea'), 
('United Kingdom')

---- Gender - Data Verification ----

SELECT * FROM Gender

---- Race - Data Insertion ----

SELECT * FROM Race

---- State - Data Verification ----

SELECT * FROM State

---- Country - Data Verification ----

SELECT * FROM Country

---- Address - Data Insertion ----

INSERT INTO Address (Apartment, Street, City, StateID, ZIPCode, CountryID)
VALUES
('415 Clarendon St', 'Unit-3', 'Syracuse', 1, 13210, 1),
('Door No: 14-15-16 A', 'Annapurnamma Peta', 'Rajahmundry', 7, 533104, 2),
('101 Ostrom Ave, Apt-4', NULL, 'Newark', 2,12367, 1),
('249 Roosevelt', NULL, 'San Hose', 3, 12345, 1),
('515 Clarendon St Unit-2', NULL, 'London', 9, 19876, 6)

---- Address - Data Verification ----

SELECT * FROM Address

---- Persons - Data Insertion ----

INSERT INTO Persons(NTID, Password, SSN, FirstName, MiddleName, LastName, DateOfBirth, GenderID, RaceID, EmailID, HomeAddressID,
MailingAddressID, MobileNo)
VALUES
('vgiduthu', 'vgiduthu@1234', NULL, 'Venkata Satya Sri Ram', NULL, 'Giduthuri', '1998-03-06', 1, 2, 'vgiduthu@syr.edu', 2, 1, '1234567890'),
('sgowredd', 'sgowredd@1234', NULL, 'Sai Vennela', 'Reddy', 'Gowreddy', '1999-12-22', 1, 2, 'sgowredd@syr.edu', 3, 3, '1234567890'),
('pnallala', 'pnallala@1234', NULL, 'Pranathi', NULL, 'Nallala', NULL, 1, 2, 'pnallala@syr.edu', 3, 3, NULL),
('chandank', 'chandank@1234', '1234567890', 'Sree', 'Chandan', 'K', '2000-12-13', 1, 2, 'chandank@syr.edu', 2, 2, '1234567890'),
('shravans', 'shravans@1234', '0123456789', 'Shravan', NULL, 'Sailada', NULL, 1, 2, 'shravans@syr.edu', 4, 4, NULL),
('keshavch', 'keshavch@1234', '0987654321', 'Keshav', NULL, 'Ch', NULL, 1, 2, 'keshavch@syr.edu', 5, 5, '1234567890')

---- Persons - Data Verification ----

SELECT * FROM Persons

---- StudentStatus - Creation ----

CREATE TABLE StudentStatus(
StudentStatusID Int PRIMARY KEY IDENTITY (1,1),
Name VARCHAR(50) NOT NULL
)

---- StudentType - Creation ----

CREATE TABLE StudentType(
StudentTypeID Int PRIMARY KEY IDENTITY (1,1),
Name VARCHAR(50) NOT NULL
)

---- StudentLevel - Creation ----

CREATE TABLE StudentLevel(
StudentLevelID Int PRIMARY KEY IDENTITY (1,1),
Name VARCHAR(50) NOT NULL
)

---- StudentStatus - Data Insertion ----

INSERT INTO StudentStatus (Name)
VALUES
('active'), 
('suspended'), 
('in-active')

---- StudentType - Data Insertion ----

INSERT INTO StudentType (Name)
VALUES
('new freshmen'), 
('continue'), 
('transfer'),
('re-admitted'), 
('new graduate'), 
('continue graduate')

---- StudentLevel - Data Insertion ----

INSERT INTO StudentLevel (Name)
VALUES
('undergraduate'), 
('graduate')

---- StudentStatus - Data Verification ----

SELECT * FROM StudentStatus

---- StudentType - Data Verification ----

SELECT * FROM StudentType

---- StudentLevel - Data Verification ----

SELECT * FROM StudentLevel

---- College - Creation ----

CREATE TABLE College(
CollegeID Int PRIMARY KEY IDENTITY (1,1),
Name VARCHAR(50) NOT NULL
)

---- College - Data Insertion ----

INSERT INTO College (Name)
VALUES
('College of Engineering and Computer Science'), 
('College of Information Sciences'),
('Whitman School of Business'),
('College of Visual Performance and Arts'),
('College of Arts and Sciences'),
('College of Professional Sciences')

---- College - Data Verification ----

SELECT * FROM College

---- MajorMinor - Creation ----

CREATE TABLE MajorMinor(
AreaOfStudyID Int PRIMARY KEY IDENTITY (1,1),
CollegeID Int NOT NULL,
FOREIGN KEY (CollegeID) REFERENCES College(CollegeID),
Name VARCHAR(50) NOT NULL
)

---- MajorMinor - Data Insertion ----

INSERT INTO MajorMinor (CollegeID, Name)
VALUES
(1, 'Masters in Computers and Information Science'), 
(2, 'Masters in Information Science'),
(3, 'Masters in Business Analytics'),
(1, 'Masters in Computer Engineering'),
(2, 'Masters in Applied Data Science'),
(1, 'Bachelors in Computer Science and Engineering')

---- MajorMinor - Data Verification ----

SELECT * FROM MajorMinor

---- Students - Creation ----

CREATE TABLE Students(
StudentID Int PRIMARY KEY IDENTITY(1,1),
PersonID Int,
FOREIGN KEY (PersonID) REFERENCES Persons(PersonID),
StudentStatusID Int,
FOREIGN KEY (StudentStatusID) REFERENCES StudentStatus(StudentStatusID),
StudentTypeID Int,
FOREIGN KEY (StudentTypeID) REFERENCES StudentType(StudentTypeID),
StudentLevelID Int,
FOREIGN KEY (StudentLevelID) REFERENCES StudentLevel(StudentLevelID),
IsGraduate CHAR(5),
CONSTRAINT CHK_IsGraduate CHECK (IsGraduate IN ('true', 'false'))
)

---- Students - Data Insertion ----

INSERT INTO Students(PersonID, StudentStatusID, StudentTypeID, StudentLevelID, IsGraduate)
VALUES
(1, 1, 5, 2, 'true'),
(2, 2, 3, 2, 'true'),
(3, 3, 1, 1, 'false')

---- Students - Data Verification ----

SELECT * FROM Students

---- AreaOfStudy - Creation ----

CREATE TABLE AreaOfStudy(
StudentID Int NOT NULL,
AreaID Int NOT NULL,
IsMajor CHAR(5),
CONSTRAINT CHK_IsMajor CHECK (IsMajor IN ('true', 'false')),
PRIMARY KEY (StudentID, AreaID),
FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
FOREIGN KEY (AreaID) REFERENCES MajorMinor(AreaOfStudyID)
)

---- AreaOfStudy - Data Insertion ----

INSERT INTO AreaOfStudy(StudentID, AreaID, IsMajor)
VALUES
(1, 1, 'true'),
(1, 5, 'true'),
(2, 2, 'true'),
(2, 1, 'true'),
(3, 5, 'false')

---- AreaOfStudy - Data Verification ----

SELECT * FROM AreaOfStudy


---- Employees - Creation ----

CREATE TABLE Employees(
EmployeeID Int PRIMARY KEY IDENTITY(1,1),
PersonID Int NOT NULL,
FOREIGN KEY (PersonID) REFERENCES Persons(PersonID),
AnnualSalary Int
)

---- Employees - Data Insertion ----

INSERT INTO Employees(PersonID, AnnualSalary)
VALUES
(4, 100000),
(5, 105000),
(6, 80000)

---- Employees - Data Verification ----

SELECT * FROM Employees

---- JobType - Creation ----

CREATE TABLE JobType(
JobTypeID Int PRIMARY KEY IDENTITY(1,1),
Name VARCHAR(50) NOT NULL
)

---- Job Type - Data Insertion ----

INSERT INTO JobType(Name)
VALUES
('Faculty'),
('Academic Support Staff'),
('Administrative Positions'),
('Research Positions'),
('Security')

---- Job Type - Data Verification ----

SELECT * FROM JobType

---- Job Title - Creation ----

CREATE TABLE JobTitle(
JobTitleID Int PRIMARY KEY IDENTITY(1,1),
Name VARCHAR(50) NOT NULL
)

---- Job Title - Data Insertion ----

INSERT INTO JobTitle(Name)
VALUES
('Lecturer'),
('Assistant Professor'),
('Associate Professor'),
('Full Professor'),
('Teaching Assistant'),
('Grading Assistant'),
('Academic Advisor'),
('Dean'),
('Research Assistant'),
('Security Supervisor')

---- Job Title - Data Verification ----

SELECT * FROM JobTitle

---- JobInformation - Creation ----

CREATE TABLE JobInformation(
JobCode Int PRIMARY KEY IDENTITY(1,1),
JobTitleID Int NOT NULL,
FOREIGN KEY (JobTitleID) REFERENCES JobTitle(JobTitleID),
Description VARCHAR(200),
JobTypeID Int,
FOREIGN KEY (JobTypeID) REFERENCES JobType(JobTypeID),
MinPay Int,
MaxPay Int
)

---- JobInformation - Data Insertion ----

INSERT INTO JobInformation(JobTitleID, Description, JobTypeID, MinPay, MaxPay)
VALUES
(1, 'Primarily focused on teaching with limited or no research responsibilities.', 1, 80000, 100000),
(2, 'Engages in teaching and research, often on a tenure track.', 1, 100000, 150000),
(3, 'Accomplished in teaching and research, often on the path to becoming full professors.', 1, 150000, 175000),
(4, 'Highest-ranking faculty with extensive expertise in teaching and research.', 1, 175000, 225000),
(5, 'Assists the professor in teaching the course.', 2, 10000, 15000),
(6, 'Assists in grading the coursework.', 2, 10000, 15000)

---- JobInformation - Data Verification ----

SELECT * FROM JobInformation

---- EmployeeAndJob - Creation ----

CREATE TABLE EmployeeAndJob(
JobCode Int,
EmployeeID Int,
PRIMARY KEY (JobCode, EmployeeID),
FOREIGN KEY (JobCode) REFERENCES JobInformation(JobCode),
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
)

---- EmployeeAndJob - Data Insertion ----

INSERT INTO EmployeeAndJob(JobCode, EmployeeID)
VALUES
(1, 1),
(2, 2),
(6, 3)

---- EmployeeAndJob - Data Verification ----

SELECT * FROM EmployeeAndJob

---- InsuranceType - Creation ----

CREATE TABLE InsuranceType(
InsuranceTypeID Int PRIMARY KEY IDENTITY(1,1),
InsuranceDescription VARCHAR(200)
)

---- InsuranceType - Data Insertion ----

INSERT INTO InsuranceType(InsuranceDescription)
VALUES
('Health'),
('Vision'),
('Dental')

---- InsuranceType - Data Verification ----

SELECT * FROM InsuranceType

---- BenefitCoverage - Creation ----

CREATE TABLE BenefitCoverage(
BenefitCoverageID Int PRIMARY KEY IDENTITY(1,1),
BenefitCoverageDescription VARCHAR(200)
)

---- BenefitCoverage - Data Insertion ----

INSERT INTO BenefitCoverage(BenefitCoverageDescription)
VALUES
('Employee only'),
('Employee with children only'),
('Employee with spouse only'),
('Employee with family')

---- BenefitCoverage - Data verification ----

SELECT * FROM BenefitCoverage

---- Benefits - Creation ----

CREATE TABLE Benefits(
BenefitID Int PRIMARY KEY IDENTITY(1,1),
InsuranceTypeID Int NOT NULL,
EmployeeID Int NOT NULL,
BenefitCoverageID Int NOT NULL,
FOREIGN KEY (InsuranceTypeID) REFERENCES InsuranceType(InsuranceTypeID),
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
FOREIGN KEY (BenefitCoverageID) REFERENCES BenefitCoverage(BenefitCoverageID),
EmployeePremiumAmount Int,
EmployerPremiumAmount Int
)

---- Benefits - Data Insertion ----

INSERT INTO Benefits(InsuranceTypeID, EmployeeID, BenefitCoverageID, EmployeePremiumAmount, EmployerPremiumAmount)
VALUES
(1, 1, 2, 10000, 15000),
(3, 1, 2, 9000, 11000),
(1, 2, 3, 14000, 19000),
(3, 2, 3, 7000, 10000),
(1, 3, 1, 3000, 5000)

---- Benefits - Data Verification ----

SELECT * FROM Benefits

---- Department - Creation ----

CREATE TABLE Department(
DepartmentID Int PRIMARY KEY IDENTITY(1,1),
Name VARCHAR(100) NOT NULL
)

---- Department - Data Insertion ----

INSERT INTO Department(Name)
VALUES
('Department of Electrical Engineering and Computer Science'),
('Department of Civil Engineering'),
('Department of Biological Sciences'),
('Department of Chemical Engineering'),
('Department of Communications')

---- Department - Data Verification ----

SELECT * FROM Department

---- CourseSub - Creation ----

CREATE TABLE CourseSub(
CourseCode CHAR(3) PRIMARY KEY,
Name VARCHAR(100) NOT NULL
)

---- CourseSub - Data Insertion ----

INSERT INTO CourseSub(CourseCode, Name)
VALUES
('CIS', 'Computer and Information Sciences'),
('CSE', 'Computer Science and Engineering'),
('BIO', 'Biology'),
('CEE', 'Civil Environmental Engineering'),
('CEN', 'Chemical Engineering')

---- CourseSub - Data Verification ----

SELECT * FROM CourseSub

---- CourseLevel - Creation ----

CREATE TABLE CourseLevel(
CourseLevelID INT PRIMARY KEY IDENTITY(1,1),
Name VARCHAR(20) NOT NULL
)

---- CourseLevel - Data Insertion ----

INSERT INTO CourseLevel(Name)
VALUES
('Undergraduate'),
('Graduate')

---- CourseLevel - Data Verification ----

SELECT * FROM CourseLevel

---- Courses - Creation ----

CREATE TABLE Courses(
CourseCode CHAR(3),
CourseNo Int,
PRIMARY KEY (CourseCode, CourseNo),
FOREIGN KEY (CourseCode) REFERENCES CourseSub(CourseCode),
Title VARCHAR(100) NOT NULL,
DepartmentID Int NOT NULL,
FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
Description VARCHAR(2000),
CourseLevelID Int,
FOREIGN KEY (CourseLevelID) REFERENCES CourseLevel(CourseLevelID),
CreditHours Int
)

---- Courses - Data Insertion ----

INSERT INTO Courses(CourseCode, CourseNo, Title, DepartmentID, Description, CourseLevelID, CreditHours)
VALUES
('CSE', 581, 'Intro to Database Management Systems', 2, 'DBMS building blocks; entity-relationship and relational models', 2, 3),
('CIS', 662, 'Intro to Mach Learning & Algms', 1, 'Introduction to Supervised, Unsupervised, reiinforcement learning methods', 2, 3),
('CIS', 554, 'Object Oriented Programming in C++', 1, NULL, 2, 3),
('CIS', 321, 'Introduction to Probability and Statistics ', 1, NULL, 1, 3),
('CIS', 351, 'Data Structures', 1, 'Introduction to Programming and Data Structures in C++', 1, 4),
('CEE', 601, 'Construction Engineering and Project Management', 4, 'Construction planning and management techniques', 2, 4),
('CEN', 616, 'Solid State Chemistry', 5, NULL, 2, 3),
('BIO', 663, 'Molecular Biotechnology', 3, NULL, 2, 3)

---- CourseLevel - Data Verification ----

SELECT * FROM Courses

---- Prerequisites - Creation ----

CREATE TABLE Prerequisites(
PrerequisitesID Int PRIMARY KEY IDENTITY(1,1),
ParentCourseCode CHAR(3) NOT NULL,
ParentCourseNo Int NOT NULL,
ChildCourseCode Char(3) NOT NULL,
ChildCourseNo Int NOT NULL,
FOREIGN KEY (ParentCourseCode, ParentCourseNo) REFERENCES Courses(CourseCode, CourseNo),
FOREIGN KEY (ChildCourseCode, ChildCourseNo) REFERENCES Courses(CourseCode, CourseNo)
)

---- Prerequisites - Data Insertion ----

INSERT INTO Prerequisites(ParentCourseCode, ParentCourseNo, ChildCourseCode, ChildCourseNo)
VALUES
('CSE', 581, 'CIS', 351),
('CIS', 662, 'CIS', 321),
('CIS', 662, 'CIS', 351),
('CIS', 554, 'CIS', 321),
('CIS', 554, 'CIS', 351)

---- Prerequisites - Data Verification ----

SELECT * FROM Prerequisites

---- Buildings - Creation ----

CREATE TABLE Buildings(
BuildingID Int PRIMARY KEY IDENTITY (1,1),
Name VARCHAR(100) NOT NULL
)

---- Buildings - Data Insertion ----

INSERT INTO Buildings (Name)
VALUES
('Life Sciences'), 
('ISchool'), 
('Hall of Languages'),
('Link Hall'),
('Bird Library'),
('New House'),
('Crouse Hall'),
('Carnege Library'),
('Henricks Chapel')

---- Buildings - Data Verification ----

SELECT * FROM Buildings

---- Projector - Creation ----

CREATE TABLE Projector(
ProjectorID Int PRIMARY KEY IDENTITY (1,1),
Name VARCHAR(50) NOT NULL
)

---- Projector - Data Insertion ----

INSERT INTO Projector (Name)
VALUES
('Canon 1111'), 
('Canon 1112'), 
('Canon 2111'),
('Canon 2112'), 
('Canon 3111'), 
('Canon 3112')

---- Projector - Data Verification ----

SELECT * FROM Projector

---- SemesterName - Creation ----

CREATE TABLE SemesterName(
SemesterNameID Int PRIMARY KEY IDENTITY (1,1),
Name VARCHAR(10) NOT NULL
)

---- SemesterName - Data Insertion ----

INSERT INTO SemesterName (Name)
VALUES
('Fall'), 
('Spring'), 
('Summer'),
('Winter')

---- SemesterName - Data Verification ----

SELECT * FROM SemesterName

---- Semesters - Creation ----

CREATE TABLE Semesters(
SemesterID INT PRIMARY KEY IDENTITY(1,1),
SemesterNameID Int NOT NULL,
FOREIGN KEY (SemesterNameID) REFERENCES SemesterName(SemesterNameID),
SemesterYear Int NOT NULL,
BeginDate Date,
EndDate Date
)

---- Semesters - Data Insertion ----

INSERT INTO Semesters (SemesterNameID, SemesterYear, BeginDate, EndDate)
VALUES
(1, 2023, '2023-08-28', '2023-12-20'), 
(2, 2024, '2024-01-20', '2024-05-02'), 
(3, 2024, '2024-05-15', '2024-07-30'),
(1, 2024, '2024-08-28', '2024-12-20'), 
(2, 2025, '2025-01-20', '2025-05-02'), 
(3, 2025, '2025-05-15', '2025-07-30')

---- Semesters - Data Verification ----

SELECT * FROM Semesters

---- ClassRoom - Creation ----

CREATE TABLE ClassRoom(
ClassRoomID Int PRIMARY KEY NOT NULL IDENTITY(1,1),
BuildingID Int,
Level Int,
RoomNo Int,
ProjectorID Int,
FOREIGN KEY(BuildingID) references Buildings(BuildingID),
FOREIGN KEY(ProjectorID) references Projector(ProjectorID),
WhiteBoardCount Int,
SeatingCapacity Int NOT NULL,
ClassroomType Varchar(20) CHECK(ClassroomType IN('Lab','Instruction'))
)

---- ClassRoom - Data Insertion ----

INSERT INTO ClassRoom(BuildingID, Level, RoomNo,ProjectorID,WhiteBoardCount,SeatingCapacity,ClassroomType) VALUES
(1, 1, 101, 1, 5, 50, 'Instruction'),
(2, 2, 201, 1, 3, 50, 'Instruction'),
(3, 3, 301, 6, 2, 100, 'Lab'),
(1, 4, 401, 4, 2, 50, 'Lab'),
(5, 1, 111, 1, 5, 110, 'Instruction'),
(2, 5, 501, 3, NULL, 70, 'Lab'),
(2, 1, 211, 4, 1, 180, 'Instruction')

---- ClassRoom - Data Verification ----

SELECT * FROM ClassRoom

---- CourseSchedule - Creation ----

CREATE TABLE CourseSchedule(
CRN Int PRIMARY KEY IDENTITY(1,1),
CourseCode CHAR(3) NOT NULL,
CourseNo Int NOT NULL,
FOREIGN KEY(ClassroomID) REFERENCES ClassRoom(ClassRoomID),
FOREIGN KEY(CourseCode,CourseNo) REFERENCES Courses(CourseCode,CourseNo),
Section Varchar(10),
FOREIGN KEY(SemesterID) REFERENCES Semesters(SemesterID),
SemesterID Int,
ClassroomID Int
)

---- CourseSchedule - Data Insertion ----

INSERT INTO CourseSchedule(CourseCode, CourseNo, Section, SemesterID, ClassroomID)
VALUES
('CSE', 581, 'M001', 1, 1),
('CIS', 662, 'M001', 2, 2),
('CIS', 554, 'M002', 4, 3),
('CIS', 351, 'M003', 3, 6),
('CIS', 321, 'M001', 3, 5),
('CEN', 616, 'M001', 1, 7),
('CEE', 601, 'M002', 2, 2),
('BIO', 663, 'M001', 5, 1)

---- CourseSchedule - Data Verification ----

SELECT * FROM CourseSchedule

---- CourseDailySchedule - Creation ----

CREATE TABLE CourseDailySchedule(
ScheduleID Int PRIMARY KEY IDENTITY(1,1),
CRN Int NOT NULL,
FOREIGN KEY (CRN) REFERENCES CourseSchedule(CRN),
Day VARCHAR(3) NOT NULL,
StartTime TIME NOT NULL,
EndTime TIME NOT NULL
)

---- CourseDailySchedule - Data Insertion ----

INSERT INTO CourseDailySchedule (CRN, Day, StartTime, EndTime)
VALUES 
(1, 'Mon', '09:00:00', '10:30:00'),
(2, 'Tue', '11:00:00', '12:30:00'),
(3, 'Wed', '13:00:00', '14:30:00'),
(4, 'Thu', '15:00:00', '16:30:00'),
(5, 'Fri', '09:00:00', '10:30:00'),
(6, 'Mon', '11:00:00', '12:30:00'),
(7, 'Tue', '13:00:00', '14:30:00'),
(8, 'Wed', '15:00:00', '16:30:00')

---- CourseDailySchedule - Data Verification ----

SELECT * FROM CourseDailySchedule

---- CourseInstructor - Creation ----

CREATE TABLE CourseInstructor (
CRN Int NOT NULL,
EmployeeID Int NOT NULL,
PRIMARY KEY (CRN, EmployeeID),
FOREIGN KEY (CRN) REFERENCES CourseSchedule(CRN),
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
)

---- CourseInstructor - Data Insertion ----

INSERT INTO CourseInstructor(CRN, EmployeeID)
VALUES
(1, 2),
(2, 1),
(3, 1),
(4, 2),
(5, 1)

---- CourseInstructor - Data Verification ----

SELECT * FROM CourseInstructor

---- EnrollmentStatus - Creation ----

CREATE TABLE EnrollmentStatus(
EnrollmentStatusID INT PRIMARY KEY IDENTITY(1,1),
Name Varchar(50) NOT NULL
)

---- EnrollmentStatus - Data Insertion ----

INSERT INTO EnrollmentStatus(Name) VALUES
('Enrolled'), ('Dropped'), ('Waitlist'), ('Unenrolled');

---- EnrollmentStatus - Data Verification ----

SELECT * FROM EnrollmentStatus

---- CourseEnrollment - Creation ----

CREATE TABLE CourseEnrollment(
StudentID Int NOT NULL,
CRN Int NOT NULL,
PRIMARY KEY(StudentID, CRN),
FOREIGN KEY(StudentID) references Students(StudentID),
FOREIGN KEY(CRN) references CourseSchedule(CRN),
EnrollmentStatusID INT,
FOREIGN KEY(EnrollmentStatusID) references EnrollmentStatus(EnrollmentStatusID),
MidTermGrade CHAR(2),
FinalTermGrade CHAR(2)
)

---- CourseEnrollment - Data Insertion ----

INSERT INTO CourseEnrollment(StudentID,CRN,EnrollmentStatusID,MidTermGrade,FinalTermGrade)
VALUES
(1, 1, 1, 'A-', 'A-'),
(1, 2, 1, 'B+', 'A-'),
(2, 1, 1, 'A', 'A-'),
(2, 4, 2, NULL, NULL),
(2, 3, 1, 'D', 'F'),
(2, 5, 1, 'B+', 'A'),
(3, 3, 1, 'A-', 'A')

---- CourseEnrollment - Data Verification ----

SELECT * FROM CourseEnrollment

---- Grant access to Graders ----

GRANT SELECT ON SCHEMA :: vgiduthu TO Graders
GRANT SELECT ON vgiduthu.Gender TO Graders;
GRANT SELECT ON vgiduthu.Race TO Graders;
GRANT SELECT ON vgiduthu.State TO Graders;
GRANT SELECT ON vgiduthu.Country TO Graders;
GRANT SELECT ON vgiduthu.Address TO Graders;
GRANT SELECT ON vgiduthu.Persons TO Graders;
GRANT SELECT ON vgiduthu.StudentStatus TO Graders;
GRANT SELECT ON vgiduthu.StudentType TO Graders;
GRANT SELECT ON vgiduthu.StudentLevel TO Graders;
GRANT SELECT ON vgiduthu.College TO Graders;
GRANT SELECT ON vgiduthu.MajorMinor TO Graders;
GRANT SELECT ON vgiduthu.Students TO Graders;
GRANT SELECT ON vgiduthu.AreaOfStudy TO Graders;
GRANT SELECT ON vgiduthu.Employees TO Graders;
GRANT SELECT ON vgiduthu.JobType TO Graders;
GRANT SELECT ON vgiduthu.JobTitle TO Graders;
GRANT SELECT ON vgiduthu.JobInformation TO Graders;
GRANT SELECT ON vgiduthu.EmployeeAndJob TO Graders;
GRANT SELECT ON vgiduthu.InsuranceType TO Graders;
GRANT SELECT ON vgiduthu.BenefitCoverage TO Graders;
GRANT SELECT ON vgiduthu.Benefits TO Graders;
GRANT SELECT ON vgiduthu.Department TO Graders;
GRANT SELECT ON vgiduthu.CourseSub TO Graders;
GRANT SELECT ON vgiduthu.CourseLevel TO Graders;
GRANT SELECT ON vgiduthu.Courses TO Graders;
GRANT SELECT ON vgiduthu.Prerequisites TO Graders;
GRANT SELECT ON vgiduthu.Buildings TO Graders;
GRANT SELECT ON vgiduthu.Projector TO Graders;
GRANT SELECT ON vgiduthu.SemesterName TO Graders;
GRANT SELECT ON vgiduthu.Semesters TO Graders;
GRANT SELECT ON vgiduthu.ClassRoom TO Graders;
GRANT SELECT ON vgiduthu.CourseSchedule TO Graders;
GRANT SELECT ON vgiduthu.CourseDailySchedule TO Graders;
GRANT SELECT ON vgiduthu.CourseInstructor TO Graders;
GRANT SELECT ON vgiduthu.EnrollmentStatus TO Graders;
GRANT SELECT ON vgiduthu.CourseEnrollment TO Graders;


