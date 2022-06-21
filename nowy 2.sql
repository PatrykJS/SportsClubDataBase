CREATE DATABASE SportsClubDatabase;

CREATE TABLE ClubEmployees (EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
EmployeeName VARCHAR(1000) NOT NULL,
EmployeeLastName VARCHAR(1000) NOT NULL,
EmployeeRole VARCHAR(100) NOT NULL,
EmployeeMonthlySalary VARCHAR(100) NOT NULL,
EmployeeEmail VARCHAR(1000),
EmployeeTelephoneNumber VARCHAR(100),
EmployeeAddres VARCHAR(1000) NOT NULL,
EmployeePostalCode VARCHAR(100) NOT NULL);

CREATE TABLE ClubMemberships (MembershipID INT PRIMARY KEY AUTO_INCREMENT,
MembershipDuration VARCHAR(100) NOT NULL,
MembershipCost VARCHAR(100) NOT NULL);

CREATE TABLE ClubMembers (MemberID INT PRIMARY KEY AUTO_INCREMENT,
MemberName VARCHAR(1000) NOT NULL,
MemberLastName VARCHAR(1000) NOT NULL,
MemberEmail VARCHAR(1000),
MemberTelephoneNumber VARCHAR(100),
MemberAddres VARCHAR(1000) NOT NULL,
MemberPostalCode VARCHAR(1000) NOT NULL);

CREATE TABLE MembershipsHistory (ID INT PRIMARY KEY AUTO_INCREMENT,
MemberID INT NOT NULL,
MembershipID INT NOT NULL,
PurcharseDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
ExpirationDate DATE NOT NULL);

ALTER TABLE MembershipsHistory 
ADD FOREIGN KEY (MemberID) REFERENCES ClubMembers(MemberID),
ADD FOREIGN KEY (MembershipID) REFERENCES ClubMemberships(MembershipID);

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
SELECT * FROM ClubEmployees WHERE EmployeeRole="Trainer"
GO;

CREATE PROCEDURE ShowYearlyExpences AS
SELECT EmployeeRole, SUM(EmployeeMonthlySalary)*12 FROM ClubEmployees GROUP BY EmployeeRole ORDER BY DESC
GO;




