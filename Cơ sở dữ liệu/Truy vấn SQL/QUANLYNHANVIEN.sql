CREATE DATABASE QUANLYNHANVIEN;

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

/* //////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////[12-10-2018]
///////////////////////////////////Các câu lệnh truy vấn dữ liệu// */

/*  2
	INNER JOIN - Điều kiện nối 
*/

/* EX. LEFT JOIN
	Đưa ra MANHANVIEN, HOVATEN, NV.MAPHONGBAN, TENPHONGBAN 
	và cả các nhân viên không thuộc phòng ban nào 
*/
SELECT MANHANVIEN, HOVATEN, NV.MAPHONGBAN, TENPHONGBAN
FROM NHANVIEN AS NV left JOIN PHONGBAN AS PB ON NV.MAPHONGBAN = PB.MAPHONGBAN

/* EX. RIGHT JOIN 
	Đưa ra MANHANVIEN, HOVATEN, NV.MAPHONGBAN, TENPHONGBAN 
	và cả các phòng ban không có nhân viên nào 
*/
SELECT MANHANVIEN, HOVATEN, NV.MAPHONGBAN, TENPHONGBAN
FROM NHANVIEN AS NV RIGHT JOIN PHONGBAN AS PB ON NV.MAPHONGBAN = PB.MAPHONGBAN

/* EX. FULL JOIN
	Đưa ra MANHANVIEN, HOVATEN, NV.MAPHONGBAN, TENPHONGBAN 
	và cả các phòng ban không có nhân viên nào , 
	cả những nhân viên không thuộc phòng ban nào
*/
SELECT MANHANVIEN, HOVATEN, NV.MAPHONGBAN, TENPHONGBAN
FROM NHANVIEN AS NV FULL JOIN PHONGBAN AS PB ON NV.MAPHONGBAN = PB.MAPHONGBAN


/*  
	Câu lệnh truy vấn lồng: là truy vấn nằm trong truy vấn
	Câu lệnh truy vấn con Subquery và phải đặt trong ngoặc đơn ()
	Có 2 loại:
		- Nằm trong FROM
			- Kết quả của truy vấn trả về là 1 bảng
		- Nằm trong WHERE
	Tối đa 32 mức

	Mệnh đề WHERE
		- IN, NOT IN : thỏa mãn điều kiện hay không thỏa mãn 
		- ALL tất cả
			WHERE <tên cột><phép toán so sánh> ALL|ANY|SOME (Sub query)
		- ANY hoặc SOME : ít nhất 1
		- EXIST : kiểm tra sự tồn tài

	Mệnh đề FROM
		SELECT <danh sách cột>
		FROM R1, R2(TRUY VẤN CON) AS TÊN_BẢNG // trả về 1 bảng nên phải có tên bảng
		WHERE <điều kiện>
	CÓ 2 cách lồng
	- Lồng phân cấp : các subquery thực hiện độc lập. Thực hiện xong thì thực hiện truy vấn bên ngoài 
	- Lồng tương quan : các subquery thực thi có những thuộc tính liên quan tới truy vấn bên ngoài
*/

/* EX. IN : tương đương với = , NOT IN tương đương khách
	Đưa ra MANHANVIEN, TENNHANVIEN làm trưởng phòng sử dụng truy vấn lồng với toán tử IN 
*/
SELECT MANHANVIEN, HOVATEN 
FROM NHANVIEN
WHERE MANHANVIEN IN (SELECT MATRUONGPHONG FROM PHONGBAN) /* Nghĩa là MANHANVIEN == MATRUONGPHONG */

/* EX. Đưa ra MANHANVIEN, TENNHANVIEN làm người giám sát sử dụng truy vấn lồng với toán tử IN */
SELECT MANHANVIEN, HOVATEN
FROM NHANVIEN
WHERE MANHANVIEN IN (SELECT MAGIAMSAT FROM NHANVIEN)

/* EX. IN
	Đưa ra MAPHONGBAN, TENPHONGBAN của những phòng ban có nhân viên có lương lớn hơn 30 triệu IN 
*/
SELECT MAPHONGBAN, TENPHONGBAN
FROM PHONGBAN
WHERE MAPHONGBAN IN (SELECT MAPHONGBAN FROM NHANVIEN WHERE NHANVIEN.LUONG >= 30000000)


/* EX. IN
	Đưa ra MANHANVIEN, HOVATEN, LUONG của những nhân viên có lương > tất cả những nhân viên ở phòng có maphongban là 'P01'
*/
SELECT MANHANVIEN, HOVATEN, LUONG
FROM NHANVIEN 
WHERE LUONG > ALL(
	SELECT LUONG 
	FROM NHANVIEN
	WHERE MAPHONGBAN = 'P01')

/* EX. ALL
	Đưa ra MANHANVIEN, HOVATEN, LUONG của những nhân viên có lương > tất cả những nhân viên ở phòng hành chính có tên là 'Hành chính'
*/
SELECT MANHANVIEN, HOVATEN, LUONG 
FROM NHANVIEN
WHERE NHANVIEN.LUONG > ALL(
	SELECT LUONG 
	FROM NHANVIEN 
	WHERE MAPHONGBAN IN (
		SELECT MAPHONGBAN
		FROM PHONGBAN
		WHERE TENPHONGBAN = N'HÀNH CHÍNH'
	))

