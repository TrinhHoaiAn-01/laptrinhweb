USE laptrinhweb_lab04;

-- Câu b.1: Liệt kê các hóa đơn của khách hàng gồm mã user, tên user và mã hóa đơn.
SELECT u.user_id, u.user_name, o.order_id
FROM users AS u
JOIN orders AS o ON o.user_id = u.user_id
ORDER BY u.user_id ASC, o.order_id ASC;

-- Câu b.2: Liệt kê số lượng hóa đơn của từng khách hàng.
SELECT u.user_id, u.user_name, COUNT(o.order_id) AS total_orders
FROM users AS u
LEFT JOIN orders AS o ON o.user_id = u.user_id
GROUP BY u.user_id, u.user_name
ORDER BY total_orders DESC, u.user_id ASC;

-- Câu b.3: Liệt kê thông tin hóa đơn gồm mã đơn hàng và số sản phẩm trong đơn.
SELECT o.order_id, COUNT(od.order_detail_id) AS total_products
FROM orders AS o
JOIN order_details AS od ON od.order_id = o.order_id
GROUP BY o.order_id
ORDER BY o.order_id ASC;

-- Câu b.4: Liệt kê thông tin mua hàng theo từng đơn hàng để tránh hiển thị xen kẽ.
SELECT u.user_id, u.user_name, o.order_id, p.product_name
FROM users AS u
JOIN orders AS o ON o.user_id = u.user_id
JOIN order_details AS od ON od.order_id = o.order_id
JOIN products AS p ON p.product_id = od.product_id
ORDER BY u.user_id ASC, o.order_id ASC, p.product_name ASC;

-- Câu b.5: Liệt kê 7 người dùng có số lượng đơn hàng nhiều nhất.
SELECT u.user_id, u.user_name, COUNT(o.order_id) AS total_orders
FROM users AS u
JOIN orders AS o ON o.user_id = u.user_id
GROUP BY u.user_id, u.user_name
ORDER BY total_orders DESC, u.user_id ASC
LIMIT 7;

-- Câu b.6: Liệt kê 7 dòng dữ liệu mua hàng có tên sản phẩm chứa Samsung hoặc Apple.
SELECT DISTINCT u.user_id, u.user_name, o.order_id, p.product_name
FROM users AS u
JOIN orders AS o ON o.user_id = u.user_id
JOIN order_details AS od ON od.order_id = o.order_id
JOIN products AS p ON p.product_id = od.product_id
WHERE LOWER(p.product_name) LIKE '%samsung%'
   OR LOWER(p.product_name) LIKE '%apple%'
ORDER BY u.user_id ASC, o.order_id ASC, p.product_name ASC
LIMIT 7;

-- Câu b.7: Liệt kê danh sách mua hàng của user và tổng tiền của mỗi đơn hàng.
SELECT u.user_id, u.user_name, o.order_id, SUM(p.product_price) AS total_amount
FROM users AS u
JOIN orders AS o ON o.user_id = u.user_id
JOIN order_details AS od ON od.order_id = o.order_id
JOIN products AS p ON p.product_id = od.product_id
GROUP BY u.user_id, u.user_name, o.order_id
ORDER BY u.user_id ASC, o.order_id ASC;

-- Câu b.8: Chọn ra 1 đơn hàng có tổng tiền lớn nhất của mỗi user.
SELECT s.user_id, s.user_name, s.order_id, s.total_amount
FROM (
    SELECT u.user_id, u.user_name, o.order_id, SUM(p.product_price) AS total_amount
    FROM users AS u
    JOIN orders AS o ON o.user_id = u.user_id
    JOIN order_details AS od ON od.order_id = o.order_id
    JOIN products AS p ON p.product_id = od.product_id
    GROUP BY u.user_id, u.user_name, o.order_id
) AS s
WHERE s.order_id = (
    SELECT s2.order_id
    FROM (
        SELECT o.user_id, o.order_id, SUM(p.product_price) AS total_amount
        FROM orders AS o
        JOIN order_details AS od ON od.order_id = o.order_id
        JOIN products AS p ON p.product_id = od.product_id
        GROUP BY o.user_id, o.order_id
    ) AS s2
    WHERE s2.user_id = s.user_id
    ORDER BY s2.total_amount DESC, s2.order_id ASC
    LIMIT 1
)
ORDER BY s.user_id ASC;

-- Câu b.9: Chọn ra 1 đơn hàng có tổng tiền nhỏ nhất của mỗi user và hiển thị thêm số sản phẩm.
SELECT s.user_id, s.user_name, s.order_id, s.total_amount, s.total_products
FROM (
    SELECT
        u.user_id,
        u.user_name,
        o.order_id,
        SUM(p.product_price) AS total_amount,
        COUNT(od.order_detail_id) AS total_products
    FROM users AS u
    JOIN orders AS o ON o.user_id = u.user_id
    JOIN order_details AS od ON od.order_id = o.order_id
    JOIN products AS p ON p.product_id = od.product_id
    GROUP BY u.user_id, u.user_name, o.order_id
) AS s
WHERE s.order_id = (
    SELECT s2.order_id
    FROM (
        SELECT
            o.user_id,
            o.order_id,
            SUM(p.product_price) AS total_amount,
            COUNT(od.order_detail_id) AS total_products
        FROM orders AS o
        JOIN order_details AS od ON od.order_id = o.order_id
        JOIN products AS p ON p.product_id = od.product_id
        GROUP BY o.user_id, o.order_id
    ) AS s2
    WHERE s2.user_id = s.user_id
    ORDER BY s2.total_amount ASC, s2.order_id ASC
    LIMIT 1
)
ORDER BY s.user_id ASC;

-- Câu b.10: Chọn ra 1 đơn hàng có số sản phẩm nhiều nhất của mỗi user và hiển thị thêm tổng tiền.
SELECT s.user_id, s.user_name, s.order_id, s.total_amount, s.total_products
FROM (
    SELECT
        u.user_id,
        u.user_name,
        o.order_id,
        SUM(p.product_price) AS total_amount,
        COUNT(od.order_detail_id) AS total_products
    FROM users AS u
    JOIN orders AS o ON o.user_id = u.user_id
    JOIN order_details AS od ON od.order_id = o.order_id
    JOIN products AS p ON p.product_id = od.product_id
    GROUP BY u.user_id, u.user_name, o.order_id
) AS s
WHERE s.order_id = (
    SELECT s2.order_id
    FROM (
        SELECT
            o.user_id,
            o.order_id,
            SUM(p.product_price) AS total_amount,
            COUNT(od.order_detail_id) AS total_products
        FROM orders AS o
        JOIN order_details AS od ON od.order_id = o.order_id
        JOIN products AS p ON p.product_id = od.product_id
        GROUP BY o.user_id, o.order_id
    ) AS s2
    WHERE s2.user_id = s.user_id
    ORDER BY s2.total_products DESC, s2.total_amount DESC, s2.order_id ASC
    LIMIT 1
)
ORDER BY s.user_id ASC;
