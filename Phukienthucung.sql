CREATE DATABASE Phukienthucung;
GO

USE Phukienthucung;
GO
CREATE TABLE QUAN_TRI (
    Tai_khoan NVARCHAR(50) NOT NULL PRIMARY KEY,  -- Tài khoản đăng nhập của quản trị
    Mat_khau NVARCHAR(32) NOT NULL,              -- Mật khẩu đăng nhập của quản trị
    Trang_thai TINYINT                          -- Trạng thái: 1-Đang hoạt động, 0-Đang bị khóa
);
CREATE TABLE KHACH_HANG (
    MaKH INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Mã khách hàng (Auto_increment)
    Ho_ten NVARCHAR(100) NULL,                    -- Tên khách hàng
    Tai_khoan NVARCHAR(50) NOT NULL UNIQUE,       -- Tài khoản đăng nhập
    Mat_khau NVARCHAR(32) NULL,                   -- Mật khẩu
    Dia_chi NVARCHAR(200) NULL,                   -- Địa chỉ
    Dien_thoai NVARCHAR(30) NULL,                 -- Điện thoại
    Email NVARCHAR(50) NOT NULL,                  -- Hộp thư điện tử
    Ngay_sinh DATETIME NULL,                     -- Ngày sinh
    Ngay_cap_nhat DATETIME NULL DEFAULT GETDATE(), -- Ngày cập nhật vào hệ thống
    Gioi_tinh TINYINT NULL,                      -- Giới tính
    Tich_diem INT NOT NULL DEFAULT 0,            -- Tích điểm mua hàng
    Trang_thai TINYINT NULL                      -- Trạng thái: 1-Đang hoạt động, 0-Đang bị khóa
);
CREATE TABLE SAN_PHAM (
    MaSP INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Mã sản phẩm (Auto_increment)
	MaKH INT REFERENCES KHACH_HANG,

    TenSP NVARCHAR(100) NOT NULL,                 -- Tên sản phẩm
    MoTa TEXT NULL,                              -- Mô tả sản phẩm
    Gia DECIMAL(10,2) NOT NULL,                  -- Giá sản phẩm
    Hinh_anh NVARCHAR(200) NULL,                  -- Đường dẫn hình ảnh sản phẩm
    Trang_thai TINYINT NULL                      -- Trạng thái: 1-Đang bán, 0-Ngừng bán
);
-- Bảng LOAI_PHU_KIEN để quản lý các loại phụ kiện thú cưng
CREATE TABLE LOAI_PHU_KIEN (
    MaLoai INT NOT NULL PRIMARY KEY IDENTITY(1,1),   -- Mã loại phụ kiện (Auto_increment)
    TenLoai NVARCHAR(100) NOT NULL,                  -- Tên loại phụ kiện (ví dụ: đồ chơi, vòng cổ)
    MoTa NVARCHAR(255) NULL                          -- Mô tả loại phụ kiện
);

-- Bảng DON_HANG để lưu thông tin các đơn hàng của khách hàng
CREATE TABLE DON_HANG (
    MaDH INT NOT NULL PRIMARY KEY IDENTITY(1,1),     -- Mã đơn hàng (Auto_increment)
    MaKH INT NOT NULL,                               -- Mã khách hàng
    Ngay_dat DATETIME NOT NULL DEFAULT GETDATE(),    -- Ngày đặt hàng
    Tong_tien DECIMAL(10,2) NOT NULL,                -- Tổng tiền đơn hàng
    Trang_thai TINYINT NOT NULL DEFAULT 0,           -- Trạng thái đơn hàng: 0-Chưa giao, 1-Đã giao, 2-Đã hủy
    FOREIGN KEY (MaKH) REFERENCES KHACH_HANG(MaKH)   -- Khóa ngoại tham chiếu đến bảng KHACH_HANG
);

-- Bảng CHI_TIET_DON_HANG để lưu chi tiết các sản phẩm trong đơn hàng
CREATE TABLE CHI_TIET_DON_HANG (
    MaDH INT NOT NULL,                               -- Mã đơn hàng
    MaSP INT NOT NULL,                               -- Mã sản phẩm
    So_luong INT NOT NULL,                           -- Số lượng sản phẩm
    Gia DECIMAL(10,2) NOT NULL,                      -- Giá tại thời điểm đặt
    PRIMARY KEY (MaDH, MaSP),                        -- Khóa chính bao gồm MaDH và MaSP
    FOREIGN KEY (MaDH) REFERENCES DON_HANG(MaDH),    -- Khóa ngoại tham chiếu đến bảng DON_HANG
    FOREIGN KEY (MaSP) REFERENCES SAN_PHAM(MaSP)     -- Khóa ngoại tham chiếu đến bảng SAN_PHAM
);

