/*Edge Case 1: Khách hàng nhập số lượng âm (ví dụ: -5)
Đây là lỗi nghiệp vụ nghiêm trọng vì không thể có giỏ hàng chứa số lượng âm. Hệ thống cần chặn điều này ở hai tầng. Tầng đầu tiên là tầng cơ sở dữ liệu, dùng ràng buộc CHECK (Quantity > 0) ngay khi tạo bảng để database tự động từ chối mọi giá trị không hợp lệ. Tầng thứ hai là tầng ứng dụng, trước khi gửi lệnh SQL, code phía backend phải kiểm tra giá trị đầu vào và trả về thông báo lỗi rõ ràng cho người dùng thay vì để lỗi từ database nổi lên.
Edge Case 2: Khách hàng bấm "Add to cart" nhưng mặt hàng đã có trong giỏ
Có hai lựa chọn thiết kế. Cách thứ nhất là Insert dòng mới — đơn giản nhưng gây ra dữ liệu trùng lặp, giỏ hàng sẽ hiển thị cùng một sản phẩm hai lần, gây nhầm lẫn cho người dùng. Cách thứ hai là Update số lượng — cộng dồn số lượng vào bản ghi hiện có, đây là hành vi đúng với nghiệp vụ thực tế. Quyết định chốt là dùng lệnh INSERT ... ON DUPLICATE KEY UPDATE để hệ thống tự động xử lý cả hai tình huống trong một câu lệnh duy nhất, yêu cầu có ràng buộc UNIQUE (UserID, ProductID) trên bảng.
*/
create database SHOPS;

USE SHOPS;

CREATE TABLE CART_ITEMS (
    CartItemID  INT PRIMARY KEY AUTO_INCREMENT,
    UserID      INT,
    ProductID   INT,
    Quantity    INT CHECK (Quantity > 0),    
    AddedDate   DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_user_product (UserID, ProductID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO CART_ITEMS (UserID, ProductID, Quantity)
VALUES (101, 5, 1)
ON DUPLICATE KEY UPDATE
    Quantity = Quantity + VALUES(Quantity);

SELECT
    CartItemID,
    ProductID,
    Quantity,
    AddedDate
FROM CART_ITEMS
WHERE UserID = 101
ORDER BY AddedDate DESC;


UPDATE CART_ITEMS
SET Quantity = 5
WHERE UserID   = 101
  AND ProductID = 5;


DELETE FROM CART_ITEMS
WHERE UserID    = 101
  AND ProductID = 5;