--16.	In ra danh s�ch c�c s?n ph?m (MASP,TENSP) kh�ng b�n ???c trong n?m 2006.
SELECT S.MASP, TENSP
FROM SANPHAM S
WHERE S.MASP NOT IN(SELECT C.MASP 
FROM CTHD C INNER JOIN HOADON H
ON C.SOHD = H.SOHD
WHERE YEAR(NGHD) = 2006)
--17.	In ra danh s�ch c�c s?n ph?m (MASP,TENSP) do �Trung Quoc� s?n xu?t kh�ng b�n ???c trong n?m 2006.
SELECT S.MASP, TENSP
FROM SANPHAM S
WHERE NUOCSX = 'TRUNG QUOC' AND S.MASP NOT IN(SELECT C.MASP 
FROM CTHD C INNER JOIN HOADON H
ON C.SOHD = H.SOHD
WHERE YEAR(NGHD) = 2006)
--18.	T�m s? h�a ??n ?� mua t?t c? c�c s?n ph?m do Singapore s?n xu?t.
SELECT H.SOHD 
FROM HOADON H
WHERE NOT EXISTS(SELECT *
FROM SANPHAM S
WHERE NUOCSX = 'SINGAPORE'
AND NOT EXISTS(SELECT * 
FROM CTHD C
WHERE C.SOHD = H.SOHD
AND C.MASP = S.MASP))

--19.	T�m s? h�a ??n trong n?m 2006 ?� mua �t nh?t t?t c? c�c s?n ph?m do Singapore s?n xu?t.
SELECT H.SOHD 
FROM HOADON H
WHERE YEAR(NGHD) = 2006 AND NOT EXISTS(SELECT *
FROM SANPHAM S
WHERE NUOCSX = 'SINGAPORE'
AND NOT EXISTS(SELECT * 
FROM CTHD C
WHERE C.SOHD = H.SOHD
AND C.MASP = S.MASP))
--20.	C� bao nhi�u h�a ??n kh�ng ph?i c?a kh�ch h�ng ??ng k� th�nh vi�n mua?
SELECT COUNT(*) as 'S? h�a ??n kh�ng ph?i c?a kh�ch h�ng ??ng k� th�nh vi�n mua'
FROM HOADON H
WHERE MAKH NOT IN(SELECT MAKH
FROM KHACHHANG K 
WHERE K.MAKH = H.MAKH)
--21.	C� bao nhi�u s?n ph?m kh�c nhau ???c b�n ra trong n?m 2006.
SELECT COUNT(DISTINCT MASP) as 'S? s?n ph?m kh�c nhau ???c b�n ra trong n?m 2006'
FROM CTHD C INNER JOIN HOADON H
ON C.SOHD = H.SOHD
WHERE YEAR(NGHD) = 2006
--22.	Cho bi?t tr? gi� h�a ??n cao nh?t, th?p nh?t l� bao nhi�u ?
SELECT MAX(TRIGIA) AS 'gi� tr? cao nh?t', MIN(TRIGIA) AS 'gi� tr? th?p nh?t'
FROM HOADON
--23.	Tr? gi� trung b�nh c?a t?t c? c�c h�a ??n ???c b�n ra trong n?m 2006 l� bao nhi�u?
SELECT AVG(TRIGIA) as 'Tr? gi� trung b�nh'
FROM HOADON
--24.	T�nh doanh thu b�n h�ng trong n?m 2006.
SELECT SUM(TRIGIA) AS DOANHTHU
FROM HOADON
WHERE YEAR(NGHD) = 2006
--25.	T�m s? h�a ??n c� tr? gi� cao nh?t trong n?m 2006.
SELECT SOHD
FROM HOADON
WHERE TRIGIA = (SELECT MAX(TRIGIA)
FROM HOADON)
--26.	T�m h? t�n kh�ch h�ng ?� mua h�a ??n c� tr? gi� cao nh?t trong n?m 2006.
SELECT HOTEN
FROM KHACHHANG K INNER JOIN HOADON H
ON K.MAKH = H.MAKH 
AND SOHD = (SELECT SOHD
			FROM HOADON
			WHERE TRIGIA = (SELECT MAX(TRIGIA)
							FROM HOADON))
--27.	In ra danh s�ch 3 kh�ch h�ng (MAKH, HOTEN) c� doanh s? cao nh?t.
SELECT TOP 3 MAKH, HOTEN
FROM KHACHHANG
ORDER BY DOANHSO DESC
--28.	In ra danh s�ch c�c s?n ph?m (MASP, TENSP) c� gi� b�n b?ng 1 trong 3 m?c gi� cao nh?t.
SELECT MASP, TENSP
FROM SANPHAM
WHERE GIA IN (SELECT DISTINCT TOP 3 GIA
			  FROM SANPHAM
			  ORDER BY GIA DESC)
--29.	In ra danh s�ch c�c s?n ph?m (MASP, TENSP) do �Thai Lan� s?n xu?t c� gi� b?ng 1 trong 3 m?c gi� cao nh?t (c?a t?t c? c�c s?n ph?m).
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'THAI LAN' AND GIA IN (SELECT DISTINCT TOP 3 GIA
FROM SANPHAM
ORDER BY GIA DESC)
--30.	In ra danh s�ch c�c s?n ph?m (MASP, TENSP) do �Trung Quoc� s?n xu?t c� gi� b?ng 1 trong 3 m?c gi� cao nh?t (c?a s?n ph?m do �Trung Quoc� s?n xu?t).
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'TRUNG QUOC' AND GIA IN (SELECT DISTINCT TOP 3 GIA
FROM SANPHAM
ORDER BY GIA DESC)
--31.	* In ra danh s�ch 3 kh�ch h�ng c� doanh s? cao nh?t (s?p x?p theo ki?u x?p h?ng).
SELECT TOP 3 MAKH, HOTEN
FROM KHACHHANG
ORDER BY DOANHSO DESC
--32.	T�nh t?ng s? s?n ph?m do �Trung Quoc� s?n xu?t.
SELECT COUNT(DISTINCT MASP) as 'T?ng s? s?n ph?m'
FROM SANPHAM
WHERE NUOCSX = 'TRUNG QUOC'
--33.	T�nh t?ng s? s?n ph?m c?a t?ng n??c s?n xu?t.
SELECT NUOCSX, COUNT(DISTINCT MASP) AS 'T?ng s? s?n ph?m'
FROM SANPHAM
GROUP BY NUOCSX
--34.	V?i t?ng n??c s?n xu?t, t�m gi� b�n cao nh?t, th?p nh?t, trung b�nh c?a c�c s?n ph?m.
SELECT NUOCSX, MAX(GIA) AS 'gi� b�n cao nh?t', MIN(GIA) AS 'gi� b�n th?p nh?t', AVG(GIA) AS 'gi� b�n trung b�nh'
FROM SANPHAM
GROUP BY NUOCSX
--35.	T�nh doanh thu b�n h�ng m?i ng�y.
SELECT NGHD, SUM(TRIGIA) AS DOANHTHU
FROM HOADON
GROUP BY NGHD