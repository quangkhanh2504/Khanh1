CREATE TABLE Kho (
    KhoID INT PRIMARY KEY NOT NULL,
    TenKho NVARCHAR(100) NOT NULL,
    DiaChiKho NVARCHAR(255) NOT NULL,
    SoDienThoai NVARCHAR(20),
    MaKho NVARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE NhanVienKho (
    NhanVienID INT PRIMARY KEY NOT NULL,
    TenNhanVien NVARCHAR(100) NOT NULL,
    SoDienThoai NVARCHAR(20),
    Email NVARCHAR(100),
    ChucVu NVARCHAR(50),
    KhoID INT,
    TrangThaiHoatDong NVARCHAR(50),
    FOREIGN KEY (KhoID) REFERENCES Kho(KhoID) ON DELETE SET NULL
);

CREATE TABLE CuaHang (
    CuaHangID INT PRIMARY KEY NOT NULL,
    TenCuaHang NVARCHAR(100) NOT NULL,
    DiaChi NVARCHAR(255) NOT NULL,
    SoDienThoai NVARCHAR(20),
    Email NVARCHAR(100),
    NguoiQuanLy NVARCHAR(100)
);

CREATE TABLE DonHang (
    DonHangID INT PRIMARY KEY NOT NULL,
    MaDonHang NVARCHAR(50) NOT NULL UNIQUE,
    CuaHangID INT,
    DiaChiGiao NVARCHAR(255),
    NgayDatHang DATE NOT NULL,
    NgayDuKienGiao DATE NOT NULL,
    TrangThai NVARCHAR(50),
    GhiChu NVARCHAR(255),
    FOREIGN KEY (CuaHangID) REFERENCES CuaHang(CuaHangID) ON DELETE CASCADE
);

CREATE TABLE TaiXe (
    TaiXeID INT PRIMARY KEY NOT NULL,
    TenTaiXe NVARCHAR(100) NOT NULL,
    SoDienThoai NVARCHAR(20),
    KhuVucPhuTrach NVARCHAR(100),
    BangLai NVARCHAR(50),
    TrangThaiHoatDong NVARCHAR(50)
);

CREATE TABLE DonHangDongGoi (
    DonHangDongGoiID INT PRIMARY KEY NOT NULL,
    DonHangID INT,
    KhoID INT,
    NhanVienID INT,
    NgayDongGoi DATETIME,
    TrangThai NVARCHAR(50),
    FOREIGN KEY (DonHangID) REFERENCES DonHang(DonHangID) ON DELETE CASCADE,
    FOREIGN KEY (KhoID) REFERENCES Kho(KhoID) ON DELETE SET NULL,
    FOREIGN KEY (NhanVienID) REFERENCES NhanVienKho(NhanVienID) ON DELETE SET NULL
);

CREATE TABLE VanChuyen (
    VanChuyenID INT PRIMARY KEY NOT NULL,
    DonHangID INT,
    TaiXeID INT,
    NgayGiao DATE,
    ThoiGianGiaoDuKien TIME,
    ThoiGianGiaoThucTe TIME,
    TrangThaiGiaoHang NVARCHAR(50),
    FOREIGN KEY (DonHangID) REFERENCES DonHang(DonHangID) ON DELETE CASCADE,
    FOREIGN KEY (TaiXeID) REFERENCES TaiXe(TaiXeID) ON DELETE SET NULL
);

CREATE TABLE LichSuKho (
    LichSuKhoID INT PRIMARY KEY NOT NULL,
    DonHangDongGoiID INT,
    KhoID INT,
    NhanVienID INT,
    ThoiGianChuyenKho DATETIME,
    TrangThai NVARCHAR(100),
    FOREIGN KEY (DonHangDongGoiID) REFERENCES DonHangDongGoi(DonHangDongGoiID) ON DELETE CASCADE,
    FOREIGN KEY (KhoID) REFERENCES Kho(KhoID) ON DELETE SET NULL,
    FOREIGN KEY (NhanVienID) REFERENCES NhanVienKho(NhanVienID) ON DELETE SET NULL
);

CREATE TABLE LichSuRFID (
    RFIDID INT PRIMARY KEY NOT NULL,
    DonHangID INT,
    NhanVienID INT,
    ThoiGianQuet DATETIME,
    ViTri NVARCHAR(255),
    TrangThai NVARCHAR(50),
    FOREIGN KEY (DonHangID) REFERENCES DonHang(DonHangID) ON DELETE CASCADE,
    FOREIGN KEY (NhanVienID) REFERENCES NhanVienKho(NhanVienID) ON DELETE SET NULL
);

CREATE TABLE LichSuAPI (
    APIID INT PRIMARY KEY NOT NULL,
    DonHangID INT,
    NhanVienID INT,
    LoaiYeuCau NVARCHAR(100),
    ThoiGianYeuCau DATETIME,
    TrangThaiYeuCau NVARCHAR(50),
    PhanHoi NVARCHAR(MAX),
    FOREIGN KEY (DonHangID) REFERENCES DonHang(DonHangID) ON DELETE CASCADE,
    FOREIGN KEY (NhanVienID) REFERENCES NhanVienKho(NhanVienID) ON DELETE SET NULL
);

CREATE TABLE ThongTinMoiTruong (
    MoiTruongID INT PRIMARY KEY NOT NULL,
    VanChuyenID INT,
    NhietDo FLOAT,
    DoAm FLOAT,
    ThoiGianDo DATETIME,
    FOREIGN KEY (VanChuyenID) REFERENCES VanChuyen(VanChuyenID) ON DELETE SET NULL
);

CREATE TABLE DonNhapKho (
    MaDonNhapKho INT PRIMARY KEY NOT NULL,
    KhoID INT,
    NhanVienID INT,
    NgayNhap DATETIME,
    GhiChu NVARCHAR(255),
    TrangThai NVARCHAR(50),
    FOREIGN KEY (KhoID) REFERENCES Kho(KhoID) ON DELETE SET NULL,
    FOREIGN KEY (NhanVienID) REFERENCES NhanVienKho(NhanVienID) ON DELETE SET NULL
);

CREATE TABLE DonXuatKho (
    MaDonXuatKho INT PRIMARY KEY NOT NULL,
    KhoID INT,
    NhanVienID INT,
    NgayXuat DATETIME,
    GhiChu NVARCHAR(255),
    TrangThai NVARCHAR(50),
    FOREIGN KEY (KhoID) REFERENCES Kho(KhoID) ON DELETE SET NULL,
    FOREIGN KEY (NhanVienID) REFERENCES NhanVienKho(NhanVienID) ON DELETE SET NULL
);

CREATE TABLE ThanhToan (
    ThanhToanID INT PRIMARY KEY NOT NULL,
    MaThanhToan NVARCHAR(50) NOT NULL UNIQUE,
    DonHangID INT,
    PhuongThuc NVARCHAR(50),
    SoTien FLOAT,
    NgayThanhToan DATETIME,
    TrangThai NVARCHAR(50),
    GhiChu NVARCHAR(255),
    FOREIGN KEY (DonHangID) REFERENCES DonHang(DonHangID) ON DELETE CASCADE
);

CREATE TABLE PhuongTien (
    PhuongTienID INT PRIMARY KEY NOT NULL,
    BienSo NVARCHAR(20) NOT NULL UNIQUE,
    LoaiPhuongTien NVARCHAR(50),
    TaiTrong FLOAT,
    NamSanXuat INT,
    TinhTrang NVARCHAR(50),
    GhiChu NVARCHAR(255)
);
