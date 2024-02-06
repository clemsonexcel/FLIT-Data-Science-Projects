# Hotel Reservation Analysis Project

## Overview
The Hotel Reservation Project involves the analysis of a dataset related to hotel bookings. The dataset contains information about reservations, guests, room types, booking details, and reservation statuses. The goal of the project is to explore, visualize, and analyze various aspects of hotel bookings, providing insights into booking trends, customer behavior, cancellation rates, and other relevant factors.

## Table of Contents
- [Data Overview](#data-overview)
- [Technologies Used](#technologies-used)
- [Folder Structure](#folder-structure)
- [Data Source](#data-source)
- [Data preprocessing](#data-preprocessing)
- [Database Structure](#database-structure)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Visualization and Analysis](#visualization-and-analysis)
- [Insights and Recommendations](#insights-and-recommendations)
- [Acknowledgments](#acknowledgments)

## Data Overview
The primary dataset used for this project is an Excel dataset with two sheets. The first sheet provides information and a description of column names, guiding our understanding of the dataset's structure. The second sheet is a table with 32 columns containing detailed information on reservations, bookings, guests, and related aspects. The dataset encompasses a mix of categorical, numerical, and date columns. Prior to analysis, we conducted essential preprocessing steps to ensure data quality and relevance.

## Technologies Used

- **Excel:** Utilized for initial data exploration and understanding.
- **Jupyter Notebook:** Used for data preprocessing tasks, including data cleaning, and transformation.
- **MySQL:** Employed for data analysis, creating and managing the database.
- **Tableau Public:** Chosen for data visualization and creating interactive dashboards.

## Folder Structure 

## Data Source
The dataset for this project was provided as part of my Data Science Apprenticeship Program. The data consists of two sheets: one containing column descriptions and another with detailed information on reservations, bookings, guests, etc.

## Data Preprocessing
 In preparation for analysis, several preprocessing steps were undertaken. These steps included handling missing values, converting data types,and ensuring consistency across columns.  These efforts were aimed at enhancing the dataset's suitability for meaningful analysis."

## Database Structure
The dataset is transformed into a relational database, with tables created to represent different aspects of the information, such as reservation details, guest information, room details, etc. There were five tables in total created, with each created with primary and foreign key to ensure data consistnecy. booking info, guest info, reservation info, ststus info, room info.

## Exploratory data analysis (EDA)
Utilizing SQL queries, we performed Exploratory Data Analysis to uncover patterns and insights within the dataset. Key analyses include:
1. **Basic Statistics:**
   - Calculated basic statistics for key columns using SQL (`COUNT`, `SUM`, `AVG`, etc.).

2. **Data Profiling:**
   - Used SQL queries to profile the data, checking for missing values, outliers, and inconsistencies.
  
3.  **Cancellation Analysis:**
   - Explored the cancellation rate for reservations, analyzing variations between hotel types.

The following sql query calculates the total number of bookings, total cancellation and cancellation rate for each hotel type:

```sql
SELECT
  hotel,
  COUNT(*) AS total_bookings,
  SUM(is_canceled) AS total_cancellations,
  AVG(is_canceled) AS cancellation_rate
FROM data
GROUP BY hotel;
```

## Visualization and Analysis
"Utilizing Tableau, we developed a comprehensive suite of visualizations to explore various aspects of hotel booking data, including booking trends, cancellation rates, and guest demographics. These visualizations serve as a foundation for our detailed analysis, helping us to identify key patterns and areas for further investigation."

One of the core aspects of our analysis focused on understanding the booking trends over time. To visualize these trends, we employed a line chart that plots the number of bookings across different time periods. This approach allows us to observe seasonal patterns, peak booking times, and potentially identify underlying factors driving these trends.

Below is a line chart illustrating how booking numbers have fluctuated on a monthly basis:

![Line Chart Showing Booking Trends Over Time](booking-trend.png)

The chart reveals a clear pattern of seasonality in booking behavior, with peaks typically occurring during summer months and a noticeable dip in the quieter winter period. Such insights are crucial for hotel management in planning for demand, staffing, and promotional activities.



