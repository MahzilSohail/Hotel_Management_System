CREATE DATABASE HOTEL_MANAGEMENT_SYSTEM;
USE HOTEL_MANAGEMENT_SYSTEM;
CREATE TABLE Hotel (
    Hotel_ID INT PRIMARY KEY,
    Hotel_Name VARCHAR(100) NOT NULL,
    Location VARCHAR(255) NOT NULL,
    Amenities VARCHAR(255),
    Contact VARCHAR(15),
    Email VARCHAR(50) UNIQUE,
    Total_Rooms INT NOT NULL,
    Website VARCHAR(100) UNIQUE,
    Rating DECIMAL(2,1) CHECK (Rating BETWEEN 0 AND 5)
);
INSERT INTO Hotel (Hotel_ID, Hotel_Name, Location, Amenities, Contact, Email, Total_Rooms, Website, Rating)
VALUES 
(101,'Four Seasons', 'Islamabad,Pakistan', 'Free WiFi, Swimming Pool, spa', '123-456-7890', 'fourseasons@example.com', 500, 'www.fourseasons.com', 4.5);
SELECT * FROM Hotel;
CREATE TABLE Franchise (
    Franchise_ID INT IDENTITY(1,1) PRIMARY KEY,
    Franchise_Name VARCHAR(100) NOT NULL,
    Location VARCHAR(255) NOT NULL,
    Established_date INT, -- or DATE
    Contact VARCHAR(15),
    Total_Rooms INT NOT NULL,
    CEO VARCHAR(100)
);
INSERT INTO Franchise (Franchise_ID,Franchise_Name, Location, Established_date, Contact, Total_Rooms, CEO)
VALUES 
(201,'Four Seasons', 'Lahore,Pakistan', 2005, '132-479-6542', 500, 'Ali Khan'),
(202,'Four Seasons', 'Karachi,Pakistan', 2006, '345-346-6789', 800, 'Bahadur Khan'),
(203,'Four Seasons', 'Peshawar,Pakistan', 2007, '932-678-2787', 490, 'Asad Khan');
SELECT * FROM Franchise;
CREATE TABLE Rooms (
    RoomID INT IDENTITY(1,1) PRIMARY KEY,
    RoomNumber INT NOT NULL,
    RoomType VARCHAR(50) NOT NULL,
    PricePerNight DECIMAL(10,2) NOT NULL,
    Capacity INT NOT NULL,
    Floor_no INT,
    Hotel_ID INT NOT NULL,
    FOREIGN KEY (Hotel_ID) REFERENCES Hotel(Hotel_ID),
    CONSTRAINT UQ_HotelRoom UNIQUE (Hotel_ID, RoomNumber)
);
SELECT * FROM Rooms;
INSERT INTO Rooms (RoomID, RoomNumber, RoomType, PricePerNight, Capacity, Floor_no, Hotel_ID)
VALUES 
(301, 101, 'Single', 15000.00, 1, 1, 101),
(302, 102, 'Double', 20000.00, 2, 2, 101),
(303, 201, 'Suite', 35000.00, 4, 3, 101);
CREATE TABLE Reservation (
    Reservation_ID INT IDENTITY(1,1) PRIMARY KEY,
    GuestID INT NOT NULL,
    RoomID INT NOT NULL,
    ContactNumber VARCHAR(15),
    Email VARCHAR(50),
    CheckInDate DATETIME NOT NULL,
    CheckOutDate DATETIME NOT NULL,
    NumberOfGuests INT NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    ReservationDate DATETIME DEFAULT GETDATE(),
    Status VARCHAR(20) DEFAULT 'Confirmed' CHECK (Status IN ('Confirmed', 'Cancelled', 'Completed')),
    FOREIGN KEY (GuestID) REFERENCES Guest(GuestID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID),
    CHECK (CheckInDate < CheckOutDate)
);
SELECT * FROM Reservation;
INSERT INTO Reservation (Reservation_ID,GuestID, RoomID, ContactNumber, Email, CheckInDate, CheckOutDate, NumberOfGuests, TotalAmount, ReservationDate, Status)
VALUES 
(401, 001, 301, '032-1234', 'fatima2@gmail.com', '2025-04-15 14:00:00', '2025-04-17 11:00:00', 1, 15000.00, '2025-04-10 10:00:00', 'Confirmed'),
(402, 002, 302, '037-5678', 'malaika99@example.com', '2025-04-20 15:00:00', '2025-04-22 12:00:00', 4, 35000.00, '2025-04-02 14:00:00', 'Confirmed'),
(403, 003, 303, '036-19887', 'mahzil898@gmail.com', '2025-04-06 16:00:00', '2025-04-17 13:00:00', 2, 20000.00, '2025-04-05 01:09:00', 'Confirmed');
CREATE TABLE Membership (
    Membership_ID INT IDENTITY(1,1) PRIMARY KEY,
    MembershipType VARCHAR(20) CHECK (MembershipType IN ('Silver', 'Gold', 'Platinum', 'Diamond')),
    DiscountRate DECIMAL(5,2) DEFAULT 0.00,
    Status VARCHAR(20) DEFAULT 'Active' CHECK (Status IN ('Active', 'Expired', 'Suspended'))
);
alter table  Membership drop column GuestID;
INSERT INTO Membership (Membership_ID,MembershipType, DiscountRate, Status)
VALUES 
(501,'Diamond', 800.00, 'Active'),
(502,'Platinum', 500.00, 'Active'),
(503,'Silver',300.00, 'Expired');
SELECT * FROM Membership;
CREATE TABLE Guest (
    GuestID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Other')),
    ContactNumber VARCHAR(15) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Nationality VARCHAR(100),
    Address VARCHAR(255),
    MembershipID INT,
    FOREIGN KEY (MembershipID) REFERENCES Membership(Membership_ID)
);
SELECT * FROM Guest;
INSERT INTO Guest (FirstName, LastName, DateOfBirth, Gender, ContactNumber, Email, Nationality, Address, MembershipID)
VALUES 
('Fatima','Zafar','2005-05-23', 'Female', '032-1234', 'fatima2@gmail.com','Pakistan', 'Bharia town', 501),
('Malaika','Asghar','2003-12-26', 'Female', '037-5678', 'malaika99@example.com','Pakistan', 'DHA',503),
('Mahnoor','Sohail','2005-08-28', 'Female', '036-19887', 'mahnoor898@gmail.com','Pakistan', 'Valencia town', 502);
update  Guest set GuestID=003 where  FirstName='Mahnoor';
CREATE TABLE Staff (
    Staff_ID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Other')),
    ContactNumber VARCHAR(15) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    HireDate DATE NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    Position VARCHAR(30) CHECK (Position IN ('Front Desk', 'Housekeeping', 'Maintenance', 'Management', 'Food & Beverage', 'Manager', 'Guard', 'Cleaner', 'Sweaper')),
    Status VARCHAR(20) DEFAULT 'Active' CHECK (Status IN ('Active', 'Inactive', 'On Leave'))
);
SELECT * FROM Staff;
INSERT INTO Staff (Staff_ID,FirstName, LastName, DateOfBirth, Gender, ContactNumber, Email, HireDate, Salary, Position, Status)
VALUES 
(701,'Ahmad', 'Ali', '1980-02-20', 'Male', '555-6789', 'ahmadali@example.com', '2025-01-10', 1500.00, 'Sweaper', 'Active'),
(702,'Junaid', 'Khan', '1990-04-10', 'Male', '555-9876', 'junaidkhan@example.com', '2025-02-15', 5500.00, 'Front Desk', 'Active'),
(703,'Kubra','Bashir', '2001-06-05', 'Female', '555-7041', 'kubrabashir@example.com', '2025-03-20', 3500.00, 'Guard', 'Active');
CREATE TABLE Payment (
    Payment_ID INT IDENTITY(1,1) PRIMARY KEY,
    Reservation_ID INT NOT NULL,
    GuestID INT NOT NULL,
    PaymentDate DATETIME DEFAULT GETDATE(),
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(20) CHECK (PaymentMethod IN ('Credit Card', 'Debit Card', 'Cash', 'Online', 'Other')),
    PaymentStatus VARCHAR(20) DEFAULT 'Pending' CHECK (PaymentStatus IN ('Pending', 'Completed', 'Failed', 'Refunded')),
    FOREIGN KEY (Reservation_ID) REFERENCES Reservation(Reservation_ID),
    FOREIGN KEY (GuestID) REFERENCES Guest(GuestID)
);
SELECT * FROM Payment;
INSERT INTO Payment (Payment_ID,Reservation_ID, GuestID, PaymentDate, Amount, PaymentMethod, PaymentStatus)
VALUES 
(801, 401, 001, '2025-04-10 09:00:00', 300.00, 'Credit Card', 'Completed'),
(802, 402, 002, '2025-04-12 12:00:00', 400.00, 'Debit Card', 'Pending');
CREATE TABLE Shift (
    Shift_id INT IDENTITY(1,1) PRIMARY KEY,
    Shift_name VARCHAR(20) CHECK (Shift_name IN ('Morning', 'Evening', 'Night')),
    Start_time TIME,
    End_time TIME
);
INSERT INTO Shift (Shift_id, Shift_name, Start_time, End_time)
VALUES
(901, 'Morning', '08:00:00', '02:00:00'),
(902, 'Evening', '02:00:00' ,'09:00:00');
SELECT * FROM Shift;
CREATE TABLE Maintenance (
    Maintenance_id INT IDENTITY(1,1) PRIMARY KEY,
    RoomID INT NOT NULL,
    Staff_ID INT NOT NULL,
    Description VARCHAR(150),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'In Progress', 'Completed')),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID),
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID)
);
INSERT INTO Maintenance (Maintenance_id, RoomID, Staff_ID, Description, status)
VALUES
(1001,301,702, 'Management', 'In Progress'),
(1002, 302,701, 'Cleaning', 'Completed');
SELECT * FROM Maintenance;
CREATE TABLE HouseKeeping (
    HousekeepingID INT IDENTITY(1,1) PRIMARY KEY,
    RoomID INT NOT NULL,
    Staff_ID INT NOT NULL,
    Cleaning_date DATE,
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'In Progress', 'Completed')),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID),
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID)
);
INSERT INTO HouseKeeping (HousekeepingID, RoomID, Staff_ID, Cleaning_date, status)
VALUES
(111,301,701, '2025-03-24', 'Completed'),
(112,302,703, '2025-06-11', 'Completed');
SELECT * FROM HouseKeeping;
CREATE TABLE Service (
    ServiceID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(70),
    Description VARCHAR(100),
    ServiceRecord VARCHAR(20) CHECK (ServiceRecord IN ('Pending', 'In Progress', 'Completed')),
    Price INT NOT NULL
);
INSERT INTO Service (ServiceID, Name, Description, ServiceRecord, Price)
VALUES
(121,'Cleaning' ,'Dusting,Room clean', 'In Progress', 2500),
(122,'Food Delivery', 'Delivered to room', 'Completed', 7000);
SELECT * FROM Service;
CREATE TABLE Inventory (
    InventoryID INT IDENTITY(1,1) PRIMARY KEY,
    Hotel_ID INT NOT NULL,
    SupplierID INT NOT NULL,
    Item_name VARCHAR(100),
    Quantity INT NOT NULL,
    Category VARCHAR(100),
    Purchase_date DATE,
    FOREIGN KEY (Hotel_ID) REFERENCES Hotel(Hotel_ID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);
SELECT * FROM Inventory;
INSERT INTO Inventory (InventoryID, Hotel_ID, SupplierID, Item_name, Quantity, Category, Purchase_date)
VALUES
(131, 101, 142, 'First Aid kit', 20 , 'Health and Safety', '2025-03-21'),
(132, 101, 141, 'Cleaning Spray', 100, 'Cleaning Supplies', '2024-12-29'),
(133, 101, 143, 'Room key cards', 200, 'Electronics', '2024-08-12');
CREATE TABLE Supplier (
    SupplierID INT IDENTITY(1,1) PRIMARY KEY,
    SupplierName VARCHAR(70),
    Contact VARCHAR(100),
    Delivery VARCHAR(100)
);
INSERT INTO Supplier(SupplierID, SupplierName, Contact, Delivery)
VALUES
(141, 'Ashfaq', '234-889-123', 'Cleaning Supplies'),
(142, 'Rizwan', '419-408-648', 'Health and safety'),
(143, 'Akbar', '720-603-101', 'Electronics');
SELECT * FROM Supplier;
CREATE TABLE Restaurant (
    Restaurant_id INT IDENTITY(1,1) PRIMARY KEY,
    Restaurant_name VARCHAR(255),
    Cuisine_type VARCHAR(100),
    Capacity INT NOT NULL,
    Open_hours VARCHAR(255),
    Hotel_ID INT NOT NULL,
    FOREIGN KEY (Hotel_ID) REFERENCES Hotel(Hotel_ID)
);
INSERT INTO Restaurant (Restaurant_id, Restaurant_name, Hotel_ID, Cuisine_type, Capacity, Open_hours)
VALUES
  (151, 'Taste of India', 101, 'Indian food',50, '11am-10pm'),
  (152, 'The Italian Kitchen', 101, 'Italian food', 75, '12pm-11pm'),
  (153, 'The Spice Route', 101, 'Korean food', 100, '10am-9pm');
SELECT * FROM Restaurant;
CREATE TABLE Menu (
    Menu_id INT IDENTITY(1,1) PRIMARY KEY,
    Restaurant_id INT NOT NULL,
    Item_name VARCHAR(255),
    Category VARCHAR(255),
    Price DECIMAL(10,2),
    Availability VARCHAR(255),
    FOREIGN KEY (Restaurant_id) REFERENCES Restaurant(Restaurant_id)
);
INSERT INTO Menu (Menu_id, Item_name, Category, Price, Restaurant_id, Availability)
VALUES
  (161, 'Chicken Tikka Masala', 'Main Course', 1600, 151, 'Available'),
  (162, 'Margherita Pizza', 'Pizza', 1800, 152, 'Available'),
  (163, 'Greek Salad', 'Salad', 700, 152, 'Available');
SELECT * FROM Menu;
CREATE TABLE FoodOrder (
    Order_ID INT IDENTITY(1,1) PRIMARY KEY,
    Delivery_status VARCHAR(255),
    Order_time DATETIME,
    Quantity INT NOT NULL,
    GuestID INT NOT NULL,
    Menu_id INT NOT NULL,
    Payment_ID INT NOT NULL,
    FOREIGN KEY (Menu_id) REFERENCES Menu(Menu_id),
    FOREIGN KEY (GuestID) REFERENCES Guest(GuestID),
    FOREIGN KEY (Payment_ID) REFERENCES Payment(Payment_ID)
);
SELECT * FROM FoodOrder;
INSERT INTO FoodOrder (Order_ID, Delivery_status, Order_time, GuestID, Menu_id, Payment_ID, Quantity)
VALUES
  (171, 'Delivered', '2022-01-01 12:00:00', 001, 161, 801, 2),
  (172, 'Pending', '2022-01-03 14:00:00', 003, 163, 802, 3),
  (173, 'Cancelled', '2022-01-05 16:00:00', 002, 162, 801, 1);
CREATE TABLE Parking (
    Parking_ID INT IDENTITY(1,1) PRIMARY KEY,
    GuestID INT NOT NULL,
    Hotel_ID INT NOT NULL,
    Vehicle_no VARCHAR(255),
    Spot_no INT NOT NULL,
    Status VARCHAR(255),
    Checkin_time DATETIME,
    Checkout_time DATETIME,
    FOREIGN KEY (GuestID) REFERENCES Guest(GuestID),
    FOREIGN KEY (Hotel_ID) REFERENCES Hotel(Hotel_ID)
);
SELECT * FROM Parking;
INSERT INTO Parking (Parking_ID, GuestID, Hotel_ID, Vehicle_no, Spot_no, Status, Checkin_time, Checkout_time)
VALUES
  (181, 001, 101, 'ABC123', 1, 'Occupied', '2022-01-01 10:00:00', '2022-01-01 12:00:00'),
  (182, 003, 101, 'GHI789', 3, 'Vacant', '2022-01-03 12:00:00', NULL),
  (183, 002, 101, 'MNO345', 5, 'Occupied', '2022-01-05 14:00:00', '2022-01-05 16:00:00');
CREATE TABLE ReviewANDFeedback (
    Review_ID INT IDENTITY(1,1) PRIMARY KEY,
    GuestID INT NOT NULL,
    Restaurant_id INT,
    Staff_ID INT,
    Review_date DATE,
    Comments VARCHAR(255),
    Rating DECIMAL(2,1) CHECK (Rating BETWEEN 0 AND 5),
    FOREIGN KEY (GuestID) REFERENCES Guest(GuestID),
    FOREIGN KEY (Restaurant_id) REFERENCES Restaurant(Restaurant_id),
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID)
);
SELECT * FROM ReviewANDFeedback;
INSERT INTO ReviewANDFeedback (Review_id, GuestID, Restaurant_id, Staff_ID, Review_date, Comments, Rating)
VALUES
  (191, 001, 151, 701, '2022-01-01', 'Excellent service and food', 5),
  (192, 003, 152, 702, '2022-01-02', 'Good experience, but slow service', 4),
  (193, 002, 153, 703, '2022-01-03', 'Poor food quality, not recommended', 1);
