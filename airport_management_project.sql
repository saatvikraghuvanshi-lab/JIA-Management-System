/* 
   AIRPORT MANAGEMENT SYSTEM DATABASE
    */

DROP DATABASE IF EXISTS airport_management;

CREATE DATABASE airport_management;

USE airport_management;

/* 
   AIRPORT
   */

CREATE TABLE Airport (
    airport_id INT AUTO_INCREMENT PRIMARY KEY,
    airport_code VARCHAR(10) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL
);

/* 
   AIRLINE
    */

CREATE TABLE Airline (
    airline_id INT AUTO_INCREMENT PRIMARY KEY,
    airline_name VARCHAR(100) UNIQUE NOT NULL,
    country VARCHAR(50) NOT NULL
);

/* 
   TERMINAL
    */

CREATE TABLE Terminal (
    terminal_id INT AUTO_INCREMENT PRIMARY KEY,
    airport_id INT NOT NULL,
    terminal_name VARCHAR(20) NOT NULL,
    terminal_type ENUM('DOMESTIC','INTERNATIONAL') NOT NULL,

    FOREIGN KEY (airport_id)
    REFERENCES Airport(airport_id)
);

/* 
   GATE
   */

CREATE TABLE Gate (
    gate_id INT AUTO_INCREMENT PRIMARY KEY,

    terminal_id INT NOT NULL,

    gate_no VARCHAR(10) NOT NULL,

    gate_status ENUM(
        'AVAILABLE',
        'OCCUPIED',
        'MAINTENANCE'
    ) DEFAULT 'AVAILABLE',

    FOREIGN KEY (terminal_id)
    REFERENCES Terminal(terminal_id)
);

/* 
   FLIGHT
    */

CREATE TABLE Flight (

    flight_id INT AUTO_INCREMENT PRIMARY KEY,

    airline_id INT NOT NULL,

    flight_no VARCHAR(20) UNIQUE NOT NULL,

    source_airport_id INT NOT NULL,

    destination_airport_id INT NOT NULL,

    flight_type ENUM(
        'DOMESTIC',
        'INTERNATIONAL'
    ) NOT NULL,

    departure_time DATETIME NOT NULL,

    arrival_time DATETIME NOT NULL,

    status ENUM(
        'SCHEDULED',
        'BOARDING',
        'DEPARTED',
        'ARRIVED',
        'DELAYED',
        'CANCELLED'
    ) DEFAULT 'SCHEDULED',

    gate_id INT,

    fare DECIMAL(10,2) NOT NULL,

    total_seats INT NOT NULL,

    FOREIGN KEY (airline_id)
    REFERENCES Airline(airline_id),

    FOREIGN KEY (source_airport_id)
    REFERENCES Airport(airport_id),

    FOREIGN KEY (destination_airport_id)
    REFERENCES Airport(airport_id),

    FOREIGN KEY (gate_id)
    REFERENCES Gate(gate_id)
);

/* 
   PASSENGER
   */

CREATE TABLE Passenger (

    passenger_id INT AUTO_INCREMENT PRIMARY KEY,

    full_name VARCHAR(100) NOT NULL,

    email VARCHAR(100) UNIQUE NOT NULL,

    phone VARCHAR(15) NOT NULL,

    passport_no VARCHAR(30),

    nationality VARCHAR(50)
);

/* 
   BOOKING
    */

CREATE TABLE Booking (

    booking_id INT AUTO_INCREMENT PRIMARY KEY,

    passenger_id INT NOT NULL,

    flight_id INT NOT NULL,

    booking_date DATETIME
    DEFAULT CURRENT_TIMESTAMP,

    seat_no VARCHAR(5) NOT NULL,

    booking_status ENUM(
        'CONFIRMED',
        'CANCELLED'
    ) DEFAULT 'CONFIRMED',

    FOREIGN KEY (passenger_id)
    REFERENCES Passenger(passenger_id),

    FOREIGN KEY (flight_id)
    REFERENCES Flight(flight_id),

    UNIQUE(flight_id, seat_no)
);

/* 
   PAYMENT
    */

CREATE TABLE Payment (

    payment_id INT AUTO_INCREMENT PRIMARY KEY,

    booking_id INT UNIQUE NOT NULL,

    amount DECIMAL(10,2) NOT NULL,

    payment_method ENUM(
        'UPI',
        'CARD',
        'NETBANKING',
        'CASH'
    ),

    payment_status ENUM(
        'PAID',
        'FAILED',
        'REFUNDED'
    ) DEFAULT 'PAID',

    payment_date DATETIME
    DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (booking_id)
    REFERENCES Booking(booking_id)
);

/* 
   BAGGAGE
    */

