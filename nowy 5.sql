CREATE DATABASE SportsClubDatabase;

CREATE TABLE ClubEmployees (EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
Name VARCHAR(200) NOT NULL,
LastName VARCHAR(200) NOT NULL,
Role VARCHAR(100) NOT NULL,
MonthlySalary VARCHAR(100) NOT NULL,
Email VARCHAR(200),
TelephoneNumber VARCHAR(100),
Addres VARCHAR(200) NOT NULL,
PostalCode VARCHAR(100) NOT NULL,
INDEX IDXEmployees (LastName, Role, MonthlySalary));

CREATE TABLE ClubMemberships (MembershipID INT PRIMARY KEY AUTO_INCREMENT,
Duration VARCHAR(100) NOT NULL,
Cost VARCHAR(100) NOT NULL);


CREATE TABLE ClubMembers (MemberID INT PRIMARY KEY AUTO_INCREMENT,
Name VARCHAR(200) NOT NULL,
LastName VARCHAR(200) NOT NULL,
Email VARCHAR(200),
TelephoneNumber VARCHAR(100),
Addres VARCHAR(200) NOT NULL,
PostalCode VARCHAR(200) NOT NULL);

CREATE TABLE MembershipsHistory (ID INT PRIMARY KEY AUTO_INCREMENT,
MemberID INT NOT NULL,
MembershipID INT NOT NULL,
PurcharseDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
ExpirationDate DATE NOT NULL);

ALTER TABLE MembershipsHistory 
ADD FOREIGN KEY (MemberID) REFERENCES ClubMembers(MemberID),
ADD FOREIGN KEY (MembershipID) REFERENCES ClubMemberships(MembershipID);



DELIMITER $$
CREATE PROCEDURE AddEmployee (IN EmployeeID INT, IN Name VARCHAR(200), IN LastName VARCHAR(200), IN Role VARCHAR(100), IN MonthlySalary VARCHAR(100),
IN Email VARCHAR(200), IN TelephoneNumber VARCHAR(100), IN Addres VARCHAR(200), IN PostalCode VARCHAR(100))
BEGIN
INSERT INTO clubemployees VALUE (EmployeeID, Name, LastName, Role, MonthlySalary, Email, TelephoneNumber, Addres, PostalCode);
END$$

DELIMITER ;



DELIMITER $$
CREATE PROCEDURE AddMember (IN MemberID INT, IN Name VARCHAR(200), IN LastName VARCHAR(200), IN Role VARCHAR(100), IN MonthlySalary VARCHAR(100),
IN Email VARCHAR(200), IN TelephoneNumber VARCHAR(100), IN Addres VARCHAR(200), IN PostalCode VARCHAR(100))
BEGIN
INSERT INTO ClubMembers VALUE (MemberID, Name, LastName, Email, TelephoneNumber, Addres, PostalCode);
END$$

DELIMITER $$



DELIMITER $$
CREATE PROCEDURE AddMembership (IN MembershipID INT, IN Duration VARCHAR(100), IN Cost VARCHAR(100))
BEGIN
INSERT INTO ClubMemberships VALUE (MembershipID, Duration, Cost);
END$$

DELIMITER ;



DELIMITER $$
CREATE PROCEDURE MembershipPurcharse (IN ID INT, IN MemberID INT, IN MembershipID INT, IN PurcharseDate TIMESTAMP, IN ExpirationDate DATE)
BEGIN
INSERT INTO MembershipsHistory VALUE (ID, MemberID, MembershipID, PurcharseDate, ExpirationDate);
END$$

DELIMITER ;



DELIMITER $$ 
CREATE PROCEDURE ShowTrainers()
BEGIN
SELECT * FROM ClubEmployees WHERE Role="Trainer";
END$$

DELIMITER ;



DELIMITER $$
CREATE PROCEDURE ShowMonthlyStaffExpences
BEGIN
SELECT Role, SUM(MonthlySalary) AS A_Month FROM ClubEmployees GROUP BY Role ORDER BY A_Month DESC;
END$$

DELIMITER ;



DELIMITER $$
CREATE PROCEDURE ShowActiveClients
BEGIN
SELECT MH.MemberID, CM.Name, CM.LastName, MH.MembershipID,
CMS.Duration, MH.ExpirationDate
FROM MembershipsHistory AS MH
INNER JOIN ClubMembers AS CM 
ON MH.MemberID=CM.MemberID
INNER JOIN ClubMemberships AS CMS
ON MH.MembershipID=CMS.MembershipID
WHERE MH.ExpirationDate >= "CURRENT_DATE"
ORDER BY MH.ExpirationDate;
END$$

DELIMITER ;