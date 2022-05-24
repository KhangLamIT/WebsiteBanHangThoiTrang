USE MASTER
GO
CREATE DATABASE QuanLy_QuanAo
GO
USE QuanLy_QuanAo
GO
--------------------------------------------------- TẠO BẢNG ---------------------------------------------------
--BẢNG QUẢN TRỊ VIÊN
CREATE TABLE QUANTRIVIEN
(
	TenDangNhap VARCHAR(20),
	MatKhau VARCHAR(150),
	Quyen INT,
	CONSTRAINT PK_QuanTriVien PRIMARY KEY(TenDangNhap)
)
GO
--BẢNG KHÁCH HÀNG
CREATE TABLE KHACHHANG
(
	TenDangNhap VARCHAR(20),
	MatKhau VARCHAR(150),
	Hoten NVARCHAR(50),
	SoDT CHAR(20),
	Email VARCHAR(50),
	DiaChi NVARCHAR(100),
	GioiTinh NVARCHAR(5),
	CONSTRAINT PK_KhachHang PRIMARY KEY(TenDangNhap)
)
GO
--BẢNG LOẠI SẢN PHẨM
CREATE TABLE LOAISANPHAM
(
	MaLoai VARCHAR(20) not null,
	TenLoaiSP NVARCHAR(50),
	CONSTRAINT PK_LoaiSanPham PRIMARY KEY(MaLoai)
)
GO
--BẢNG SẢN PHẨM
CREATE TABLE SANPHAM
(
	MaSP CHAR(20) not null,
	TenSP NVARCHAR(100),
	GiaBan INT,
	GiaCu INT,
	MoTa NVARCHAR(MAX),
	HinhAnh VARCHAR(100),
	MaLoai VARCHAR(20)
	CONSTRAINT PK_SanPham PRIMARY KEY(MaSP)
)
GO
--BẢNG GIỎ HÀNG
CREATE TABLE GIOHANG
(
	TenDangNhapKhachHang VARCHAR(20),
	MaSP CHAR(20) not null,
	SoLuongSP INT,
	CONSTRAINT PK_GIOHANG PRIMARY KEY(MaSP,TenDangNhapKhachHang)
)
GO
--BẢNG ĐƠN HÀNG
CREATE TABLE DONHANG
(
	MaDonHang INT IDENTITY(1,1),
	TenDangNhapKhachHang VARCHAR(20),
	MaSP CHAR(20),
	SoLuong INT,
	TongTien FLOAT,
	NgayDatHang DATE,
	NgayGiaoHang DATE,
	TrangThai NVARCHAR(10),--đã giao hay chưa giao
	GhiChu NVARCHAR(50)
	PRIMARY KEY(MaDonHang)
)
GO
--------------------------------------------------- RÀNG BUỘC TOÀN VẸN ---------------------------------------------------
--TẠO RÀNG BUỘC CÓ TÊN LÀ UNI_SODT ĐỂ KIỂM TRA TÍNH DUY NHẤT CHO CỘT SODT
ALTER TABLE KHACHHANG
ADD CONSTRAINT UNI_SODT UNIQUE(SODT)
go
--TẠO RÀNG BUỘC CÓ TÊN LÀ UNI_EMAIL ĐỂ KIỂM TRA TÍNH DUY NHẤT CHO CỘT EMAIL
ALTER TABLE KHACHHANG
ADD CONSTRAINT UNI_EMAIL UNIQUE(EMAIL)

--------------------------------------------------- KHÓA NGOẠI ---------------------------------------------------
-- THUỘC TÍNH [TenDangNhapKhachHang] CỦA BẢNG [GIOHANG] 
-- THAM CHIẾU ĐẾN THUỘC TÍNH [TenDangNhap] CỦA BẢN [KHACHHANG]
ALTER TABLE SANPHAM
ADD CONSTRAINT FK_SANPHAM_LOAISANPHAM
FOREIGN KEY(MaLoai)
REFERENCES LOAISANPHAM(MaLoai)
GO

