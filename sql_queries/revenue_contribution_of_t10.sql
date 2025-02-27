-- CTE 1: Calculate total yearly revenue for each product category.
-- Extracts the year from the order purchase timestamp and sums revenue (price + freight value).
WITH annual_data AS (
  SELECT
    EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
    p.product_category_name,
    SUM(oi.price + oi.freight_value) AS category_revenue
  FROM
    order_items oi
  JOIN
    orders_cleaned o
    ON oi.order_id = o.order_id
  JOIN
    products p
    ON oi.product_id = p.product_id
  GROUP BY
    year, p.product_category_name
),

-- CTE 2: Calculate the total revenue for the top 10 categories each year.
-- Ranks product categories by revenue and sums the revenue for the top 10.
top_categories AS (
  SELECT
    year,
    SUM(category_revenue) AS top_10_revenue
  FROM (
    -- Rank product categories by revenue within each year.
    SELECT
      year,
      product_category_name,
      category_revenue,
      ROW_NUMBER() OVER (PARTITION BY year ORDER BY category_revenue DESC) AS row_num
    FROM
      annual_data
  )
  WHERE
    row_num <= 10
  GROUP BY
    year
),

-- CTE 3: Calculate the total annual revenue for each year.
total_revenue AS (
  SELECT
    year,
    SUM(category_revenue) AS annual_revenue
  FROM
    annual_data
  GROUP BY
    year
)

-- Final Query: Calculate the percentage contribution of the top 10 categories to annual revenue.
SELECT
  tr.year,
  ROUND(tr.annual_revenue, 2) AS annual_revenue,
  ROUND(tc.top_10_revenue, 2) AS top_10_revenue,
  ROUND((tc.top_10_revenue / tr.annual_revenue) * 100, 2) AS percentage_contribution
FROM
  total_revenue tr
JOIN
  top_categories tc
ON tr.year = tc.year
ORDER BY
  tr.year;