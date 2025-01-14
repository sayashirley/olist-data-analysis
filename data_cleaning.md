# Data Cleaning Documentation

## 1. Data Overview

- **Source**: [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

- **Size**:  
  - `customers`: 99,441 rows and 5 columns  
  - `orders`: 99,441 rows and 8 columns  
  - `order_items`: 112,650 rows and 7 columns  
  - `order_payments`: 103,886 rows and 5 columns  
  - `order_reviews`: 99,224 rows and 7 columns  
  - `products`: 32,951 rows and 9 columns  
  - `sellers`: 3,095 rows and 4 columns  
  - `geolocation`: 1,000,163 rows and 5 columns  
  - `product_category_name_translation`: 71 rows and 2 columns  

## 2. Initial Data Assessment

The table below lists the key fields for each dataset, which are used to adapt the general SQL query below for checking duplicates and missing values:

<div align="center">
  
| `table_name` | `key_field`  |
| ------------ | ------------ |
| `customers`  | `customer_id`|
| `orders`     | `order_id`   |
| `products`   | `product_id` |
| `sellers`    | `seller_id`  | 

</div>

```sql
SELECT 
  COUNT(*) AS total_rows,
  COUNT(DISTINCT key_field) AS distinct_values,
  SUM(CASE WHEN key_field IS NULL THEN 1 ELSE 0 END) AS missing_values
FROM table_name;
```

### Result:
- Missing values: 0
- Duplicates: 0

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
- **Size**:  
  - `customers`: 99,441 rows and 5 columns  
  - `orders`: 99,441 rows and 8 columns  
  - `order_items`: 112,650 rows and 7 columns  
  - `order_payments`: 103,886 rows and 5 columns  
  - `order_reviews`: 99,224 rows and 7 columns  
  - `products`: 32,951 rows and 9 columns  
  - `sellers`: 3,095 rows and 4 columns  
  - `geolocation`: 1,000,163 rows and 5 columns  
  - `product_category_name_translation`: 71 rows and 2 columns
- **Key changes**: [List of major changes made]
