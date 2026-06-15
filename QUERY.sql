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