# E-commerce Product Analytics Dashboard

An end-to-end project built with MySQL and Power BI to transform raw e-commerce product data into an interactive dashboard for product portfolio, pricing, and market performance analysis.

This project follows a complete BI workflow, including data cleaning, dimensional modelling, ETL, dashboard development, and business insight generation.

## About the Project

E-commerce platforms manage thousands of products across different brands, sellers, and categories. As product portfolios continue to grow, it becomes increasingly difficult to monitor pricing strategies, inventory status, discount effectiveness, and customer ratings using raw datasets alone.

This project focuses on product portfolio management by combining pricing, inventory availability, and customer ratings to support merchandising and product strategy decisions.

Hence, this project built an end-to-end Business Intelligence solution that transforms raw product data into an interactive Power BI dashboard. The dashboard helps users explore product portfolio composition, pricing trends, brand performance, customer ratings, and inventory availability from multiple business perspectives.

## Business Questions

This dashboard was designed to answer questions such as:

1. Which product categories contain the largest number of products?
2. Which brands have the largest product portfolio?
3. How are products priced across different brands and categories?
4. How are discounts distributed across the product catalogue?
5. Which categories receive the highest customer ratings?
6. Which brands experience the highest out-of-stock rate?
7. Is there a relationship between product price and customer ratings?
8. How does selling price compare with actual price?

## Dataset

Source: Kaggle E-commerce Product Dataset

Industry: E-commerce / Retail

The dataset contains product listing information including:

- row_id
- _id
- actual_price
- average_rating
- brand	category
- crawled_at
- discount
- description	
- images
- out_of_stock
- pid
- product_details
- seller
- selling_price
- sub_category
- title
- url

## Project Workflow
<img width="439" height="482" alt="image" src="https://github.com/user-attachments/assets/577382d7-46f6-4c4d-8b2e-1ff5f9ed27f2" />

## Data Preparation

The dataset was first imported into MySQL Workbench for data cleaning and modelling before being loaded into Power BI.

The preparation process included:

- Removing duplicate records
- Standardizing data types
- Renaming columns
- Building dimension and fact tables
- Creating surrogate keys for Dim Seller
- Designed and implemented a Star Schema

After importing the cleaned data into Power BI, additional transformations were completed using Power Query, including:

- Data formatting
- Removed Unneeded columns
- Data type conversion
- Creating calculated attributes
- Preparing the dataset for DAX calculations
- Creating a Date dimension
- Developed DAX measures to support KPI calculations
- Removed corrupted product records from Dim Products and rebuilt the fact table relationship, resulting in 1,429 excluded unmatched rows (28,080 → 26,651)
  
## Exploratory Data Analysis

Before designing the dashboard, exploratory analysis was performed to understand the overall product portfolio and identify business patterns.

The initial analysis focused on:

- Product Category Distribution
  
  <img width="766" height="415" alt="image" src="https://github.com/user-attachments/assets/74f42762-5ed6-45e4-b15c-bb3c6ebb2b21" />

  Highlighted which product categories contain the largest number of products before developing the portfolio dashboard.

- Price Distribution

  <img width="766" height="415" alt="image" src="https://github.com/user-attachments/assets/aefecf49-578d-43a7-a472-941c1b251ad6" />

  Revealed the overall selling price distribution and identified common pricing ranges across products.

- Discount Distribution

  <img width="766" height="415" alt="image" src="https://github.com/user-attachments/assets/152af058-2b6d-4fc4-a912-30d8b1dc2e04" />

  Helped understand how discounts are distributed and identify the most common discount levels.

- Customer Rating Distribution

  <img width="766" height="415" alt="image" src="https://github.com/user-attachments/assets/3d13a91e-6148-4e11-be76-27955f1e3ceb" />

  Provided an overview of customer satisfaction by examining the distribution of product ratings.

These findings helped determine the KPIs and visualizations included in the final dashboard.

## Data Model

