--Cau 1
CREATE TABLE VATU 
(
	MaVT varchar(4) primary key,
	TenTV nvarchar(30),
	DVTinh money,
	SLCon int
);

CREATE TABLE HDBAN
(
	MaHD varchar(4) primary key,
	NgayXuat date,
	HoTenKhach nvarchar(30)
);

CREATE TABLE HANGXUAT
(
	MaHD varchar(4) primary key,
	MaVT varchar(4),
	DonGia money,
	SLBan int 
)

--Cau 2
select top 1 (slban* dongia) as 'tong tien ', mahd 
 from  hangxuat
 order by [tong tien ] 
 
--Cau 3
CREATE FUNCTION f3 (
    @MAHD varchar(10)
)
RETURNS TABLE
AS
RETURN
    SELECT 
        HX.MAHD,
        HD.NGAYXUAT,
        HD.MAVT,
        HX.DONGIA,
        HX.SLBAN,  
        CASE
            WHEN WEEKDAY(HD.NGAYXUAT) = 0 THEN N'Th? hai'            
            WHEN WEEKDAY(HD.NGAYXUAT) = 1 THEN N'Th? ba'
            WHEN WEEKDAY(HD.NGAYXUAT) = 2 THEN N'Th? t?'
            WHEN WEEKDAY(HD.NGAYXUAT) = 3 THEN N'Th? n?m'
            WHEN WEEKDAY(HD.NGAYXUAT) = 4 THEN N'Th? sáu'
            WHEN WEEKDAY(HD.NGAYXUAT) = 5 THEN N'Th? b?y'
            ELSE N'Ch? nh?t'
        END AS NGAYTHU
    FROM HANGXUAT HX
    INNER JOIN HDBAN HD ON HX.MAHD = HD.MAHD
    WHERE HX.MAHD = @MAHD;
--Cau 4
CREATE FUNCTION f3 (
    @MAHD varchar(10)
)
RETURNS TABLE
AS
RETURN
    SELECT 
        HX.MAHD,
        HD.NGAYXUAT,
        HD.MAVT,
        HX.DONGIA,
        HX.SLBAN,  
        CASE
            WHEN WEEKDAY(HD.NGAYXUAT) = 0 THEN N'Th? hai'            
            WHEN WEEKDAY(HD.NGAYXUAT) = 1 THEN N'Th? ba'
            WHEN WEEKDAY(HD.NGAYXUAT) = 2 THEN N'Th? t?'
            WHEN WEEKDAY(HD.NGAYXUAT) = 3 THEN N'Th? n?m'
            WHEN WEEKDAY(HD.NGAYXUAT) = 4 THEN N'Th? sáu'
            WHEN WEEKDAY(HD.NGAYXUAT) = 5 THEN N'Th? b?y'
            ELSE N'Ch? nh?t'
        END AS NGAYTHU
    FROM HANGXUAT HX
    INNER JOIN HDBAN HD ON HX.MAHD = HD.MAHD
    WHERE HX.MAHD = @MAHD;