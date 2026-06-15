create database football_ticket_booking_system


-- =========================================================================
-- SYSTEM: Football Ticket Booking System Database Setup Template
-- DESCRIPTION: Pseudo-DDL Template for Table Creation & Data Insertion
-- INSTRUCTIONS: Replace 'TYPE' and the constraint placeholders with your own
--               actual data types, relational keys, and check criteria.
-- =========================================================================

-- DROP TABLES IF THEY ALREADY EXIST TO PREVENT CONFLICTS
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Matches;
DROP TABLE IF EXISTS Users;


-- =========================================================================
-- 1. CREATE USERS TABLE
-- =========================================================================
CREATE TABLE Users (
    user_id serial,
    full_name varchar(100) not null,
    email varchar(100) not null,
    role varchar(20) not null,
    phone_number varchar(15),
    
    -- Write your constraint to make 'user_id' the Primary Key
  primary key (user_id),
    -- Write your constraint to ensure 'email' values are never duplicated
  unique (email),
    -- Write your check constraint to restrict 'role' to specific allowed strings
  check(role in ('Ticket Manager', 'Football Fan'))
);



-- =========================================================================
-- 2. CREATE MATCHES TABLE
-- =========================================================================
CREATE TABLE Matches (
    match_id serial,
    fixture varchar(100) not null,
    tournament_category varchar(100) not null,
    base_ticket_price decimal(10,2) not null,
    match_status varchar(20) not null,
    
    -- Write your constraint to make 'match_id' the Primary Key
  primary key (match_id),
    -- Write your check constraint to prevent negative ticket prices
  check (base_ticket_price >= 0),
    -- Write your check constraint to restrict 'match_status' values
  check(match_status in ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
);



-- =========================================================================
-- 3. CREATE BOOKINGS TABLE
-- =========================================================================
CREATE TABLE Bookings (
    booking_id serial,
    user_id int not null,
    match_id int not null,
    seat_number varchar(10),
    payment_status varchar(20),
    total_cost decimal(10,2) not null,
    
    -- Write your constraint to make 'booking_id' the Primary Key
  primary key (booking_id),
    -- Write your Foreign Key constraint linking 'user_id' to the Users table
  foreign key (user_id) references Users(user_id),
    -- Write your Foreign Key constraint linking 'match_id' to the Matches table
  foreign key (match_id) references Matches(match_id),
    -- Write your check constraint to ensure 'total_cost' is non-negative
  check (total_cost >= 0),
    -- Write your check constraint to restrict 'payment_status' values
  check (payment_status in ('Pending', 'Confirmed', 'Cancelled', 'Refunded'))
);



-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO USERS
-- =========================================================================
INSERT INTO Users (user_id, full_name, email, role, phone_number) VALUES
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
(2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO MATCHES
-- =========================================================================
INSERT INTO Matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90.00, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80.00, 'Available');

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO BOOKINGS
-- =========================================================================
INSERT INTO Bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101, NULL, NULL, 150.00),
(505, 3, 102, 'C-20', 'Pending', 120.00);



-- Part 2

-- Query 1: Retrieve all upcoming football matches belonging to the 'Champions League' where the match status is 'Available'.

select match_id, fixture, base_ticket_price from Matches 
where tournament_category = 'Champions League' and match_status = 'Available';



-- Query 2: Search for all users whose full names start with 'Tanvir' or contain the phrase 'Haque' (case-insensitive).

select user_id, full_name, email from Users
where full_name ilike 'Tanvir%' or full_name ilike '%Haque%';


-- Query 3: Retrieve all booking records where the payment status is missing (NULL), replacing the empty result with 'Action Required'.

select booking_id, user_id, match_id, coalesce(payment_status, 'Action Required') as systematic_status from Bookings
where payment_status is null;


