CREATE DATABASE QuanLyVeXemPhim;

CREATE TABLE LoaiGhe (
	MaLoaiGhe INT PRIMARY KEY,
	TenLoaiGhe NVARCHAR(20), 
	GiaVe int
);

CREATE TABLE Ghe (
	MaGhe INT PRIMARY KEY,
	TrangThai NVARCHAR(20) CHECK(TrangThai IN(N'Còn trống',N'Đã đặt')) DEFAULT (N'Còn trống'),
	MaLoaiGhe INT REFERENCES LoaiGhe(MaLoaiGhe)
);

CREATE TABLE CaChieu (
	MaCaChieu INT PRIMARY KEY,
	ThoiGianChieu DATETIME DEFAULT(GETDATE())
);
CREATE TABLE PhongChieu (
	MaPhongChieu INT PRIMARY KEY,
	TenPhongChieu NVARCHAR(20),
	SoLuongGheMotDay INT,
	SoLuongDay INT,
	TongSoGhe INT

);
CREATE TABLE Phim (
	MaPhim INT PRIMARY KEY,
	TenPhim NVARCHAR(50),
	ThoiGian DATETIME DEFAULT(GETDATE()),
	HangSanXuat NVARCHAR(50),
	TheLoai NVARCHAR(50),
	MoTa NTEXT,
	GhiChu NVARCHAR(50),

);
CREATE TABLE LichChieu(
	MaLichChieu INT PRIMARY KEY,
	NgayChieu DATETIME DEFAULT(GETDATE()),
	MaCaChieu INT REFERENCES CaChieu(MaCaChieu),
	MaPhongChieu INT REFERENCES PhongChieu(MaPhongChieu),
	MaPhim INT REFERENCES Phim(MaPhim)
);
CREATE TABLE NhanVien (
	MaNhanVien INT PRIMARY KEY,
	TenNhanVien NVARCHAR(50),
	NgaySinh DATETIME DEFAULT(GETDATE()),
	GioiTinh NVARCHAR(3) CHECK (GioiTinh IN(N'Nam', N'Nữ')) DEFAULT(N'Nữ'),
	DiaChi NVARCHAR(50),
	SoDienThoai NVARCHAR(15)
);

CREATE TABLE Ve (
	MaVe INT PRIMARY KEY,
	NgayBan DATETIME DEFAULT(GETDATE()),
	MaGhe INT REFERENCES Ghe(MaGhe),
	MaLichChieu INT REFERENCES LichChieu(MaLichChieu),
	MaNhanVien INT REFERENCES NhanVien(MaNhanVien)
);
GO
-------------------PROCEDURE-------------------
---------------INSERT----------------------
-- 1 LoaiGhe
CREATE PROCEDURE SP_LoaiGhe_Insert
	@MaLoaiGhe int,
	@TenLoaiGhe nvarchar(50),
	@GiaVe int
AS
BEGIN
	
END
GO
-- 2 Ghe

-- 3 NhanVien
-- 4 Ve
-- 5 CaChieu
-- 6 PhongChieu
-- 7 LichChieu
-- 8 Phim


---------------UPDATE----------------------
-- 1 LoaiGhe

-- 2 Ghe
-- 3 NhanVien
-- 4 Ve
-- 5 CaChieu
-- 6 PhongChieu
-- 7 LichChieu
-- 8 Phim
---------------DELETE BY ID----------------
-- 1 LoaiGhe

-- 2 Ghe
-- 3 NhanVien
-- 4 Ve
-- 5 CaChieu
-- 6 PhongChieu
-- 7 LichChieu
-- 8 Phim


---------------SELECT ALL----------------------
-- 1 LoaiGhe
CREATE PROCEDURE SP_LoaiGhe_SelectAll
AS
BEGIN
	SELECT * FROM LoaiGhe
END
GO

-- 2 Ghe

CREATE PROCEDURE SP_Ghe_SelectAll
AS
BEGIN
	SELECT * FROM Ghe
END
GO
-- 3 NhanVien
CREATE PROCEDURE SP_NhanVien_SelectAll
AS
BEGIN
	SELECT * FROM NhanVien
END
GO

-- 4 Ve
CREATE PROCEDURE SP_Ve_SelectAll
AS
BEGIN
	SELECT * FROM Ve
END
GO
-- 5 CaChieu
CREATE PROCEDURE SP_CaChieu_SelectAll
AS
BEGIN
	SELECT * FROM CaChieu
END
GO

-- 6 PhongChieu
CREATE PROCEDURE SP_PhongChieu_SelectAll
AS
BEGIN
	SELECT * FROM PhongChieu
END
GO

-- 7 LichChieu
CREATE PROCEDURE SP_LichChieu_SelectAll
AS
BEGIN
	SELECT * FROM LichChieu
END
GO

-- 8 Phim
CREATE PROCEDURE SP_Phim_SelectAll
AS
BEGIN
	SELECT * FROM Phim
END
GO