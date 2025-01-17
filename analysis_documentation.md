# Analysis Documentation

## Top-Selling Product Category of 2016-2018

### 1. Problem Statement

What are the top-selling product categories for each year between 2016-2018? This analysis will help identify key product categories that contribute the most to revenue, providing insights for inventory planning and promotional strategies.

### 2. Datasets
- `orders_cleaned`
- `order_items`
- `products`
- `product_category_name_translation`

### 3. Methodology

### 4. Results

### 5. Visualisation


```sql
SELECT 
  o.seller_id,
  COUNT(*) AS order_count,
  s.seller_zip_code_prefix,
  EXTRACT(YEAR FROM o.shipping_limit_date) AS Year,
  EXTRACT(MONTH FROM o.shipping_limit_date) AS Month,
  o.price
FROM 
  `olist.order_items` AS o
JOIN 
  `olist.sellers` AS s
  ON o.seller_id = s.seller_id
WHERE 
  o.product_id ='8e1446d14972eb9ba34dd6273315f419'
GROUP BY
  o.seller_id,
  s.seller_zip_code_prefix,
  Year,
  Month,
  o.price
ORDER BY
  seller_id,
  Year,
  Month
```
