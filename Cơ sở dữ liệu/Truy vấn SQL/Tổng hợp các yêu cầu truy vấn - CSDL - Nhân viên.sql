-----------------------------------------------------------------------------------------------
DROP DATABASE QUANLYNHANVIEN
GO
CREATE DATABASE QUANLYNHANVIEN;
GO	
CREATE TABLE PHONGBAN(
	MAPHONGBAN NCHAR(10) PRIMARY KEY,
	TENPHONGBAN VARCHAR(20) UNIQUE NOT NULL,
	MATRUONGPHONG NCHAR(10),
	NGAYNHANCHUC DATETIME DEFAULT (GETDATE()),
);

CREATE TABLE DUAN(
	MADUAN NCHAR(10) PRIMARY KEY,
	TENDUAN VARCHAR(20) UNIQUE NOT NULL,
	MAPHONGBAN NCHAR(10) REFERENCES PHONGBAN(MAPHONGBAN)
);

CREATE TABLE NHANVIEN(
	MANHANVIEN NCHAR(10) PRIMARY KEY,
	HOVATEN NVARCHAR(50) NOT NULL,
	NGAYSINH DATETIME,
	DIACHI NCHAR(128),
	GIOITINH NCHAR(3) CHECK (GIOITINH IN('Nam', 'Nữ')) DEFAULT('Nữ'),
	LUONG INT DEFAULT (10000000),
	MAGIAMSAT NCHAR(10),
	MAPHONGBAN NCHAR(10) REFERENCES PHONGBAN(MAPHONGBAN) 
);
/*	Chú ý: Tạo khóa chính gồm 2 trường
	- Bảng phân công là bảng sinh ra từ quan hệ n-n
	- Khóa chính là MANHANVIEN,MADUAN
	- Đồng thời là khóa ngoại 
*/
CREATE TABLE PHANCONG(
	MANHANVIEN NCHAR(10) REFERENCES  NHANVIEN(MANHANVIEN),
	MADUAN NCHAR(10) REFERENCES DUAN(MADUAN),
	SOGIO DECIMAL(3,1),
	PRIMARY KEY (MANHANVIEN, MADUAN)
);

CREATE TABLE THANNHAN(
	MANHANVIEN NCHAR(10) REFERENCES NHANVIEN(MANHANVIEN),
	HOTEN NVARCHAR(50) NOT NULL,
	PRIMARY KEY (MANHANVIEN, HOTEN),
	NGAYSINH DATETIME,
	GIOITINH NCHAR(3) CHECK (GIOITINH IN('Nam', 'Nữ')) DEFAULT('Nữ'),
	QUANHE NVARCHAR(25)

);
-----------------------------------------------------------------------------------------------
/* EX 1. LEFT JOIN
	Đưa ra MANHANVIEN, HOVATEN, NV.MAPHONGBAN, TENPHONGBAN 
	và cả các nhân viên không thuộc phòng ban nào 
*/
SELECT NV.MANHANVIEN, NV.HOVATEN, PB.MAPHONGBAN, PB.TENPHONGBAN
FROM NHANVIEN AS NV LEFT JOIN PHONGBAN AS PB ON NV.MAPHONGBAN = PB.MAPHONGBAN
----------

/* EX 2. RIGHT JOIN 
	Đưa ra MANHANVIEN, HOVATEN, NV.MAPHONGBAN, TENPHONGBAN 
	và cả các phòng ban không có nhân viên nào 
*/
SELECT NV.MANHANVIEN, NV.HOVATEN, PB.MAPHONGBAN, PB.TENPHONGBAN
FROM NHANVIEN AS NV RIGHT JOIN PHONGBAN AS PB ON NV.MAPHONGBAN = PB.MAPHONGBAN
----------

/* EX 3. FULL JOIN
	Đưa ra MANHANVIEN, HOVATEN, NV.MAPHONGBAN, TENPHONGBAN 
	và cả các phòng ban không có nhân viên nào , 
	cả những nhân viên không thuộc phòng ban nào
*/
SELECT NV.MANHANVIEN, NV.HOVATEN, PB.MAPHONGBAN, PB.TENPHONGBAN
FROM NHANVIEN AS NV FULL JOIN PHONGBAN AS PB ON NV.MAPHONGBAN = PB.MAPHONGBAN
----------