CREATE TABLE ReviewResponse (
    Response_id INT IDENTITY(1,1) PRIMARY KEY,
    Restaurant_id INT NOT NULL,
    Staff_ID INT NOT NULL,
    Response_date DATE,
    Response_text VARCHAR(255),
    FOREIGN KEY (Restaurant_id) REFERENCES Restaurant(Restaurant_id),
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID)
);
INSERT INTO ReviewResponse (Response_id, Restaurant_id, Staff_ID, Response_date, Response_text)
VALUES
  (2001, 151, 701, '2022-01-01', 'Thank you for your feedback! We will work on improving our service'),
  (2002, 151, 701, '2022-01-04', 'We appreciate your feedback and will work on reducing noise levels in our restaurant'),
  (2003, 152, 702, '2022-01-05', 'Thank you for your review. We will review our pricing strategy to ensure it is competitive');
SELECT * FROM ReviewResponse;
CREATE TABLE HotelPolicy (
    Policy_ID INT IDENTITY(1,1) PRIMARY KEY,
    Hotel_ID INT NOT NULL,
    Policy_type VARCHAR(100),
    Description VARCHAR(100),
    Effective_date DATE NOT NULL,
    FOREIGN KEY (Hotel_ID) REFERENCES Hotel(Hotel_ID)
);
INSERT INTO HotelPolicy (Policy_ID, Hotel_ID, Policy_type, Descrition, Effective_date) 
VALUES
(211, 101, 'Check-in Policy', 'Check-in allowed after 2 PM only', '2023-01-01'),
(212, 101,  'Cancellation Policy', 'Free cancellation up to 24 hours before check-in', '2023-01-10'),
(213, 101, 'Smoking Policy', 'Smoking allowed only in designated areas', '2023-02-15');
SELECT * FROM HotelPolicy;
CREATE TABLE LegalDocuments (
    Document_ID INT IDENTITY(1,1) PRIMARY KEY,
    Hotel_ID INT NOT NULL,
    Document_type VARCHAR(100),
    Renewale_status VARCHAR(100),
    Expiry_date DATE NOT NULL,
    FOREIGN KEY (Hotel_ID) REFERENCES Hotel(Hotel_ID)
);
INSERT INTO LegalDocuments (Document_ID, Hotel_ID, Document_type, Renewale_status, Expiry_date) 
VALUES
(221, 101, 'Business License', 'Active', '2026-12-31'),
(222, 101, 'Fire Safety Certificate', 'Due for Renewal', '2025-06-30'),
(223, 101, 'Health Inspection Report', 'Active', '2025-11-15');
SELECT * FROM LegalDocuments;
CREATE TABLE SecurityLogs (
    log_ID INT IDENTITY(1,1) PRIMARY KEY,
    Hotel_ID INT NOT NULL,
    Staff_ID INT NOT NULL,
    Action VARCHAR(100),
    Details VARCHAR(100),
    Timestamp DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (Hotel_ID) REFERENCES Hotel(Hotel_ID),
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID)
);
SELECT * FROM SecurityLogs;
INSERT INTO SecurityLogs (log_ID, Hotel_ID, Staff_ID, Action, Details) 
VALUES
(231, 101, 701, 'Patrol', 'Night security patrol completed for floor 2'),
(232, 101, 703, 'Emergency', 'Fire alarm test conducted successfully'),
(233, 101, 702, 'Access Denied', 'Unauthorized attempt to access storage room');
CREATE TABLE LoyaltyProgram (
    Loyalty_ID INT IDENTITY(1,1) PRIMARY KEY,
    GuestID INT NOT NULL,
    Membership_status VARCHAR(100),
    Points_earned INT NOT NULL,
    FOREIGN KEY (GuestID) REFERENCES Guest(GuestID)
);
INSERT INTO LoyaltyProgram (Loyalty_ID, GuestID, Membership_status, Points_earned) 
VALUES
(241, 001, 'Silver', 1200),
(242, 002, 'Gold', 2800),
(243, 003, 'Platinum', 5200);
SELECT * FROM LoyaltyProgram;

