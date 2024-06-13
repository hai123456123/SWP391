Drop database SWP391
create database SWP391
USE SWP391;

-- T?o b?ng Brand
CREATE TABLE Brand (
    bid INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50) NOT NULL
);

-- T?o b?ng Category
CREATE TABLE Category (
    cid INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50) NOT NULL
);

-- T?o b?ng Product
CREATE TABLE Product (
    id INT IDENTITY(1,1) PRIMARY KEY,
    cid INT NOT NULL,
    bid INT NOT NULL,
    name NVARCHAR(100) NOT NULL,
    image NVARCHAR(255),
    price FLOAT(10) NOT NULL,
    description NVARCHAR(MAX),
    stock INT NOT NULL,
    CONSTRAINT FK_Product_Category FOREIGN KEY (cid) REFERENCES Category(cid),
    CONSTRAINT FK_Product_Brand FOREIGN KEY (bid) REFERENCES Brand(bid)
);

-- T?o b?ng Users
CREATE TABLE Users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    email NVARCHAR(50) NOT NULL,
    pass NVARCHAR(50) NOT NULL,
    fullName NVARCHAR(100),
    phone VARCHAR(15),
    address NVARCHAR(1000),
    roleId INT NOT NULL,
    gender NVARCHAR(10),
    dob DATE
);


-- T?o b?ng Feedback
CREATE TABLE Feedback (
    id INT IDENTITY(1,1) PRIMARY KEY,
    userId INT NOT NULL,
    pid INT NOT NULL,
    comment NVARCHAR(MAX),
    rate INT NOT NULL CHECK (rate >= 1 AND rate <= 5), -- Added CHECK constraint for rate
    CONSTRAINT FK_Feedback_User FOREIGN KEY (userId) REFERENCES Users(id),
    CONSTRAINT FK_Feedback_Product FOREIGN KEY (pid) REFERENCES Product(id)
);

-- T?o b?ng Cart
CREATE TABLE Cart (
    id INT IDENTITY(1,1) PRIMARY KEY,
    userId INT NOT NULL,
    pid INT NOT NULL,
    quantity INT NOT NULL,
    price FLOAT(10),
    CONSTRAINT FK_Cart_User FOREIGN KEY (userId) REFERENCES Users(id),
    CONSTRAINT FK_Cart_Product FOREIGN KEY (pid) REFERENCES Product(id)
);

-- T?o b?ng ProductCart (liên k?t nhi?u-nhi?u gi?a Product và Cart)
CREATE TABLE ProductCart (
    pid INT NOT NULL,
    cartId INT NOT NULL,
    CONSTRAINT PK_ProductCart PRIMARY KEY (pid, cartId),
    CONSTRAINT FK_ProductCart_Product FOREIGN KEY (pid) REFERENCES Product(id),
    CONSTRAINT FK_ProductCart_Cart FOREIGN KEY (cartId) REFERENCES Cart(id)
);

-- T?o b?ng Order
CREATE TABLE [Order] (
    id INT IDENTITY(1,1) PRIMARY KEY,
    userId INT NOT NULL,
    date DATE NOT NULL,
    status NVARCHAR(500),
    total FLOAT(10) NOT NULL,
    CONSTRAINT FK_Order_User FOREIGN KEY (userId) REFERENCES Users(id)
);

-- T?o b?ng OrderDetail
CREATE TABLE OrderDetail (
    id INT IDENTITY(1,1) PRIMARY KEY,
    oid INT NOT NULL,
    pid INT NOT NULL,
    price FLOAT(10) NOT NULL, -- Changed to FLOAT to be consistent with other price columns
    quantity INT NOT NULL,
    total FLOAT(20) NOT NULL,
    CONSTRAINT FK_OrderDetail_Order FOREIGN KEY (oid) REFERENCES [Order](id),
    CONSTRAINT FK_OrderDetail_Product FOREIGN KEY (pid) REFERENCES Product(id)
);