/* EX 4. IN : tương đương với = , NOT IN tương đương khách
	Đưa ra MANHANVIEN, TENNHANVIEN làm trưởng phòng sử dụng truy vấn lồng với toán tử IN 
*/
SELECT NV.MANHANVIEN, NV.HOVATEN
FROM NHANVIEN AS NV
WHERE NV.MANHANVIEN IN (SELECT MATRUONGPHONG FROM PHONGBAN )
----------

/* EX 5. IN 
    Đưa ra MANHANVIEN, TENNHANVIEN làm người giám sát sử dụng truy vấn lồng với toán tử  
*/
SELECT MANHANVIEN, HOVATEN
FROM NHANVIEN 
WHERE MANHANVIEN IN (SELECT MAGIAMSAT FROM NHANVIEN)
----------

/* EX 6. IN
	Đưa ra MAPHONGBAN, TENPHONGBAN của những phòng ban có nhân viên có lương lớn hơn 30 triệu IN 
*/
SELECT MAPHONGBAN, TENPHONGBAN
FROM PHONGBAN 
WHERE MAPHONGBAN IN (SELECT MAPHONGBAN FROM NHANVIEN WHERE LUONG > 300000)
----------

/* EX 7. IN
	Đưa ra MANHANVIEN, HOVATEN, LUONG của những nhân viên có lương > tất cả những nhân viên ở phòng có maphongban là 'P01'
*/
SELECT MANHANVIEN, HOVATEN, LUONG
FROM NHANVIEN
WHERE LUONG > ALL(SELECT LUONG FROM NHANVIEN WHERE MAPHONGBAN = 1)
----------

/* EX 8. ALL
	Đưa ra MANHANVIEN, HOVATEN, LUONG của những nhân viên có lương > tất cả những nhân viên ở phòng hành chính có tên là 'Hành chính'
*/
SELECT MANHANVIEN, HOVATEN, LUONG
FROM NHANVIEN
WHERE LUONG > ALL (SELECT LUONG FROM NHANVIEN AS NV, PHONGBAN AS PB WHERE NV.MAPHONGBAN = PB.MAPHONGBAN AND PB.TENPHONGBAN = N'Hành Chính')
----------
/* EX 9. ANY SOME
	Đưa ra MANHANVIEN, HOVATEN, LUONG của những nhân viên có lương > ít nhất lương của 1 người ở phòng 01
*/
SELECT MANHANVIEN, HOVATEN, LUONG
FROM NHANVIEN
WHERE LUONG > ANY (SELECT LUONG FROM NHANVIEN WHERE MAPHONGBAN = 4)
----------

/* EX 10. 
	Đưa ra MANHANVIEN, TENNHANVIEN của những thành viên ở phòng nghiên cứu
*/
SELECT MANHANVIEN, HOVATEN 
FROM NHANVIEN AS NV, PHONGBAN AS PB
WHERE NV.MAPHONGBAN = PB.MAPHONGBAN AND PB.TENPHONGBAN = N'Nghiên Cứu'
----------

/* EX 11. Exit - lồng tương quan
	Đưa ra MANHANVIEN, TENNHANVIEN là trưởng phòng	
*/
SELECT NV.HOVATEN, NV.MANHANVIEN
FROM NHANVIEN AS NV, PHONGBAN AS PB
WHERE NV.MANHANVIEN = PB.MATRUONGPHONG
----------

/* EX 12. viết truy vấn lồng với mệnh đề nằm trong FROM
	Đưa ra MANHANVIEN, TENNHANVIEN , TENPHONGBAN tương ứng của nhân viên
*/
SELECT NV.MANHANVIEN, NV.HOVATEN, PB.TENPHONGBAN
FROM NHANVIEN AS NV, (SELECT MAPHONGBAN, TENPHONGBAN FROM PHONGBAN) AS PB
WHERE NV.MAPHONGBAN = PB.MAPHONGBAN
----------

/* EX 13. viết truy vấn lồng với mệnh đề nằm trong FROM
	Đưa ra MANHANVIEN, TENNHANVIEN  của những nhân viên là trưởng phòng
*/
SELECT NV.MANHANVIEN, NV.HOVATEN
FROM NHANVIEN AS NV, (SELECT MATRUONGPHONG FROM PHONGBAN) AS PB
WHERE NV.MANHANVIEN = PB.MATRUONGPHONG
----------
/* EX 14.
	 Đưa ra phòng ban CÓ phụ trách dự án. Thông tin đưa ra gồm mã phòng ban, tên phòng ban. 
*/

