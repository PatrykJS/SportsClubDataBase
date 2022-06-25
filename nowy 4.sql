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
INDEX IDXEmployees (LastName, Role, MonthlySalary),
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


DELIMITER//
CREATE PROCEDURE AddEmployee (IN EmployeeID INT NULL, IN Name VARCHAR(1000), IN LastName VARCHAR(1000), IN Role VARCHAR(100), IN MonthlySalary VARCHAR(100), 
IN Email VARCHAR(1000), IN TelephoneNumber VARCHAR(100), IN Addres VARCHAR(1000), IN PostalCode VARCHAR(100))
AS
INSERT INTO ClubEmployees VALUES (EmployeeId, Name, LastName, Role, MonthlySalary, Email, TelephoneNumber, Addres, PostalCode)
END//
DELIMITER;


DELIMITER// 
CREATE PROCEDURE ShowTrainers AS
SELECT * FROM Employees WHERE Role="Trainer"
END//
DELIMITER;


DELIMITER//
CREATE PROCEDURE ShowMonthlyStaffExpences AS
SELECT Role, SUM(MonthlySalary) FROM ClubEmployees GROUP BY Role ORDER BY DESC
END//
DELIMITER;


DELIMITER//
CREATE PROCEDURE ShowActiveClients AS
SELECT MembershipsHistory.MemberID, ClubMembers.Name, ClubMembers.LastName, MembershipsHistory.MembershipID,
ClubMemberships.Duration, MembershipsHistory.ExpirationDate
FROM ((MembershipsHistory AS MH
INNER JOIN ClubMembers AS CM 
ON MH.MemberID=CM.MemberID)
INNER JOIN ClubMemberships AS CMS
ON MH.MembershipID=CMS.MembershipID)
WHERE MembershipsHistory.ExpirationDate >= "CURRENT_DATE"
ORDER BY MembershipsHistory.ExpirationDate
END//
DELIMITER;