/* EX. ANY SOME
	Đưa ra MANHANVIEN, HOVATEN, LUONG của những nhân viên có lương > ít nhất lương của 1 người ở phòng hành chính có tên là 'Hành chính'
*/
SELECT MANHANVIEN, HOVATEN
FROM NHANVIEN
WHERE LUONG > ANY (
	SELECT LUONG
	FROM NHANVIEN AS NV, PHONGBAN AS PB
	WHERE NV.MAPHONGBAN = PB.MAPHONGBAN AND TENPHONGBAN = N'HÀNH CHÍNH'
)
/* EX. Exit - lồng tương quan
	Đưa ra MANHANVIEN, TENNHANVIEN của những thành viên ở phòng nghiên cứu
*/
SELECT MANHANVIEN, HOVATEN
FROM NHANVIEN AS NV, PHONGBAN AS PB
WHERE NV.MAPHONGBAN = PB.MAPHONGBAN AND TENPHONGBAN = N'Nghiên cứu'

/*CÁCH 2 : TRUY VẤN LỒNG */


/* EX. Exit - lồng tương quan
	Đưa ra MANHANVIEN, TENNHANVIEN là trưởng phòng	
*/
SELECT MANHANVIEN, HOVATEN
FROM NHANVIEN
WHERE EXISTS (
	SELECT *
	FROM PHONGBAN
	WHERE MATRUONGPHONG = NHANVIEN.MAGIAMSAT
)

/* EX. viết truy vấn lồng với mệnh đề nằm trong FROM
	Đưa ra MANHANVIEN, TENNHANVIEN , TENPHONGBAN tương ứng của nhân viên
*/
SELECT MANHANVIEN, HOVATEN, TENPHONGBAN
FROM NHANVIEN AS NV, (SELECT MAPHONGBAN, TENPHONGBAN FROM PHONGBAN) AS PB
WHERE NV.MAPHONGBAN = PB.MAPHONGBAN

/* EX. viết truy vấn lồng với mệnh đề nằm trong FROM
	Đưa ra MANHANVIEN, TENNHANVIEN  của những nhân viên là trưởng phòng
*/
SELECT MANHANVIEN, HOVATEN
FROM NHANVIEN, (SELECT MATRUONGPHONG FROM PHONGBAN) PB
WHERE NHANVIEN.MANHANVIEN = PB.MATRUONGPHONG

/* EX. Bài tập 1
	- Đưa ra phòng ban có phụ trách dự án. Thông tin đưa ra gồm mã phòng ban, tên phòng ban. 
*/

/* EX. Bài tập 2
	- Đưa ra phòng ban chưa có trưởng phòng và không phụ trách dự án nào.Thông tin đưa ra gồm mã phòng ban, tên phòng ban.
*/
SELECT MAPHONGBAN, PB.TENPHONGBAN
FROM PHONGBAN AS PB
WHERE PB.MATRUONGPHONG IS NULL AND MAPHONGBAN NOT IN (SELECT MAPHONGBAN FROM DUAN) 
/* EX. Bài tập 3
	- Đưa ra nhân viên không có người thân. Thông tin đưa ra gồm mã nhân viên, họ tên, ngày sinh, địa chỉ. 
*/

/* EX. Bài tập 4
	-  Đưa ra nhân viên không tham gia dự án. Thông tin đưa ra gồm mã nhân viên, họ tên, ngày sinh, địa chỉ. 
*/



/*____________________________________________________[17-10-2018]__________________________________________________________________*/

/*__________________________________________________________________________________________________________________________________*/

/*
1.	NHANVIEN(MANV,HOTENNV, NGAYSINH, GIOITINH, DIACHI, LUONG, MAGIAMSAT, MAPHONGBAN)
2.	THANNHAN(MANHANVIEN, TENTHANNHAN, NGAYSINH, GIOITINH, QUANHE)
3.	PHONGBAN(MAPHONGBAN, TENPHONGBAN, DIADIEM, MATRUONGPHONG, NGAYNHANCHUC,)
4.	DUAN(MADUAN, TENDUAN, MAPHONGBAN)
5.	PHANCONG(MANHANVIEN, MADUAN, SOGIO)

*/

/* EX.
	-  Đưa ra mã nhân viên, tên nhân viên, tên dự án mà nhân viên tham gia 
*/
SELECT NV.MANHANVIEN, NV.HOVATEN, DA.TENDUAN
FROM NHANVIEN AS NV, DUAN AS DA, PHANCONG AS PC
WHERE NV.MANHANVIEN = PC.MANHANVIEN AND DA.MADUAN = PC.MADUAN
/* EX.
	-  Đưa ra mã nhân viên, tên nhân viên là người giám sát, là trưởng phòng
*/
SELECT NV1.MANHANVIEN, NV1.HOVATEN
FROM NHANVIEN AS NV1,NHANVIEN AS NV2, PHONGBAN AS PB 
WHERE NV1.MANHANVIEN = NV2.MAGIAMSAT AND NV1.MANHANVIEN = PB.MAPHONGBAN
/* EX.
	-  Đưa ra mã nhân viên, tên nhân viên là trưởng phòng tham gia dự án
*/

/* EX.
	-  Đưa ra mã dự án, tên dự án có trưởng phòng tham gia dự án sử dụng truy vấn lồng
*/
SELECT DA.MADUAN, DA.TENDUAN
FROM DUAN AS DA, PHANCONG AS PC, PHONGBAN AS PB
WHERE PB.MATRUONGPHONG = PC.MANHANVIEN AND DA.MADUAN = PC.MADUAN
/* EX.
	-  Tăng lương thêm 1.000.000 cho những nhân viên là trưởng phòng
	Giải :
		- B1. Lấy ra những nhân viên là trưởng phòng
		- B2. Update các nhân viên 
*/
UPDATE NHANVIEN
SET LUONG = LUONG + 1000000
WHERE MANHANVIEN IN (SELECT MATRUONGPHONG FROM NHANVIEN, PHONGBAN WHERE NHANVIEN.MANHANVIEN = PHONGBAN.MATRUONGPHONG)
/* EX.
	-  Tăng lương thêm 1.000.000 cho những nhân viên là trưởng phòng, là người giám sát và có thân nhân
	Giải :
		- B1. Lấy ra những nhân viên là trưởng phòng
		- B2. Update các nhân viên 
*/
UPDATE NHANVIEN
SET LUONG = LUONG + 1000000
WHERE MANHANVIEN IN (SELECT MATRUONGPHONG FROM NHANVIEN, PHONGBAN WHERE PHONGBAN.MATRUONGPHONG = NHANVIEN.MANHANVIEN)
AND MANHANVIEN IN(SELECT MAGIAMSAT FROM NHANVIEN)
AND MANHANVIEN IN(SELECT MANHANVIEN FROM THANNHAN)

		/*PHÉP TOÁN TẬP HỢP TRONG SQL*/
