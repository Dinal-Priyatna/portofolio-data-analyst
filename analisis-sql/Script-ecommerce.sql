--nomor 2
SELECT product_code, product_name, product_line, msrp
FROM products
ORDER BY msrp DESC
LIMIT 1

--NOMOR 3
SELECT sales_rep_employee_number, COUNT(*) AS jumlah_customer
FROM customers
WHERE sales_rep_employee_number IS NOT NULL
GROUP BY sales_rep_employee_number
HAVING COUNT(*) > 3

--nomor 3
SELECT sales_rep_employee_number, COUNT(sales_rep_employee_number) AS jumlah_customer
FROM customers
GROUP BY sales_rep_employee_number
HAVING COUNT(sales_rep_employee_number) > 3

--nomor 4
SELECT c.city, COUNT(DISTINCT o.order_number) AS jumlah_order
FROM customers c
INNER JOIN orders o ON c.customer_number = o.customer_number
GROUP BY c.city
ORDER BY jumlah_order DESC
limit 1

--nomor 5
WITH basket_per_order AS (
    SELECT o.order_number, c.city, SUM(od.quantity_ordered) AS basket_size
    FROM orderdetails od
    INNER JOIN orders o ON od.order_number = o.order_number
    INNER JOIN customers c ON o.customer_number = c.customer_number
    GROUP BY o.order_number, c.city
)
SELECT city, ROUND(AVG(basket_size), 2) AS average_basket_size
FROM basket_per_order
GROUP BY city
ORDER BY average_basket_size DESC
