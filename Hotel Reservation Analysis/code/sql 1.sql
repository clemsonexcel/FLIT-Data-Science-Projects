-- CREATING RELATIONAL TABLES

-- creating reservation information table
CREATE TABLE IF NOT EXISTS reservation (
    reservation_id INT PRIMARY KEY,
    guest_id INT,
    hotel VARCHAR(255),
    is_canceled INT,
    lead_time INT,
    arrival_date_year INT,
    arrival_date_month VARCHAR(255),
    arrival_date_week_number INT,
    arrival_date_day_of_month INT,
    stays_in_weekend_nights INT,
    stays_in_week_nights INT
);

-- creating room information table 
CREATE TABLE room (
    room_id INT  PRIMARY KEY,
    reservation_id INT,
    reserved_room_type VARCHAR(255),
    assigned_room_type VARCHAR(255),
    booking_changes INT,
    deposit_type VARCHAR(255),
    agent INT,
    company INT
);


-- creating guest information table
CREATE TABLE guest (
    guest_id INT  PRIMARY KEY,
    reservation_id INT,
    room_id INT,
    adults INT,
    children INT,
    babies INT,
    meal VARCHAR(255),
    country VARCHAR(255),
    market_segment VARCHAR(255),
    distribution_channel VARCHAR(255),
    is_repeated_guest INT,
    previous_cancellations INT,
    previous_bookings_not_canceled INT
);

-- creating booking details table
CREATE TABLE booking (
    booking_id INT  PRIMARY KEY,
    guest_id INT,
    days_in_waiting_list INT,
    customer_type VARCHAR(255),
    adr FLOAT,
    required_car_parking_spaces INT,
    total_of_special_requests INT
);

-- creating status table
CREATE TABLE status (
	status_id INT PRIMARY KEY,
    reservation_id INT,
    booking_id INT,
    reservation_status VARCHAR(255),
    reservation_status_date VARCHAR(255)
);

/*ADDING FOREIGN KEYS TO THE TABLES */

ALTER TABLE status
ADD FOREIGN KEY (reservation_id) REFERENCES reservation(reservation_id),
ADD FOREIGN KEY (booking_id) REFERENCES booking(booking_id);

ALTER TABLE reservation
ADD FOREIGN KEY (guest_id) REFERENCES guest(guest_id);

ALTER TABLE booking
ADD FOREIGN KEY (guest_id) REFERENCES guest(guest_id);

ALTER TABLE guest
ADD FOREIGN KEY (reservation_id) REFERENCES reservation(reservation_id),
ADD FOREIGN KEY (room_id) REFERENCES room(room_id);

ALTER TABLE room
ADD FOREIGN KEY (reservation_id) REFERENCES reservation(reservation_id);


/* Rename adr column in booking table to average_daily_rate */

ALTER TABLE `hotel_reservation`.`booking` 
CHANGE COLUMN `adr` `avg_daily_rate` FLOAT NULL DEFAULT NULL ;

/* change reservation status date in status table to date format */

-- Add a new column with the correct date format
ALTER TABLE status
ADD COLUMN new_reservation_status_date DATE;

-- Update the new column with the correct date format
UPDATE status
SET new_reservation_status_date = STR_TO_DATE(reservation_status_date, '%d/%m/%Y');

-- Update the new column with the values from the old column
UPDATE status
SET new_reservation_status_date = reservation_status_date;

-- Drop the old column
ALTER TABLE status
DROP COLUMN reservation_status_date;

-- Rename the new column to the original name
ALTER TABLE status
CHANGE COLUMN new_reservation_status_date reservation_status_date DATE;

/* Checking for missing values*/
-- replace the table name and column with what you need

SELECT COUNT(*) - COUNT(company) AS missing_count FROM room;
-- there are no missing values 

/* creating a new column 'arrival_date' to combine arrival year month and day */

-- creating new column 'arrival_date_month_number
ALTER TABLE reservation
ADD COLUMN arrival_date_month_number INT;

-- Update the new column with the numeric representation of the month
UPDATE reservation
SET arrival_date_month_number = MONTH(STR_TO_DATE(arrival_date_month, '%M'));

-- Drop the original text month column if needed
ALTER TABLE your_table
DROP COLUMN month_column;


ALTER TABLE reservation
ADD COLUMN arrival_date DATE;

UPDATE reservation
SET arrival_date = CONCAT(arrival_date_year, '-', LPAD(arrival_date_month_number, 2, '0'), '-', LPAD(arrival_date_day_of_month, 2, '0'));

-- Drop the individual year, month, and day columns if needed
ALTER TABLE your_table
DROP COLUMN year_column,
DROP COLUMN month_column,
DROP COLUMN day_column;




-- files exported with table export wizard.










