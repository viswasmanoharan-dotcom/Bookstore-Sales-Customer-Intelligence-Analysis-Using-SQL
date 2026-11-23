-- STEP 1 CREATE DATABASE
CREATE DATABASE LIBRARY;
use library;
-- STEP 2 CREATE DATABASE SCHEMA

CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(200),
    genre VARCHAR(100),
    price DECIMAL(6,2),
    stock INT
);

-- 2. customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(150),
    city VARCHAR(100),
    signup_date DATE
);

-- 3. orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    book_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- 4. marketing_spend table
CREATE TABLE marketing_spend (
    spend_id INT PRIMARY KEY,
    customer_id INT,
    spend_amount DECIMAL(7,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
SELECT * FROM ORDERS;
-- STEP 3 INSERT SAMPLE DATA
INSERT INTO books VALUES
(1, 'Data Science 101', 'Education', 29.99, 100),
(2, 'The Art of SQL', 'Technology', 34.50, 50),
(3, 'Mystery at the Bookstore', 'Fiction', 15.00, 20),
(4, 'Learn Python the Hard Way', 'Education', 40.00, 30),
(5, 'Fantasy World Chronicles', 'Fantasy', 22.50, 10);

-- customers
INSERT INTO customers VALUES
(1, 'Alice', 'New York', '2023-01-10'),
(2, 'Bob', 'San Francisco', '2023-03-15'),
(3, 'Charlie', 'Austin', '2023-06-20'),
(4, 'Diana', 'New York', '2024-01-10'),
(5, 'Evan', 'Chicago', '2024-04-05');

-- orders
INSERT INTO orders VALUES
(1, 1, 1, 2, '2024-06-01'),
(2, 2, 2, 1, '2024-06-02'),
(3, 1, 3, 1, '2024-06-03'),
(4, 3, 1, 3, '2024-06-04'),
(5, 4, 5, 2, '2024-06-04'),
(6, 5, 2, 2, '2024-06-05'),
(7, 2, 4, 1, '2024-06-05'),
(8, 1, 1, 1, '2024-06-06');

-- marketing_spend
INSERT INTO marketing_spend VALUES
(1, 1, 50.00),
(2, 2, 75.00),
(3, 3, 40.00),
(4, 4, 60.00),
(5, 5, 35.00);
SELECT * FROM MARKETING_SPEND;
-- STEP 4 ANALYZE BOOK PERFORMANCE
SELECT 
    b.title,
    SUM(o.quantity) AS total_units_sold,
    SUM(o.quantity * b.price) AS total_revenue
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY b.title
ORDER BY total_revenue DESC;
-- STEP 5 ALERT
SELECT 
    title, stock
FROM books
WHERE stock < 15;
-- STEP 6 SEGMENT CUSTOMERS USING RECENCY, FREQUENCY,MONETARY ANALYSIS
WITH customer_metrics AS (
    SELECT
        c.customer_id,
        c.name,
        MAX(o.order_date) AS last_order,
        COUNT(o.order_id) AS frequency,
        SUM(o.quantity * b.price) AS monetary
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN books b
        ON o.book_id = b.book_id
    GROUP BY
        c.customer_id,
        c.name
)

SELECT
    *,
    DATEDIFF('2024-07-01', last_order) AS recency_days
FROM customer_metrics;
-- STEP 7 COMPARE CUSTOMER LIFETIME REVENUE VS ACQUISITION COST
WITH customer_spend AS (
    SELECT 
        o.customer_id,
        SUM(o.quantity * b.price) AS total_revenue
    FROM orders o
    JOIN books b ON o.book_id = b.book_id
    GROUP BY o.customer_id
)
SELECT 
    c.customer_id,
    c.name,
    ms.spend_amount,
    cs.total_revenue,
    (cs.total_revenue - ms.spend_amount) AS profit
FROM customers c
JOIN marketing_spend ms ON c.customer_id = ms.customer_id
JOIN customer_spend cs ON c.customer_id = cs.customer_id;
-- STEP 8 MONTHLY SALES TREND
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(o.quantity * b.price) AS total_revenue
FROM orders o
JOIN books b 
    ON o.book_id = b.book_id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month;
-- STEP 9 RETURNING CUSTOMERS
SELECT 
    c.customer_id,
    c.name,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING total_orders > 1;
-- STEP 10 AVERAGE ORDER VALUE
SELECT 
    ROUND(SUM(quantity * b.price) * 1.0 / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM orders o
JOIN books b ON o.book_id = b.book_id;
-- STEP 11 TOP 5 BOOKS BY REVENUE
WITH book_sales AS (
    SELECT
        b.book_id,
        b.title,
        SUM(o.quantity * b.price) AS revenue
    FROM books b
    JOIN orders o ON b.book_id = o.book_id
    GROUP BY b.book_id, b.title
)
SELECT *,
       RANK() OVER (ORDER BY revenue DESC) AS sales_rank
FROM book_sales
LIMIT 5;
-- STEP 12 CUMULATIVE MONTHLY REVENUE
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
        SUM(o.quantity * b.price) AS revenue
    FROM orders o
    JOIN books b ON o.book_id = b.book_id
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
)
SELECT
    month,
    revenue,
    SUM(revenue) OVER (
        ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS cumulative_revenue
FROM monthly_sales;
-- STEP 13 COMPARE CURRENT MONTH REVENUE WITH PREVIOUS MONTH REVENUE
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
        SUM(o.quantity * b.price) AS revenue
    FROM orders o
    JOIN books b ON o.book_id = b.book_id
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
),
comparison AS (
    SELECT
        month,
        revenue,
        LAG(revenue) OVER (ORDER BY month) AS previous_revenue
    FROM monthly_sales
)
SELECT
    month,
    revenue,
    previous_revenue,
    ROUND(
        (revenue - previous_revenue) * 100.0 /
        NULLIF(previous_revenue, 0), 2
    ) AS growth_percentage
FROM comparison;
-- STEP 14 BOOKS PRICED ABOVE AVERAGE PRICE
SELECT
    title,
    price
FROM books
WHERE price > (
    SELECT AVG(price)
    FROM books
);
-- STEP 15 CUSTOMERS WHO SPEND MORE THAN AVERAGE CUSTOMER
SELECT
    c.customer_id,
    c.name,
    SUM(o.quantity * b.price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN books b ON o.book_id = b.book_id
GROUP BY c.customer_id, c.name
HAVING SUM(o.quantity * b.price) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT
            SUM(o2.quantity * b2.price) AS customer_total
        FROM orders o2
        JOIN books b2 ON o2.book_id = b2.book_id
        GROUP BY o2.customer_id
    ) AS avg_spending
);
-- STEP 16 IDENTIFY HOW MANY CUSTOMERS JOINED EACH MONTH
SELECT
    DATE_FORMAT(signup_date, '%Y-%m') AS signup_month,
    COUNT(*) AS new_customers
FROM customers
GROUP BY signup_month
ORDER BY signup_month;
SELECT * FROM BOOKS;
-- STEP 17 TOP SELLING GENRE IN EACH MONTH
WITH genre_monthly AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
        b.genre,
        SUM(o.quantity * b.price) AS revenue
    FROM orders o
    JOIN books b ON o.book_id = b.book_id
    GROUP BY month, b.genre
),
ranked_genres AS (
    SELECT *,
        RANK() OVER (
            PARTITION BY month
            ORDER BY revenue DESC
        ) AS genre_rank
    FROM genre_monthly
)
SELECT *
FROM ranked_genres
WHERE genre_rank = 1;
-- STEP 18 CHURNED CUSTOMERS
SELECT 
    c.customer_id,
    c.name,
    MAX(o.order_date) AS last_purchase,
    DATEDIFF('2025-07-01', MAX(o.order_date)) AS days_since_last_purchase
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id,
    c.name
HAVING 
    DATEDIFF('2025-07-01', MAX(o.order_date)) > 365;
   