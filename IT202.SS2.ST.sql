CREATE TABLE products (
    MaSanPham   VARCHAR(10)    PRIMARY KEY,
    TenSanPham  VARCHAR(100)   NOT NULL,
    Size        VARCHAR(10),           
    Gia         DECIMAL(10, 0) CHECK (Gia > 0) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO products (MaSanPham, TenSanPham, Size, Gia) VALUES
('P01', 'Áo sơ mi trắng',  'L',    250000),
('P02', 'Quần Jean xanh',  'M',    450000),
('P03', 'Áo thun Basic',   'XL',   150000);

UPDATE products
SET Gia = 400000
WHERE MaSanPham = 'P02';

UPDATE products
SET Gia = Gia * 1.10;

DELETE FROM products
WHERE MaSanPham = 'P03';


SELECT * FROM products;

SELECT TenSanPham, Size
FROM products;

SELECT *
FROM products
WHERE Gia > 300000;