/*
	UNION (ALL) hợp
	INTESRECT giao
	EXCEPT trừ
	- 2 vế select giống nhau
	- from và where khác nhau
*/

/* EX. UNION hợp
	- Cho biết mã dự án có
	- Nhân viên với họ là Nguyen tham gia hoặc
	- Trưởng phòng chủ trì dự án đó với họ là Nguyen
*/
/*CACH 1*/
SELECT DA.MADUAN
FROM DUAN AS DA, NHANVIEN AS NV, PHANCONG AS PC
WHERE DA.MADUAN = PC.MADUAN AND PC.MANHANVIEN = NV.MANHANVIEN AND NV.HOVATEN LIKE 'Nguyen%'

UNION 

SELECT DA.MADUAN
FROM DUAN AS DA, NHANVIEN AS NV, PHONGBAN AS PB
WHERE DA.MAPHONGBAN = PB.MAPHONGBAN AND NV.MANHANVIEN = PB.MATRUONGPHONG AND NV.MANHANVIEN LIKE 'Nguyen%'

/*CACH 2*/
SELECT MADUAN
FROM PHANCONG WHERE MANHANVIEN IN (SELECT MANHANVIEN FROM NHANVIEN WHERE NHANVIEN.HOVATEN LIKE 'Nguyen%')
UNION
SELECT MADUAN
FROM DUAN WHERE MAPHONGBAN IN (SELECT MAPHONGBAN FROM PHONGBAN WHERE MATRUONGPHONG IN (SELECT MANHANVIEN FROM NHANVIEN WHERE HOVATEN LIKE 'NGUYEN%'))

/* EX. Except
	- Đưa ra những trưởng phòng không tham gia dự án
*/
			/* HÀM TÍNH TOÁN VÀ THỐNG KÊ */
			/*
				SUM,
				MIN
				MAX
				AVG
				
				COUNT
			*/
/* EX
	- Đếm số nhân viên trong bảng nhân viên
*/
SELECT COUNT(MANHANVIEN)
FROM NHANVIEN

SELECT COUNT(*)
FROM NHANVIEN
/* EX
	- Đếm số nhân viên đã biên chế vào phòng ban rồi
*/
SELECT COUNT(MANHANVIEN)
FROM NHANVIEN
WHERE NHANVIEN.MAPHONGBAN IS NOT NULL

/* EX
	- Đếm số phòng ban đã có nhân viên
	- COUNT DISTINCT
*/

/* EX
	- Đếm số nhân viên trong từng phòng ban
	- COUNT DISTINCT
*/
SELECT NV.MAPHONGBAN, COUNT (DISTINCT NV.MANHANVIEN) AS TONGSONHANVIEN
FROM NHANVIEN AS NV
GROUP BY NV.MAPHONGBAN

/*GROUP BY - HAVING <Điều kiện trên nhóm>
	<Chú ý: các mênh>
*/



/*____________________________________________________[19-10-2018]__________________________________________________________________*/
/* EX Group by
	- Tính tổng số thân nhân của từng phòng ban
	- Đưa ra mã phòng ban, tên phòng ban, tổng số thân nhân của từng phòng ban
*/
SELECT PB.MAPHONGBAN, PB.TENPHONGBAN, COUNT(TN.HOTEN)
FROM THANNHAN AS TN, PHONGBAN AS PB, NHANVIEN AS NV
WHERE TN.MANHANVIEN = NV.MANHANVIEN AND NV.MAPHONGBAN = PB.MAPHONGBAN
GROUP BY PB.MAPHONGBAN, PB.TENPHONGBAN
/* EX Group by
	- Tính tổng số giờ mà nhân viên tham gia dự án
	- Đưa ra mã dự án, tên dự án, tổng số giờ tham gia dự án
*/
SELECT DA.MADUAN, DA.TENDUAN, COUNT (PC.SOGIO)
FROM DUAN AS DA, PHANCONG AS PC 
WHERE DA.MADUAN = PC.MADUAN
GROUP BY DA.MADUAN, DA.TENDUAN

/* EX Group by
	- Tính tổng số giờ mà nhân viên là người giám sát tham gia dự án
	- Đưa ra mã dự án, tên dự án, tổng số giờ tham gia dự án
*/
SELECT NV1.MANHANVIEN, NV1.HOVATEN, SUM(PC.SOGIO) AS TONGSO
FROM NHANVIEN AS NV1, PHANCONG AS PC, NHANVIEN NV2
WHERE NV1.MANHANVIEN = NV2.MAGIAMSAT AND NV1.MANHANVIEN = PC.MANHANVIEN
GROUP BY NV1.MANHANVIEN, NV1.HOVATEN

/* EX
	- Đưa ra mã dự án, tên dự án chưa có trưởng phòng tham gia
*/
/* CÁCH 1 */
SELECT DA.MADUAN, DA.TENDUAN
FROM DUAN AS DA, PHANCONG AS PC
WHERE DA.MADUAN = PC.MADUAN AND PC.MANHANVIEN NOT IN (SELECT MATRUONGPHONG FROM PHONGBAN) 

