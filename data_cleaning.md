# Data Cleaning Documentation

## 1. Data Overview
**Source**: [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

**Size**:
- `customers`: 99,441 rows and 5 columns
- `orders`: 99,441 rows and 8 columns
- `order_items`: 112,650 rows and 7 columns
- `order_payments`: 103,886 rows and 5 columns
- `order_reviews`: 99,224 rows and 7 columns
- `products`: 32,951 rows and 9 columns
- `sellers`: 3,095 rows and 4 columns
- `geolocation`: 1,000,163 rows and 5 columns
- `product_category_name_translation`: 71 rows and 2 columns

**Key fields**:
- `customer_id`: Distinct customer ID for each order. 
- `order_id`: A unique code assigned to each order.
- `product_id`: A unique code assigned to each product.
- `seller_id`: A unique code assigned to each seller.

## 2. Initial Data Assessment
Before cleaning, the following SQL query was used to assess the dataset:

```sql
SELECT 
  COUNT(*) AS total_rows,
  COUNT(DISTINCT id) AS unique_ids,
  SUM(CASE WHEN value IS NULL THEN 1 ELSE 0 END) AS missing_values
FROM your_table;
```
- Missing values: [Summary or counts]
- Duplicates: [Count]
- Outliers: [Description]

## 3. Cleaning Steps
- **Step 1**: [Describe step, e.g., "Removed duplicates"]
- **Step 2**: [Describe step, e.g., "Imputed missing values using the median"]
- **Step 3**: [Describe step, e.g., "Transformed column 'X' into categories"]

## 4. Challenges and Resolutions
- **Challenge 1**: [Describe challenge]
  - **Resolution**: [How you solved it]
- **Challenge 2**: [Describe challenge]
  - **Resolution**: [How you solved it]

## 5. Final Cleaned Dataset
- **Size**: [Final row/column count]
- **Key changes**: [List of major changes made]
