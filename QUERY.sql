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