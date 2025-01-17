# Analysis Documentation

## Top-Selling Product Categories per Year (2016-2018)

### 1. Problem Statement

What are the top-selling product categories for each year between 2016-2018? This analysis will help identify key product categories that contribute the most to revenue, providing insights for inventory planning and promotional strategies.

### 2. Datasets
- `orders_cleaned`
- `order_items`
- `products`
- `product_category_name_translation`

### 3. Methodology

#### Subquery 1: Extracting Year and Calculating Total Orders per Category

In the first subquery, I aggregated the total number of orders for each product category, grouped by year. The key steps in this subquery include:

1. **Extract Year**:

    Extracted the year from the `order_purchase_timestamp` in the `orders_cleaned` dataset.

2. **Joins**:

    - Connected the `orders_cleaned` dataset with the `order_items` dataset to retrieve order details.
    
    - Linked the `order_items` dataset with the `products` dataset to obtain category names.
    
    - Mapped the `products` dataset to the `product_category_name_translation` dataset to translate product categories from Portuguese to English.

3. **Filter for Delivered Orders**:

    Filtered the data to include only delivered orders.

4. **Aggregation**:

    Counted the total number of orders for each product category per year.

#### Subquery 2: Ranking Top-Selling Categories

The results from Subquery 1 were used to rank product categories within each year based on the total number of orders. The key steps in this subquery include:

1. **Ranking**:

    Ranked product categories for each year in descending order of total orders.

2. **Filtering for Top 3 Categories**:

    Selected only the top three categories for each year.

#### Main Query: Combining Results

The main query combines the results from the subqueries to produce a final list of the top-selling product categories for each year. The results are presented in descending order of total orders for better visibility of the highest-performing categories.

### 4. Results

<p align="center">
  <img src="visuals/top_selling_category.png" alt="Top Selling Product Categories (2016-2018)" width="750">
  <br>
  <em>Figure 1: Top Selling Product Categories per Year (2016-2018)</em>
</p>

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
