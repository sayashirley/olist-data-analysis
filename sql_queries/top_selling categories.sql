SELECT
  year,
  category_name_english,
  total_orders,
  top_selling
FROM (
  SELECT
    year,
    category_name_english,
    total_orders,
    ROW_NUMBER() OVER (PARTITION BY year ORDER BY total_orders DESC) AS top_selling
  FROM (
    SELECT
      EXTRACT(YEAR
      FROM
        o.order_purchase_timestamp) AS year,
      t.category_name_english,
      COUNT(*) AS total_orders
    FROM
      orders_cleaned AS o
    JOIN
      order_items AS i
    ON
      o.order_id = i.order_id
    JOIN
      products AS p
    ON
      i.product_id = p.product_id
    JOIN
      product_category_name_translation AS t
    ON
      p.product_category_name = t.category_name_portuguese
    WHERE
      o.order_status = 'delivered'
    GROUP BY
      year,
      t.category_name_english
    ORDER BY
      year ASC,
      total_orders DESC 
  ) AS subq1 
) AS subq2
WHERE
  top_selling <= 3
ORDER BY
  year ASC,
  total_orders DESC;