-- QUERIES
-- AND
SELECT * FROM Guest
WHERE Gender = 'Female' AND Nationality = 'Pakistan';
-- OR
SELECT * FROM Staff
WHERE Status = 'On Leave' OR Status = 'Inactive';
-- BETWEEN
SELECT * FROM Reservation
WHERE CheckInDate BETWEEN '2025-04-01' AND '2025-04-20';
-- LIKE
SELECT * FROM Guest
WHERE Email LIKE '%@%.%';
SELECT * FROM Guest
WHERE FirstName LIKE 'M%';
-- IN
SELECT * FROM Guest
WHERE MembershipID IN (501, 502);
-- NOT
SELECT * FROM Staff
WHERE Position NOT IN ('Guard');
-- LIMIT/OFFSET
SELECT * FROM Restaurant
ORDER BY [SomeColumn]
OFFSET 1 ROWS FETCH NEXT 2 ROWS ONLY;
-- GROUP BY/COUNT
SELECT Position, COUNT(*) AS TotalStaff
FROM Staff
GROUP BY Position;
SELECT MembershipID, COUNT(*) AS NumberOfGuests
FROM Guest
GROUP BY MembershipID;
-- HAVING/COUNT
SELECT Position, COUNT(*) AS TotalStaff
FROM Staff
GROUP BY Position
HAVING COUNT(*) > 1;
-- Aggregation
-- COUNT
SELECT COUNT(*) AS TotalReviews FROM ReviewANDFeedback;
-- AVG
SELECT AVG(PricePerNight) AS AverageRoomPrice FROM Rooms;
-- SUM
SELECT SUM(Amount) AS TotalRevenue FROM Payment
WHERE PaymentStatus = 'Completed';
-- MAX/MIN
SELECT MAX(Salary) AS MaxSalary, MIN(Salary) AS MinSalary FROM Staff;
-- DISTINCT
SELECT DISTINCT Cuisine_type FROM Restaurant;
-- DML/DDL
-- DELETE
DELETE FROM Guest
WHERE Address = 'DHA';
-- TRUNCATE
TRUNCATE TABLE LoyaltyProgram;
-- DROP TABLE
DROP TABLE HouseKeeping;
-- UPDATE
UPDATE Staff
SET Salary = 6000.00
WHERE Staff_ID = 702;
-- ALTER
-- ADD COLUMN
ALTER TABLE Menu
ADD Calories INT;
-- ADD COLUMN WITH FOREIGN KEY REFERENCE
ALTER TABLE Membership
ADD GuestID INT NOT NULL;
ALTER TABLE Membership
ADD CONSTRAINT FK_Membership_Guest
FOREIGN KEY (GuestID) REFERENCES Guest(GuestID);
-- TO CHANGE COLUMN AND CONSTRAINT
ALTER TABLE Hotel
ALTER COLUMN Contact VARCHAR(30);
-- RENAME COLUMN
EXEC sp_rename 'HotelPolicy.Descrition', 'Description', 'COLUMN';
SELECT * FROM HotelPolicy;
-- DROP COLUMN
ALTER TABLE  Membership DROP COLUMN GuestID;
-- JOINS
-- INNER JOIN
SELECT Guest.FirstName, Guest.LastName, Reservation.RoomID, Reservation.CheckInDate
FROM Guest
INNER JOIN Reservation ON Guest.GuestID = Reservation.GuestID;
-- LEFTOUTER JOIN
SELECT Guest.FirstName, Guest.LastName, Reservation.Reservation_ID
FROM Guest 
LEFT JOIN Reservation ON Guest.GuestID = Reservation.GuestID;
-- RIGHT OUTER JOIN
SELECT Guest.FirstName, Reservation.Reservation_ID
FROM Guest
RIGHT JOIN Reservation ON Guest.GuestID = Reservation.GuestID;
-- FULL OUTER JOIN
SELECT Guest.GuestID, Guest.FirstName, Reservation.Reservation_ID
FROM Guest
LEFT JOIN Reservation ON Guest.GuestID = Reservation.GuestID
UNION
SELECT Guest.GuestID, Guest.FirstName, Reservation.Reservation_ID
FROM Guest
RIGHT JOIN Reservation ON Guest.GuestID = Reservation.GuestID;
-- UNION
SELECT FirstName, LastName FROM Guest
UNION
SELECT FirstName, LastName FROM Staff;
-- SUBQUERY
	-- 1