-- THUỘC TÍNH [TenDangNhapKhachHang] CỦA BẢNG [GIOHANG] 
-- THAM CHIẾU ĐẾN THUỘC TÍNH [TenDangNhap] CỦA BẢN [KHACHHANG]
ALTER TABLE GIOHANG
ADD CONSTRAINT FK_GIOHANG_KHACHHANG 
FOREIGN KEY(TenDangNhapKhachHang)
REFERENCES KHACHHANG(TenDangNhap)
GO
-- THUỘC TÍNH [MaSP] CỦA BẢNG [GIOHANG] 
-- THAM CHIẾU ĐẾN THUỘC TÍNH [MaSP] CỦA BẢN [SANPHAM]
ALTER TABLE GIOHANG
ADD CONSTRAINT FK_GIOHANG_SANPHAM
FOREIGN KEY(MaSP)
REFERENCES SANPHAM(MaSP)
GO
-- THUỘC TÍNH [TenDangNhapKhachHang] CỦA BẢNG [DONHANG] 
-- THAM CHIẾU ĐẾN THUỘC TÍNH [TenDangNhap] CỦA BẢN [KHACHHANG]
ALTER TABLE DONHANG
ADD CONSTRAINT FK_DONHANG_KHACHHANG 
FOREIGN KEY(TenDangNhapKhachHang)
REFERENCES KHACHHANG(TenDangNhap)
GO
-- THUỘC TÍNH [MaSP] CỦA BẢNG [DONHANG] 
-- THAM CHIẾU ĐẾN THUỘC TÍNH [MaSP] CỦA BẢN [SANPHAM]
ALTER TABLE DONHANG
ADD CONSTRAINT FK_DONHANG_SANPHAM
FOREIGN KEY(MaSP)
REFERENCES SANPHAM(MaSP)
--------------------------------------------------- NHẬP DỮ LIỆU ---------------------------------------------------
--NHẬP DỮ LIỆU BẢNG QUANTRIVIEN
INSERT INTO QUANTRIVIEN(TenDangNhap,MatKhau,Quyen)
VALUES('Admin','123',1)
GO

--NHẬP DỮ LIỆU BẢNG KHACHHANG
INSERT INTO KHACHHANG(TenDangNhap,MatKhau,Hoten,SoDT,Email,DiaChi,GioiTinh)
VALUES('Long','123',N'Đinh Thành Long','0123456789','dinhthanhlong@gmail.com',N'Đắk Lắk',N'Nam')
INSERT INTO KHACHHANG(TenDangNhap,MatKhau,Hoten,SoDT,Email,DiaChi,GioiTinh)
VALUES('Khang','123',N'Lâm Chí Khang','0342468501','Khanglam517@gmail.com', N'Sóc Trang', N'Nam')
GO

--NHẬP DỮ LIỆU BẢNG LOAISANPHAM
INSERT INTO LOAISANPHAM
VALUES('Ao',N'Áo'),
('Quan',N'Quần')
GO



