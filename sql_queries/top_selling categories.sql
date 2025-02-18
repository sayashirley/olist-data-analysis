WITH revenue_data AS (
    SELECT
        EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
        t.category_name_english,
        SUM(oi.price + oi.freight_value) AS category_revenue
    FROM
        order_items oi
    JOIN
        orders_cleaned o
        ON oi.order_id = o.order_id
    JOIN
        products p
        ON oi.product_id = p.product_id
    JOIN
        product_category_name_translation t
        ON p.product_category_name = t.category_name_portuguese
    GROUP BY
        year,
        t.category_name_english
),
ranked_data AS (
    SELECT
        year,
        category_name_english,
        CAST(ROUND(category_revenue, 0) AS INT64) AS category_revenue,
        RANK() OVER (PARTITION BY year ORDER BY category_revenue DESC) AS category_rank
    FROM
        revenue_data
)
SELECT
    year,
    category_name_english,
    category_revenue,
    category_rank
FROM
    ranked_data
WHERE
    category_rank <= 10
ORDER BY
    year,
    category_rank;