SELECT * FROM Guest
WHERE GuestID IN (SELECT GuestID FROM Reservation);
    -- 2
SELECT Restaurant_id, Item_name
FROM Menu
WHERE Restaurant_id IN (
    SELECT Restaurant_id
    FROM Menu
    WHERE Price > 500
    GROUP BY Restaurant_id
    HAVING COUNT(*) > 1
);
    -- 3
SELECT FirstName, LastName
FROM Guest
WHERE GuestID = (
    SELECT GuestID
    FROM Reservation
    GROUP BY GuestID
    ORDER BY COUNT(*) DESC
    LIMIT 1
);
    -- 4
SELECT * FROM Service
WHERE Price > (
    SELECT AVG(Price) FROM Service
);
-- STORED PROCEDURS
CALL GetStaffByStatus('Active');
CALL GetHotelsByRating(4.0);
CALL GetInventoryByCategory('Cleaning Supplies');
CALL AddPayment(401, 1, 20000.00, 'Credit Card', 'Completed');
-- with joins
CALL GetGuestReservations(1);
CALL ListReservations();
CALL MaintenaceReport();
CALL AllEmails();
CALL GuestMembershipDetails();
CALL RevenuePerHotel();
-- SCALAR FUNCTIONS
-- 1
DELIMITER //
CREATE FUNCTION CalculateGuestAge(dob DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, dob, CURDATE());
END //
DELIMITER ;
SELECT CalculateGuestAge('1995-08-24') AS GuestAge;
-- 2
DELIMITER //
CREATE FUNCTION GetGuestFullName( firstName VARCHAR(50), lastName VARCHAR(50))
RETURNS VARCHAR(101)
DETERMINISTIC
BEGIN
    DECLARE fullName VARCHAR(101);
    SET fullName = CONCAT(firstName, ' ', lastName);
    RETURN fullName;
