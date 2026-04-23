/*
Kịch bản rủi ro (ít nhất 3)
Người dùng nhập số tiền âm khi nạp/rút → làm sai số dư
Một khách hàng tạo nhiều ví → vi phạm quy định 1 ví/người
Giao dịch có số tiền = 0 hoặc NULL → dữ liệu vô nghĩa
Giao dịch không có trạng thái hợp lệ (VD: “abc”)
Ví có thể bị cập nhật thành số dư âm
*/ 
CREATE DATABASE IF NOT EXISTS shopeepay_mini;
USE shopeepay_mini;

CREATE TABLE USERS (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100) NOT NULL
);

CREATE TABLE WALLETS (
    WalletID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT NOT NULL UNIQUE,
    Balance DECIMAL(12,2) NOT NULL DEFAULT 0 CHECK (Balance >= 0),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES USERS(UserID)
);

CREATE TABLE TRANSACTIONS (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    WalletID INT NOT NULL,
    Type ENUM('DEPOSIT','WITHDRAW','PAYMENT') NOT NULL,
    Amount DECIMAL(12,2) NOT NULL CHECK (Amount > 0),
    Status ENUM('PENDING','SUCCESS','FAILED') DEFAULT 'PENDING',
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (WalletID) REFERENCES WALLETS(WalletID)
);