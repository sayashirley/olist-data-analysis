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

### Missing Values and Duplicates

This table lists the key fields for each dataset, which were used to adapt the SQL query below for checking duplicates and missing values:

<div align="center">
  
| `table_name`    | `key_field`     |
| ------------    | ------------    |
| `customers`     | `customer_id`   |
| `orders`        | `order_id`      |
| `products`      | `product_id`    |
| `sellers`       | `seller_id`     | 

</div>

```sql
SELECT 
  COUNT(*) AS total_rows,
  COUNT(DISTINCT key_field) AS distinct_values,
  SUM(CASE WHEN key_field IS NULL THEN 1 ELSE 0 END) AS missing_values
FROM table_name;
```

> **Result**: No missing values or duplicates were found in the key fields.

### Logical Timestamp Validation

Verified that all date fields follow a logical order (e.g. `order_purchase_timestamp` ≤ `order_approved_at` ≤ `order_delivered_carrier_date` ≤ `ordered_delivered_customer_date`) for `delivered` orders:

```sql
SELECT
order_id,
order_purchase_timestamp,
order_approved_at,
order_delivered_carrier_date,
order_delivered_customer_date
FROM
  orders
WHERE
  -- Check for illogical timestamp order
  NOT (
    order_purchase_timestamp <= order_approved_at AND
    order_approved_at <= order_delivered_carrier_date AND
    order_delivered_carrier_date <= order_delivered_customer_date
  ) 
  -- Exclude NULL timestamps
  AND order_purchase_timestamp IS NOT NULL
  AND order_approved_at IS NOT NULL
  AND order_delivered_carrier_date IS NOT NULL 
  AND order_delivered_customer_date IS NOT NULL
  -- Filter only delivered orders
  AND order_status = 'delivered';
```

> **Result**: Identified 1,373 rows with inconsistencies:<br>- `order_approved_at > order_delivered_carrier_date`: 1,350 rows.<br>- `order_delivered_carrier_date > order_delivered_customer_date`: 23 rows.

### Numeric Value Validation
  
Ensured that all numeric fields (`price`, `freight_value`) contained positive values:

```sql
SELECT
*
FROM
  order_items
WHERE
  price < 0 OR freight_value < 0;
```
  
> **Result**: No negative values found.

### Category Consistency Checks

Ensured consistency between the `products` and `product_category_name_translation` tables by checking for unmatched product categories:

```sql
SELECT
  DISTINCT p.product_category_name
FROM
  products AS p
JOIN
  product_category_name_translation AS t
ON 
  p.product_category_name = t.category_name_portuguese
WHERE 
  t.category_name_portuguese IS NULL;
```
  
> **Result**: All product categories matched.

### Timestamp Range Validation

Verified that all timestamps fall within the expected range (2016-2018):

```sql
SELECT
  MIN(order_approved_at) AS earliest_date,
  MAX(order_approved_at) AS latest_date
FROM
  orders;
```

> **Result**: All timestamps fell within the expected range.
 
## 3. Cleaning Steps

**Handling Missing Values with `order_status`**

- **Approval Date**:
  - Missing `order_approved_at` was valid for orders with `order_status` = `created` and `canceled`. These rows were retained.

- **Carrier Delivery Date**:
  - Rows with missing `order_delivered_carrier_date` and `order_status` = `delivered` were deleted.
  - Other statuses (`created`, `approved`, etc.) were considered valid and retained.
 
- **Customer Delivery Date**:
  - Missing `order_delivered_customer_date` was acceptable for incomplete orders (e.g.`created`, `processing`, `shipped`).
  - Rows with missing values and `order_status` = `delivered` were deleted.

```sql
DELETE FROM
  orders
WHERE
  (
    order_delivered_carrier_date IS NULL 
    OR order_delivered_customer_date IS NULL
  )
  AND order_status = 'delivered';
```

> **Result**: 9 rows were removed from `orders`.

## 4. Challenges and Resolutions

**Inconsistent Timestamps**

  - Issues Found:
    - 1,350 rows where `order_approved_at > order_delivered_carrier_date`.
    - 23 rows where `order_delivered_carrier_date > order_delivered_customer_date`.
  
  - Actions Taken:
    - Rows where `order_delivered_carrier_date > order_delivered_customer_date` were removed.
    - Rows where `order_approved_at > order_delivered_carrier_date` were flagged for further analysis.

```sql
DELETE FROM
  orders
WHERE
  order_delivered_carrier_date > order_delivered_customer_date
  AND order_status = 'delivered';
```

> **Result**: 23 rows were removed from `orders`.

```sql
-- Add a boolean column to flag rows.  
ALTER TABLE orders
  ADD COLUMN is_flagged BOOLEAN;

-- Set the conditions for when it is true.
UPDATE orders
SET is_flagged = TRUE
WHERE order_approved_at > order_delivered_carrier_date
  AND order_status = 'delivered';

-- Set the conditions for when it is false.
UPDATE orders
SET is_flagged = FALSE
WHERE is_flagged IS NULL;
```

> **Result**: 1,350 rows were flagged.

## 5. Final Cleaned Dataset

- **Size**:  
  - `customers`: 99,441 rows and 5 columns  
  - `orders`: 99,409 rows and 9 columns
  - `order_items`: 112,650 rows and 7 columns  
  - `order_payments`: 103,886 rows and 5 columns  
  - `order_reviews`: 99,224 rows and 7 columns  
  - `products`: 32,951 rows and 9 columns  
  - `sellers`: 3,095 rows and 4 columns  
  - `geolocation`: 1,000,163 rows and 5 columns  
  - `product_category_name_translation`: 71 rows and 2 columns
 
- **Key changes**:
  - Removed a total of 32 rows from `orders` dataset, reducing the number of rows by 0.032%.
  - Added a column in `orders` to identify flagged rows where inconsistent timestamps are present.