/* CÁCH 2: Cách này hay hơn vì lấy cái gì thì chỉ từ bảng đấy thôi.*/
SELECT MADUAN, TENDUAN
FROM DUAN 
WHERE DUAN.MADUAN IN (
	SELECT MADUAN FROM PHANCONG WHERE PHANCONG.MANHANVIEN NOT IN (
		SELECT MATRUONGPHONG FROM PHONGBAN
		)
	)

/* EX 
	- Đưa ra mã nhân viên, tên nhân viên, lương của những nhân viên có lương cao nhất của từng phòng ban
*/

/* CÁCH 1: Truy vấn lồng với mệnh đề tương quan(câu lệnh truy vấn trong ngoặc có quan hệ với ngoài ngoặc) - tuy nhiên bí quá mới dùng */
SELECT NV.MANHANVIEN, NV.HOVATEN, NV.LUONG
FROM NHANVIEN AS NV
WHERE LUONG IN (
	SELECT MAX(LUONG)
	FROM NHANVIEN
	WHERE MAPHONGBAN = NV.MAPHONGBAN
	GROUP BY MAPHONGBAN
)

/*CÁCH 2: Lấy ra một bảng khác có lương cao nhất của từng phòng ban*/
SELECT NV1.MANHANVIEN, NV1.HOVATEN, NV1.LUONG
FROM NHANVIEN AS NV1, (SELECT MAPHONGBAN, MAX(LUONG) AS MAXLUONG FROM NHANVIEN AS NV GROUP BY MAPHONGBAN) AS NV2
WHERE NV1.MAPHONGBAN = NV2.MAPHONGBAN

SELECT NV.MANHANVIEN, NV.HOVATEN, NV.LUONG
FROM NHANVIEN AS NV
WHERE LUONG = (
	SELECT MAX(LUONG) 
	FROM NHANVIEN
	GROUP BY MAPHONGBAN 
	HAVING MAPHONGBAN = NV.MAPHONGBAN
)
/* EX 
	- Đưa ra mã dự án, tên dự án của những nhân viên ở Hà Nội
*/
SELECT DA.MADUAN, DA.TENDUAN
FROM DUAN AS DA, PHANCONG AS PC, (SELECT NV.MANHANVIEN FROM NHANVIEN AS NV WHERE NV.DIACHI LIKE N'Hà Nội') AS NV
WHERE DA.MADUAN = PC.MADUAN AND PC.MANHANVIEN = NV.MANHANVIEN

/* EX 
	- Tính tổng số dự án tham gia và tổng số giờ tham gia đó của những nhân viên là trưởng phòng
	Giải
	- B1. Tìm xem các bảng nào sẽ sử dụng
		- Số giờ => PHANCONG
		- Nhân viên là trưởng phòng => PHONGBAN
		- 
*/
SELECT COUNT(DA.MADUAN) AS TONGDUAN, SUM(PC.SOGIO) AS TONGSOGIO, PC.MANHANVIEN
FROM DUAN AS DA, PHANCONG AS PC
WHERE DA.MADUAN = PC.MADUAN AND PC.MANHANVIEN IN (SELECT MATRUONGPHONG FROM PHONGBAN)
GROUP BY PC.MANHANVIEN
/* EX 
	- Đưa ra mã dự án, tên dự án, tên nhân viên, mã nhân viên của nhân viên là người giám sát tham gia
*/
SELECT DA.MADUAN, DA.TENDUAN
FROM DUAN AS DA, NHANVIEN AS NV, PHANCONG AS PC
WHERE DA.MADUAN = PC.MADUAN AND PC.MANHANVIEN = NV.MAGIAMSAT
/* EX 
	- Tính tổng số thân nhân của nhân viên là người giám sát
	- Đưa ra mã và tên nhân viên
*/
/* EX 
	- Đưa ra mã dự án, tên dự án của những nhân viên có thân nhân tham gia
*/
/* EX 
	- Đưa ra mã dự án, tên dự án của những nhân viên là trưởng phòng tham gia
*/

/* EX 
	- Tính tổng số thân nhân của những nhân viên là trưởng phòng
	- Đưa ra mã nhân viên, tên nhân viên, tổng số thân nhân
*/


/*____________________________________________________[24-10-2018]__________________________________________________________________*/
/* EX 
	- Yêu cầu 1: Đưa ra mã nhân viên, tên nhân viên, tên dự án mà người đó tham gia và người đó là người giám sát
	- Yêu cầu 2: Tính tổng số dự án là nhân viên là người giám sát tham gia. Đưa ra mã nhân viên, tên nhân viên và tổng số dự án đã tham gia
*/

/*Yêu cầu 1*/
SELECT NV1.MANHANVIEN, NV1.HOVATEN, DA.MADUAN, DA.TENDUAN
FROM NHANVIEN AS NV1, NHANVIEN AS NV2, PHANCONG AS PC, DUAN AS DA
WHERE NV1.MANHANVIEN = NV2.MAGIAMSAT AND NV1.MANHANVIEN = PC.MANHANVIEN AND DA.MADUAN = PC.MADUAN

/*Yêu cầu 2*/
SELECT NV1.MANHANVIEN, NV1.HOVATEN, COUNT(PC.MADUAN) AS TONGSODUAN
FROM NHANVIEN AS NV1, NHANVIEN AS NV2, PHANCONG AS PC
WHERE NV1.MANHANVIEN = NV2.MAGIAMSAT AND NV1.MANHANVIEN = PC.MANHANVIEN
GROUP BY NV1.MANHANVIEN, NV1.HOVATEN


/* EX 
	- Yêu cầu 1: Đưa ra mã nhân viên, tên nhân viên, họ tên thân nhân của những nhân viên là trưởng phòng có tham gia dự án
	- Yêu cầu 2: Tính tổng số thân nhân của những nhân viên là trưởng phòng tham gia dự án. Thông tin gồm tên nv, mã nv, tổng thân nhân
*/

