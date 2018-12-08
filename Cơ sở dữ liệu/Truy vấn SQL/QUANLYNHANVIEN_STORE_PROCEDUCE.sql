-- Tạo thủ tục: thống kê các dự án tham gia của 1 phòng ban có tên là gì đó. Đầu vào: tên phòng ban, đầu ra: nhân viên và tổng số dự án của từng nhân viên

ALTER PROCEDURE SP_TONGSODUAN_THONGKE 
	@TENPHONGBAN NCHAR(50)
AS
BEGIN
	SELECT NV.MANHANVIEN, NV.HOVATEN, NV.GIOITINH, COUNT(PC.MADUAN) AS TONGSODUAN
	FROM NHANVIEN AS NV, PHONGBAN AS PB, PHANCONG AS PC
	WHERE NV.MAPHONGBAN = PB.MAPHONGBAN AND NV.MANHANVIEN = PC.MANHANVIEN AND PB.TENPHONGBAN = @TENPHONGBAN
	GROUP BY NV.MANHANVIEN
END;

[dbo].[SP_TONGSODUAN_THONGKE] N'Hành Chính'

[dbo].[SP_TONGSODUAN_THONGKE] N'TH'


---------------------------------------------------------------------------------------------------------------
-- Tạo thủ tục thêm 1 dự án mới, 
-- Sau đó cho tất cả nhân viên thuộc phòng P01 tham gia dự án này
-- Insert một lúc nhiều bản ghi
CREATE PROCEDURE SP_THEMDUAN_INSERT
	@MADUAN CHAR(10),
	@TENDUAN NVARCHAR(50)
AS
BEGIN
	INSERT INTO DUAN(MADUAN, TENDUAN)
	VALUES(@MADUAN, @TENDUAN)

	INSERT INTO PHANCONG(MADUAN, MANHANVIEN)
	SELECT @MADUAN, MANHANVIEN 
	FROM NHANVIEN
	WHERE MAPHONGBAN='1'
END
[dbo].[SP_THEMDUAN_INSERT] '22', 'THEM DU AN MOI'
---------------------------------------------------------------------------------------------------------------
-- Thêm 1 nhân viên mới: Thông tin thêm gồm Họ và tên, mã nhân viên, mã phòng ban
CREATE PROCEDURE SP_NHANVIEN_INSERT 
	@MANHANVIEN CHAR(10),
	@HOTEN NCHAR(50),
	@MAPHONGBAN CHAR(10)
AS 
BEGIN
	INSERT INTO NHANVIEN(MANHANVIEN, HOVATEN,MAPHONGBAN)
	VALUES(@MANHANVIEN, @HOTEN, @MAPHONGBAN)
END
[dbo].[SP_NHANVIEN_INSERT] '16', N'Nguyễn Hữu Hiếu', '2'

---------------------------------------------------------------------------------------------------------------
-- Sửa thông tin theo mã nhân viên: họ tên, ngày sinh, lương, 
CREATE PROCEDURE SP_NHANVIEN_UPDATE
	@MANHANVIEN CHAR(10),
	@HOVATEN NCHAR(50),
	@NGAYSINH DATE,
	@LUONG INT
AS
BEGIN
	UPDATE NHANVIEN
	SET HOVATEN = @HOVATEN,
		LUONG = @LUONG,
		NGAYSINH = @NGAYSINH
	WHERE @MANHANVIEN = MANHANVIEN
END
[dbo].[SP_NHANVIEN_UPDATE] '3', N'Nguyễn Văn Bân', '11-01-1998', 200000
---------------------------------------------------------------------------------------------------------------
-- Xóa nhân viên có mã nhân viên là gì đó
CREATE PROCEDURE SP_NHANVIEN_DELETE
	@MANHANVIEN CHAR(10)
AS 
BEGIN
	DELETE PHANCONG
	WHERE MANHANVIEN = @MANHANVIEN
	DELETE NHANVIEN
	WHERE MANHANVIEN = @MANHANVIEN
END
[dbo].[SP_NHANVIEN_DELETE] '1'
---------------------------------------------------------------------------------------------------------------
-- Thống kê nhân viên theo mã phòng ban
CREATE PROCEDURE SP_DANHSACHNHANVIEN_THONGKE
	@MAPHONGBAN NCHAR(50)
AS
BEGIN
	SELECT MANHANVIEN, HOVATEN, NGAYSINH, LUONG
	FROM NHANVIEN
	WHERE MAPHONGBAN = @MAPHONGBAN
END
[dbo].[SP_DANHSACHNHANVIEN_THONGKE] '2'

---------------------------------------------------------------------------------------------------------------
-- Tạo function xem danh sách nhân viên của phòng ban nào đó
ALTER FUNCTION FUNC_XEMDANHSACHNV(@TENPHONGBAN NVARCHAR(50)) RETURNS TABLE
AS
RETURN(SELECT MANHANVIEN, HOVATEN, NGAYSINH, LUONG FROM NHANVIEN INNER JOIN PHONGBAN ON PHONGBAN.MAPHONGBAN = NHANVIEN.MAPHONGBAN WHERE TENPHONGBAN = @TENPHONGBAN)

SELECT * FROM DBO.FUNC_XEMDANHSACHNV('TH')


---------------------------------------------------------------------------------------------------------------
-- Tạo function đếm số nhân viên của phòng ban nào đó

