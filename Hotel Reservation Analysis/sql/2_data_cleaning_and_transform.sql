use hotel_db;

/*
Cols - Total Records | Market_segment | Dist channel| 
2020 - 40687 | 7 (no undefined) | 0
2019 - 79264 | 8 (2 undefined) | 5
2018 - 21996 | 8 (2 undefined) | 4
15-17 - 119390 | 8 ( 2 undefied0 | 5

*/


-- Meal 4 main and undefined; 1517 has 1169 undefined, 2020 has 413, 2019 has 789, 2018 has 170

-- APPEND ALL THE YEARS DATA INTO ONE DATA AND JOIN WITH THE OTHER TABLES

-- next i would like to create these as a full table

create table main as 
(
	with years as (
		select * from year_1517
		union all 
		select * from year_2018
		union all 
		select * from year_2019
		union all 
		select * from year_2020
	)
	select years.*,
		Cost as meal_cost,
		Discount as market_discount
	from years 
	left join meal_cost on years.meal = meal_cost.meal
	left join market_segment on years.market_segment = market_segment.market_segment
);



/*
Data Cleaning Steps
- drop undefined values in market segment table
- drop undefined values in distribution channel col
-- drop values L and P in the room type for both reserved and assigned
*/
-- DATA CLEANING

-- market segemnt column -- drop Undefined values
delete from main
where market_segment = 'Undefined';

-- distribution channel columns - drop undefined value
delete from main
where distribution_channel = 'Undefined';

-- Assgned room type and reserved room type drop type L amd P
delete from main
where assigned_room_type = 'L' or assigned_room_type = 'P';


delete from main 
where reserved_room_type = 'L' or reserved_room_type = 'P'; 



-- check for rows with 0 in number of adults as that cannot be right 
select count(*)
from main
where adults = 0;
-- 826 rows hav adults as 0. can this be right?


-- data with 0 adults and with babies or children 
select count(*) 
from main
where adults = 0 and 
	babies > 0 and 
    children > 0;

-- 461 data entries with 0 adults and a number of chidren or bablies. we will drop these. 
select count(*) 
from main
where adults = 0 and 
	(babies > 0 or children > 0 );   

-- 365 entries with 0 adut and 0 children and 0 babaies.
select *
from main
where adults = 0 and 
	babies = 0 and 
    children = 0;  
    

-- dropping when adults is zero. 826 rows were affected. 
delete from main
where adults = 0;


-- -- babies with 9 or 10 values should be checked and also children.
select distinct babies
from main;
-- baues numbers; 0, 1, 2, 10, 9;  9 and 10 seem abnormal -- 5 rows have babies as 9 and 10


-- drop rows where babies re 9 or 10 - 5 rows affeted. 
delete from main
where babies > 2;


-- children values
select distinct children
from main;

-- children are 0, 1, 2, 3, and 10. lets understand the 10.

select * 
from main
where children = 10;

-- 4 rows had children with 10 children. with total stay as 14 and asdults as 2. seems like a stretch.

-- dropping rows with children = 10
delete from main
where children = 10;


-- lets check out parking space
select distinct required_car_parking_spaces
from main;

-- the distinct numbers are 0, 1, 2, 8, 3. lets see the distribution
select required_car_parking_spaces as parking,
	count(*) as freq
from main
group by parking;

-- 8 had 4 and 3 had 6. i will cjeck later to see if it is unusual to have such number.


-- somethinng to check if both weekend and weekdays are 0. that cannot be right
select stays_in_weekend_nights as weekend,
	stays_in_week_nights as weekday
from main
where weekend = 0 and weekday = 0;

select count(*)
from main
where stays_in_weekend_nights = 0 and stays_in_week_nights = 0;
-- 1438 entries had 0 in weekends and weekdays. 

-- drop rows with 0 in weekdays an weeknights as that cannot be possible.
delete from main
where stays_in_weekend_nights = 0 and stays_in_week_nights = 0;


-- creating new useful columns 

-- creating total night column which is addition of stays in weekdays amd stays in weekends
select stays_in_weekend_nights as weekend,
	stays_in_week_nights as weekday,
    (stays_in_weekend_nights + stays_in_week_nights) as total_stay
from main 
limit 10;


-- create table total stay
alter table main
add column total_stay int;

-- populate total_stay column
update main
set total_stay = stays_in_weekend_nights + stays_in_week_nights;


-- create revenue column
alter table main
add column revenue float;

-- populate revenue column column
update main
set revenue = adr * total_stay;


-- create column for season
alter table main
add column season varchar(36);

-- populate season column
update main
set season = 	case when arrival_date_month in ('December', 'January', 'February') then 'Winter' 
					when arrival_date_month in ('March', 'April', 'May') then 'Spring' 
					when arrival_date_month in ('June', 'July', 'August') then 'Summer' 
					when arrival_date_month in ('September', 'October', 'November') then 'Autumn' 
                    end;



-- create arrival_month column
alter table main
add column arrival_month int;

-- populate arrival_month column
update main
set arrival_month = case when arrival_date_month = 'January' then 1 
				when arrival_date_month = 'February' then 2
				when arrival_date_month = 'March' then 3
				when arrival_date_month = 'April' then 4
				when arrival_date_month = 'May' then 5
				when arrival_date_month = 'June' then 6
				when arrival_date_month = 'July' then 7
				when arrival_date_month = 'August' then 8
				when arrival_date_month = 'September' then 9
				when arrival_date_month = 'October' then 10
				when arrival_date_month = 'November' then 11
				when arrival_date_month = 'December' then 12
				end;

-- this will also give the numerical number of the data instaed of the case function
update main
set arrival_month =	MONTH(STR_TO_DATE(arrival_date_month, '%M'));


-- create arrival date column
alter table main
add column arrival_date date;

-- populate arrival_date column
update main
set arrival_date = concat(arrival_date_year, '-', arrival_month, '-',  arrival_date_day_of_month);

-- create booking_date column
alter table main
add column booking_date date;

-- populate booking_date column
update main
set booking_date = date_sub(arrival_date, interval lead_time day);


-- checking for outliers in data

select month(booking_date), revenue
from main
order by revenue desc
limit 10;