/*Yêu cầu 1*/
SELECT NV.MANHANVIEN, NV.HOVATEN, TN.HOTEN
FROM NHANVIEN AS NV, PHONGBAN AS PB, PHANCONG AS PC, THANNHAN AS TN
WHERE NV.MANHANVIEN = PB.MATRUONGPHONG AND PC.MADUAN = NV.MANHANVIEN AND NV.MANHANVIEN = TN.MANHANVIEN

/*Yêu cầu 2*/
SELECT NV.MANHANVIEN, NV.HOVATEN, COUNT(TN.HOTEN) AS TONGSOTHANNHAN
FROM NHANVIEN AS NV, PHONGBAN AS PB, THANNHAN AS TN, PHANCONG AS PC
WHERE NV.MANHANVIEN = PB.MATRUONGPHONG AND NV.MANHANVIEN = PB.MATRUONGPHONG AND NV.MANHANVIEN = PC.MANHANVIEN
GROUP BY NV.MANHANVIEN

/* EX 
	- Yêu cầu 1: Tính tổng dự án của phòng ban. Đưa ra mã, tên phòng ban, tổng số dự án mà phòng ban tham gia
	- Yêu cầu 2: Đưa ra những phòng ban có 5 dự án trở lên
*/

/*Yêu cầu 1*/
SELECT PB.MAPHONGBAN, PB.TENPHONGBAN, COUNT(DA.TENDUAN)
FROM PHONGBAN AS PB, DUAN AS DA
WHERE PB.MAPHONGBAN = DA.MAPHONGBAN
GROUP BY PB.MAPHONGBAN

/*Yêu cầu 2*/
/* EX HAVING - Điều kiện trên nhóm
	- Yêu cầu 1: Tính tổng số giờ, tổng số dự án của từng nhân viên của phòng nhiên cứu "Nghiên cứu"
	- Yêu cầu 2: Đưa ra mã nhân viên, tên nhân viên tham gia 10 dự án trở lên
*/
/*Yêu cầu 1*/
SELECT  NV.MANHANVIEN, NV.HOVATEN, SUM(PC.SOGIO), COUNT (PC.MADUAN)
FROM NHANVIEN AS NV, PHANCONG AS PC
WHERE NV.MANHANVIEN = PC.MANHANVIEN
GROUP BY NV.HOVATEN

/*Yêu cầu 2*/
SELECT NV.MANHANVIEN, NV.HOVATEN, COUNT(PC.MADUAN)
FROM NHANVIEN AS NV, PHANCONG AS PC
WHERE NV.MANHANVIEN = PC.MANHANVIEN
GROUP BY NV.MANHANVIEN
HAVING COUNT(PC.MADUAN) >= 10
/* EX 
	- Yêu cầu 1: Đưa ra mã phòng ban, tên phòng ban, số lượng dự án mà phòng ban phụ trách nhiều dự án nhất
	- Yêu cầu 2: Đưa ra mã nhân viên, tên nhân viên, số dự án tham mà nhân viên tham gia nhiều nhất theo từng phòng ban
*/
/*Yêu cầu 1
	- Cách 1: Select top 1 với with tise để đưa ra những bộ giá trị bằng thằng đầu tiên
	- Cách 2: Dùng All
	- Cách 3: Dùng view
	- Cách 4: Đếm số dự án theo từng phòng ban, lấy ra cái lớn nhất - select max, rồi lấy ra những phòng ban có số lượng bằng số lượng max ấy  
*/

/*Yêu cầu 2 - Lấy ra một bảng phụ trách nhiều dự án nhất*/



