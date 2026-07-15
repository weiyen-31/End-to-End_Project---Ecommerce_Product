# Data CLeaning

## Check Duplicates and Remove it

</> SQL
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY pid ORDER BY CAST(crawled_at AS DATE) DESC) AS rnk   
    FROM raw) T
WHERE rnk = 1;

## Data Standardation and Consistency, Remove Unwanted Spaces and Handle Missing Value

</> SQL
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
