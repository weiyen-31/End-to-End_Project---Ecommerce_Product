# Data Modelling

## Create Staging Table（Cleaned Data）

</> SQL
CREATE TABLE `product_cleaned_data`(
	`row_id` INT,
	`_id` TEXT,
	`actual_price` DECIMAL (10,2),
	`avg_rating` DECIMAL (2,1),
	`brand` VARCHAR (55),
	`category` VARCHAR (255),
	`crawled_at` DATETIME,
	`discount` VARCHAR (55),
	`description` TEXT,
	`images` TEXT,
	`out_of_stock` VARCHAR(10),
	`product_id` VARCHAR (255),
	`product_details` TEXT,
	`seller` VARCHAR (255),
	`selling_price` DECIMAL (10,2),
	`sub_category` VARCHAR (255),
	`product_name` TEXT,
	`url` TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `product_cleaned_data`
SELECT CAST(Row_id AS UNSIGNED) AS row_id,
       _id,
       CAST(NULLIF(actual_price, '') AS DECIMAL (10,2)) AS actual_price,
       CAST(NULLIF(average_rating, '')AS DECIMAL (2,1)) AS avg_rating,
       NULLIF(brand, '') AS brand,
       Category,
       STR_TO_DATE(crawled_at, '%d/%m/%Y, %H:%i:%s') AS crawled_at,
       NULLIF(discount, '') AS discount,
       NULLIF(`description`, '') AS `description`,\
       REPLACE(
           REPLACE(images, '[', '')
        , ']', '') AS images,
       LOWER(out_of_stock) AS out_of_stock,
       pid,
       product_details,
       CASE
           WHEN seller = '' THEN NULLIF(seller, '')
           WHEN seller REGEXP '[0-9]{1}\\.[0-9]{1}Seller changed' 
                THEN REGEXP_REPLACE(seller,'[0-9]{1}\\.[0-9]{1}Seller changed.*', '')
           WHEN seller REGEXP '\\(Not Enough Ratin' 
                THEN REPLACE(seller, '(Not Enough Ratin','')
           WHEN seller REGEXP '\\(New Sell' 
                THEN REPLACE(seller, '(New Sell','')	
           ELSE seller
       END AS seller,
       CAST(NULLIF(selling_price, '') AS DECIMAL(10,2)),
       sub_category,
       title,
       url
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY pid ORDER BY CAST(crawled_at AS DATE) DESC) AS rnk   
    FROM raw) T
WHERE rnk = 1;


## Create dimension table - `seller`

</> SQL
CREATE TABLE `seller`(
  `seller_code` INT AUTO_INCREMENT PRIMARY KEY,
  `seller` VARCHAR (255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `seller` (
  seller
  )
SELECT seller
FROM (
  SELECT DISTINCT seller
  FROM product_cleaned_data
  ) t;

UPDATE seller
SET seller = 'Unknown Seller'
WHERE seller IS NULL;

UPDATE seller
SET seller_code = '0'
WHERE seller = 'Unknown Seller';


## Create dimension table - `product`

 </> SQL 
CREATE TABLE `product`(
  `product_id` VARCHAR (255) PRIMARY KEY,
  `product_name` TEXT,
  `product_details` TEXT,
  `brand` VARCHAR (55),
  `category` VARCHAR (255),
  `sub_category` VARCHAR (255),
  `description` TEXT,
  `images` TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `product` (
  product_id,
  product_name,
  product_details,
  brand,
  category,
  sub_category,
  `description`,
  images
  )
SELECT product_id,
       product_name,
       product_details,
       brand,
       category,
       sub_category,
       `description`,
       images
FROM (
  SELECT DISTINCT product_id,
         product_name,
         product_details,
         brand,
         category,
         sub_category,
         `description`,
         images
  FROM product_cleaned_data
  ) T;


## Create fact table - `product_listing`

</> SQL
CREATE TABLE `Product_Listing` (
  `product_id` VARCHAR (255),
  `actual_price` DECIMAL (10,2),
  `selling_price` DECIMAL (10,2),
  `discount` VARCHAR (55),
  `avg_rating` DECIMAL (2,1),
  `out_of_stock` VARCHAR(10),
  `seller_code` INT,
  `crawled_at` DATETIME,
  `url` TEXT,
  
  PRIMARY KEY (product_id),
  FOREIGN KEY (seller_code) REFERENCES seller(seller_code),
  FOREIGN KEY (product_id) REFERENCES product(product_id
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;\

INSERT INTO `Product_Listing` (
  product_id,
  actual_price,
  selling_price,
  discount,
  avg_rating,
  out_of_stock,
  seller_code,
  crawled_at,
  url
  )
SELECT product_id,
       actual_price,
       selling_price,
       discount,
       avg_rating,
       out_of_stock,
       S.seller_code,
       crawled_at,
       url
FROM product_cleaned_data CD
JOIN seller S 
  ON S.seller = CD. seller;