/*____________________________________________________[31-10-2018]__________________________________________________________________*/
/* Bài tập
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
-- Yêu cầu 1: Tính tổng số thân nhân cho nhân viên là người giám sát. Thông tin đưa ra: mã nhân viên, tên nhân viên, tổng số thân nhân

/*____________________________________________________[2-11-2018]__________________________________________________________________*/
/* Bài tập
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
-- Yêu cầu 1
SELECT PB.MAPHONGBAN, PB.TENPHONGBAN, DA.TENDUAN
FROM PHONGBAN AS PB, DUAN AS DA
WHERE DA.MAPHONGBAN = PB.MAPHONGBAN AND DA.DIADIEM NOT LIKE N'Hà Nội'

-- Yêu cầu 2
SELECT DA.MADUAN, DA.TENDUAN, COUNT(PC.MANHANVIEN) AS TONGSONHANVIEN
FROM DUAN AS DA, PHANCONG AS PC
WHERE DA.MADUAN = PC.MADUAN AND DA.TENDUAN NOT LIKE N'Hà Nội'
GROUP BY DA.MADUAN, DA.TENDUAN 

-- Yêu cầu 3
SELECT NV.MANHANVIEN, NV.HOVATEN, TN.HOTEN AS HOTENTHANNHAN
FROM NHANVIEN AS NV, PHONGBAN AS PB, THANNHAN AS TN
WHERE NV.MANHANVIEN = PB.MATRUONGPHONG AND NV.MANHANVIEN = TN.MANHANVIEN

-- Yêu cầu 4: Tính tổng số dự án mà nhân viên tham gia theo từng phòng ban. Đưa ra mã phòng ban, tên phòng ban, số lượng dự án
SELECT PB.MAPHONGBAN, PB.TENPHONGBAN, COUNT(PC.MADUAN) AS TONGSODUAN
FROM PHONGBAN AS PB, PHANCONG AS PC, NHANVIEN AS NV
WHERE PB.MAPHONGBAN = NV.MAPHONGBAN AND NV.MANHANVIEN = PC.MANHANVIEN
GROUP BY PB.MAPHONGBAN, PB.TENPHONGBAN

-- Yêu cầu 5: Đưa ra mã phòng ban, tên phòng ban, tên nhân viên là người giám sát
SELECT PB.MAPHONGBAN, PB.TENPHONGBAN, NV1.HOVATEN
FROM PHONGBAN AS PB, NHANVIEN AS NV1, NHANVIEN AS NV2
WHERE PB.MAPHONGBAN = NV1.MAPHONGBAN AND NV1.MAGIAMSAT = NV2.MANHANVIEN

-- Yêu cầu 6: Tính tổng số dự án tham gia của những nhân viên là người giám sát theo từng phòng ban
SELECT NV1.MANHANVIEN, NV1.HOVATEN, NV1.MAPHONGBAN, PB.TENPHONGBAN, COUNT(PC.MADUAN) AS TONGSODUAN
FROM NHANVIEN AS NV1, NHANVIEN AS NV2, PHANCONG AS PC, PHONGBAN AS PB
WHERE NV1.MANHANVIEN = PC.MANHANVIEN AND NV1.MAGIAMSAT = NV2.MANHANVIEN AND NV1.MAPHONGBAN = PB.MAPHONGBAN
GROUP BY NV1.MANHANVIEN, NV1.HOVATEN, NV1.MAPHONGBAN, PB.TENPHONGBAN 

-- Yêu cầu 7: Đưa ra mã nhân viên, tên nhân viên, lương, tên phòng ban, có lương < 5 triệu và có tham gia dự án
SELECT NV.MANHANVIEN, NV.HOVATEN, NV.LUONG, PB.MAPHONGBAN
FROM NHANVIEN AS NV, PHONGBAN AS PB, PHANCONG AS PC
WHERE NV.MAPHONGBAN = PB.MAPHONGBAN AND NV.LUONG < 5000000 AND NV.MANHANVIEN = PC.MANHANVIEN
GROUP BY NV.MANHANVIEN, NV.HOVATEN, NV.LUONG, PB.MAPHONGBAN

-- Yêu cầu 8: Tính tổng số dự án tham gia của nhân viên là trưởng phòng theo từng phòng ban
SELECT PB.MAPHONGBAN, PB.MATRUONGPHONG, COUNT(PC.MADUAN) AS TONGSODUAN
FROM PHANCONG AS PC, PHONGBAN AS PB
WHERE PC.MANHANVIEN = PB.MATRUONGPHONG
GROUP BY PB.MAPHONGBAN, PB.MATRUONGPHONG

-- Yêu cầu 9: Đưa ra mã phòng ban, tên phòng ban chưa có nhân viên tham gia dự án
SELECT PB.MAPHONGBAN, PB.TENPHONGBAN 
FROM PHONGBAN AS PB
	EXCEPT
SELECT PB.MAPHONGBAN, PB.TENPHONGBAN 
FROM PHONGBAN AS PB, NHANVIEN AS NV
WHERE PB.MAPHONGBAN = NV.MAPHONGBAN AND NV.MANHANVIEN IN (SELECT MANHANVIEN FROM PHANCONG)

-- Yêu cầu 10: Đưa ra mã dự án, tên dự án có nhân viên là trưởng phòng tham gia <><><>
SELECT DA.MADUAN, DA.TENDUAN
FROM PHANCONG AS PC , DUAN AS DA
WHERE PC.MADUAN = DA.MADUAN AND PC.MANHANVIEN NOT IN (SELECT MATRUONGPHONG FROM PHONGBAN) 
GROUP BY DA.MADUAN, DA.TENDUAN
-- Yêu cầu 11: Tính tổng số giờ tham gia dự án của các nhân viên là trưởng phòng theo từng dự án
-- Yêu cầu 12: Tính tổng số thân nhân của mỗi nhân viên là trưởng phòng

-- Yêu cầu 13: Đưa ra mã phòng ban, tên phòng ban có nhân viên chưa tham gia dự án

/*_________________________________________________________________________________________________________________________________*/
/*____________________________________________________[2-11-2018]__________________________________________________________________*/
/*_________________________________________________________________________________________________________________________________*/
-- Tạo thủ tục đưa ra thông tin về nhân viên tham gia dự án có phòng ban có tên là gì đó, thông tin đưa ra gồm mã nhân viên, họ tên nhân viên, tên dự án và số giờ tham gia dự án
CREATE PROCEDURE SP_NHANVIENPHONGBAN_SELECT
	@TENPHONGBAN NVARCHAR(20)
AS
BEGIN
	SELECT NV.MANHANVIEN, NV.HOVATEN, DA.TENDUAN, PC.SOGIO
	FROM NHANVIEN AS NV, PHONGBAN AS PB, PHANCONG AS PC, DUAN AS DA
	WHERE PB.TENPHONGBAN = @TENPHONGBAN AND NV.MAPHONGBAN = PB.MAPHONGBAN AND PC.MANHANVIEN = NV.MANHANVIEN AND DA.MADUAN = PC.MADUAN
END
GO
[dbo].[SP_NHANVIENPHONGBAN_SELECT] N'Hành Chính'
-- Tạo hàm thống kê tổng số giờ tham gia dự án theo từng nhân viên trong phòng ban có tên là gì đó
ALTER FUNCTION THONGKE_SOGIO(@TENPHONGBAN NVARCHAR(50))
	RETURNS TABLE
AS
RETURN(
	SELECT NV.MANHANVIEN, NV.HOVATEN, SUM(PC.SOGIO)
	FROM PHANCONG AS PC, NHANVIEN AS NV, PHONGBAN AS PB
	WHERE PB.TENPHONGBAN = @TENPHONGBAN AND NV.MAPHONGBAN = PB.MAPHONGBAN AND NV.MANHANVIEN = PC.MANHANVIEN  
	GROUP BY NV.MANHANVIEN, NV.HOVATEN
)
-- Gọi function
SELECT * FROM dbo.THONGKE_SOGIO(N'Hành Chính')

