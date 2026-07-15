# ETL Process
  
##Dataset Import

</> SQL
CREATE TABLE `ecommerce_product_raw_data` (
  `row_id` TEXT,
  `_id` TEXT,
  `actual_price` TEXT,
  `average_rating` TEXT,
  `brand` TEXT,
  `category` TEXT,
  `crawled_at` TEXT,
  `discount` TEXT,
  `description` TEXT,
  `images` TEXT,
  `out_of_stock` TEXT,
  `pid` TEXT,
  `product_details` TEXT,
  `seller` TEXT,
  `selling_price` TEXT,
  `sub_category` TEXT,
  `title` TEXT,
  `url` TEXT
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
    

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Ecommerce_Product_raw.csv'
INTO TABLE ecommerce_product_raw_data
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES

## Export Cleaned Data

SELECT 'row_id', '_id', 'actual_price', 'avg_rating', 'brand category', 'crawled_at',	
       'discount', 'description', 'images', 'out_of_stock', 'product_id', 
       'product_details', 'seller', 'selling_price', 'sub_category', 'product_name', 'url'
UNION ALL
SELECT row_id, _id, actual_price, avg_rating, brand category, crawled_at,	
       discount, description, images, out_of_stock, product_id, 
       product_details, seller, selling_price, sub_category, product_name, url
FROM product_listing
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Ecommerce_Product_cleaned'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