--NHẬP DỮ LIỆU BẢNG SANPHAM
--Sản phẩm Áo
INSERT INTO SANPHAM(MaSP,TenSP,GiaBan,GiaCu,MoTa,HinhAnh,MaLoai)
VALUES('TS18155N',N'ÁO T-SHIRT - TS18155N',124500,249000, N'Chất liệu: 98% Cotton, 2% Spandex. Áo T-shirt, kiểu dáng Body Fit thể thao, trẻ trung, năng động. Tone màu tím thời trang, dễ phối đồ. Chất liệu cotton nhẹ, thoải mái, thoáng mát.','ts18155n.jpg','Ao'),
('TSD81527',N'ÁO T-SHIRT DÀI TAY - TSD81527',180000,360000,N'Chất liệu: 98% Cotton, 2% Spandex. Áo T-shirt dài tay chui đầu cổ tròn nam tính. Thiết kế thoải mái theo form dáng Relax Fit giúp chàng trai dễ dàng vận động. Gam màu trẻ trung, năng động, hiện đại.','tsd81527.jpg','Ao'),
('TSD81291-CO',N'ÁO TSHIRT - TSD81291-CO',160000,330000,N'Chất liệu: 98% Cotton, 2% Spandex. Áo T-shirt dài tay chui đầu cổ tròn nam tính. Thiết kế thoải mái theo form dáng Relax Fit giúp chàng trai dễ dàng vận động. Gam màu trẻ trung, năng động, hiện đại.','tsd81291.jpg','Ao'),
('TSD81508',N'ÁO NỈ CHUI ĐẦU DÀI TAY - TSD81508',175000,355000,N'Chất liệu: 98% Cotton, 2% Spandex. Áo T-shirt dài tay chui đầu cổ tròn nam tính. Thiết kế thoải mái theo form dáng Relax Fit giúp chàng trai dễ dàng vận động. Gam màu trẻ trung, năng động, hiện đại.','tsd81508.jpg','Ao'),
('TSD81528',N'ÁO T-SHIRT DÀI TAY - TSD81528',180000,360000,N'Chất liệu: 98% Cotton, 2% Spandex. Áo T-shirt dài tay chui đầu cổ tròn nam tính. Thiết kế thoải mái theo form dáng Relax Fit giúp chàng trai dễ dàng vận động. Gam màu trẻ trung, năng động, hiện đại.','tsd81528.jpg','Ao'),
('TSD81511',N'ÁO TSHIRT - TSD81511',210000,410000,N'Chất liệu: 98% Cotton, 2% Spandex. Áo T-shirt dài tay chui đầu cổ tròn nam tính. Thiết kế thoải mái theo form dáng Relax Fit giúp chàng trai dễ dàng vận động. Gam màu trẻ trung, năng động, hiện đại.','tsd81511.jpg','Ao'),
('TS65258',N'ÁO T-SHIRT - TS65258',170000,345000,N'Chất liệu: 98% Cotton, 2% Spandex. Áo T-shirt dài tay chui đầu cổ tròn nam tính. Thiết kế thoải mái theo form dáng Relax Fit giúp chàng trai dễ dàng vận động. Gam màu trẻ trung, năng động, hiện đại.','ts65258-1.jpg','Ao'),
('ALD80501',N'ÁO LEN NAM OWEN CAO CẤP - ALD80501',170000,345000,N'Chất liệu: 98% Cotton, 2% Spandex. Áo T-shirt dài tay chui đầu cổ tròn nam tính. Thiết kế thoải mái theo form dáng Relax Fit giúp chàng trai dễ dàng vận động. Gam màu trẻ trung, năng động, hiện đại.','ALD80501.jpg','Ao'),
('ALD65167',N'ÁO LEN NAM OWEN CAO CẤP - ALD65167',150000,325000,N'Chất liệu: 98% Cotton, 2% Spandex. Áo T-shirt dài tay chui đầu cổ tròn nam tính. Thiết kế thoải mái theo form dáng Relax Fit giúp chàng trai dễ dàng vận động. Gam màu trẻ trung, năng động, hiện đại.','ALD65167.jpg','Ao'),
('ALD80471',N'ÁO LEN - ALD80471',212500,425000,N'Chất liệu: 98% Cotton, 2% Spandex. Áo T-shirt dài tay chui đầu cổ tròn nam tính. Thiết kế thoải mái theo form dáng Relax Fit giúp chàng trai dễ dàng vận động. Gam màu trẻ trung, năng động, hiện đại.','ALD80471.jpg','Ao'),
('ALD80487',N'ÁO LEN - ALD80487',222500,445000,N'Chất liệu: 98% Cotton, 2% Spandex. Áo T-shirt dài tay chui đầu cổ tròn nam tính. Thiết kế thoải mái theo form dáng Relax Fit giúp chàng trai dễ dàng vận động. Gam màu trẻ trung, năng động, hiện đại.','ald80487-3.jpg','Ao')
--Sản phẩm Quần
INSERT INTO SANPHAM(MaSP,TenSP,GiaBan,GiaCu,MoTa,HinhAnh,MaLoai)
VALUES('QJDT6476-ME',N'QUẦN JEANS - QJDT6476-ME', 302500, 605000, N'Chất liệu: 99% Cotton, 1% Spandex. Chất liệu vải Cotton pha Spandex co dãn, đàn hồi tốt. Thiết kế theo form dáng Slim Fit mạnh mẽ, cá tính. Gam màu tối nam tính, trẻ trung, hiện đại dễ phối đồ.','QJDT6476-ME.jpg','Quan'),
('QJDT1419',N'QUẦN JEANS - QJDT1419', 282500, 565000, N'Chất liệu: 99% Cotton, 1% Spandex. Chất liệu vải Cotton pha Spandex co dãn, đàn hồi tốt. Thiết kế theo form dáng Slim Fit mạnh mẽ, cá tính. Gam màu tối nam tính, trẻ trung, hiện đại dễ phối đồ.','QJDT1419.jpg','Quan'),
('QKSL6429',N'QUẦN KHAKI - QKSL6429', 237500, 456000, N'Chất liệu: 99% Cotton, 1% Spandex. Chất liệu vải Cotton pha Spandex co dãn, đàn hồi tốt. Thiết kế theo form dáng Slim Fit mạnh mẽ, cá tính. Gam màu tối nam tính, trẻ trung, hiện đại dễ phối đồ.','qksl6429-re_1_.jpg','Quan'),
('QKSL625',N'QUẦN KHAKI - QKSL6205', 257500, 515000, N'Chất liệu: 99% Cotton, 1% Spandex. Chất liệu vải Cotton pha Spandex co dãn, đàn hồi tốt. Thiết kế theo form dáng Slim Fit mạnh mẽ, cá tính. Gam màu tối nam tính, trẻ trung, hiện đại dễ phối đồ.','QKSL6205.jpg','Quan'),
('QKSL17949',N'QUẦN KHAKI - QKSL17949', 267500, 525000, N'Chất liệu: 99% Cotton, 1% Spandex. Chất liệu vải Cotton pha Spandex co dãn, đàn hồi tốt. Thiết kế theo form dáng Slim Fit mạnh mẽ, cá tính. Gam màu tối nam tính, trẻ trung, hiện đại dễ phối đồ.','QKSL17949.jpg','Quan'),
('SW20243',N'QUẦN SHORT - SW20243', 267500, 340000, N'Chất liệu: 99% Cotton, 1% Spandex. Chất liệu vải Cotton pha Spandex co dãn, đàn hồi tốt. Thiết kế theo form dáng Slim Fit mạnh mẽ, cá tính. Gam màu tối nam tính, trẻ trung, hiện đại dễ phối đồ.','SW20243.jpg','Quan'),
('QJDT1428',N'QUẦN JEANS - QJDT1419', 282500, 565000, N'Chất liệu: 99% Cotton, 1% Spandex. Chất liệu vải Cotton pha Spandex co dãn, đàn hồi tốt. Thiết kế theo form dáng Slim Fit mạnh mẽ, cá tính. Gam màu tối nam tính, trẻ trung, hiện đại dễ phối đồ.','QJDT1419.jpg','Quan'),
('QKSL6205',N'QUẦN KHAKI - QKSL6205', 257500, 515000, N'Chất liệu: 99% Cotton, 1% Spandex. Chất liệu vải Cotton pha Spandex co dãn, đàn hồi tốt. Thiết kế theo form dáng Slim Fit mạnh mẽ, cá tính. Gam màu tối nam tính, trẻ trung, hiện đại dễ phối đồ.','QKSL6205.jpg','Quan'),
('QJDT6476',N'QUẦN JEANS - QJDT6476-ME', 302500, 605000, N'Chất liệu: 99% Cotton, 1% Spandex. Chất liệu vải Cotton pha Spandex co dãn, đàn hồi tốt. Thiết kế theo form dáng Slim Fit mạnh mẽ, cá tính. Gam màu tối nam tính, trẻ trung, hiện đại dễ phối đồ.','QJDT6476-ME.jpg','Quan')
GO

--NHẬP DỮ LIỆU BẢNG GIOHANG
INSERT INTO GIOHANG(TenDangNhapKhachHang,MaSP,SoLuongSP)
VALUES('Khang','QJDT6476-ME', 2)
GO


--------------------------NHÁP-------------------
SELECT * FROM dbo.GIOHANG
SELECT * FROM dbo.DONHANG
DELETE dbo.DONHANG WHERE TenDangNhapKhachHang = 'khang271'