--16.	In ra danh sách các s?n ph?m (MASP,TENSP) không bán ???c trong n?m 2006.
SELECT S.MASP, TENSP
FROM SANPHAM S
WHERE S.MASP NOT IN(SELECT C.MASP 
FROM CTHD C INNER JOIN HOADON H
ON C.SOHD = H.SOHD
WHERE YEAR(NGHD) = 2006)
--17.	In ra danh sách các s?n ph?m (MASP,TENSP) do “Trung Quoc” s?n xu?t không bán ???c trong n?m 2006.
SELECT S.MASP, TENSP
FROM SANPHAM S
WHERE NUOCSX = 'TRUNG QUOC' AND S.MASP NOT IN(SELECT C.MASP 
FROM CTHD C INNER JOIN HOADON H
ON C.SOHD = H.SOHD
WHERE YEAR(NGHD) = 2006)
--18.	Tìm s? hóa ??n ?ã mua t?t c? các s?n ph?m do Singapore s?n xu?t.
SELECT H.SOHD 
FROM HOADON H
WHERE NOT EXISTS(SELECT *
FROM SANPHAM S
WHERE NUOCSX = 'SINGAPORE'
AND NOT EXISTS(SELECT * 
FROM CTHD C
WHERE C.SOHD = H.SOHD
AND C.MASP = S.MASP))

--19.	Tìm s? hóa ??n trong n?m 2006 ?ã mua ít nh?t t?t c? các s?n ph?m do Singapore s?n xu?t.
SELECT H.SOHD 
FROM HOADON H
WHERE YEAR(NGHD) = 2006 AND NOT EXISTS(SELECT *
FROM SANPHAM S
WHERE NUOCSX = 'SINGAPORE'
AND NOT EXISTS(SELECT * 
FROM CTHD C
WHERE C.SOHD = H.SOHD
AND C.MASP = S.MASP))
--20.	Có bao nhiêu hóa ??n không ph?i c?a khách hàng ??ng ký thành viên mua?
SELECT COUNT(*) as 'S? hóa ??n không ph?i c?a khách hàng ??ng ký thành viên mua'
FROM HOADON H
WHERE MAKH NOT IN(SELECT MAKH
FROM KHACHHANG K 
WHERE K.MAKH = H.MAKH)
--21.	Có bao nhiêu s?n ph?m khác nhau ???c bán ra trong n?m 2006.
SELECT COUNT(DISTINCT MASP) as 'S? s?n ph?m khác nhau ???c bán ra trong n?m 2006'
FROM CTHD C INNER JOIN HOADON H
ON C.SOHD = H.SOHD
WHERE YEAR(NGHD) = 2006
--22.	Cho bi?t tr? giá hóa ??n cao nh?t, th?p nh?t là bao nhiêu ?
SELECT MAX(TRIGIA) AS 'giá tr? cao nh?t', MIN(TRIGIA) AS 'giá tr? th?p nh?t'
FROM HOADON
--23.	Tr? giá trung bình c?a t?t c? các hóa ??n ???c bán ra trong n?m 2006 là bao nhiêu?
SELECT AVG(TRIGIA) as 'Tr? giá trung bình'
FROM HOADON
--24.	Tính doanh thu bán hàng trong n?m 2006.
SELECT SUM(TRIGIA) AS DOANHTHU
FROM HOADON
WHERE YEAR(NGHD) = 2006
--25.	Tìm s? hóa ??n có tr? giá cao nh?t trong n?m 2006.
SELECT SOHD
FROM HOADON
WHERE TRIGIA = (SELECT MAX(TRIGIA)
FROM HOADON)
--26.	Tìm h? tên khách hàng ?ã mua hóa ??n có tr? giá cao nh?t trong n?m 2006.
SELECT HOTEN
FROM KHACHHANG K INNER JOIN HOADON H
ON K.MAKH = H.MAKH 
AND SOHD = (SELECT SOHD
			FROM HOADON
			WHERE TRIGIA = (SELECT MAX(TRIGIA)
							FROM HOADON))
--27.	In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh s? cao nh?t.
SELECT TOP 3 MAKH, HOTEN
FROM KHACHHANG
ORDER BY DOANHSO DESC
--28.	In ra danh sách các s?n ph?m (MASP, TENSP) có giá bán b?ng 1 trong 3 m?c giá cao nh?t.
SELECT MASP, TENSP
FROM SANPHAM
WHERE GIA IN (SELECT DISTINCT TOP 3 GIA
			  FROM SANPHAM
			  ORDER BY GIA DESC)
--29.	In ra danh sách các s?n ph?m (MASP, TENSP) do “Thai Lan” s?n xu?t có giá b?ng 1 trong 3 m?c giá cao nh?t (c?a t?t c? các s?n ph?m).
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'THAI LAN' AND GIA IN (SELECT DISTINCT TOP 3 GIA
FROM SANPHAM
ORDER BY GIA DESC)
--30.	In ra danh sách các s?n ph?m (MASP, TENSP) do “Trung Quoc” s?n xu?t có giá b?ng 1 trong 3 m?c giá cao nh?t (c?a s?n ph?m do “Trung Quoc” s?n xu?t).
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'TRUNG QUOC' AND GIA IN (SELECT DISTINCT TOP 3 GIA
FROM SANPHAM
ORDER BY GIA DESC)
--31.	* In ra danh sách 3 khách hàng có doanh s? cao nh?t (s?p x?p theo ki?u x?p h?ng).
SELECT TOP 3 MAKH, HOTEN
FROM KHACHHANG
ORDER BY DOANHSO DESC
--32.	Tính t?ng s? s?n ph?m do “Trung Quoc” s?n xu?t.
SELECT COUNT(DISTINCT MASP) as 'T?ng s? s?n ph?m'
FROM SANPHAM
WHERE NUOCSX = 'TRUNG QUOC'
--33.	Tính t?ng s? s?n ph?m c?a t?ng n??c s?n xu?t.
SELECT NUOCSX, COUNT(DISTINCT MASP) AS 'T?ng s? s?n ph?m'
FROM SANPHAM
GROUP BY NUOCSX
--34.	V?i t?ng n??c s?n xu?t, tìm giá bán cao nh?t, th?p nh?t, trung bình c?a các s?n ph?m.
SELECT NUOCSX, MAX(GIA) AS 'giá bán cao nh?t', MIN(GIA) AS 'giá bán th?p nh?t', AVG(GIA) AS 'giá bán trung bình'
FROM SANPHAM
GROUP BY NUOCSX
--35.	Tính doanh thu bán hàng m?i ngày.
SELECT NGHD, SUM(TRIGIA) AS DOANHTHU
FROM HOADON
GROUP BY NGHD