INSERT INTO QUAN_TRI (Tai_khoan, Mat_khau, Trang_thai) 
VALUES 
('NguyenBaTruong', '123456', 1),
('admin2', 'abcdef', 1),
('admin3', 'password', 0),
('admin4', 'qwerty', 1),
('admin5', '123abc', 0);
INSERT INTO KHACH_HANG (Ho_ten, Tai_khoan, Mat_khau, Dia_chi, Dien_thoai, Email, Ngay_sinh, Ngay_cap_nhat, Gioi_tinh, Tich_diem, Trang_thai)
VALUES 
(N'Nguyen Ba Truong', 'NBT', '123456', N'123 Đường ABC', '0901234567', 'chanhchua1301@gmail.com', '2004-01-13', GETDATE(), 1, 100, 1),
(N'Tran Thi B', 'user2', 'abcdef', N'456 Đường XYZ', '0902345678', 'user2@example.com', '1992-02-02', GETDATE(), 0, 200, 1),
(N'Le Van C', 'user3', 'password', N'789 Đường LMN', '0903456789', 'user3@example.com', '1985-03-03', GETDATE(), 1, 150, 0),
(N'Pham Thi D', 'user4', 'qwerty', N'987 Đường QRS', '0904567890', 'user4@example.com', '1995-04-04', GETDATE(), 0, 50, 1),
(N'Hoang Van E', 'user5', '123abc', N'654 Đường UVW', '0905678901', 'user5@example.com', '1988-05-05', GETDATE(), 1, 300, 0);
INSERT INTO SAN_PHAM (TenSP, MoTa, Gia, Hinh_anh, Trang_thai)
VALUES 
(N'Vòng cổ mèo', 'dài 3m',  200.000, 'vong-co-bong-tron-trai-cay7450_560x560.png', 1),
(N'Đồ chơi đĩa bay', N'đựng được thức ăn', 920.000, 'do-choi-dia-bay-banh-thuong-cho-cho-meo-paw-pet-frisbee-leakage-toy-400x400.webp', 1),
(N'Dây dắt cún', 'dài 5m', 150.000, 'day-dat-teddy-s-1-3kg-m-3-5kg-l-5-7kg-xl7-10kg8344_560x560.png', 0);
-- Thêm các loại phụ kiện vào bảng LOAI_PHU_KIEN
INSERT INTO LOAI_PHU_KIEN (TenLoai, MoTa)
VALUES 
    (N'Đồ chơi', N'Đồ chơi dành cho thú cưng, giúp giải trí và vận động'),
    (N'Vòng cổ', N'Vòng cổ và dây dắt cho chó, mèo'),
    (N'Đồ ăn', N'Thức ăn cho chó, mèo và các loại thú cưng khác'),
    (N'Chuồng', N'Chuồng và lồng cho thú cưng'),
    (N'Phụ kiện vệ sinh', N'Dụng cụ vệ sinh cho thú cưng, như tã, khay vệ sinh');
-- Giả sử đã có khách hàng với MaKH = 1 và các sản phẩm với MaSP = 1 và MaSP = 2

-- Thêm một đơn hàng mới vào bảng DON_HANG
INSERT INTO DON_HANG (MaKH, Tong_tien, Trang_thai)
VALUES 
    (1, 500000, 0);  -- Đơn hàng chưa giao

-- Giả sử MaDH của đơn hàng mới vừa tạo là 1 (tự động tạo do Auto_increment)

-- Thêm chi tiết cho đơn hàng vào bảng CHI_TIET_DON_HANG
INSERT INTO CHI_TIET_DON_HANG (MaDH, MaSP, So_luong, Gia)
VALUES 
    (1, 1, 2, 250000),  -- 2 sản phẩm với MaSP = 1, giá 250,000 mỗi cái
    (1, 2, 1, 50000);    -- 1 sản phẩm với MaSP = 2, giá 50,000

Select*from SAN_PHAM
Select*from KHACH_HANG
Select*from QUAN_TRI
drop table  SAN_PHAM
drop table  KHACH_HANG
drop table  QUAN_TRI
drop database ThucPhamThuCung