/*_________________________________________________________________________________________________________________________________*/
/*____________________________________________________[14-11-2018]__________________________________________________________________*/
/*_________________________________________________________________________________________________________________________________*/
---------------------------------------------TRIGGER-------------------------------------
-- Trigger không có tham số đầu vào, chỉ có tham số nội tại
-- Lời gọi khác thủ tục và hàm
-- Trigger tự động gọi khi có các sự kiện kích (3 cái sau)
-- Insert, delete, update và 3 sự kiện phải thực hiện bằng câu lệnh  <nghĩa là - khi mở bảng ra để sửa trực tiếp thì không được>
------
-- Trong trigger có 2 bảng
-- inserted : lưu lại bảng vừa được thêm vào
-- deleted : lưu lại bảng vừa được cập nhật
-- Thao tác update sẽ lưu vào cả 2 bảng
-- Chỉ có phạm vi trong trigger và y hệt trigger gắn với bảng và gắn với on
------
-- Trigger dạng for after : sự kiện kích hoạt trigger (insert, update, delete) xảy ra xong mới kích hoạt tới các câu lệnh trong trigger
-- Trigger dạng instead of : bỏ qua sự kiện kích hoạt trigger , chỉ thực hiện câu lệnh trong trigger
	-- Chú ý: instead of nó không thay đổi dữ liệu trong bảng
-- Tạo trigger
-- Trigger nằm ở trong table -> trigger
--------------- Có 2 loại trigger
-- Trigger sửa đổi dữ liệu
-- Bật lại trigger : alter trigger
-- Tắt trigger: disable
--

CREATE TRIGGER TRIG_THEMNV ON NHANVIEN FOR
INSERT 
AS
BEGIN
	DECLARE @MANHANVIEN INT
	SELECT * FROM INSERTED
	PRINT N'Mã nhân viên vừa thêm à: '
END
GO
-- Gọi trigger --
INSERT INTO NHANVIEN(MANHANVIEN, HOVATEN)
VALUES(23, N'Nguyễn Hữu Hiếu')
GO
-- Tạo trigger cho sự kiện insert cho sự kiện vừa thêm, vừa sửa và in ra dữ liệu cũ, dữ liệu mới
ALTER TRIGGER TRIG_THEMNV ON NHANVIEN FOR
INSERT
AS
BEGIN
	DECLARE @MANHANVIEN INT, @HOVATEN NVARCHAR(50)
	SELECT @MANHANVIEN FROM INSERTED
	PRINT N'Mã nhân viên vừa thêm à: '
	SELECT
END
GO
-- Tạo trigger update - cho 1 bảng

-- Tạo trigger xóa nhân viên, thông báo mã nhân viên và họ tên nhân viên vừa xóa - cho 1 bảng\

-- Instead of : xóa nhân viên ở nhiều bảng - Chú ý: Xóa ngược lại theo thứ tự tạo bảng
ALTER TRIGGER TRIG_XOANV ON NHANVIEN INSTEAD OF
DELETE
AS
DECLARE @MANHANVIEN INT 
BEGIN 
	SELECT @MANHANVIEN = MANHANVIEN FROM DELETED

	DELETE THANNHAN WHERE MANHANVIEN = @MANHANVIEN

	DELETE PHANCONG WHERE MANHANVIEN = @MANHANVIEN

	DELETE NHANVIEN WHERE MANHANVIEN = @MANHANVIEN

	UPDATE NHANVIEN 
	SET MAGIAMSAT = NULL
	WHERE MAGIAMSAT = @MANHANVIEN

	UPDATE PHONGBAN 
	SET MATRUONGPHONG = NULL 
	WHERE MATRUONGPHONG = @MANHANVIEN

	PRINT N'Xóa thành công'
END

DELETE NHANVIEN WHERE MANHANVIEN = 2
----Các yêu cầu về trigger
-- For delete, update, insert - các bảng tạm inserted, updated
-- instead of delete, update, insert
-- Bài tập về nhà
-- 1. Viết trigger cập nhật tự động trườn tổng số nhân viên trong bảng phòng ban khi có sự kiện - thêm, xóa, đổi phòng cho nhân viên 
-- 2. Viết trigger - Tạo trigger để tính số lượng nhân viên dưới quyền theo từng nhân viên là người giám sát - trực tiếp, gián tiến <theo cây>




/*_________________________________________________________________________________________________________________________________*/
/*____________________________________________________[16-11-2018]_________________________________________________________________*/
/*_________________________________________________________________________________________________________________________________*/

-- EX 1. Insert thêm 1 cột dữ liệu là tổng số nhân viên vào từng phòng ban
ALTER TABLE PHONGBAN ADD TONGSONHANVIEN INT
GO
/*
-- EX 2. Cập nhật cột dữ liệu tổng số nhân viên cho từng phòng ban
	- Bước 1: Lấy ra cột mã phòng ban của từng phòng ban trong mệnh đề where
	- Bước 2: Count giá trị
	- Bước 3: Gán vào bảng phòng ban
	
*/
CREATE TRIGGER TRIG_TONGNHANVIEN ON PHONGBAN
FOR INSERT, UPDATE
AS
	DECLARE @MAPHONGBAN INT, @TONG INT
BEGIN
	SELECT 
	FROM PHONGBAN AS PB
	WHERE PB.MAPHONGBAN = NV.MAPHONGBAN IN (
		SELECT NV.MAPHONGBAN, COUNT (DISTINCT NV.MANHANVIEN)
		FROM NHANVIEN AS NV
		GROUP BY NV.MAPHONGBAN)
	 
END
GO

