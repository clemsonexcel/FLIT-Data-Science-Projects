use hotel_db;

-- creating the tables
-- year_2020 table 
create table year_2020
(
	hotel varchar(36),
	is_canceled int,
	lead_time int, 
    arrival_date_year int,
    arrival_date_month varchar(36),
	arrival_date_week_number int,
	arrival_date_day_of_month int,
	stays_in_weekend_nights int,
	stays_in_week_nights int, 
	adults int,
	children int,
	babies int,
	meal text,
	country varchar(255),
	market_segment varchar(255),
	distribution_channel varchar(255), 
	is_repeated_guest int,
	previous_cancellations int, 
	previous_bookings_not_canceled int, 
	reserved_room_type varchar(255),
	assigned_room_type varchar(255),
	booking_changes int,
	deposit_type varchar(255),
	agent int,
	company int,
	days_in_waiting_list int,
	customer_type varchar(255),
	adr float,
	required_car_parking_spaces int,
	total_of_special_requests int,
	reservation_status varchar(255), 
	reservation_status_date date
);

-- year_2019 table 
create table year_2019
(
	hotel varchar(36),
	is_canceled int,
	lead_time int, 
    arrival_date_year int,
    arrival_date_month varchar(36),
	arrival_date_week_number int,
	arrival_date_day_of_month int,
	stays_in_weekend_nights int,
	stays_in_week_nights int, 
	adults int,
	children int,
	babies int,
	meal text,
	country varchar(255),
	market_segment varchar(255),
	distribution_channel varchar(255), 
	is_repeated_guest int,
	previous_cancellations int, 
	previous_bookings_not_canceled int, 
	reserved_room_type varchar(255),
	assigned_room_type varchar(255),
	booking_changes int,
	deposit_type varchar(255),
	agent int,
	company int,
	days_in_waiting_list int,
	customer_type varchar(255),
	adr float,
	required_car_parking_spaces int,
	total_of_special_requests int,
	reservation_status varchar(255), 
	reservation_status_date date
);

-- year_2018 table 
create table year_2018
(
	hotel varchar(36),
	is_canceled int,
	lead_time int, 
    arrival_date_year int,
    arrival_date_month varchar(36),
	arrival_date_week_number int,
	arrival_date_day_of_month int,
	stays_in_weekend_nights int,
	stays_in_week_nights int, 
	adults int,
	children int,
	babies int,
	meal text,
	country varchar(255),
	market_segment varchar(255),
	distribution_channel varchar(255), 
	is_repeated_guest int,
	previous_cancellations int, 
	previous_bookings_not_canceled int, 
	reserved_room_type varchar(255),
	assigned_room_type varchar(255),
	booking_changes int,
	deposit_type varchar(255),
	agent int,
	company int,
	days_in_waiting_list int,
	customer_type varchar(255),
	adr float,
	required_car_parking_spaces int,
	total_of_special_requests int,
	reservation_status varchar(255), 
	reservation_status_date date
);

-- year_2015-2017 table 
create table year_1517
(
	hotel varchar(36),
	is_canceled int,
	lead_time int, 
    arrival_date_year int,
    arrival_date_month varchar(36),
	arrival_date_week_number int,
	arrival_date_day_of_month int,
	stays_in_weekend_nights int,
	stays_in_week_nights int, 
	adults int,
	children int,
	babies int,
	meal text,
	country varchar(255),
	market_segment varchar(255),
	distribution_channel varchar(255), 
	is_repeated_guest int,
	previous_cancellations int, 
	previous_bookings_not_canceled int, 
	reserved_room_type varchar(255),
	assigned_room_type varchar(255),
	booking_changes int,
	deposit_type varchar(255),
	agent int,
	company int,
	days_in_waiting_list int,
	customer_type varchar(255),
	adr float,
	required_car_parking_spaces int,
	total_of_special_requests int,
	reservation_status varchar(255), 
	reservation_status_date date
);

-- LOADING THE DATA


-- loading year 2020 data
LOAD DATA INFILE 'year_2020.csv'
INTO TABLE year_2020
FIELDS TERMINATED BY ","  
LINES TERMINATED BY "\r\n" 
IGNORE 1 LINES;


-- loading year 2019 data
LOAD DATA INFILE 'year_2019.csv'
INTO TABLE year_2019
FIELDS TERMINATED BY ","  
LINES TERMINATED BY "\r\n" 
IGNORE 1 LINES;

-- loading year 2018 data
LOAD DATA INFILE 'year_2018.csv'
INTO TABLE year_2018
FIELDS TERMINATED BY ","  
LINES TERMINATED BY "\r\n" 
IGNORE 1 LINES;


-- loading year_1517 data
LOAD DATA INFILE 'year_15-17.csv'
INTO TABLE year_1517
FIELDS TERMINATED BY ","  
LINES TERMINATED BY "\r\n" 
IGNORE 1 LINES;












































