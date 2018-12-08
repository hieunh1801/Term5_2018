-- Left Join -- Đưa ra mã nhân viên, tên nv, mã phòng ban, tên phòng ban và cả các nhân viên không thuộc phòng ban nào 
SELECT NV.MANHANVIEN, NV.HOVATEN, PB.MAPHONGBAN, PB.TENPHONGBAN
FROM NHANVIEN AS NV LEFT JOIN PHONGBAN AS PB ON NV.MAPHONGBAN = PB.MAPHONGBAN

-- Right Join -- Đưa ra mã nhân viên, tên nv, mã phòng ban, tên phòng ban và cả các phòng ban không có nhân viên nào
SELECT NV.MANHANVIEN, NV.HOVATEN, PB.MAPHONGBAN, PB.TENPHONGBAN
FROM NHANVIEN AS NV RIGHT JOIN PHONGBAN AS PB ON NV.MAPHONGBAN = PB.MAPHONGBAN

-- Full Join -- Đưa ra mã nhân viên, tên nv, mã phòng ban, tên phòng ban và cả các nhân viên không thuộc phòng ban nào, cả những phòng ban không có nhân viên
SELECT NV.MANHANVIEN, NV.HOVATEN, PB.MAPHONGBAN, PB.TENPHONGBAN
FROM NHANVIEN AS NV FULL JOIN PHONGBAN AS PB ON NV.MAPHONGBAN = PB.MAPHONGBAN

-- TRUY VẤN LỒNG --------------------------------------------------------------------------------------------------------------------------------------------------------

-- Truy vấn lồng: Where, IN- Đưa ra mã nhân viên, tên nhân viên là trưởng phòng
SELECT NV.MANHANVIEN, NV.HOVATEN
FROM NHANVIEN AS NV
WHERE NV.MANHANVIEN IN (SELECT MATRUONGPHONG FROM PHONGBAN)

-- Truy vấn lồng: Where, IN- Đưa ra mã nhân viên, tên nhân viên là người giám sát
SELECT NV.MANHANVIEN, NV.HOVATEN
FROM NHANVIEN AS NV
WHERE NV.MAGIAMSAT IN (SELECT MAGIAMSAT FROM NHANVIEN)

-- Đưa ra mã phòng ban, tên phòng ban của những nhân viên có lương >= 30 triệu
SELECT PB.MAPHONGBAN, PB.TENPHONGBAN 
FROM PHONGBAN AS PB
WHERE PB.MAPHONGBAN IN (SELECT NV.MAPHONGBAN FROM NHANVIEN AS NV WHERE NV.LUONG >= 300000)

-- Đưa ra những nhân viên có lương lớn hơn tất cả những nhân viên thuộc phòng 1
SELECT NV.MANHANVIEN, NV.HOVATEN
FROM NHANVIEN AS NV
WHERE NV.LUONG > ALL (SELECT LUONG FROM NHANVIEN WHERE NV.MAPHONGBAN = 1)

-- Đưa ra manv, tennv, luong của những nhân viên có lương > lương tất cả những nhân viên ở phòng hành chính
-- Đưa ra manv, tennv, lương của những nhân viên thuộc phòng nghiên cứu

-- 