CREATE TABLE Baggage (

    baggage_id INT AUTO_INCREMENT PRIMARY KEY,

    booking_id INT NOT NULL,

    belt_no VARCHAR(10),

    weight DECIMAL(6,2),

    status ENUM(
        'CHECKED_IN',
        'LOADED',
        'ARRIVED',
        'COLLECTED'
    ) DEFAULT 'CHECKED_IN',

    FOREIGN KEY (booking_id)
    REFERENCES Booking(booking_id)
);

/* 
   SAMPLE AIRPORT DATA
    */

INSERT INTO Airport
(airport_code,name,city,country)
VALUES

('JAI','Jaipur International Airport','Jaipur','India'),

('DEL','Indira Gandhi International Airport','Delhi','India'),

('BOM','Chhatrapati Shivaji Maharaj Airport','Mumbai','India'),

('BLR','Kempegowda International Airport','Bengaluru','India'),

('HYD','Rajiv Gandhi International Airport','Hyderabad','India'),

('CCU','Netaji Subhas Chandra Bose Airport','Kolkata','India'),

('MAA','Chennai International Airport','Chennai','India'),

('DXB','Dubai International Airport','Dubai','UAE'),

('BKK','Suvarnabhumi Airport','Bangkok','Thailand'),

('KUL','Kuala Lumpur International Airport','Kuala Lumpur','Malaysia'),

('MUC','Munich International Airport','Munich','Germany');

/* 
   AIRLINES
    */

INSERT INTO Airline
(airline_name,country)
VALUES

('Air India','India'),
('IndiGo','India'),
('Vistara','India'),
('Emirates','UAE'),
('Lufthansa','Germany'),
('Thai Airways','Thailand'),
('Malaysia Airlines','Malaysia');

/* 
   TERMINALS
    */

INSERT INTO Terminal
(airport_id,terminal_name,terminal_type)
VALUES

(1,'T1','DOMESTIC'),
(1,'T2','INTERNATIONAL');

/* 
   GATES
    */

INSERT INTO Gate
(terminal_id,gate_no)
VALUES

(1,'G1'),
(1,'G2'),
(1,'G3'),
(1,'G4'),

(2,'G5'),
(2,'G6'),
(2,'G7'),
(2,'G8');

/* 
   DOMESTIC FLIGHTS
    */

INSERT INTO Flight
(
airline_id,
flight_no,
source_airport_id,
destination_airport_id,
flight_type,
departure_time,
arrival_time,
status,
gate_id,
fare,
total_seats
)
VALUES

(1,'AI101',1,2,'DOMESTIC',
'2026-11-01 08:00:00',
'2026-11-01 09:00:00',
'SCHEDULED',1,4500,180),

(2,'6E201',1,3,'DOMESTIC',
'2026-11-01 10:00:00',
'2026-11-01 12:00:00',
'SCHEDULED',2,5200,180),

(3,'UK301',1,4,'DOMESTIC',
'2026-11-01 13:00:00',
'2026-11-01 15:30:00',
'SCHEDULED',3,6500,180),

(2,'6E401',1,5,'DOMESTIC',
'2026-11-01 16:00:00',
'2026-11-01 18:00:00',
'SCHEDULED',4,5800,180),

(1,'AI501',1,6,'DOMESTIC',
'2026-11-01 18:30:00',
'2026-11-01 20:45:00',
'SCHEDULED',1,6100,180),

(3,'UK601',1,7,'DOMESTIC',
'2026-11-01 21:00:00',
'2026-11-01 23:15:00',
'SCHEDULED',2,5900,180);

/*
  // INTERNATIONAL FLIGHTS
   */

INSERT INTO Flight
(
airline_id,
flight_no,
source_airport_id,
destination_airport_id,
flight_type,
departure_time,
arrival_time,
status,
gate_id,
fare,
total_seats
)
VALUES

(4,'EK701',1,8,'INTERNATIONAL',
'2026-11-02 01:00:00',
'2026-11-02 03:30:00',
'SCHEDULED',5,25000,220),

(6,'TG702',1,9,'INTERNATIONAL',
'2026-11-02 05:00:00',
'2026-11-02 10:30:00',
'SCHEDULED',6,28000,220),

(7,'MH703',1,10,'INTERNATIONAL',
'2026-11-02 11:30:00',
'2026-11-02 17:00:00',
'SCHEDULED',7,30000,220),

(5,'LH704',1,11,'INTERNATIONAL',
'2026-11-02 20:00:00',
'2026-11-03 03:00:00',
'SCHEDULED',8,55000,250);

/* ==========================================
   TEST QUERIES
   ========================================== */

SHOW TABLES;

SELECT * FROM Airport;

SELECT * FROM Airline;

SELECT * FROM Flight;