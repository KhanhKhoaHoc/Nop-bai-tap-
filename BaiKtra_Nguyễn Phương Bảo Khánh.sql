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