SELECT PB.MAPHONGBAN, PB.TENPHONGBAN
FROM PHONGBAN AS PB
WHERE PB.MAPHONGBAN IN (SELECT MAPHONGBAN FROM DUAN)
---------
/* EX 15.
	-- YÊU CẦU 1: Đưa ra phòng ban chưa có trưởng phòng
	-- YÊU CẦU 2: Đưa ra phòng ban không phụ trách dự án nào
	-- YÊU CẦU 3: Đưa ra phòng ban chưa có trưởng phòng và không phụ trách dự án nào.Thông tin đưa ra gồm mã phòng ban, tên phòng ban.
*/
-- YÊU CẦU 1: Đưa ra phòng ban chưa có trưởng phòng
SELECT PB.MAPHONGBAN, PB.TENPHONGBAN, PB.MATRUONGPHONG
FROM PHONGBAN AS PB
WHERE PB.MATRUONGPHONG IS NULL

-- YÊU CẦU 2: Đưa ra phòng ban không phụ trách dự án nào
SELECT PB.MAPHONGBAN, PB.TENPHONGBAN
FROM PHONGBAN AS PB
EXCEPT
SELECT PB.MAPHONGBAN, PB.TENPHONGBAN
FROM PHONGBAN AS PB
WHERE PB.MAPHONGBAN IN (SELECT MAPHONGBAN FROM DUAN)

-- YÊU CẦU 3: Đưa ra phòng ban chưa có trưởng phòng và không phụ trách dự án nào.Thông tin đưa ra gồm mã phòng ban, tên phòng ban.
SELECT PB.MAPHONGBAN, PB.TENPHONGBAN
FROM PHONGBAN AS PB
WHERE PB.MATRUONGPHONG IS NULL
EXCEPT
SELECT PB.MAPHONGBAN, PB.TENPHONGBAN
FROM PHONGBAN AS PB
WHERE PB.MAPHONGBAN IN (SELECT MAPHONGBAN FROM DUAN) AND  PB.MATRUONGPHONG IS NULL
----------

/* EX 16. 
	- Đưa ra nhân viên không có người thân. Thông tin đưa ra gồm mã nhân viên, họ tên, ngày sinh, địa chỉ. 
*/
SELECT NV.MANHANVIEN, NV.HOVATEN, NV.NGAYSINH, NV.DIACHI
FROM NHANVIEN AS NV
WHERE NV.MANHANVIEN NOT IN (SELECT MANHANVIEN FROM THANNHAN)
----------

/* EX 17.
	-  Đưa ra nhân viên không tham gia dự án. Thông tin đưa ra gồm mã nhân viên, họ tên, ngày sinh, địa chỉ. 
*/
SELECT NV.MANHANVIEN, NV.HOVATEN, NV.NGAYSINH, NV.DIACHI
FROM NHANVIEN AS NV 
WHERE NV.MANHANVIEN NOT IN (SELECT MANHANVIEN FROM PHANCONG)
----------
/* EX 18.
	-  Đưa ra mã nhân viên, tên nhân viên, tên dự án mà nhân viên tham gia 
*/
----------
/* EX 19.
	-  Đưa ra mã nhân viên, tên nhân viên là người giám sát đồng thời là trưởng phòng
*/

----------
/* EX 20.
	-  Đưa ra mã nhân viên, tên nhân viên là trưởng phòng tham gia dự án
*/
----------
/* EX 21.
	-  Đưa ra mã dự án, tên dự án có trưởng phòng tham gia dự án sử dụng truy vấn lồng
*/
----------
/* EX 22.
	-  Tăng lương thêm 1.000.000 cho những nhân viên là trưởng phòng
	Giải :
		- B1. Lấy ra những nhân viên là trưởng phòng
		- B2. Update các nhân viên 
*/
----------
/* EX 23.
	-  Tăng lương thêm 1.000.000 cho những nhân viên là trưởng phòng, là người giám sát và có thân nhân
	Giải :
		- B1. Lấy ra những nhân viên là trưởng phòng
		- B2. Update các nhân viên 
*/
----------
/*------------------PHÉP TOÁN TẬP HỢP TRONG SQL-------------------*/

/* EX 23. UNION hợp
	- Cho biết mã dự án có
	- Nhân viên với họ là Nguyen tham gia hoặc
	- Trưởng phòng chủ trì dự án đó với họ là Nguyen
*/

/* EX 24. Except
    - Đưa ra những trưởng phòng không tham gia dự án
*/

/* EX 25. Count
	- Đếm số nhân viên trong bảng nhân viên
*/
 
/* EX 26. Count
	- Đếm số nhân viên đã biên chế vào phòng ban rồi
*/