-- EX 3. Tạo Trigger để cập nhập số nhân viên khi có sự kiện thêm, sửa nhân viên <TH: 1 người, nhiều người, chuyển cả phòng A -> B>
ALTER TRIGGER TRIG_CAPNHAT ON NHANVIEN
FOR INSERT, UPDATE
AS 
	DECLARE @MAPHONGBAN INT
BEGIN
	SELECT @MAPHONGBAN = MAPHONGBAN FROM inserted
	UPDATE PHONGBAN
	SET TONGSONHANVIEN = (SELECT COUNT(MANHANVIEN) FROM NHANVIEN WHERE MAPHONGBAN = @MAPHONGBAN)
	WHERE MAPHONGBAN = @MAPHONGBAN

	SELECT @MAPHONGBAN = MAPHONGBAN FROM deleted
	UPDATE PHONGBAN
	SET TONGSONHANVIEN = (SELECT COUNT(MANHANVIEN) FROM NHANVIEN WHERE MAPHONGBAN = @MAPHONGBAN)
	WHERE MAPHONGBAN = @MAPHONGBAN

	SELECT * FROM PHONGBAN
END
GO
INSERT INTO NHANVIEN(MANHANVIEN, HOVATEN, MAPHONGBAN)
VALUES(25, N'Nguyễn Hữu Hiếu', 2)

-- INSERT nhiều giá trị
insert into PHONGBAN (MAPHONGBAN, TENPHONGBAN)
values(16, N'HC'),(17, N'CC')


-- EX 4. Tạo Trigger để cập nhật số nhân viên khi có sự kiện xóa nhân viên 

-----------------------------------CON TRỎ--------------------------------------------
-- Sử dụng con trỏ để duyệt từng bản ghi một rồi muốn làm gì thì làm
-- Các bước sử dụng con trỏ
-- 1. Tạo
-- 2. OPEN , dùng xong CLOSE
-- Truy xuất và duyệt con trỏ: next, fist pre

-- Tham số hệ thống @@FETCH_STATUS = 0 
-- @@CURSOR



DECLARE PUB_CURSOR CURSOR SCROLL 
FOR SELECT * FROM NHANVIEN ORDER BY MAPHONGBAN
GO

OPEN PUB_CURSOR
FETCH FIRST FROM PUB_CURSOR
WHILE @@FETCH_STATUS = 0
BEGIN 
	FETCH NEXT FROM PUB_CURSOR
END
GO
-- Tạo 1 thủ tục sử dụng con trỏ để đánh số báo danh tự động cho các nhân viên tham gia thi chứng chỉ ngoại ngữ
-- Các nhân viên lưu trong bảng danh sách gồm các trường: Số báo danh, mã nhân viên, họ tên, ngày sinh. Trong đó - SBD định dạng như sau: SBD+Số thứ tự

CREATE PROCEDURE SP_DANHSACH_TAOBANG
AS
BEGIN
	CREATE TABLE DANHSACHTHI(SOBAODANH CHAR(10), MANHANVIEN INT, HOVATEN NVARCHAR(50), NGAYSINH DATE)
	DECLARE @MANHANVIEN INT, @HOVATEN NVARCHAR(50), @NGAYSINH DATE, @I INT
	SET @I = 1
	--
	DECLARE CUR_POINT CURSOR FORWARD_ONLY FOR SELECT MANHANVIEN, HOVATEN, NGAYSINH FROM NHANVIEN
	--
	OPEN CUR_POINT
	-- 
	WHILE 0=0 -- @@FETCH_STATUS = 0
	BEGIN 
		FETCH NEXT FROM CUR_POINT
			INTO @MANHANVIEN, @HOVATEN, @NGAYSINH 
			IF @@FETCH_STATUS <> 0
				BREAK
			INSERT INTO DANHSACHTHI (SOBAODANH, MANHANVIEN, HOVATEN, NGAYSINH)
			VALUES('SBD' + CONVERT(CHAR(7), @I), @MANHANVIEN, @HOVATEN, @NGAYSINH)
		SET @I = @I + 1
	END
	--
	CLOSE CUR_POINT
	DEALLOCATE CUR_POINT
END
--
DROP TABLE DANHSACHTHI
GO
SP_DANHSACH_TAOBANG
GO
SELECT * FROM DANHSACHTHI

-- Bài tập: Thêm trường tổng số giờ vào bảng dự án, sử dụng con trỏ cập nhật lại dữ liệu cho bảng số giờ



-- Cách 1: Dùng con trỏ duyệt từng bản ghi trong bảng dự án. Lấy mã dự án rồi count trong bảng phân công
-- Cách 2: Dùng con trỏ duyệt từng bản ghi trong bảng phân công lấy mã dự án - tổng số giờ rồi quay ra cập nhật lại bảng dự án
ALTER TABLE DUAN ADD TONGSOGIO INT
DECLARE @MADUAN INT, @TSG INT
DECLARE CONTRO CURSOR STATIC
FOR SELECT MADUAN, SUM(SOGIO)
	FROM PHANCONG
	GROUP BY MADUAN
--
OPEN CONTRO
FETCH FIRST FROM CONTRO INTO @MADUAN, @TSG
--
WHILE @@FETCH_STATUS = 0 -- Truy suất thành công tới con trỏ. Nếu là -1 thì là không thành công
	BEGIN
	-- UPDATE
		UPDATE DUAN 
		SET TONGSOGIO = @TSG
		WHERE MADUAN = @MADUAN
		PRINT 'CẬP NHẬT THÀNH CÔNG'
	-- POITER.NEXT
	FETCH NEXT FROM CONTRO INTO @MADUAN, @TSG
	END
CLOSE CONTRO
DEALLOCATE CONTRO

SELECT * FROM DUAN
-------------------------------TẠO KHUNG NHÌN VIEW--------------------------------