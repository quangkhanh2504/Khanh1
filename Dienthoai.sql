-- Bảng Khách Hàng
CREATE TABLE KhachHang (
    MaKhachHang INT PRIMARY KEY NOT NULL,
    TenKhachHang NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    SoDienThoai NVARCHAR(20),
    DiaChi NVARCHAR(255),
    NgaySinh DATE,
    GioiTinh NVARCHAR(10),
    NgayGiaNhap DATETIME DEFAULT GETDATE()
);

-- Bảng Sản Phẩm
CREATE TABLE SanPham (
    MaSanPham INT PRIMARY KEY NOT NULL,
    TenSanPham NVARCHAR(100) NOT NULL,
    ThuongHieu NVARCHAR(50),
    DanhMuc NVARCHAR(50),
    GiaTien DECIMAL(18, 2) NOT NULL,
    TonKho INT NOT NULL,
    MoTa NVARCHAR(255),
    NgayRaMat DATE,
    HinhAnh NVARCHAR(255)
);

-- Bảng Đơn Hàng
CREATE TABLE DonHang (
    MaDonHang INT PRIMARY KEY NOT NULL,
    MaKhachHang INT,
    NgayDatHang DATETIME DEFAULT GETDATE(),
    DiaChiGiao NVARCHAR(255),
    TongTien DECIMAL(18, 2) NOT NULL,
    TrangThai NVARCHAR(50),  -- 'Đang chờ', 'Đã giao', 'Đã hủy'
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang) ON DELETE CASCADE
);

-- Bảng Chi Tiết Đơn Hàng
CREATE TABLE ChiTietDonHang (
    MaChiTietDonHang INT PRIMARY KEY NOT NULL,
    MaDonHang INT,
    MaSanPham INT,
    SoLuong INT NOT NULL,
    Gia DECIMAL(18, 2) NOT NULL,
    ThanhTien DECIMAL(18, 2) NOT NULL,  -- Giá sản phẩm * Số lượng
    FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang) ON DELETE CASCADE,
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham) ON DELETE CASCADE
);

-- Bảng Thanh Toán
CREATE TABLE ThanhToan (
    MaThanhToan INT PRIMARY KEY NOT NULL,
    MaDonHang INT,
    PhuongThucThanhToan NVARCHAR(50),  -- 'Tiền mặt', 'Chuyển khoản', 'Thanh toán qua thẻ'
    SoTienThanhToan DECIMAL(18, 2) NOT NULL,
    NgayThanhToan DATETIME DEFAULT GETDATE(),
    TrangThaiThanhToan NVARCHAR(50),  -- 'Đã thanh toán', 'Chưa thanh toán'
    FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang) ON DELETE CASCADE
);

-- Bảng Nhân Viên
CREATE TABLE NhanVien (
    MaNhanVien INT PRIMARY KEY NOT NULL,
    TenNhanVien NVARCHAR(100) NOT NULL,
    ChucVu NVARCHAR(50),  -- 'Quản lý', 'Nhân viên bán hàng', 'Tài xế', ...
    SoDienThoai NVARCHAR(20),
    Email NVARCHAR(100),
    DiaChi NVARCHAR(255),
    NgayVaoLam DATETIME DEFAULT GETDATE(),
    TrangThaiHoatDong NVARCHAR(50)  -- 'Đang làm việc', 'Nghỉ việc'
);

-- Bảng Kho
CREATE TABLE Kho (
    MaKho INT PRIMARY KEY NOT NULL,
    TenKho NVARCHAR(100) NOT NULL,
    DiaChiKho NVARCHAR(255),
    SoDienThoai NVARCHAR(20),
    MaKhoUnique NVARCHAR(50) NOT NULL UNIQUE
);

-- Bảng Khuyến Mãi
CREATE TABLE KhuyenMai (
    MaKhuyenMai INT PRIMARY KEY NOT NULL,
    TenKhuyenMai NVARCHAR(100),
    MoTa NVARCHAR(255),
    NgayBatDau DATE,
    NgayKetThuc DATE,
    DieuKien NVARCHAR(255),  -- Điều kiện áp dụng khuyến mãi
    GiaTriKhuyenMai DECIMAL(18, 2)  -- % giảm giá hoặc giá trị khuyến mãi
);

-- Bảng Đánh Giá Sản Phẩm
CREATE TABLE DanhGiaSanPham (
    MaDanhGia INT PRIMARY KEY NOT NULL,
    MaSanPham INT,
    MaKhachHang INT,
    DiemDanhGia INT,  -- Điểm đánh giá từ 1-5
    BinhLuan NVARCHAR(255),
    NgayDanhGia DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham) ON DELETE CASCADE,
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang) ON DELETE CASCADE
);

-- Bảng Lịch Sử Thanh Toán
CREATE TABLE LichSuThanhToan (
    MaLichSuThanhToan INT PRIMARY KEY NOT NULL,
    MaThanhToan INT,
    SoTien DECIMAL(18, 2) NOT NULL,
    NgayThanhToan DATETIME DEFAULT GETDATE(),
    PhuongThuc NVARCHAR(50),  -- 'Tiền mặt', 'Chuyển khoản', ...
    TrangThai NVARCHAR(50),  -- 'Đã thanh toán', 'Chưa thanh toán'
    FOREIGN KEY (MaThanhToan) REFERENCES ThanhToan(MaThanhToan) ON DELETE CASCADE
);
