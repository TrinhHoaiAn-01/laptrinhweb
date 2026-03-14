SET NAMES utf8mb4;

CREATE DATABASE IF NOT EXISTS laptrinhweb_lab04
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE laptrinhweb_lab04;

DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INT(11) NOT NULL AUTO_INCREMENT,
    user_name VARCHAR(25) NOT NULL,
    user_email VARCHAR(55) NOT NULL,
    user_pass VARCHAR(255) NOT NULL,
    updated_at DATETIME NULL,
    created_at DATETIME NULL,
    PRIMARY KEY (user_id)
);

CREATE TABLE products (
    product_id INT(11) NOT NULL AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    product_price DOUBLE NOT NULL,
    product_description TEXT NOT NULL,
    updated_at DATETIME NULL,
    created_at DATETIME NULL,
    PRIMARY KEY (product_id)
);

CREATE TABLE orders (
    order_id INT(11) NOT NULL AUTO_INCREMENT,
    user_id INT(11) NOT NULL,
    updated_at DATETIME NULL,
    created_at DATETIME NULL,
    PRIMARY KEY (order_id),
    CONSTRAINT fk_orders_users
        FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE order_details (
    order_detail_id INT(11) NOT NULL AUTO_INCREMENT,
    order_id INT(11) NOT NULL,
    product_id INT(11) NOT NULL,
    updated_at DATETIME NULL,
    created_at DATETIME NULL,
    PRIMARY KEY (order_detail_id),
    CONSTRAINT fk_order_details_orders
        FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT fk_order_details_products
        FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO users (user_name, user_email, user_pass, updated_at, created_at) VALUES
('maria', 'maria.itech@gmail.com', '123456', '2026-03-14 19:05:12', '2026-03-14 19:05:12'),
('minhtri', 'minhtri.store@gmail.com', '123456', '2026-03-14 19:06:05', '2026-03-14 19:06:05'),
('anhai', 'anhai@gmail.com', '123456', '2026-03-14 19:06:42', '2026-03-14 19:06:42'),
('linh', 'linh@yahoo.com', '123456', '2026-03-14 19:07:18', '2026-03-14 19:07:18'),
('quangan', 'quangan.work@gmail.com', '123456', '2026-03-14 19:07:49', '2026-03-14 19:07:49'),
('maihoa', 'maihoa.design@gmail.com', '123456', '2026-03-14 19:08:21', '2026-03-14 19:08:21'),
('trami', 'trami.vip@gmail.com', '123456', '2026-03-14 19:08:54', '2026-03-14 19:08:54'),
('kiet', 'kiet@yahoo.com', '123456', '2026-03-14 19:09:17', '2026-03-14 19:09:17'),
('namson', 'namson.i@gmail.com', '123456', '2026-03-14 19:09:43', '2026-03-14 19:09:43'),
('minhai', 'minh.ai@gmail.com', '123456', '2026-03-14 19:10:06', '2026-03-14 19:10:06'),
('phuoc', 'phuoc@yahoo.com', '123456', '2026-03-14 19:10:28', '2026-03-14 19:10:28'),
('hagiang', 'hagiang@gmail.com', '123456', '2026-03-14 19:10:57', '2026-03-14 19:10:57');

INSERT INTO products (product_name, product_price, product_description, updated_at, created_at) VALUES
('Samsung Galaxy S24', 21990000, 'Dien thoai Samsung cao cap', '2026-03-14 19:12:01', '2026-03-14 19:12:01'),
('Apple iPhone 15', 19990000, 'Dien thoai Apple the he moi', '2026-03-14 19:12:18', '2026-03-14 19:12:18'),
('Samsung Smart TV 55 inch', 13490000, 'Tivi thong minh Samsung', '2026-03-14 19:12:33', '2026-03-14 19:12:33'),
('Apple Watch Series 9', 9990000, 'Dong ho thong minh Apple', '2026-03-14 19:12:48', '2026-03-14 19:12:48'),
('Sony WH-1000XM5', 7990000, 'Tai nghe chong on Sony', '2026-03-14 19:13:04', '2026-03-14 19:13:04'),
('Xiaomi Pad 6', 8990000, 'May tinh bang Xiaomi', '2026-03-14 19:13:21', '2026-03-14 19:13:21'),
('Dell Inspiron 15', 15990000, 'Laptop Dell van phong', '2026-03-14 19:13:38', '2026-03-14 19:13:38'),
('Logitech MX Master 3S', 2490000, 'Chuot khong day Logitech', '2026-03-14 19:13:56', '2026-03-14 19:13:56'),
('Samsung Galaxy Buds FE', 1990000, 'Tai nghe Samsung true wireless', '2026-03-14 19:14:11', '2026-03-14 19:14:11'),
('Apple AirPods Pro', 6490000, 'Tai nghe Apple khong day', '2026-03-14 19:14:28', '2026-03-14 19:14:28');

INSERT INTO orders (user_id, updated_at, created_at) VALUES
(1, '2026-03-14 19:15:05', '2026-03-14 19:15:05'),
(2, '2026-03-14 19:15:37', '2026-03-14 19:15:37'),
(2, '2026-03-14 19:16:02', '2026-03-14 19:16:02'),
(3, '2026-03-14 19:16:28', '2026-03-14 19:16:28'),
(4, '2026-03-14 19:16:55', '2026-03-14 19:16:55'),
(5, '2026-03-14 19:17:21', '2026-03-14 19:17:21'),
(6, '2026-03-14 19:17:49', '2026-03-14 19:17:49'),
(7, '2026-03-14 19:18:13', '2026-03-14 19:18:13'),
(7, '2026-03-14 19:18:38', '2026-03-14 19:18:38'),
(8, '2026-03-14 19:19:01', '2026-03-14 19:19:01'),
(9, '2026-03-14 19:19:24', '2026-03-14 19:19:24'),
(10, '2026-03-14 19:19:52', '2026-03-14 19:19:52'),
(12, '2026-03-14 19:20:14', '2026-03-14 19:20:14'),
(6, '2026-03-14 19:20:37', '2026-03-14 19:20:37');

INSERT INTO order_details (order_id, product_id, updated_at, created_at) VALUES
(1, 1, '2026-03-14 19:21:05', '2026-03-14 19:21:05'),
(1, 8, '2026-03-14 19:21:05', '2026-03-14 19:21:05'),
(2, 2, '2026-03-14 19:21:32', '2026-03-14 19:21:32'),
(2, 10, '2026-03-14 19:21:32', '2026-03-14 19:21:32'),
(2, 8, '2026-03-14 19:21:32', '2026-03-14 19:21:32'),
(3, 1, '2026-03-14 19:21:59', '2026-03-14 19:21:59'),
(3, 3, '2026-03-14 19:21:59', '2026-03-14 19:21:59'),
(4, 5, '2026-03-14 19:22:24', '2026-03-14 19:22:24'),
(4, 6, '2026-03-14 19:22:24', '2026-03-14 19:22:24'),
(5, 7, '2026-03-14 19:22:47', '2026-03-14 19:22:47'),
(6, 3, '2026-03-14 19:23:12', '2026-03-14 19:23:12'),
(6, 9, '2026-03-14 19:23:12', '2026-03-14 19:23:12'),
(6, 8, '2026-03-14 19:23:12', '2026-03-14 19:23:12'),
(7, 2, '2026-03-14 19:23:41', '2026-03-14 19:23:41'),
(7, 4, '2026-03-14 19:23:41', '2026-03-14 19:23:41'),
(7, 10, '2026-03-14 19:23:41', '2026-03-14 19:23:41'),
(8, 1, '2026-03-14 19:24:07', '2026-03-14 19:24:07'),
(9, 9, '2026-03-14 19:24:36', '2026-03-14 19:24:36'),
(9, 8, '2026-03-14 19:24:36', '2026-03-14 19:24:36'),
(9, 5, '2026-03-14 19:24:36', '2026-03-14 19:24:36'),
(9, 6, '2026-03-14 19:24:36', '2026-03-14 19:24:36'),
(10, 6, '2026-03-14 19:25:01', '2026-03-14 19:25:01'),
(10, 8, '2026-03-14 19:25:01', '2026-03-14 19:25:01'),
(11, 2, '2026-03-14 19:25:29', '2026-03-14 19:25:29'),
(11, 1, '2026-03-14 19:25:29', '2026-03-14 19:25:29'),
(11, 10, '2026-03-14 19:25:29', '2026-03-14 19:25:29'),
(12, 4, '2026-03-14 19:25:53', '2026-03-14 19:25:53'),
(13, 3, '2026-03-14 19:26:14', '2026-03-14 19:26:14'),
(13, 5, '2026-03-14 19:26:14', '2026-03-14 19:26:14'),
(14, 9, '2026-03-14 19:26:39', '2026-03-14 19:26:39'),
(14, 8, '2026-03-14 19:26:39', '2026-03-14 19:26:39');
