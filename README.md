Here are 30  data engineering queries for the provided dataset:


Retrieve all products with a stock quantity of less than 50.
Find all customers who have made a payment.
List all employees working in the 'USA' office.
Retrieve all orders that have a status of 'Cancelled'.
Find the total number of products available in each product line.
Calculate the average buyPrice of products in the 'Motorcycles' product line.
Find all employees who report to a specific manager.
List all offices located in a specific country (e.g., 'France').
Find the top 5 products with the highest MSRP.
Retrieve all customers who have a credit limit greater than 50,000.
List all payments made by customers in the year 2023.
Find the total number of employees working in each office.
Calculate the total amount paid by each customer.
Retrieve all orders placed between January 1, 2023, and July 1, 2023.
Find all products that are currently out of stock (i.e., quantityInStock = 0).
List all customers along with their sales representative’s (employee) name.
Calculate the total value of all products in stock for each product line.
Find the average buyPrice of all products sold by a specific vendor.
List all orders and their corresponding total amounts (quantityOrdered * priceEach).
Retrieve the names of customers who have placed more than 5 orders.
Find all employees whose email domain is 'example.com'.
List all employees along with their office location.
Find all products that have been ordered more than 100 times.
Retrieve the total amount of payments made for each year.
Find the top 3 employees who manage the most customers.
Write a CTE that shows each employee along with the total credit limit of their customers.Include employees only if their customers' total credit exceeds 100,000.
Write a query to calculate the running total of payments for each customer.Use a window function to get the cumulative sum of the amount column in the payments table.
Create a CTE to list orders where the shippedDate is later than the requiredDate or where the shippedDate is NULL. Retrieve relevant order details like order number, order date, and customer name.
Write a query using a window function to rank products within each product line based on their buyPrice. Return the product name, product line, buy price, and rank.
Find the product code, product name, and product line of products that have a higher MSRP than the average MSRP of all products in their respective product line.

