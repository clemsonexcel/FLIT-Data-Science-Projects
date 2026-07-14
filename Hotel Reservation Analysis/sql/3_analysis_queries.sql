-- here we do some analysis by answering  some questions.
use hotel_db;
### General Performance & Trends  

-- What is the total number of bookings per year/month?
select  arrival_date_month as month,
		sum(case when arrival_date_year = 2015 then 1 else 0 end) as y_2015,
        sum(case when arrival_date_year = 2016 then 1 else 0 end) as y_2016,
        sum(case when arrival_date_year = 2017 then 1 else 0 end) as y_2017,
        sum(case when arrival_date_year = 2018 then 1 else 0 end) as y_2018,
        sum(case when arrival_date_year = 2019 then 1 else 0 end) as y_2019,
        sum(case when arrival_date_year = 2020 then 1 else 0 end) as y_2020
from main
group by month;

-- using the booking date
select year(booking_date) as year,
		count(*) as bookings
from main
group by year
order by bookings DESC;

select month(booking_date) as month,
	sum(case when year(booking_date) = 2014 then 1 else 0 end) as y_2014,
	sum(case when year(booking_date) = 2015 then 1 else 0 end) as y_2015,
    sum(case when year(booking_date) = 2016 then 1 else 0 end) as y_2016,
    sum(case when year(booking_date) = 2017 then 1 else 0 end) as y_2017,
    sum(case when year(booking_date) = 2018 then 1 else 0 end) as y_2018,
    sum(case when year(booking_date) = 2019 then 1 else 0 end) as y_2019,
    sum(case when year(booking_date) = 2020 then 1 else 0 end) as y_2020,
    count(*) as total
from main
group by month
order by month;

  
-- will this be no of bookings by hotel?
select hotel, count(*) as bookings
from main
group by hotel;


-- How has the average daily rate (ADR) changed over time? 
-- adr over the years
select arrival_date_year as year,
		round(sum(adr)) as adr
from main
group by year;

-- adr over the months
select  arrival_date_month as month,
		round(sum(case when arrival_date_year = 2015 then adr else 0 end)) as adr_2015,
        round(sum(case when arrival_date_year = 2016 then adr else 0 end)) as adr_2016,
        round(sum(case when arrival_date_year = 2017 then adr else 0 end)) as adr_2017,
        round(sum(case when arrival_date_year = 2018 then adr else 0 end)) as adr_2018,
        round(sum(case when arrival_date_year = 2019 then adr else 0 end)) as adr_2019,
        round(sum(case when arrival_date_year = 2020 then adr else 0 end)) as adr_2020
from main
group by month;

-- What is the revenue trend over the years?  


### Customer Behavior & Preferences 

-- What are the most popular room types? (Based on number of bookings)
select reserved_room_type as room_type,
		count(*) as total,
		count(*)/ (select count(*) from main) as percent
from main
group by room_type
order by total desc;


-- Which market segment brings in the most bookings? (Corporate, Online, Walk-in, etc.) 
select market_segment, 
		count(*) as bookings,
		count(*)/ (select count(*) from main) as percent
from main
group by market_segment
order by bookings desc;


-- What is the average length of stay for customers?
select avg(total_stay) as avg_stay
from main; -- about 3.44 days

-- avg by hotel
select hotel, 
	avg(total_stay) as avg_stay
from main 
group by hotel; -- resort has an higher avg stay of 4.4 than city of 3.


-- Which months have the highest and lowest booking rates?
-- will booking rate be total bookings not cancelled / total bookings in general.. 



### Cancellation & No-show Analysis* 

-- What percentage of bookings get canceled?

-- total cancellation
select
	case when is_canceled = 0 then 'No' else 'Yes' end as canceled,
	count(*) as booking,
	count(*) / (select count(*) from main) as percent
from main
group by canceled
having canceled = 'Yes';

-- cancellation by each hotel
select hotel,
	case when is_canceled = 0 then 'No' else 'Yes' end as canceled,
	count(*) as booking,
	count(*) / (select count(*) from main) as percent
from main
group by canceled, hotel
having canceled = 'Yes';



-- Is there a pattern in cancellations based on room type or customer segment?**

-- cancellations by market segment
select market_segment,
	case when is_canceled = 0 then 'No' else 'Yes' end as canceled,
	count(*) / (select count(*) from main) as percent
from main
group by canceled, market_segment
having canceled = 'Yes'
order by percent desc;

-- Do customers who book further in advance cancel more often? 
select 
	lead_time,
	sum(is_canceled) as cancellations
from main
group by lead_time
order by cancellations DESC
limit 15;


-- cancelation rate over time
select year(booking_date) as year,
		case when is_canceled = 0 then 'No' else 'Yes' end as canceled,
	count(*) / (select count(*) from main) as percent
from main
group by year
where is_canceled = 'No'
group by canceled, market_segment
order by percent desc; 


### Revenue & Discounts

-- Which customer segment brings in the most revenue?
select customer_type,
	round(sum(revenue)) as revenue,
	sum(revenue) / (select sum(revenue) from main) as percent
from main
group by customer_type
order by revenue desc;


-- What is the impact of discounts on revenue?
-- would not cover discount

-- Is there a difference in spending between direct bookings and third-party bookings?


-- with distribution channel
select distinct distribution_channel, 
		count(*)
from main
group by distribution_channel;


-- wuth market segment
select distinct market_segment, 
		count(*)
from main
group by market_segment
order by count(*) desc;


### Operational Efficiency 

-- What is the average lead time (days between booking and check-in)?
select avg(lead_time)
from main; -- 103 days

--

