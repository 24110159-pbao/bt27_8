CREATE DATABASE ShoppingServiceMVC CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; 
USE ShoppingServiceMVC; 

-- 1. Tạo bảng Category
CREATE TABLE Category (
    cate_id INT AUTO_INCREMENT PRIMARY KEY,
    cate_name VARCHAR(255) NOT NULL,
    icons VARCHAR(255)
); 

-- Chèn dữ liệu danh mục (Tự động sinh mã 1, 2, 3)
INSERT INTO Category(cate_name, icons) VALUES 
('Quần Áo Nam', 'category/ao-nam.jpg'), 
('Quần Áo Nữ', 'category/ao-nu.jpg'), 
('Giày Dép', 'category/giay.jpg'),
('Điện thoại & Máy tính', 'category/dien-thoai.jpg'); -- Thêm danh mục thứ 4 để không bị lỗi khóa ngoại ở bảng video

-- 2. Tạo bảng users
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    username VARCHAR(100) NOT NULL UNIQUE,
    fullname VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    avatar VARCHAR(255),
    roleid INT NOT NULL DEFAULT 2,
    phone VARCHAR(20),
    createddate DATE NOT NULL
); 

INSERT INTO users (email, username, fullname, password, avatar, roleid, phone, createddate) VALUES 
('admin@gmail.com', 'admin', 'Administrator', '123456', NULL, 1, '0900000001', CURDATE()), 
('user@gmail.com', 'user', 'Nguyen Van User', '123456', NULL, 2, '0900000002', CURDATE()); 

-- 3. Tạo bảng videos (Đã sửa lỗi liên kết khóa ngoại)
CREATE TABLE videos (
    videoId VARCHAR(50) PRIMARY KEY,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    description TEXT,
    poster VARCHAR(500),
    title VARCHAR(255),
    views INT NOT NULL DEFAULT 0,
    categoryId INT,
    CONSTRAINT fk_videos_categories FOREIGN KEY (categoryId) REFERENCES Category(cate_id) -- Sửa thành Category(cate_id)
); 

-- Chèn dữ liệu video (Mã categoryId từ 1 đến 4 hợp lệ vì bảng Category đã có 4 danh mục)
INSERT INTO videos (videoId, active, description, poster, title, views, categoryId) VALUES 
('v01', TRUE, 'Video Iphone', 'iphone.jpg', 'Iphone 17 Pro Max', 100, 1), 
('v02', TRUE, 'Video Samsung', 'samsung.jpg', 'Samsung Galaxy S26', 200, 2), 
('v03', TRUE, 'Video Oppo', 'oppo.jpg', 'Oppo Find X', 150, 3), 
('v04', TRUE, 'Video Xiaomi', 'xiaomi.jpg', 'Xiaomi 16', 300, 4);
