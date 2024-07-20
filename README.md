# Analyzing Supermarket Sales using MySQL 👩🏻‍💻

# Introduction

This project involved an in-depth analysis of sales data from a retail company. The dataset included various attributes such as Invoice ID, Branch, City, Customer type, Gender, Product line, Unit price, Quantity, Tax, Total, Date, Time, Payment method, cost of goods sold (COGS), gross margin percentage, gross income, and customer rating. Our objective was to derive meaningful insights that could help strategic decision-making and enhance business performance.

# Dataset 🔡
[Download dataset from kaggle](https://www.kaggle.com/datasets/aungpyaeap/supermarket-sales)

The dataset contains the following columns:

1. Invoice ID
2. Branch
3. City
4. Customer type
5. Gender
6. Product line
7. Unit price
8. Quantity
9. Tax 5%
10. Total
11. Date
12. Time
13. Payment

# MySQL Queries (Basics + Advanced)👇🏻

## 1. Total Sales by Branch
This query calculates the total sales for each branch.

    SELECT Branch, SUM(Total) AS Total_Sales
    FROM data
    GROUP BY Branch;

![1](https://github.com/user-attachments/assets/7f7c46d1-e242-4d15-a5f2-1eae22c5a412)

## 2. Average Rating by Product Line
This query calculates the average customer rating for each product line.

    SELECT `Product line`, AVG(Rating) AS Average_Rating
    FROM data
    GROUP BY `Product line`;

![2](https://github.com/user-attachments/assets/88fd294b-a87b-4876-825c-0c1199203f0b)

## 3. Sales by Payment Method
This query calculates the total sales for each payment method.

    SELECT Payment, SUM(Total) AS Total_Sales
    FROM data
    GROUP BY Payment;

![3](https://github.com/user-attachments/assets/89a78798-5f92-4491-8ab9-9a5520bd1ca6)

## 4. Sales by City and Customer Type
This query calculates the total sales for each city, further divided by customer type (Member or Normal).

    SELECT City, `Customer type`, SUM(Total) AS Total_Sales
    FROM data
    GROUP BY City, `Customer type`;

![4](https://github.com/user-attachments/assets/7bcd5527-a511-420e-af39-3ab6b6972e85)


## 5. Total Quantity Sold by Product Line
This query calculates the total quantity of items sold for each product line.

    SELECT `Product line`, SUM(Quantity) AS Total_Quantity
    FROM data
    GROUP BY `Product line`;

![5](https://github.com/user-attachments/assets/97832a2e-92bd-482f-98ba-2f1f4140c1a5)

## 6. Monthly Sales
This query calculates the total sales for each month.

    SELECT DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m') AS Month, SUM(Total) AS Total_Sales
    FROM data
    GROUP BY Month;

![6](https://github.com/user-attachments/assets/a047d78e-24f4-4df2-b381-e0cfebde5d67)

## 7.  Sales Distribution by Gender
This query calculates the total sales for each gender.

    SELECT Gender, SUM(Total) AS Total_Sales
    FROM data
    GROUP BY Gender;

![7](https://github.com/user-attachments/assets/6d6aa9b1-b96d-48fe-a697-39287129509b)

## 8. Average Gross Income by City
This query calculates the average gross income for each city.

    SELECT City, AVG(`gross income`) AS Average_Gross_Income
    FROM data
    GROUP BY City;

![8](https://github.com/user-attachments/assets/1efc616c-72ab-4359-8ab0-1e1f961b7c7f)

## 9. Top 5 Products by Sales
This query finds the top 5 product lines by total sales.

    SELECT `Product line`, SUM(Total) AS Total_Sales
    FROM data
    GROUP BY `Product line`
    ORDER BY Total_Sales DESC
    LIMIT 5;
    
![9](https://github.com/user-attachments/assets/40466f4e-c1d0-4827-853e-8ba1994bde23)

## 10. Sales by Hour
This query calculates the total sales for each hour of the day.

    SELECT HOUR(STR_TO_DATE(Time, '%H:%i')) AS Hour, SUM(Total) AS Total_Sales
    FROM data
    GROUP BY Hour;

![10](https://github.com/user-attachments/assets/8d9f6533-22f2-4a46-9d4f-a6a7c1ded0b6)

## 11. Monthly Sales Growth
This query calculates the month-over-month sales growth.

        SELECT 
            DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m') AS Month, 
            SUM(Total) AS Total_Sales, 
            LAG(SUM(Total)) OVER (ORDER BY DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m')) AS Previous_Month_Sales,
            (SUM(Total) - LAG(SUM(Total)) OVER (ORDER BY DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m'))) / LAG(SUM(Total)) OVER (ORDER BY DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m')) * 100 AS Sales_Growth_Percentage
        FROM data
        GROUP BY Month;

![11](https://github.com/user-attachments/assets/86249d97-7063-4757-a890-44fea9b4b03f)

## 12. Customer Retention by Month
This query calculates customer retention by counting unique returning customers per month.

        SELECT 
            DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m') AS Month,
            COUNT(DISTINCT CASE WHEN `Customer type` = 'Member' THEN `Invoice ID` END) AS Returning_Customers,
            COUNT(DISTINCT `Invoice ID`) AS Total_Customers,
            COUNT(DISTINCT CASE WHEN `Customer type` = 'Member' THEN `Invoice ID` END) / COUNT(DISTINCT `Invoice ID`) * 100 AS Retention_Rate
        FROM data
        GROUP BY Month;

![12](https://github.com/user-attachments/assets/fb7a9560-7568-4f86-9ef8-8169e0a7686d)

## 13. Average Purchase Frequency by Customer Type
This query calculates the average purchase frequency for each customer type.

    SELECT 
        `Customer type`, 
        COUNT(`Invoice ID`) / COUNT(DISTINCT DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m-%d')) AS Avg_Purchase_Frequency
    FROM data
    GROUP BY `Customer type`;

![13](https://github.com/user-attachments/assets/56710e27-19f1-434e-9f6d-a2f0c1f05c44)

## 14. Time Series Analysis of Sales
This query performs a time series analysis to calculate the rolling average sales over 3 months.

    SELECT 
        DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m') AS Month,
        SUM(Total) AS Total_Sales,
        AVG(SUM(Total)) OVER (ORDER BY DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m') ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Rolling_Avg_Sales_3_Months
    FROM data
    GROUP BY Month;

![14](https://github.com/user-attachments/assets/c62c5b68-587b-495b-a4cf-a6d6b6775cd8)

## 15. Correlation Between Unit Price and Rating
This query calculates the correlation between unit price and customer rating.

        SELECT 
            AVG((`Unit price` - (SELECT AVG(`Unit price`) FROM data)) * (Rating - (SELECT AVG(Rating) FROM data))) / 
            (STDDEV_SAMP(`Unit price`) * STDDEV_SAMP(Rating)) AS Correlation
        FROM data;

![15](https://github.com/user-attachments/assets/f79928d0-04cd-445d-8090-0cd5e5ddbeb6)

## 16. Top Customers by Total Spend
This query identifies the top 5 customers by total spend.

        SELECT 
            `Invoice ID`, 
            SUM(Total) AS Total_Spend
        FROM data
        GROUP BY `Invoice ID`
        ORDER BY Total_Spend DESC
        LIMIT 5;

![16](https://github.com/user-attachments/assets/c753efde-5008-4ae2-ad39-6e2a8a8c120c)

## 17. Sales Performance by Time of Day
This query analyzes sales performance by different times of the day.

    SELECT 
        CASE
            WHEN HOUR(STR_TO_DATE(Time, '%H:%i')) BETWEEN 0 AND 5 THEN 'Midnight - 6 AM'
            WHEN HOUR(STR_TO_DATE(Time, '%H:%i')) BETWEEN 6 AND 11 THEN '6 AM-Noon'
            WHEN HOUR(STR_TO_DATE(Time, '%H:%i')) BETWEEN 12 AND 17 THEN 'Noon - 6 PM'
            ELSE '6 PM - Midnight'
        END AS Time_Period,
        SUM(Total) AS Total_Sales
    FROM data
    GROUP BY Time_Period;

![17](https://github.com/user-attachments/assets/764613f2-8c1a-4c0a-ab29-bcf92c292782)

## 18. Gender-Based Sales Analysis Over Time
This query tracks sales trends over time based on gender.

    SELECT 
        DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m') AS Month,
        Gender,
        SUM(Total) AS Total_Sales
    FROM data
    GROUP BY Month, Gender
    ORDER BY Month, Gender;

![18](https://github.com/user-attachments/assets/c31da5cb-4315-4a8a-87ee-9e78d641f5ad)

# Conclusion 🔚

The comprehensive analysis of the retail sales dataset provided valuable insights into various aspects of the business. These findings can help strategic decision-making, improve operational efficiency, enhance customer satisfaction, and drive overall business growth. By leveraging these insights, the company can optimize its marketing efforts, inventory management, customer relationship management, and operational planning. Implementing these data-driven strategies will position the company for sustained growth and competitive advantage in the retail market.