-- T?o b?ng Payment
CREATE TABLE Payment (
    id INT IDENTITY(1,1) PRIMARY KEY,
    oid INT NOT NULL,
    type INT NOT NULL,
    date DATE NOT NULL,
    amount FLOAT(20) NOT NULL,
    CONSTRAINT FK_Payment_Order FOREIGN KEY (oid) REFERENCES [Order](id)
);

-- Thêm d? li?u vào b?ng Brand
SET IDENTITY_INSERT Brand ON;

INSERT INTO Brand (bid, name) VALUES
(1, 'Apple'),
(2, 'Samsung'),
(3, 'Xiaomi'),
(4, 'OPPO'),
(5, 'ASUS'),
(6, 'Nokia'),
(7, 'Sony'),
(8, 'DELL'),
(9, 'HP'),
(10, 'LG'),
(11, 'Acer');

SET IDENTITY_INSERT Brand OFF;

-- Thêm d? li?u vào b?ng Category
SET IDENTITY_INSERT Category ON;

INSERT INTO Category (cid, name) VALUES
(1, N'?i?n Tho?i,Tablet'),
(2, N'Laptop'),
(3, N'??ng h?'),
(4, N'Ph? ki?n');

SET IDENTITY_INSERT Category OFF;

-- Thêm d? li?u vào b?ng Users

INSERT INTO Users (email, pass, fullName, phone, address, roleId, gender, dob)
VALUES 
('hai31082003@gmail.com', '123', 'John Doe', '1234567890', '123 Main St, Anytown, USA', 1, 'Male', '1980-01-01'),
('longvupp@gmail.com', '123', 'Jane Smith', '0987654321', '456 Elm St, Othertown, USA', 2, 'Male', '1990-02-02'),
('alice.jones@example.com', 'password789', 'Alice Jones', '1231231234', '789 Oak St, Sometown, USA', 3, 'Female', '2000-03-03');


-- Thêm d? li?u vào b?ng Product
INSERT INTO Product (bid, cid, name, image, price, description, stock) VALUES