/* EX 27. Count Distinct
	- Đếm số phòng ban đã có nhân viên
*/

/* EX 28.
	- Đếm số nhân viên trong từng phòng ban
	- COUNT DISTINCT
*/



/* EX 30. Group by
	- Tính tổng số thân nhân của từng phòng ban
	- Đưa ra mã phòng ban, tên phòng ban, tổng số thân nhân của từng phòng ban
*/

/* EX 31. Group by
	- Tính tổng số giờ mà nhân viên tham gia dự án
	- Đưa ra mã dự án, tên dự án, tổng số giờ tham gia dự án
*/

/* EX 32. Group by
	- Tính tổng số giờ mà nhân viên là người giám sát tham gia dự án
	- Đưa ra mã dự án, tên dự án, tổng số giờ tham gia dự án
*/

/* EX 33.
	- Đưa ra mã dự án, tên dự án chưa có trưởng phòng tham gia
*/

/* EX 34.
	- Đưa ra mã nhân viên, tên nhân viên, lương của những nhân viên có lương cao nhất của từng phòng ban
*/

/* EX 35.
	- Đưa ra mã dự án, tên dự án của những nhân viên ở Hà Nội
*/

/* EX 37.
	- Tính tổng số dự án tham gia và tổng số giờ tham gia đó của những nhân viên là trưởng phòng
	Giải
	- B1. Tìm xem các bảng nào sẽ sử dụng
		- Số giờ => PHANCONG
		- Nhân viên là trưởng phòng => PHONGBAN
		- 
*/

/* EX 38.
	- Đưa ra mã dự án, tên dự án, tên nhân viên, mã nhân viên của nhân viên là người giám sát tham gia
*/

/* EX 39.
	- Tính tổng số thân nhân của nhân viên là người giám sát
	- Đưa ra mã và tên nhân viên
*/
/* EX 40.
	- Đưa ra mã dự án, tên dự án của những nhân viên có thân nhân tham gia
*/
/* EX 41.
	- Đưa ra mã dự án, tên dự án của những nhân viên là trưởng phòng tham gia
*/

/* EX 42.
	- Tính tổng số thân nhân của những nhân viên là trưởng phòng
	- Đưa ra mã nhân viên, tên nhân viên, tổng số thân nhân
*/

/* EX 43.
	- Yêu cầu 1: Đưa ra mã nhân viên, tên nhân viên, tên dự án mà người đó tham gia và người đó là người giám sát
	- Yêu cầu 2: Tính tổng số dự án là nhân viên là người giám sát tham gia. Đưa ra mã nhân viên, tên nhân viên và tổng số dự án đã tham gia
*/

/* EX 44.
	- Yêu cầu 1: Đưa ra mã nhân viên, tên nhân viên, họ tên thân nhân của những nhân viên là trưởng phòng có tham gia dự án
	- Yêu cầu 2: Tính tổng số thân nhân của những nhân viên là trưởng phòng tham gia dự án. Thông tin gồm tên nv, mã nv, tổng thân nhân
*/


/* EX 45.
	- Yêu cầu 1: Tính tổng dự án của phòng ban. Đưa ra mã, tên phòng ban, tổng số dự án mà phòng ban tham gia
	- Yêu cầu 2: Đưa ra những phòng ban có 5 dự án trở lên
*/

/* EX 46. GROUP BY - HAVING - Điều kiện trên nhóm
	- Yêu cầu 1: Tính tổng số giờ, tổng số dự án của từng nhân viên của phòng nhiên cứu "Nghiên cứu"
	- Yêu cầu 2: Đưa ra mã nhân viên, tên nhân viên tham gia 10 dự án trở lên
*/

