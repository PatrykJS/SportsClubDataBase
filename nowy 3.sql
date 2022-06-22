CREATE DATABASE SportsClubDatabase;

CREATE TABLE ClubEmployees (EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
Name VARCHAR(1000) NOT NULL,
LastName VARCHAR(1000) NOT NULL,
Role VARCHAR(100) NOT NULL,
MonthlySalary VARCHAR(100) NOT NULL,
Email VARCHAR(1000),
TelephoneNumber VARCHAR(100),
Addres VARCHAR(1000) NOT NULL,
PostalCode VARCHAR(100) NOT NULL,
CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci);

CREATE TABLE ClubMemberships (MembershipID INT PRIMARY KEY AUTO_INCREMENT,
Duration VARCHAR(100) NOT NULL,
Cost VARCHAR(100) NOT NULL,
CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci);

CREATE TABLE ClubMembers (MemberID INT PRIMARY KEY AUTO_INCREMENT,
Name VARCHAR(1000) NOT NULL,
LastName VARCHAR(1000) NOT NULL,
Email VARCHAR(1000),
TelephoneNumber VARCHAR(100),
Addres VARCHAR(1000) NOT NULL,
PostalCode VARCHAR(1000) NOT NULL,
CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci);

CREATE TABLE MembershipsHistory (ID INT PRIMARY KEY AUTO_INCREMENT,
MemberID INT NOT NULL,
MembershipID INT NOT NULL,
PurcharseDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
ExpirationDate DATE NOT NULL,
CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci);

ALTER TABLE MembershipsHistory 
ADD FOREIGN KEY (MemberID) REFERENCES ClubMembers(MemberID),
ADD FOREIGN KEY (MembershipID) REFERENCES ClubMemberships(MembershipID);

CREATE PROCEDURE AddEmployee (IN EmployeeID INT NULL, IN Name VARCHAR(1000), IN LastName VARCHAR(1000), IN Role VARCHAR(100), IN MonthlySalary VARCHAR(100), 
IN Email VARCHAR(1000), IN TelephoneNumber VARCHAR(100), IN Addres VARCHAR(1000), IN PostalCode VARCHAR(100))
AS
INSERT INTO ClubEmployees VALUES (EmployeeId, Name, LastName, Role, MonthlySalary, Email, TelephoneNumber, Addres, PostalCode)
GO;

INSERT INTO ClubEmployees VALUES (NULL, "Patryk", "Sawicki", "CEO", "20000PLN", "PatrykJS@wp.pl", "+48794900291", "Warsaw, Wspólna 73", "00-687"),
(NULL, "Agata", "Woźniak", "Accountant", "6400PLN", "AWozniak@DB.com", "+48000000000", "Warsaw, Daleka 7", "00-725"),
(NULL, "Grzegorz", "Bodczak", "Manager", "7100PLN", "GBodczak@DB.com", "+48100100100", "Warsaw, Koźmina 90", "00-323"),
(NULL, "Dominik", "Frodczak", "Trainer", "4200PLN", "DFrodczak@DB.com", "+48200200200", "Warsaw, Maniakalna 12", "00-100"),
(NULL, "Klaudia", "Sobierajska", "Trainer", "4400PLN", "KSobierajska@DB.com", "+48300300300", "Warsaw, Chmielna 2", "00-281")
(NULL, "Sebastian", "Banasiuk", "Security", "3500PLN", NULL, "+48400400400", "Warsaw, Polna 15", "00-700"),
(NULL, "Monika", "Fredry", "Janitor", "2800PLN", "MFredry@DB.com", "+48500500500", "Warsaw, Bema 65", "00-621");

INSERT INTO ClubMemberships VALUES (NULL, "One time entry", "20PLN"),
(NULL, "Two weeks", "70PLN"),
(NULL, "One month", "120PLN"),
(NULL, "Six months", "600PLN"),
(NULL, "One year", "1000PLN");

CREATE PROCEDURE ShowTrainers AS
SELECT * FROM Employees WHERE Role="Trainer"
GO;

CREATE PROCEDURE ShowMonthlyStaffExpences AS
SELECT Role, SUM(MonthlySalary) FROM ClubEmployees GROUP BY Role ORDER BY DESC
GO;

CREATE PROCEDURE ShowYearlyIncome AS
SELECT 

CREATE PROCEDURE ShowActiveClients AS
SELECT MembershipsHistory.MemberID, ClubMembers.Name, ClubMembers.LastName, MembershipsHistory.MembershipID,
ClubMemberships.Duration, MembershipsHistory.ExpirationDate
FROM ((MembershipsHistory AS MH
JOIN ClubMembers AS CM 
ON MH.MemberID=CM.MemberID)
JOIN ClubMemberships AS CMS
ON MH.MembershipID=CMS.MembershipID)
WHERE MembershipsHistory.ExpirationDate >= "CURRENT_DATE"
ORDER BY MembershipsHistory.ExpirationDate
GO;