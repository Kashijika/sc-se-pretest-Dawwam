--- DDL
CREATE DATABASE sipelajar_db;
USE sipelajar_db;

-- Kategori Buku
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

-- Buku
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(225) NOT NULL,
    publisher VARCHAR(225) NOT NULL,
    isbn VARCHAR(50) UNIQUE NOT NULL,
    published_year INT,
    stock INT NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- User (Peminjaman)
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address TEXT NOT NULL,
    ktp_number VARCHAR(30) UNIQUE NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Peminjaman
CREATE TABLE borrowings (
    borrowings_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE DEFAULT NULL,
    fine INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

--- DML
INSERT INTO categories (category_name) VALUES
('Teknologi'), ('Fiksi'), ('Sejarah'), ('Sains'), ('Ekonomi');

-- User
INSERT INTO users (name, address, ktp_number, phone, email) VALUES
('Andi', 'Jl. Merdeka No. 10', '3201011234560001', '081234567890', 'andi@email.com'),
('Siti', 'Jl. Kebon Jeruk No. 5', '3201011234560002', '081234567891', 'siti@email.com'),
('Budi', 'Jl. Diponegoro No. 12', '3201011234560003', '081234567892', 'budi@email.com'),
('Dewi', 'Jl. Sudirman No. 8', '3201011234560004', '081234567893', 'dewi@email.com'),
('Rizky', 'Jl. Ahmad Yani No. 15', '3201011234560005', '081234567894', 'rizky@email.com');

-- Buku
INSERT INTO books (title, author, publisher, isbn, published_year, stock, category_id) VALUES
('Pemrograman Go Dasar', 'Eko Kurniawan', 'Media Kita', '978-602-000-1', 2022, 5, 1),
('Belajar ReactJS', 'Budi Raharjo', 'Informatika', '978-602-000-2', 2023, 3, 1),
('Laskar Pelangi', 'Andrea Hirata', 'Bentang Pustaka', '978-979-3062-79-2', 2005, 4, 2),
('Sejarah Dunia Yang Disembunyikan', 'Jonathan Black', 'Alvabet', '978-602-822-6', 2015, 2, 3),
('Fisika Kuantum', 'Michio Kaku', 'Gramedia', '978-602-000-5', 2018, 3, 4),
('Prinsip Ekonomi Makro', 'N. Gregory Mankiw', 'Salemba Empat', '978-602-000-6', 2020, 5, 5),
('Algoritma & Struktur Data', 'Rinaldi Munir', 'Informatika', '978-602-000-7', 2019, 4, 1),
('Bumi Manusia', 'Pramoedya Ananta Toer', 'Lentera Dipantara', '978-979-973-1', 1980, 2, 2),
('Pengantar Ilmu Politik', 'Miriam Budiardjo', 'Yayasan Obor', '978-602-000-9', 2016, 3, 3),
('Clean Code', 'Robert C. Martin', 'Prentice Hall', '978-013-235-0', 2008, 1, 1);

-- Peminjaman
-- User 1
INSERT INTO borrowings (user_id, book_id, borrow_date, due_date, return_date, fine) VALUES
(1, 1, '2026-09-01', '2026-09-08', '2026-09-07', 0),
(1, 2, '2026-09-01', '2026-09-08', '2026-09-08', 0),
(1, 3, '2026-09-01', '2026-09-08', '2026-09-05', 0);

-- User 2
INSERT INTO borrowings (user_id, book_id, borrow_date, due_date, return_date, fine) VALUES 
(2, 4, '2026-09-02', '2026-09-09', '2026-09-09', 0),
(2, 5, '2026-09-02', '2026-09-09', '2026-09-08', 0),
(2, 6, '2026-09-02', '2026-09-09', '2026-09-07', 0);

-- User 3, Terlambat
INSERT INTO borrowings (user_id, book_id, borrow_date, due_date, return_date, fine) VALUES 
(3, 7, '2026-09-01', '2026-09-08', '2026-09-08', 0),
(3, 8, '2026-09-01', '2026-09-08', '2026-09-08', 0),
(3, 9, '2026-09-01', '2026-09-08', '2026-09-13', 5000);

--- QUERY
SELECT b.book_id, b.title, b.author
FROM books b
LEFT JOIN borrowings br ON b.book_id = br.book_id
WHERE br.borrowings_id IS NULL;

SELECT u.user_id, u.name, SUM(br.fine) AS total_fine
FROM users u
JOIN borrowings br ON u.user_id = br.user_id
WHERE br.fine > 0
GROUP BY u.user_id, u.name;

SELECT u.users_id, u.name, b.little AS borrowed_book, br.borrow_date, br.return_date, br.fine
FROM users u
JOIN borrowings br ON u.user_id = br.user_id
JOIN books b ON br.book_id = b.book_id
ORDER BY u.user_id;
