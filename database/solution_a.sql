USE laptrinhweb_lab04;

-- Câu a.1: Lấy ra danh sách người dùng theo thứ tự tên từ A đến Z.
SELECT user_id, user_name, user_email
FROM users
ORDER BY user_name ASC;

-- Câu a.2: Lấy ra 07 người dùng theo thứ tự tên từ A đến Z.
SELECT user_id, user_name, user_email
FROM users
ORDER BY user_name ASC
LIMIT 7;

-- Câu a.3: Lấy ra danh sách người dùng có tên chứa chữ a và sắp xếp theo bảng chữ cái.
SELECT user_id, user_name, user_email
FROM users
WHERE LOWER(user_name) LIKE '%a%'
ORDER BY user_name ASC;

-- Câu a.4: Lấy ra danh sách người dùng có tên bắt đầu bằng chữ m.
SELECT user_id, user_name, user_email
FROM users
WHERE LOWER(user_name) LIKE 'm%'
ORDER BY user_name ASC;

-- Câu a.5: Lấy ra danh sách người dùng có tên kết thúc bằng chữ i.
SELECT user_id, user_name, user_email
FROM users
WHERE LOWER(user_name) LIKE '%i'
ORDER BY user_name ASC;

-- Câu a.6: Lấy ra danh sách người dùng có email sử dụng dịch vụ Gmail.
SELECT user_id, user_name, user_email
FROM users
WHERE LOWER(SUBSTRING_INDEX(user_email, '@', -1)) = 'gmail.com'
ORDER BY user_name ASC;

-- Câu a.7: Lấy ra danh sách người dùng dùng Gmail và tên bắt đầu bằng chữ m.
SELECT user_id, user_name, user_email
FROM users
WHERE LOWER(SUBSTRING_INDEX(user_email, '@', -1)) = 'gmail.com'
  AND LOWER(user_name) LIKE 'm%'
ORDER BY user_name ASC;

-- Câu a.8: Lấy ra danh sách người dùng dùng Gmail, tên có chữ i và độ dài tên lớn hơn 5.
SELECT user_id, user_name, user_email
FROM users
WHERE LOWER(SUBSTRING_INDEX(user_email, '@', -1)) = 'gmail.com'
  AND LOWER(user_name) LIKE '%i%'
  AND CHAR_LENGTH(user_name) > 5
ORDER BY user_name ASC;

-- Câu a.9: Lấy ra danh sách người dùng có chữ a, độ dài tên từ 5 đến 9, dùng Gmail và phần tên email có chữ i.
SELECT user_id, user_name, user_email
FROM users
WHERE LOWER(user_name) LIKE '%a%'
  AND CHAR_LENGTH(user_name) BETWEEN 5 AND 9
  AND LOWER(SUBSTRING_INDEX(user_email, '@', -1)) = 'gmail.com'
  AND LOWER(SUBSTRING_INDEX(user_email, '@', 1)) LIKE '%i%'
ORDER BY user_name ASC;

-- Câu a.10: Lấy ra danh sách người dùng thỏa một trong ba điều kiện lọc theo tên hoặc email.
SELECT user_id, user_name, user_email
FROM users
WHERE (LOWER(user_name) LIKE '%a%' AND CHAR_LENGTH(user_name) BETWEEN 5 AND 9)
   OR (LOWER(user_name) LIKE '%i%' AND CHAR_LENGTH(user_name) < 9)
   OR (LOWER(SUBSTRING_INDEX(user_email, '@', -1)) = 'gmail.com'
       AND LOWER(SUBSTRING_INDEX(user_email, '@', 1)) LIKE '%i%')
ORDER BY user_name ASC;