(1, 1, 'iPhone 13', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-13_2_.png', 13390000, N'iPhone 13 có m?t s? thay ??i l?n v? camera so v?i trên iPhone 12 Series. C? th?, iPhone có th? ???c trang b? ?ng kính siêu r?ng m?i giúp máy hi?n th? ???c nhi?u chi ti?t h?n ? các b?c hình thi?u sáng. Trong khi ?ó ?ng kính góc r?ng có th? thu ???c nhi?u sáng h?n, lên ??n 47% giúp ch?t l??ng b?c ?nh, video ???c c?i thi?n h?n.', 100),
(1, 1, 'iPhone 14', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-14_1.png', 16590000, 'iPhone 14 128GB s? h?u màn hình Retina XDR OLED kích th??c 6.1 inch cùng ?? sáng v??t tr?i lên ??n 1200 nits. Máy c?ng ???c trang b? camera kép 12 MP phía sau cùng c?m bi?n ?i?m ?nh l?n, ??t 1.9 micron giúp c?i thi?n kh? n?ng ch?p thi?u sáng. M?u iPhone 14 m?i c?ng mang trong mình con chip Apple A15 Bionic phiên b?n 5 nhân mang l?i hi?u su?t v??t tr?i.', 100),
(1, 1, 'iPhone 15', 'https://cellphones.com.vn/iphone-15.html', 22590000, N'iPhone 15 128GB ???c trang b? màn hình Dynamic Island kích th??c 6.1 inch v?i công ngh? hi?n th? Super Retina XDR màn l?i tr?i nghi?m hình ?nh v??t tr?i. ?i?n tho?i v?i m?t l?ng kính nhám ch?ng bám m? hôi. Camera trên iPhone 15 series c?ng ???c nâng c?p lên c?m bi?n 48MP cùng tính n?ng ch?p zoom quang h?c t?i 2x. Cùng v?i thi?t k? c?ng s?c thay ??i t? lightning sang USB-C vô cùng ?n t??ng.', 100),
(2, 1, 'Samsung Galaxy S24 Ultra', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/s/ss-s24-ultra-xam-222.png', 29990000, N'Samsung S24 Ultra là siêu ph?m smartphone ??nh cao m? ??u n?m 2024 ??n t? nhà Samsung v?i chip Snapdragon 8 Gen 3 For Galaxy m?nh m?, công ngh? t??ng lai Galaxy AI cùng khung vi?n Titan ??ng c?p h?a h?n s? mang t?i nhi?u s? thay ??i l?n v? m?t thi?t k? và c?u hình. SS Galaxy S24 b?n Ultra s? h?u màn hình 6.8 inch Dynamic AMOLED 2X t?n s? quét 120Hz. Máy c?ng s? h?u camera chính 200MP, camera zoom quang h?c 50MP, camera tele 10MP và camera góc siêu r?ng 12MP.', 10),
(2, 1, 'Samsung Galaxy S23 Ultra', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/a/samsung-s23-ulatra_2__1.png', 23990000, N'Samsung S23 Ultra là dòng ?i?n tho?i cao c?p c?a Samsung, s? h?u camera ?? phân gi?i 200MP ?n t??ng, chip Snapdragon 8 Gen 2 m?nh m?, b? nh? RAM 8GB mang l?i hi?u su?t x? lý v??t tr?i cùng khung vi?n vuông v?c sang tr?ng. S?n ph?m ???c ra m?t t? ??u n?m 2023.', 100),
(2, 1, 'Samsung Galaxy Z Flip5', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/a/samsung-z-lip5_3_.png', 19990000, N'Samsung Galaxy Z Flip 5 có thi?t k? màn hình r?ng 6.7 inch và ?? phân gi?i Full HD+ (1080 x 2640 Pixels), dung l??ng RAM 8GB, b? nh? trong 256GB. Màn hình Dynamic AMOLED 2X c?a ?i?n tho?i này hi?n th? rõ nét và s?c nét, mang ??n tr?i nghi?m ?n t??ng khi s? d?ng.', 100),
(3, 1, 'Xiaomi 14', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-14-pre-xanh-la.png', 19990000, N'Xiaomi 14 5G mang trên mình màn hình OLED 6.36-inch, cùng v?i b? vi x? lý Qualcomm Snapdragon 8 Gen 3, làm nên m?t c?u hình siêu m?nh m? cho ng??i dùng. ?i kèm v?i ?ó là viên pin dung l??ng 4610mAh h? tr? t?c ?? s?c 90W k?t h?p cùng h? th?ng ba camera sau v?i c?m bi?n chính 50MP, ??m b?o hi?u su?t và kh? n?ng ch?p ?nh ?n t??ng. ??c bi?t h?n, Xiaomi 14 5G không ch? s?n sàng cho 5G mà còn h? tr? s?c không dây, mang l?i s? ti?n l?i cao cho ng??i dùng.', 100),
(3, 1, 'Xiaomi 14 Ultra 5G', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-14-ultra_3.png', 29990000, N'Tr?i nghi?m ch?p hình nh? máy ?nh nh? 4 camera cao c?p, mãn nhãn v?i thi?t k? thanh l?ch cùng các gam màu b?t m?t,ghi ?i?m m?nh m? v?i màn hình AMOLED ??p m?t, th?m m?,chip Snapdragon 8 Gen 3 ho?t ??ng m?nh m?, pin 5000mAh', 100),
(3, 1, 'Xiaomi 13T Pro 5G', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-13-pro-thumb-xanh-la9.jpg', 14790000, N'Xiaomi 13T Pro là flagship m?i nh?t nhà Xiaomi, m?nh m? ?n t??ng v?i chip MediaTek Dimensity 9200+, cùng v?i ?ó là RAM 12GB và b? nh? trong lên t?i 512GB. ??c bi?t, kh? n?ng ch?p ?nh ??nh cao nh? c?m camera siêu ch?t, viên pin l?n 5000mAh cùng s?c nhanh 120W. T?t c? s? mang t?i m?t siêu ph?m ?ình ?ám giúp b?n có ???c tr?i nghi?m ??c ?áo và kh?ng ??nh ???c cá tính c?a mình.', 100),
(4, 1, 'OPPO A78', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/o/p/oppo-a78.png', 6990000, N'Là m?u ?i?n tho?i t?m trung ??u tiên ???c OPPO ra m?t trong n?m 2023, OPPO A78 s? h?u m?t thi?t k? b?t m?t cùng nh?ng c?i ti?n trong hi?u n?ng v?i vi x? lý Qualcomm Snapdragon 680 có kh? n?ng h? tr? k?t n?i 4G, 8GB RAM ( m? r?ng thêm 8GB), 256GB b? nh? và viên pin 5000mAh h? tr? công ngh? s?c siêu t?c 67W.', 100),
(4, 1, 'OPPO A17K', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/o/p/oppo-a17k.png', 2790000, N'OPPO A17K có thi?t k? màn hình LCD v?i kích th??c 6.56 inch cùng ?? phân gi?i full HD +. ??ng th?i so v?i h? ti?n nhi?m, A17K ???c nâng c?p v?i RAM 4GB cùng b? nh? trong 64GB giúp ng??i dùng có l?u tr? ???c nhi?u h?n.', 100),
(4, 1, 'OPPO Reno11 F', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/d/i/dien-thoai-oppo-reno-11-f-2.png', 8490000, N'OPPO Reno11 F 5G cung c?p tr?i nghi?m hi?n th?, x? lý siêu m??t mà v?i màn hình AMOLED 6.7 inch hi?n ??i cùng chipset MediaTek Dimensity 7050 m?nh m?. H? th?ng quay ch?p trên th? h? Reno11 F 5G này ???c c?i thi?n h?n thông qua c?m 3 camera v?i ?? phân gi?i l?n l??t là 64MP, 8MP và 2MP. Ngoài ra, cung c?p n?ng l??ng cho th? h? OPPO smartphone này là viên pin 5000mAh cùng s?c nhanh 67W, mang t?i tr?i nghi?m li?n m?ch su?t ngày dài.', 100),
(5, 1, 'ASUS ROG Phone 7 Ultimate', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/_/1_365.jpg', 26190000, N'Asus ROG phone 7 Ultimate 16GB 512GB s? h?u con chip Snapdragon 8 Gen 2 v?i s?c m?nh siêu kh?ng ??n t? nhà Qualcomm. Màn hình ???c làm t? màn amoled có kích th??c kh?ng t?n 6.78 inch cho ch?t l??ng hình ?nh Full HD Plus. Camera siêu x?n v?i ?? phân gi?i lên ??n 50MP ?i kèm viên pin dung l??ng vô ??i 6000mAh và ch? ?? s?c HyperCharge 65W.', 100),
(6, 1, 'Nokia 215', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/n/o/nokia-215-4g-600jpg-600x600.jpg', 980000, N'V?i nhi?u ng??i dùng thích s? nh? g?n c?a các thi?t k? dòng ?i?n tho?i ph? thông c?a Nokia, vi?c trang b? cho mình m?t chi?c Nokia 215 4G là m?t s? l?a ch?n phù h?p v?i ??y ?? các tính n?ng và còn thêm c? kh? n?ng có th? truy c?p internet mang ??n cho ng??i dùng tr?i nghi?m hoàn toàn m?i.', 100),
(6, 1, 'Nokia 3210 4G', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/n/o/nokia-3210-4g.png', 1550000, N'Nokia 3210 4G là m?t trong nh?ng s?n ph?m ?i?n tho?i ph? thông phù h?p v?i nh?ng ai yêu thích s? ??n gi?n, hoài c? và c?n m?t chi?c ?i?n tho?i ph? ?? liên l?c, gi?i trí c? b?n. V?i thi?t k? ?n t??ng cùng tính n?ng ?a d?ng, ch?c ch?n khi s? h?u và s? d?ng b?n s? c?m nh?n ???c s? thu?n ti?n.', 100),
(6, 1, 'Nokia 110 4G Pro', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/n/o/nokia-110-4g-pro_1__1.png', 710000, N'N?i b?t v?i thi?t k? m?i m? k?t h?p v?i nhi?u thông s? k? thu?t ?n t??ng, Nokia 110 4G Pro ???c ?ánh giá là v??t tr?i h?n h?n so v?i các dòng ?i?n tho?i ph? thông cùng phân khúc khác. Máy s? h?u k?t n?i 4G ?n ??nh cùng dung l??ng pin l?n, giúp b?n tho?i mái tr?i nghi?m Internet nhanh chóng, thu?n thi?n m?i lúc, m?i n?i. N?u b?n ?ang tìm ki?m m?t m?u ?i?n tho?i ??n gi?n, ?áng tin c?y thì Nokia 110 Pro 4G s? là g?i ý không nên b? qua nhé!', 100),


(1, 2, 'Macbook Pro 14 M3 Pro', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/g/p/gpu.png', 48990000, N'Macbook Pro M3 Pro b?n 14 inch 18GB/512GB có kh? n?ng lý ?? h?a chuyên sâu, k?t c?u 3D m?t cách ?n ??nh và m??t mà. Bên c?nh ?ó, s?n ph?m có ch?t l??ng hi?n th? r?t s?c nét, và t?n s? quét lên t?i 120Hz, giúp ng??i dùng làm vi?c hi?u qu?, nhanh chóng.', 100),
(1, 2, 'Apple Macbook Air M2 2022', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/m/a/macbook_air_m2_1_1.png', 23890000, N'Macbook Air M2 2022 v?i thi?t k? sang tr?ng, v? ngoài siêu m?ng ??y l?ch lãm. M?u Macbook Air m?i v?i nh?ng nâng c?p v? thi?t k? và c?u hình cùng giá bán ph?i ch?ng, ?ây s? là m?t thi?t b? lý t??ng cho công vi?c và gi?i trí.', 100),
(1, 2, 'Apple MacBook Air M1 256GB 2020', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/a/i/air_m2.png', 18690000, N'Macbook Air M1 là dòng s?n ph?m có thi?t k? m?ng nh?, sang tr?ng và tinh t? cùng v?i ?ó là giá thành ph?i ch?ng nên MacBook Air ?ã thu hút ???c ?ông ??o ng??i dùng yêu thích và l?a ch?n. ?ây c?ng là m?t trong nh?ng phiên b?n Macbook Air m?i nh?t mà khách hàng không th? b? qua khi ??n v?i HoLaTech.', 100),
(5, 2, 'Laptop ASUS TUF Gaming F15 FX506HF-HN078W', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_13__5_14.png', 17290000, N'Laptop Asus Tuf Gaming F15 FX506HF-HN078W v?i thi?t k? n?ng ??ng, mang v? ??p thu hút v?i CPU core intel i5, GPU GeForce RTX™ 2050 và RAM 8 GB. K?t h?p là màn hi?n th? FHD IPS 144Hz c?c k? rõ nét. Ngoài ra laptop Asus Gaming c?ng có thêm h? th?ng âm thanh ??nh cao nh? vào công ngh? tiên ti?n ?? ph?c v? t?i ?a ng??i dùng.', 100),
(5, 2, 'Laptop ASUS ROG Strix G16 G614JU-N3135W', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_20__1_21.png', 31490000, N'Laptop Asus ROG Strix G16 G614JU-N3135W trang b? cho mình m?t b? vi x? lý Intel Core i5 th? h? 13 m?i nh?t cho phép máy v?n hành m??t mà m?i tác v?. T?c ?? x? lý lên ??n 4.6GHz giúp t?ng hi?u su?t, gi?m th?i gian x? lý và cho b?n tr?i nghi?m tuy?t v?i ? các t?a game n?ng hay trình thi?t k? ?? h?a nhi?u chi ti?t.', 100),
(5, 2, 'Laptop ASUS TUF Gaming F15 FX507VV-LP157W', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_14__4_8.png', 29990000, N'Laptop ASUS TUF Gaming F15 FX507VV-LP157W là m?t chi?c laptop ch?i game t?m trung ???c trang b? b? vi x? lý Intel Core i7-13620H và card ?? h?a RTX 4060 8GB GDDR6. Màn hình 15,6 inch Full HD có t?n s? quét 144Hz cho tr?i nghi?m ch?i game m??t mà và s?c nét. Laptop ???c trang b? h? th?ng t?n nhi?t Arc Flow Fans giúp duy trì hi?u n?ng ?n ??nh trong th?i gian dài.', 100),
(8, 2, 'Laptop Dell Vostro 3520 F0V0VI3', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/l/a/laptop-dell-vostro-3520-f0v0vi3-thumbnails.png', 9690000, N'Laptop Dell Vostro 3520 F0V0VI3 s? d?ng b? b? vi x? lý Intel Core i3 - 1215U k?t h?p v?i RAM dung l??ng 8GB cho kh? n?ng x? lý công vi?c hàng ngày hi?u qu?. Máy ???c trang b? ? c?ng SSD PCIe t?c ?? cao v?i dung l??ng 512GB giúp b?n truy c?p và t?i thông tin nhanh chóng. Màn hình full HD kích th??c 15.6 inch mang ??n nh?ng khung hình m??t mà và s?c nét. Máy có các c?ng giao ti?p thông d?ng ?? b?n d? dàng chia s? d? li?u. ', 100),
(8, 2, 'Laptop Dell Vostro 3520 GD02R', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_6__152.png', 12490000, N'Dell Vostro 3520 GD02R có th? ???c coi là dòng laptop Dell Vostro ???c ?a chu?ng b?i nh?ng ng??i dùng v?n phòng nh? vào hi?u n?ng ?n ??nh c?ng nh? màn hình s?ng ??ng v?a ?áp ?ng t?t cho c? nhu c?u làm vi?c c?ng nh? gi?i trí h?ng ngày.', 100),
(8, 2, 'Laptop Dell Vostro 3520', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/l/a/laptop_dell_vostro_3520i7.png', 18490000, N'Laptop Dell Vostro 3520 là m?t trong nh?ng s?n ph?m laptop Dell Vostro ?áng chú ý c?a th??ng hi?u Dell, ???c thi?t k? ?? ?áp ?ng nhu c?u làm vi?c và gi?i trí c?a ng??i dùng hi?n ??i. V?i thi?t k? nh? g?n, hi?u n?ng m?nh m? và tính n?ng b?o m?t ?n t??ng, s?n ph?m này s? là m?t tr? th? ??c l?c cho công vi?c và gi?i trí hàng ngày c?a b?n.', 100),
(11, 2, 'Laptop Gaming Acer Nitro V ANV15-51-55CA', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/l/a/laptop-gaming-acer-nitro-v-anv15-51-55ca.jpg', 26990000, N'Laptop Gaming Nitro V ANV15-51-55CA ?em l?i tr?i nghi?m gaming m?nh m? v?i b? vi x? lý Intel Gen 13 i5-13420H, cùng card ?? h?a r?i NVIDIA RTX 4050. Ngoài ra, ?n ph?m laptop Acer gaming này c?ng ???c trang b? 16GB RAM DDR5, cung c?p kh? n?ng x? lý ?a nhi?m m??t mà, và b? nh? SSD 512GB, ??m b?o t?c ?? truy xu?t d? li?u siêu nhanh chóng. Cùng v?i ?ó là kích th??c màn hình 15,6 inch, t?n s? quét 144Hz giúp t?i ?u hóa tr?i nghi?m hình ?nh s?c nét và m??t mà cho game th?.', 100),
(11, 2, 'Laptop Acer Swift Go 14 AI SFG14-73-71ZX NX.KSLSV.002', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/l/a/laptop-acer-swift-go-14-ai-sfg14-73-71zx.png', 26490000, N'Laptop Acer Swift Go 14 AI SFG14-73-71ZX t? hào là m?t trong nh?ng chi?c laptop xách tay tích h?p hi?u qu? công ngh? trí tu? nhân t?o. K?t h?p v?i con chip Intel Core cùng card ?? h?a Intel Arc Graphics, m?u laptop Acer Swift này cho hi?u su?t nhanh nh?t có th?.', 100),
(11, 2, 'Laptop Acer Aspire 3 A315-59-381E', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/l/a/laptop-acer-aspire-3-a315-59-381e-thumbnails.png', 9790000, N'Laptop Acer Aspire 3 A315-59-381E mang ??n m?t di?n m?o thanh l?ch v?i c?u hình ?n ??nh trong phân khúc t?m trung. V?i CPU Intel Core i3-1215U và ? c?ng SSD dung l??ng 512GB, máy ?áp ?ng ???c nhu c?u làm vi?c hàng ngày và gi?i trí ?a d?ng c?a ng??i dùng.', 100),
(11, 2, 'Laptop Acer Gaming Aspire 7 A715-76-53PJ', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_7__1_12.png', 14990000, N'Laptop Acer Gaming Aspire 7 A715-76-53PJ là chi?c laptop s? h?u c?u hình m?nh v?i b? vi x? lý Intel Core th? h? 12 và card ?? h?a Intel UHD Graphics. Máy có màn hình 15.6 inch, ?? phân gi?i Full HD (1920 x 1080), b? nh? RAM 16GB DDR4 và dung l??ng l?u tr? SSD 512GB. Ngoài ra, máy còn ???c trang b? các c?ng k?t n?i nh? HDMI, USB Type-C, USB 3.2 Gen 1 Type-A, RJ-45 và có kh? n?ng ch?i game t?t.', 100),
(10, 2, 'Laptop LG Gram 2023 17Z90R-G.AH78A5', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_d_i_10_.png', 38990000, N'Laptop LG Gram 2023 17Z90R-G.AH78A5 là dòng laptop siêu m?ng nh? c?a LG s? h?u m?t c?u hình ?n ??nh r?t thích h?p v?i ng??i dùng v?n phòng. M?u laptop LG Gram 2023 này gây ?n t??ng v?i ng??i dùng v? kh? n?ng hi?n th?, hi?u n?ng s? d?ng.', 100),
(10, 2, 'Laptop LG Gram 2023 14Z90RS-G.AH54A5', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/4/14z90rs-ah54a5.png', 28490000, N'Laptop LG Gram 2023 14Z90RS-G.AH54A5 là m?t dòng máy tính xách tay nh? và m?nh m? ???c phát hành vào n?m 2023. Thông qua nhi?u ??c ?i?m n?i b?t, phiên b?n laptop LG Gram 2023 này h?a h?n s? mang ??n nh?ng giây phút làm vi?c và gi?i trí tuy?t v?i dành cho b?n.', 100),
(10, 2, 'Laptop LG Gram 2023 15Z90RT-G.AH55A5', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_5__2_1.png', 31990000, N'Laptop LG Gram 2023 15Z90RT-G.AH55A5 s? h?u ki?u dáng m?ng nh? ??c tr?ng, màn hình l?n, ?em l?i hình ?nh s?ng ??ng. Chi?c laptop LG 2023 có hi?u n?ng ? m?c ?n ??nh, giúp b?n ?a nhi?m t?t và gi?i quy?t ???c nhanh các tác v? t? v?n phòng c? b?n ??n nâng cao. ', 100),
(9, 2, 'Laptop HP 15 250 G8 85C69EA', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_6_3.png', 11990000, N'Laptop HP 15 250 G8 85C69EA là dòng máy ???c làm g?n nh? cho tính di ??ng cao, phù h?p dùng ???c ? m?i n?i. Hi?u su?t c?a máy ???c duy trì ?n ??nh nh? vào c?u hình t?m trung cùng th?i l??ng pin t?t ?? b?n hoàn thành nhanh chóng m?i tác v?.', 100),
(9, 2, 'Laptop HP Elitebook 630 G9 6M142PA', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_14__1_65.png', 16990000, N'Laptop HP Elitebook 630 G9 6M142PA ???c gi?i doanh nhân ?u ái l?a ch?n v?i nh?ng ??c ?i?m v??t b?c. Thông qua lo?t công ngh? hi?n ??i cùng b? vi x? lý i5 th? h? 12, phiên b?n laptop HP này ch?c ch?n s? giúp b?n hoàn thành công vi?c m?t cách hi?u qu? và nhanh chóng.', 100),
(9, 2, 'Laptop HP Pavilion 15-EG3093TU 8C5L4PA', 'https://cellphones.com.vn/laptop-hp-14-ep0112tu-8c5l1pa.html', 16990000, N'Laptop HP Pavilion 15-EG3093TU 8C5L4PA ?i cùng b? vi x? lý CPU Gen 13 và b? nh? RAM 16 GB chu?n DDR4 mang ??n kh? n?ng x? lý vô cùng nhanh chóng. Màn hình r?ng 15.6 inch Full HD trên máy cung c?p hình ?nh s?c nét và màu s?c chân th?c. H?n n?a, ? c?ng s?n ph?m laptop HP Pavilion giúp l?u tr? d? li?u m?t cách hi?u qu? và t?i ?u hóa t?c ?? làm vi?c.', 100),

(1, 3, 'Apple Watch SE 2 2023 40mm', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/a/p/apple-watch-se-2023-40mm.png', 5790000, N'Apple Watch SE 2023 40mm (GPS) không ch? là m?t s?n ph?m ??ng h? xem gi?, nó còn tích h?p r?t nhi?u tính n?ng theo dõi s?c kh?e, luy?n t?p thông minh. V?i thi?t k? vô cùng sang tr?ng nh? màn hình Retina, khung vi?n nhôm cùng kính c??ng l?c ch?c ch?n.', 100),
(1, 3, 'Apple Watch Series 9 45mm', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/a/p/apple_lte_3__1.png', 10690000, N'??ng h? Apple Watch Series 9 45mm s? h?u on chip S9 SiP - CPU v?i 5,6 t? bóng bán d?n giúp mang l?i hi?u n?ng c?i thi?n h?n 60% so v?i th? h? S8. Màn hình thi?t b? v?i kích th??c 45mm cùng ?? sáng t?i ?a lên 2000 nit mang l?i tr?i nghi?m hi?n th? v??t tr?i. Cùng v?i ?ó, ??ng h? Apple Watch s9 này còn ???c trang b? nhi?u tính n?ng h? tr? theo dõi s?c kh?e và t?p luy?n thông minh.', 100),
(1, 3, 'Apple Watch Ultra 2 49mm ', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/a/p/apple_watch_ultra_2.png', 20990000, N'??ng h? Apple Watch Ultra 2 s? h?u khung vi?n titan sang tr?ng cùng con chip S9 SiP th? h? m?i mang l?i m?t tr?i nghi?m dùng ?n ??nh và m??t mà. ??ng h? v?i ba phiên b?n dây ?eo thì h?p cho t?ng nhu c?u s? d?ng khác nhau c?a ng??i dùng.', 100),
(2, 3, '??ng h? Samsung Galaxy Fit 3', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/a/samsung_3.png', 1290000, N'??ng h? Samsung Galaxy Fit 3 thi?t k? thanh m?nh, g?n gàng, màn hình AMOLED 1.6 inch, tr?ng l??ng ch? 36.8g, kháng n??c 5ATM và b?i IP68 cùng viên pin 208mAh kéo dài d?n 13 ngày ?n t??ng tích h?p s?c không dây.', 100);

-- Thêm d? li?u vào b?ng Feedback
INSERT INTO Feedback (userId, pid, comment, rate) VALUES
(1, 1, 'Great phone!', 5),
(2, 2, 'Good value for money.', 4);

-- Thêm d? li?u vào b?ng Cart
INSERT INTO Cart (userId, pid, quantity, price) VALUES
(1, 1, 1, 13390000),
(2, 2, 2, 16590000);

-- Thêm d? li?u vào b?ng ProductCart
INSERT INTO ProductCart (pid, cartId) VALUES
(1, 1),
(2, 2);

-- Thêm d? li?u vào b?ng Order
INSERT INTO [Order] (userId, date, status, total) VALUES
(1, '2024-06-01', 'Delivered', 13390000),
(2, '2024-06-02', 'Processing', 33180000);

-- Thêm d? li?u vào b?ng OrderDetail
INSERT INTO OrderDetail (oid, pid, price, quantity, total) VALUES
(1, 1, 13390000, 1, 13390000),
(2, 2, 16590000, 2, 33180000);

-- Thêm d? li?u vào b?ng Payment
INSERT INTO Payment (oid, type, date, amount) VALUES
(1, 1, '2024-06-01', 13390000),
(2, 2, '2024-06-02', 33180000);