END //

DELIMITER ;
SELECT GetGuestFullName('Malaika', 'Asghar') AS FullName;
-- 3
DELIMITER //
CREATE FUNCTION CalculateDiscountedAmount(originalAmount DECIMAL(10,2), discountRate DECIMAL(5,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN originalAmount - (originalAmount * (discountRate / 100));
END //

DELIMITER ;
SELECT CalculateDiscountedAmount(5000, 15) AS DiscountedPrice;
-- 4
DELIMITER //
CREATE FUNCTION CheckRoomAvailability(roomStatus ENUM('Available', 'Occupied', 'Maintenance'))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    IF roomStatus = 'Available' THEN
        RETURN 'Room Available';
    ELSE
        RETURN 'Room Not Available';
    END IF;
END //
DELIMITER ;
SELECT CheckRoomAvailability('Available') AS AvailabilityStatus;
-- 5
DELIMITER //
CREATE FUNCTION StaffDetails(firstName VARCHAR(50), lastName VARCHAR(50), position VARCHAR(50))
RETURNS VARCHAR(150)
DETERMINISTIC
BEGIN
    RETURN CONCAT(firstName, ' ', lastName, ' - ', position);
END //
DELIMITER ;
SELECT StaffDetails('Kubra', 'Bashir', 'Receptionist') AS StaffInfo;
-- TRIGGERS
-- 1
DELIMITER $$
CREATE TRIGGER set_room_booked_after_reservation
AFTER INSERT ON Reservation
FOR EACH ROW
BEGIN
  UPDATE Rooms
  SET RoomType = CONCAT(RoomType, ' - Booked')
  WHERE RoomID = NEW.RoomID;
END $$
DELIMITER ;
INSERT INTO Reservation (GuestID, RoomID, ContactNumber, Email, CheckInDate, CheckOutDate, NumberOfGuests, TotalAmount, Status)
VALUES (1, 301, '032-1111', 'iqra@gmail.com', '2025-05-10 14:00:00', '2025-05-12 12:00:00', 2, 25000.00, 'Confirmed');
SELECT * FROM Reservation;
-- 2
DELIMITER $$

CREATE TRIGGER log_staff_update
BEFORE UPDATE ON Staff
FOR EACH ROW
BEGIN
  INSERT INTO SecurityLogs (Hotel_ID, Staff_ID, Action, Details)
  VALUES (
    101,
    OLD.Staff_ID,
    'Staff Info Update',
    CONCAT('Before update: ', OLD.FirstName, ' ', OLD.LastName, ', Position: ', OLD.Position, ', Salary: ', OLD.Salary)
  );
END $$

DELIMITER ;
UPDATE Staff
SET Salary = 7000.00
WHERE Staff_ID = 702;
SELECT * FROM SecurityLogs;