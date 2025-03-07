## Project Background

Olist is a leading Brazilian e-commerce platform that connects small and medium-sized businesses to customers across the country. It operates as a marketplace, enabling sellers to list their products and manage orders efficiently. Olist’s extensive database includes information on customer orders, product categories, seller performance, delivery times, and customer reviews, making it a rich source of data for analysing e-commerce trends and operational efficiency.

The goal of this project is to leverage Olist’s data to analyze two critical aspects of its business:

1. **Product Category Performance**: Identify top-selling product categories, analyse sales trends, and understand customer purchasing behaviour to uncover opportunities for growth and optimisation.
2. **Delivery Performance**: Evaluate delivery times, identify bottlenecks in the delivery process, and assess the impact of delivery efficiency on customer satisfaction and repeat purchases.

By combining insights from both analyses, this project aims to provide actionable recommendations to optimise product offerings, improve delivery operations, and enhance the overall customer experience on Olist.

## Data Structure & Overview

Olist´s database structure consists of the following nine tables:

<p align="center">
  <img src="visuals/ERD_olist.png" alt="ERD" width="900">
  <br>
  <em>Figure 1: Entity Relationship Diagram showing table relationships in the dataset.</em>
</p>

  
- `customers`: This dataset includes information about the customer, such as their location and unique customer ID. The latter allows us to identify returning customers.  

- `orders`: This dataset offers insights into individual transactions, including the order status, timestamps for when an order was approved, when it was handed over to the carrier, when it was delivered to the customer, and the estimated delivery date provided at the time of purchase.

- `order_items`: This dataset includes information about the items purchased within each order, such as item price and freight value. This allows us to calculate total order and freight value.

- `order_payments`: 
This dataset includes information about the payment options for each order, such as method of payment, transaction value and number of installments chosen by the customer.

- `order_reviews`: 
This dataset includes data about customer reviews, including review score, comments and creation date. 

- `products`: 
Information about each product, such as categories, dimensions and weight.  

- `sellers`: 
This dataset contains location information about the sellers who processed orders placed on Olist.

- `geolocation`: 
Geographic data containing Brazilian zip codes, city, state and coordinates.

- `product_category_name_translation`: 
This dataset offers English translations for all product category names.

A detailed account of data inspection and cleaning can be found [here](data_cleaning.md)

## Executive Summary

This section will provide a high-level overview of the key findings from the analysis of product category performance and delivery times.

### Overview of Findings

Initial analysis of product category performance has identified the top-selling categories and highlighted trends in customer purchasing behavior. The upcoming delivery performance analysis will focus on evaluating delivery efficiency and its impact on customer satisfaction.

## Insights Deep Dive

[Detailed analysis of product category performance with visualizations and key metrics.]

## Recommendations

Based on the analysis of top-selling product categories, it is recommended to focus marketing efforts on these categories and explore opportunities to expand the product range within these categories. Additional recommendations related to delivery performance will be provided upon completion of the next phase of analysis.

## Next Steps
The next phase of this project will involve analysing delivery times to understand their impact on customer satisfaction and overall sales performance. Insights from this analysis will be integrated into the existing findings to provide a comprehensive view of Olist's performance.

## Conclusion
This project aims to provide valuable insights into product category performance and delivery times, which can inform strategic decisions for Olist. As the analysis continues, additional insights and recommendations will be added to enhance the overall impact of this project.

## Sources 
Region mapping is based on [ISO](https://www.iso.org/obp/ui/#iso:code:3166:BR) 