The data model follows a Star Schema consisting of:

- 1 Fact Table
- 3 Dimension Tables

<img width="539" height="391" alt="image" src="https://github.com/user-attachments/assets/66fedbc3-b730-4b28-afe4-4ab8da6e3e31" />

Relationships：

<img width="788" height="194" alt="image" src="https://github.com/user-attachments/assets/4e1de306-d95c-4642-a7c4-05e3e57dbdb3" />

## Dashboard

The report consists of three pages, each focusing on a different business perspective.

### 1. Product Portfolio Overview

<img width="880" height="492" alt="image" src="https://github.com/user-attachments/assets/e6b591c1-b7eb-4268-9be6-87eb712bbbf8" />

This page provides an overview of the product catalogue and inventory.

Highlights include:

- Total Products
- Average Selling Price
- Average Rating
- Average Discount Rate
- Products by Category
- Stock Availability
- Top Brands
- Top Sellers
- Price vs Rating

### 2️. Pricing & Market Analysis

<img width="872" height="482" alt="image" src="https://github.com/user-attachments/assets/4b129bae-70e9-4ec2-bf1f-72792f460cc9" />

This page focuses on pricing behaviour and discount strategies across the marketplace.

Highlights include:

- Highest Selling Price
- Lowest Selling Price
- Average Selling Price by Brand
- Price Distribution
- Average Discount by Category
- Discount Distribution
- Selling Price vs Actual Price

### 3️. Product Performance

<img width="878" height="487" alt="image" src="https://github.com/user-attachments/assets/6749e4cc-d43c-446d-ba8c-4e7df6d8ed69" />

This page evaluates product quality and inventory performance.

Highlights include:

- Highest Rating
- Average Rating
- Rating by Category
- Rating Distribution
- Rating by Brand
- Top Rated Sub-Categories
- Out-of-stock Rate by Brand

## Key Insights

1. Clothing & Accessories accounted for the largest share of products in the catalogue.
2. Most products were available in stock, with an overall stock availability above 90%.
3. Selling prices were concentrated within the lower-to-mid price range.
4. Discount rates clustered around mid-to-high discount levels, indicating aggressive promotional pricing.
5. Most products received ratings between 3.5 and 4.5 stars.
6. A small number of brands showed significantly higher out-of-stock rates, potentially affecting customer experience.

## Recommendations

1. Review pricing strategies for brands positioned above the market average.
2. Monitor brands with high out-of-stock rates to improve inventory planning.
3. Continue promoting highly rated product categories to strengthen customer satisfaction.
4. Evaluate the effectiveness of large discounts to ensure profitability.
5. Expand product offerings in high-performing categories with strong customer ratings.

## Repository Structure

```
Ecommerce-Product-Dashboard
│
├── Dataset
|    ├── Raw Data.csv
│    ├── Cleaned Data.csv
│
├── MySQL
│   ├── Data Cleaning.sql
│   ├── ETL.sql
│   ├── Data Model.sql
│
├── Power BI
│   └── Ecommerce Product Dashboard.pbix
│
├── Images
│   ├── Dashboard Product Overview.png
│   ├── Dashboard Pricing & Market Analysis.png
│   ├── Dashboard Product Performance.png
│   ├── Schema.png
│
└── README.md
```
   
## Tools Used

| Tool | Purpose |
|------|---------|
| MySQL Workbench | Data Cleaning, ETL & Data Modeling |
| Power BI | Dashboard Development |
| Power Query | Data Transformation |
| DAX | Business Calculations |
| Star Schema | Data Warehouse Modeling |
| GitHub | Version Control & Portfolio |

## Skills Demonstrated
- SQL
- ETL
- Data Cleaning
- Data Modeling
- Star Schema Design
- Surrogate Keys
- Power Query
- DAX
- Power BI
- Dashboard Design
- Business Intelligence
- Product Analytics
- Pricing Analysis
- Inventory Analysis
- Data Visualization