select hotel, 
		avg(lead_time)
from main
group by hotel; -- city hotel has a higher avg of 110 with resort at 92 but they are similar.
-- I think i will group the lead time by months so i can get insights for bookings



-- Are there peak check-in days where staff should be better prepared?


-- Do weekend bookings have a higher revenue than weekday bookings?
select  
	round(sum(stays_in_weekend_nights * adr)) as weekend_revenue,
	round(sum(stays_in_week_nights * adr)) as weekday_revenue
from main


 


##  **Booking Trends:

   -- What is the overall trend in the number of bookings over time?
   -- same as earlier. this will be a line chsrt to show trend.
   
   -- How does the distribution of bookings vary by hotel type?
   
   
   -- Are there specific months or seasons with higher booking activity?
   
  -- month and bookings

select arrival_date_month as month,
		count(*) as bookings
from main
group by month
order by bookings desc;
  
-- seasons and bookings
select 
	case when arrival_date_month in ('December', 'January', 'February') then 'Winter' 
		when arrival_date_month in ('March', 'April', 'May') then 'Spring' 
        when arrival_date_month in ('June', 'July', 'August') then 'Summer'  
        when arrival_date_month in ('September', 'October', 'November') then 'Autumn' 
        end as season,
	count(*) as bookings
from main
group by season;
   
   
#  **Cancellation Analysis:**

-- What is the cancellation rate for reservations, and does it vary between hotel types?
select hotel, sum(is_canceled)/ (select count(*) from main) as cancellation
from main
where is_canceled = 1
group by hotel; 
   
-- Are there specific factors (e.g., lead time, room type) associated with a higher likelihood of cancellation?


# **Guest Demographics:**
 
   -- how many country
select count(distinct country) as country_no
from main; -- 178

-- What is the distribution of guests based on their country of origin?
select country, count(*) as total
from main
group by country
order by total desc;

-- How does the average daily rate (ADR) vary across different customer demographics?
select customer_type,
	round(avg(adr)) as adr
from main
group by customer_type;

-- Are there particular market segments that contribute significantly to bookings?
select market_segment, count(*) as bookings
from main
group by market_segment;


# **Room Allocation and Changes:**

-- How often do guests receive the room type they initially reserved?
select sum(case when reserved_room_type = assigned_room_type then 1 else 0 end) as same_room,
		sum(case when reserved_room_type <> assigned_room_type then 1 else 0 end) as different_rooms
from main;

-- What factors contribute to changes in assigned room types?
   
-- Are there patterns in the number of booking changes made by customers?


# **Performance Metrics:**

-- What are the average lead times for bookings?
select avg(lead_time) from main;
   
-- How does the average daily rate (ADR) correlate with other factors like booking channel or customer type?
   
   
-- What is the average number of special requests made by guests?
select avg(total_of_special_requests) from main;

select sum(total_of_special_requests) from main;


# **Repeat Guests:**
-- What percentage of guests are repeated customers?
select  case when is_repeated_guest = 0 then 'No_repeat' else 'Repeat' end as guest,
	count(*) as total,
    count(is_repeated_guest) / (select count(*) from main) as percent
from main
group by is_repeated_guest;
 
 
-- How does the booking behavior of repeat guests differ from first-time guests?


# Reservation Status:

-- What are the most common reservation statuses, and how do they evolve over time?
select reservation_status, 
		count(*) as total,
        count(reservation_status) / (select count(*) from main) as percent
from main
group by reservation_status;

   
-- Are there specific reasons provided for reservations being marked as canceled or no-show?
-- No


# **Geographic Analysis:**
-- Can you identify any geographic patterns in booking behavior or cancellation rates?
-- How does the origin of guests relate to market segments and booking channels?

# **Deposit Analysis:**

-- What proportion of bookings involve a deposit, and how does it vary across hotel types?
select deposit_type, 
		count(*)as total,
        sum(case when hotel = 'Resort Hotel' then 1 else 0 end)/ (select count(*) from main) as 'Resort',
        sum(case when hotel = 'City Hotel' then 1 else 0 end) / (select count(*) from main) as 'City',
        count(deposit_type) / (select count(*) from main) as total_percent
from main
group by deposit_type;

   
-- Are there differences in cancellation rates between bookings with and without a deposit?
select deposit_type,
		sum(is_canceled),
		sum(is_canceled) / (select count(*) from main) as cancel_rate
from main
group by deposit_type;

-- cancellation rate by hotel
select hotel,
		sum(is_canceled),
		sum(is_canceled) / (select count(*) from main) as cancel_rate
from main
group by hotel; 


# **Customer Behavior:**
-- How does the number of previous cancellations impact current booking behavior?

-- Are there specific customer types associated with higher or lower booking changes?
select customer_type,
		count(customer_type) as total,
		sum(booking_changes) as booking_changes,
        sum(booking_changes) / (select count(*) from main) as change_percent
from main
group by customer_type;



#  **Booking Channel Analysis:**
   
-- What is the distribution of bookings across different distribution channels?
-- Do bookings from specific channels have higher or lower cancellation rates?
select distribution_channel,
		count(*) as bookings,
		sum(is_canceled) as total_cancel,
		count(distribution_channel) / (select count(*) from main) as cancel_rate
from main
group by distribution_channel;
		

# **Seasonal Analysis:**

-- How does booking behavior and cancellation rates vary across different seasons? (create season column)
select season,
		count(*) as bookings,
		sum(is_canceled) as total_cancel,
		count(season) / (select count(*) from main) as cancel_rate
from main
group by season;

-- Are there particular months with a higher demand for certain room types or special requests?





	




















