/* EX 47.
	- Yêu cầu 1: Đưa ra mã phòng ban, tên phòng ban, số lượng dự án mà phòng ban phụ trách nhiều dự án nhất
        - Cách 1: Select top 1 với with tise để đưa ra những bộ giá trị bằng thằng đầu tiên
        - Cách 2: Dùng All
        - Cách 3: Dùng view
        - Cách 4: Đếm số dự án theo từng phòng ban, lấy ra cái lớn nhất - select max, rồi lấy ra những phòng ban có số lượng bằng số lượng max ấy  
	- Yêu cầu 2: Đưa ra mã nhân viên, tên nhân viên, số dự án tham mà nhân viên tham gia nhiều nhất theo từng phòng ban
*/
/* EX 48.
	- Yêu cầu 1: Tính tổng số thân nhân cho nhân viên là người giám sát. Thông tin đưa ra: mã nhân viên, tên nhân viên, tổng số thân nhân
	- Yêu cầu 2: Đưa ra những phòng ban có từ 5 nhân viên giám sát trở lên. Thông tin đưa ra: mã phòng ban, tên phòng ban, số lượng người giám sát
	- Yêu cầu 3: Đưa ra mã phòng ban, tên phòng ban, tên nhân viên tham gia dự án(Dự án do phòng ban phụ trách hoặc phụ trách)
	- Yêu cầu 4: Tính tổng số nhân viên theo từng dự án. Thông tin gồm: mã dự án, tên dự án, số lượng nhân viên tham gia
	- Yêu cầu 5: Đưa ra mã nhân viên, tên nhân viên, tên dự án mà nhân viên tham gia
	- Yêu cầu 6: Đưa ra mã nhân viên, tên nhân viên, tên dự án mà nhân viên tham gia(nếu có)
	- Yêu cầu 7: Tính tổng số dự án tham gia của từng nhân viên
	- Yêu cầu 8: Đưa ra mã nhân viên, tên nhân viên, tên của những thân nhân là trưởng phòng
	- Yêu cầu 9: Tính tổng số thân nhân theo từng phòng ban
	- Yêu cầu 10: Đưa ra mã nhân viên, tên nhân viên, tên dự án của những nhân viên là người giám sát
	- Yêu cầu 11: Tính tổng số nhân viên là người giám sát theo từng dự án
	- Yêu cầu 12: Alter table add Thêm trường tổng số nhân viên vào bảng phòng ban
		- Dùng lệnh cập nhật giá trị cho bảng này
	- Yêu cầu 13: Đưa ra mã phòng ban, tên phòng ban, tên nhân viên thuộc phòng ban đó tham gia dự án không thuộc phòng ban đó phụ trách
	- Yêu cầu 14: Đưa ra những dự án có nhiều hơn 1 nhân viên là trưởng phòng tham gia.
*/

/* EX 49.
	-- Yêu cầu 1: Đưa ra mã phòng ban, tên phòng ban, tên dự án nằm ngoài Hà Nội do phòng ban phụ trách
	-- Yêu cầu 2: Tính tổng số nhân viên tham gia theo từng dự án nằm ngoài Hà Nội
	-- Yêu cầu 3: Đưa ra mã nhân viên, tên nhân viên, tên thân nhân của những nhân viên là trưởng phòng
	-- Yêu cầu 4: Tính tổng số dự án mà nhân viên tham gia theo từng phòng ban. Đưa ra mã phòng ban, tên phòng ban, số lượng dự án
	-- Yêu cầu 5: Đưa ra mã phòng ban, tên phòng ban, tên nhân viên là người giám sát
	-- Yêu cầu 6: Tính tổng số dự án tham gia của những nhân viên là người giám sát theo từng phòng ban
	-- Yêu cầu 7: Đưa ra mã nhân viên, tên nhân viên, lương, tên phòng ban, có lương < 5 triệu và có tham gia dự án
	-- Yêu cầu 8: Tính tổng số dự án tham gia của nhân viên là trưởng phòng theo từng phòng ban
	-- Yêu cầu 9: Đưa ra mã phòng ban, tên phòng ban chưa có nhân viên tham gia dự án
	-- Yêu cầu 10: Đưa ra mã dự án, tên dự án không có nhân viên là trưởng phòng tham gia <><><>
	-- Yêu cầu 11: Tính tổng số giờ tham gia dự án của các nhân viên là trưởng phòng theo từng dự án
	-- Yêu cầu 12: Tính tổng số thân nhân của mỗi nhân viên là trưởng phòng
	-- Yêu cầu 13: Đưa ra mã phòng ban, tên phòng ban có nhân viên chưa tham gia dự án

*/
-----------------------------PROCEDURE + FUCNTION + TRIGGER ---------------------------
/* EX 1. PROCEDURE
  Tạo thủ tục đưa ra thông tin về nhân viên tham gia dự án có phòng ban có tên là gì đó, thông tin đưa ra gồm mã nhân viên, họ tên nhân viên, tên dự án và số giờ tham gia dự án
*/

/* EX 2. FUNCTION
    Tạo hàm thống kê tổng số giờ tham gia dự án theo từng nhân viên trong phòng ban có tên là gì đó
*/

/* EX 1.
  
*/

/* EX 1.
  
*/

/* EX 1.
  
*/

/* EX 1.
  
*/

/* EX 1.
  
*/