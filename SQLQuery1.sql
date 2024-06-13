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

-- T?o b?ng ProductCart (li�n k?t nhi?u-nhi?u gi?a Product v� Cart)
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

-- Th�m d? li?u v�o b?ng Brand
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

-- Th�m d? li?u v�o b?ng Category
SET IDENTITY_INSERT Category ON;

INSERT INTO Category (cid, name) VALUES
(1, N'?i?n Tho?i,Tablet'),
(2, N'Laptop'),
(3, N'??ng h?'),
(4, N'Ph? ki?n');

SET IDENTITY_INSERT Category OFF;

-- Th�m d? li?u v�o b?ng Users

INSERT INTO Users (email, pass, fullName, phone, address, roleId, gender, dob)
VALUES 
('hai31082003@gmail.com', '123', 'John Doe', '1234567890', '123 Main St, Anytown, USA', 1, 'Male', '1980-01-01'),
('longvupp@gmail.com', '123', 'Jane Smith', '0987654321', '456 Elm St, Othertown, USA', 2, 'Male', '1990-02-02'),
('alice.jones@example.com', 'password789', 'Alice Jones', '1231231234', '789 Oak St, Sometown, USA', 3, 'Female', '2000-03-03');


-- Th�m d? li?u v�o b?ng Product
INSERT INTO Product (bid, cid, name, image, price, description, stock) VALUES

(1, 1, 'iPhone 13', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-13_2_.png', 13390000, N'iPhone 13 c� m?t s? thay ??i l?n v? camera so v?i tr�n iPhone 12 Series. C? th?, iPhone c� th? ???c trang b? ?ng k�nh si�u r?ng m?i gi�p m�y hi?n th? ???c nhi?u chi ti?t h?n ? c�c b?c h�nh thi?u s�ng. Trong khi ?� ?ng k�nh g�c r?ng c� th? thu ???c nhi?u s�ng h?n, l�n ??n 47% gi�p ch?t l??ng b?c ?nh, video ???c c?i thi?n h?n.', 100),
(1, 1, 'iPhone 14', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-14_1.png', 16590000, 'iPhone 14 128GB s? h?u m�n h�nh Retina XDR OLED k�ch th??c 6.1 inch c�ng ?? s�ng v??t tr?i l�n ??n 1200 nits. M�y c?ng ???c trang b? camera k�p 12 MP ph�a sau c�ng c?m bi?n ?i?m ?nh l?n, ??t 1.9 micron gi�p c?i thi?n kh? n?ng ch?p thi?u s�ng. M?u iPhone 14 m?i c?ng mang trong m�nh con chip Apple A15 Bionic phi�n b?n 5 nh�n mang l?i hi?u su?t v??t tr?i.', 100),
(1, 1, 'iPhone 15', 'https://cellphones.com.vn/iphone-15.html', 22590000, N'iPhone 15 128GB ???c trang b? m�n h�nh Dynamic Island k�ch th??c 6.1 inch v?i c�ng ngh? hi?n th? Super Retina XDR m�n l?i tr?i nghi?m h�nh ?nh v??t tr?i. ?i?n tho?i v?i m?t l?ng k�nh nh�m ch?ng b�m m? h�i. Camera tr�n iPhone 15 series c?ng ???c n�ng c?p l�n c?m bi?n 48MP c�ng t�nh n?ng ch?p zoom quang h?c t?i 2x. C�ng v?i thi?t k? c?ng s?c thay ??i t? lightning sang USB-C v� c�ng ?n t??ng.', 100),
(2, 1, 'Samsung Galaxy S24 Ultra', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/s/ss-s24-ultra-xam-222.png', 29990000, N'Samsung S24 Ultra l� si�u ph?m smartphone ??nh cao m? ??u n?m 2024 ??n t? nh� Samsung v?i chip Snapdragon 8 Gen 3 For Galaxy m?nh m?, c�ng ngh? t??ng lai Galaxy AI c�ng khung vi?n Titan ??ng c?p h?a h?n s? mang t?i nhi?u s? thay ??i l?n v? m?t thi?t k? v� c?u h�nh. SS Galaxy S24 b?n Ultra s? h?u m�n h�nh 6.8 inch Dynamic AMOLED 2X t?n s? qu�t 120Hz. M�y c?ng s? h?u camera ch�nh 200MP, camera zoom quang h?c 50MP, camera tele 10MP v� camera g�c si�u r?ng 12MP.', 10),
(2, 1, 'Samsung Galaxy S23 Ultra', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/a/samsung-s23-ulatra_2__1.png', 23990000, N'Samsung S23 Ultra l� d�ng ?i?n tho?i cao c?p c?a Samsung, s? h?u camera ?? ph�n gi?i 200MP ?n t??ng, chip Snapdragon 8 Gen 2 m?nh m?, b? nh? RAM 8GB mang l?i hi?u su?t x? l� v??t tr?i c�ng khung vi?n vu�ng v?c sang tr?ng. S?n ph?m ???c ra m?t t? ??u n?m 2023.', 100),
(2, 1, 'Samsung Galaxy Z Flip5', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/a/samsung-z-lip5_3_.png', 19990000, N'Samsung Galaxy Z Flip 5 c� thi?t k? m�n h�nh r?ng 6.7 inch v� ?? ph�n gi?i Full HD+ (1080 x 2640 Pixels), dung l??ng RAM 8GB, b? nh? trong 256GB. M�n h�nh Dynamic AMOLED 2X c?a ?i?n tho?i n�y hi?n th? r� n�t v� s?c n�t, mang ??n tr?i nghi?m ?n t??ng khi s? d?ng.', 100),
(3, 1, 'Xiaomi 14', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-14-pre-xanh-la.png', 19990000, N'Xiaomi 14 5G mang tr�n m�nh m�n h�nh OLED 6.36-inch, c�ng v?i b? vi x? l� Qualcomm Snapdragon 8 Gen 3, l�m n�n m?t c?u h�nh si�u m?nh m? cho ng??i d�ng. ?i k�m v?i ?� l� vi�n pin dung l??ng 4610mAh h? tr? t?c ?? s?c 90W k?t h?p c�ng h? th?ng ba camera sau v?i c?m bi?n ch�nh 50MP, ??m b?o hi?u su?t v� kh? n?ng ch?p ?nh ?n t??ng. ??c bi?t h?n, Xiaomi 14 5G kh�ng ch? s?n s�ng cho 5G m� c�n h? tr? s?c kh�ng d�y, mang l?i s? ti?n l?i cao cho ng??i d�ng.', 100),
(3, 1, 'Xiaomi 14 Ultra 5G', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-14-ultra_3.png', 29990000, N'Tr?i nghi?m ch?p h�nh nh? m�y ?nh nh? 4 camera cao c?p, m�n nh�n v?i thi?t k? thanh l?ch c�ng c�c gam m�u b?t m?t,ghi ?i?m m?nh m? v?i m�n h�nh AMOLED ??p m?t, th?m m?,chip Snapdragon 8 Gen 3 ho?t ??ng m?nh m?, pin 5000mAh', 100),
(3, 1, 'Xiaomi 13T Pro 5G', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-13-pro-thumb-xanh-la9.jpg', 14790000, N'Xiaomi 13T Pro l� flagship m?i nh?t nh� Xiaomi, m?nh m? ?n t??ng v?i chip MediaTek Dimensity 9200+, c�ng v?i ?� l� RAM 12GB v� b? nh? trong l�n t?i 512GB. ??c bi?t, kh? n?ng ch?p ?nh ??nh cao nh? c?m camera si�u ch?t, vi�n pin l?n 5000mAh c�ng s?c nhanh 120W. T?t c? s? mang t?i m?t si�u ph?m ?�nh ?�m gi�p b?n c� ???c tr?i nghi?m ??c ?�o v� kh?ng ??nh ???c c� t�nh c?a m�nh.', 100),
(4, 1, 'OPPO A78', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/o/p/oppo-a78.png', 6990000, N'L� m?u ?i?n tho?i t?m trung ??u ti�n ???c OPPO ra m?t trong n?m 2023, OPPO A78 s? h?u m?t thi?t k? b?t m?t c�ng nh?ng c?i ti?n trong hi?u n?ng v?i vi x? l� Qualcomm Snapdragon 680 c� kh? n?ng h? tr? k?t n?i 4G, 8GB RAM ( m? r?ng th�m 8GB), 256GB b? nh? v� vi�n pin 5000mAh h? tr? c�ng ngh? s?c si�u t?c 67W.', 100),
(4, 1, 'OPPO A17K', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/o/p/oppo-a17k.png', 2790000, N'OPPO A17K c� thi?t k? m�n h�nh LCD v?i k�ch th??c 6.56 inch c�ng ?? ph�n gi?i full HD +. ??ng th?i so v?i h? ti?n nhi?m, A17K ???c n�ng c?p v?i RAM 4GB c�ng b? nh? trong 64GB gi�p ng??i d�ng c� l?u tr? ???c nhi?u h?n.', 100),
(4, 1, 'OPPO Reno11 F', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/d/i/dien-thoai-oppo-reno-11-f-2.png', 8490000, N'OPPO Reno11 F 5G cung c?p tr?i nghi?m hi?n th?, x? l� si�u m??t m� v?i m�n h�nh AMOLED 6.7 inch hi?n ??i c�ng chipset MediaTek Dimensity 7050 m?nh m?. H? th?ng quay ch?p tr�n th? h? Reno11 F 5G n�y ???c c?i thi?n h?n th�ng qua c?m 3 camera v?i ?? ph�n gi?i l?n l??t l� 64MP, 8MP v� 2MP. Ngo�i ra, cung c?p n?ng l??ng cho th? h? OPPO smartphone n�y l� vi�n pin 5000mAh c�ng s?c nhanh 67W, mang t?i tr?i nghi?m li?n m?ch su?t ng�y d�i.', 100),
(5, 1, 'ASUS ROG Phone 7 Ultimate', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/_/1_365.jpg', 26190000, N'Asus ROG phone 7 Ultimate 16GB 512GB s? h?u con chip Snapdragon 8 Gen 2 v?i s?c m?nh si�u kh?ng ??n t? nh� Qualcomm. M�n h�nh ???c l�m t? m�n amoled c� k�ch th??c kh?ng t?n 6.78 inch cho ch?t l??ng h�nh ?nh Full HD Plus. Camera si�u x?n v?i ?? ph�n gi?i l�n ??n 50MP ?i k�m vi�n pin dung l??ng v� ??i 6000mAh v� ch? ?? s?c HyperCharge 65W.', 100),
(6, 1, 'Nokia 215', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/n/o/nokia-215-4g-600jpg-600x600.jpg', 980000, N'V?i nhi?u ng??i d�ng th�ch s? nh? g?n c?a c�c thi?t k? d�ng ?i?n tho?i ph? th�ng c?a Nokia, vi?c trang b? cho m�nh m?t chi?c Nokia 215 4G l� m?t s? l?a ch?n ph� h?p v?i ??y ?? c�c t�nh n?ng v� c�n th�m c? kh? n?ng c� th? truy c?p internet mang ??n cho ng??i d�ng tr?i nghi?m ho�n to�n m?i.', 100),
(6, 1, 'Nokia 3210 4G', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/n/o/nokia-3210-4g.png', 1550000, N'Nokia 3210 4G l� m?t trong nh?ng s?n ph?m ?i?n tho?i ph? th�ng ph� h?p v?i nh?ng ai y�u th�ch s? ??n gi?n, ho�i c? v� c?n m?t chi?c ?i?n tho?i ph? ?? li�n l?c, gi?i tr� c? b?n. V?i thi?t k? ?n t??ng c�ng t�nh n?ng ?a d?ng, ch?c ch?n khi s? h?u v� s? d?ng b?n s? c?m nh?n ???c s? thu?n ti?n.', 100),
(6, 1, 'Nokia 110 4G Pro', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/n/o/nokia-110-4g-pro_1__1.png', 710000, N'N?i b?t v?i thi?t k? m?i m? k?t h?p v?i nhi?u th�ng s? k? thu?t ?n t??ng, Nokia 110 4G Pro ???c ?�nh gi� l� v??t tr?i h?n h?n so v?i c�c d�ng ?i?n tho?i ph? th�ng c�ng ph�n kh�c kh�c. M�y s? h?u k?t n?i 4G ?n ??nh c�ng dung l??ng pin l?n, gi�p b?n tho?i m�i tr?i nghi?m Internet nhanh ch�ng, thu?n thi?n m?i l�c, m?i n?i. N?u b?n ?ang t�m ki?m m?t m?u ?i?n tho?i ??n gi?n, ?�ng tin c?y th� Nokia 110 Pro 4G s? l� g?i � kh�ng n�n b? qua nh�!', 100),


(1, 2, 'Macbook Pro 14 M3 Pro', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/g/p/gpu.png', 48990000, N'Macbook Pro M3 Pro b?n 14 inch 18GB/512GB c� kh? n?ng l� ?? h?a chuy�n s�u, k?t c?u 3D m?t c�ch ?n ??nh v� m??t m�. B�n c?nh ?�, s?n ph?m c� ch?t l??ng hi?n th? r?t s?c n�t, v� t?n s? qu�t l�n t?i 120Hz, gi�p ng??i d�ng l�m vi?c hi?u qu?, nhanh ch�ng.', 100),
(1, 2, 'Apple Macbook Air M2 2022', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/m/a/macbook_air_m2_1_1.png', 23890000, N'Macbook Air M2 2022 v?i thi?t k? sang tr?ng, v? ngo�i si�u m?ng ??y l?ch l�m. M?u Macbook Air m?i v?i nh?ng n�ng c?p v? thi?t k? v� c?u h�nh c�ng gi� b�n ph?i ch?ng, ?�y s? l� m?t thi?t b? l� t??ng cho c�ng vi?c v� gi?i tr�.', 100),
(1, 2, 'Apple MacBook Air M1 256GB 2020', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/a/i/air_m2.png', 18690000, N'Macbook Air M1 l� d�ng s?n ph?m c� thi?t k? m?ng nh?, sang tr?ng v� tinh t? c�ng v?i ?� l� gi� th�nh ph?i ch?ng n�n MacBook Air ?� thu h�t ???c ?�ng ??o ng??i d�ng y�u th�ch v� l?a ch?n. ?�y c?ng l� m?t trong nh?ng phi�n b?n Macbook Air m?i nh?t m� kh�ch h�ng kh�ng th? b? qua khi ??n v?i HoLaTech.', 100),
(5, 2, 'Laptop ASUS TUF Gaming F15 FX506HF-HN078W', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_13__5_14.png', 17290000, N'Laptop Asus Tuf Gaming F15 FX506HF-HN078W v?i thi?t k? n?ng ??ng, mang v? ??p thu h�t v?i CPU core intel i5, GPU GeForce RTX� 2050 v� RAM 8 GB. K?t h?p l� m�n hi?n th? FHD IPS 144Hz c?c k? r� n�t. Ngo�i ra laptop Asus Gaming c?ng c� th�m h? th?ng �m thanh ??nh cao nh? v�o c�ng ngh? ti�n ti?n ?? ph?c v? t?i ?a ng??i d�ng.', 100),
(5, 2, 'Laptop ASUS ROG Strix G16 G614JU-N3135W', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_20__1_21.png', 31490000, N'Laptop Asus ROG Strix G16 G614JU-N3135W trang b? cho m�nh m?t b? vi x? l� Intel Core i5 th? h? 13 m?i nh?t cho ph�p m�y v?n h�nh m??t m� m?i t�c v?. T?c ?? x? l� l�n ??n 4.6GHz gi�p t?ng hi?u su?t, gi?m th?i gian x? l� v� cho b?n tr?i nghi?m tuy?t v?i ? c�c t?a game n?ng hay tr�nh thi?t k? ?? h?a nhi?u chi ti?t.', 100),
(5, 2, 'Laptop ASUS TUF Gaming F15 FX507VV-LP157W', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_14__4_8.png', 29990000, N'Laptop ASUS TUF Gaming F15 FX507VV-LP157W l� m?t chi?c laptop ch?i game t?m trung ???c trang b? b? vi x? l� Intel Core i7-13620H v� card ?? h?a RTX 4060 8GB GDDR6. M�n h�nh 15,6 inch Full HD c� t?n s? qu�t 144Hz cho tr?i nghi?m ch?i game m??t m� v� s?c n�t. Laptop ???c trang b? h? th?ng t?n nhi?t Arc Flow Fans gi�p duy tr� hi?u n?ng ?n ??nh trong th?i gian d�i.', 100),
(8, 2, 'Laptop Dell Vostro 3520 F0V0VI3', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/l/a/laptop-dell-vostro-3520-f0v0vi3-thumbnails.png', 9690000, N'Laptop Dell Vostro 3520 F0V0VI3 s? d?ng b? b? vi x? l� Intel Core i3 - 1215U k?t h?p v?i RAM dung l??ng 8GB cho kh? n?ng x? l� c�ng vi?c h�ng ng�y hi?u qu?. M�y ???c trang b? ? c?ng SSD PCIe t?c ?? cao v?i dung l??ng 512GB gi�p b?n truy c?p v� t?i th�ng tin nhanh ch�ng. M�n h�nh full HD k�ch th??c 15.6 inch mang ??n nh?ng khung h�nh m??t m� v� s?c n�t. M�y c� c�c c?ng giao ti?p th�ng d?ng ?? b?n d? d�ng chia s? d? li?u. ', 100),
(8, 2, 'Laptop Dell Vostro 3520 GD02R', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_6__152.png', 12490000, N'Dell Vostro 3520 GD02R c� th? ???c coi l� d�ng laptop Dell Vostro ???c ?a chu?ng b?i nh?ng ng??i d�ng v?n ph�ng nh? v�o hi?u n?ng ?n ??nh c?ng nh? m�n h�nh s?ng ??ng v?a ?�p ?ng t?t cho c? nhu c?u l�m vi?c c?ng nh? gi?i tr� h?ng ng�y.', 100),
(8, 2, 'Laptop Dell Vostro 3520', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/l/a/laptop_dell_vostro_3520i7.png', 18490000, N'Laptop Dell Vostro 3520 l� m?t trong nh?ng s?n ph?m laptop Dell Vostro ?�ng ch� � c?a th??ng hi?u Dell, ???c thi?t k? ?? ?�p ?ng nhu c?u l�m vi?c v� gi?i tr� c?a ng??i d�ng hi?n ??i. V?i thi?t k? nh? g?n, hi?u n?ng m?nh m? v� t�nh n?ng b?o m?t ?n t??ng, s?n ph?m n�y s? l� m?t tr? th? ??c l?c cho c�ng vi?c v� gi?i tr� h�ng ng�y c?a b?n.', 100),
(11, 2, 'Laptop Gaming Acer Nitro V ANV15-51-55CA', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/l/a/laptop-gaming-acer-nitro-v-anv15-51-55ca.jpg', 26990000, N'Laptop Gaming Nitro V ANV15-51-55CA ?em l?i tr?i nghi?m gaming m?nh m? v?i b? vi x? l� Intel Gen 13 i5-13420H, c�ng card ?? h?a r?i NVIDIA RTX 4050. Ngo�i ra, ?n ph?m laptop Acer gaming n�y c?ng ???c trang b? 16GB RAM DDR5, cung c?p kh? n?ng x? l� ?a nhi?m m??t m�, v� b? nh? SSD 512GB, ??m b?o t?c ?? truy xu?t d? li?u si�u nhanh ch�ng. C�ng v?i ?� l� k�ch th??c m�n h�nh 15,6 inch, t?n s? qu�t 144Hz gi�p t?i ?u h�a tr?i nghi?m h�nh ?nh s?c n�t v� m??t m� cho game th?.', 100),
(11, 2, 'Laptop Acer Swift Go 14 AI SFG14-73-71ZX NX.KSLSV.002', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/l/a/laptop-acer-swift-go-14-ai-sfg14-73-71zx.png', 26490000, N'Laptop Acer Swift Go 14 AI SFG14-73-71ZX t? h�o l� m?t trong nh?ng chi?c laptop x�ch tay t�ch h?p hi?u qu? c�ng ngh? tr� tu? nh�n t?o. K?t h?p v?i con chip Intel Core c�ng card ?? h?a Intel Arc Graphics, m?u laptop Acer Swift n�y cho hi?u su?t nhanh nh?t c� th?.', 100),
(11, 2, 'Laptop Acer Aspire 3 A315-59-381E', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/l/a/laptop-acer-aspire-3-a315-59-381e-thumbnails.png', 9790000, N'Laptop Acer Aspire 3 A315-59-381E mang ??n m?t di?n m?o thanh l?ch v?i c?u h�nh ?n ??nh trong ph�n kh�c t?m trung. V?i CPU Intel Core i3-1215U v� ? c?ng SSD dung l??ng 512GB, m�y ?�p ?ng ???c nhu c?u l�m vi?c h�ng ng�y v� gi?i tr� ?a d?ng c?a ng??i d�ng.', 100),
(11, 2, 'Laptop Acer Gaming Aspire 7 A715-76-53PJ', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_7__1_12.png', 14990000, N'Laptop Acer Gaming Aspire 7 A715-76-53PJ l� chi?c laptop s? h?u c?u h�nh m?nh v?i b? vi x? l� Intel Core th? h? 12 v� card ?? h?a Intel UHD Graphics. M�y c� m�n h�nh 15.6 inch, ?? ph�n gi?i Full HD (1920 x 1080), b? nh? RAM 16GB DDR4 v� dung l??ng l?u tr? SSD 512GB. Ngo�i ra, m�y c�n ???c trang b? c�c c?ng k?t n?i nh? HDMI, USB Type-C, USB 3.2 Gen 1 Type-A, RJ-45 v� c� kh? n?ng ch?i game t?t.', 100),
(10, 2, 'Laptop LG Gram 2023 17Z90R-G.AH78A5', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_d_i_10_.png', 38990000, N'Laptop LG Gram 2023 17Z90R-G.AH78A5 l� d�ng laptop si�u m?ng nh? c?a LG s? h?u m?t c?u h�nh ?n ??nh r?t th�ch h?p v?i ng??i d�ng v?n ph�ng. M?u laptop LG Gram 2023 n�y g�y ?n t??ng v?i ng??i d�ng v? kh? n?ng hi?n th?, hi?u n?ng s? d?ng.', 100),
(10, 2, 'Laptop LG Gram 2023 14Z90RS-G.AH54A5', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/4/14z90rs-ah54a5.png', 28490000, N'Laptop LG Gram 2023 14Z90RS-G.AH54A5 l� m?t d�ng m�y t�nh x�ch tay nh? v� m?nh m? ???c ph�t h�nh v�o n?m 2023. Th�ng qua nhi?u ??c ?i?m n?i b?t, phi�n b?n laptop LG Gram 2023 n�y h?a h?n s? mang ??n nh?ng gi�y ph�t l�m vi?c v� gi?i tr� tuy?t v?i d�nh cho b?n.', 100),
(10, 2, 'Laptop LG Gram 2023 15Z90RT-G.AH55A5', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_5__2_1.png', 31990000, N'Laptop LG Gram 2023 15Z90RT-G.AH55A5 s? h?u ki?u d�ng m?ng nh? ??c tr?ng, m�n h�nh l?n, ?em l?i h�nh ?nh s?ng ??ng. Chi?c laptop LG 2023 c� hi?u n?ng ? m?c ?n ??nh, gi�p b?n ?a nhi?m t?t v� gi?i quy?t ???c nhanh c�c t�c v? t? v?n ph�ng c? b?n ??n n�ng cao. ', 100),
(9, 2, 'Laptop HP 15 250 G8 85C69EA', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_6_3.png', 11990000, N'Laptop HP 15 250 G8 85C69EA l� d�ng m�y ???c l�m g?n nh? cho t�nh di ??ng cao, ph� h?p d�ng ???c ? m?i n?i. Hi?u su?t c?a m�y ???c duy tr� ?n ??nh nh? v�o c?u h�nh t?m trung c�ng th?i l??ng pin t?t ?? b?n ho�n th�nh nhanh ch�ng m?i t�c v?.', 100),
(9, 2, 'Laptop HP Elitebook 630 G9 6M142PA', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_14__1_65.png', 16990000, N'Laptop HP Elitebook 630 G9 6M142PA ???c gi?i doanh nh�n ?u �i l?a ch?n v?i nh?ng ??c ?i?m v??t b?c. Th�ng qua lo?t c�ng ngh? hi?n ??i c�ng b? vi x? l� i5 th? h? 12, phi�n b?n laptop HP n�y ch?c ch?n s? gi�p b?n ho�n th�nh c�ng vi?c m?t c�ch hi?u qu? v� nhanh ch�ng.', 100),
(9, 2, 'Laptop HP Pavilion 15-EG3093TU 8C5L4PA', 'https://cellphones.com.vn/laptop-hp-14-ep0112tu-8c5l1pa.html', 16990000, N'Laptop HP Pavilion 15-EG3093TU 8C5L4PA ?i c�ng b? vi x? l� CPU Gen 13 v� b? nh? RAM 16 GB chu?n DDR4 mang ??n kh? n?ng x? l� v� c�ng nhanh ch�ng. M�n h�nh r?ng 15.6 inch Full HD tr�n m�y cung c?p h�nh ?nh s?c n�t v� m�u s?c ch�n th?c. H?n n?a, ? c?ng s?n ph?m laptop HP Pavilion gi�p l?u tr? d? li?u m?t c�ch hi?u qu? v� t?i ?u h�a t?c ?? l�m vi?c.', 100),

(1, 3, 'Apple Watch SE 2 2023 40mm', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/a/p/apple-watch-se-2023-40mm.png', 5790000, N'Apple Watch SE 2023 40mm (GPS) kh�ng ch? l� m?t s?n ph?m ??ng h? xem gi?, n� c�n t�ch h?p r?t nhi?u t�nh n?ng theo d�i s?c kh?e, luy?n t?p th�ng minh. V?i thi?t k? v� c�ng sang tr?ng nh? m�n h�nh Retina, khung vi?n nh�m c�ng k�nh c??ng l?c ch?c ch?n.', 100),
(1, 3, 'Apple Watch Series 9 45mm', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/a/p/apple_lte_3__1.png', 10690000, N'??ng h? Apple Watch Series 9 45mm s? h?u on chip S9 SiP - CPU v?i 5,6 t? b�ng b�n d?n gi�p mang l?i hi?u n?ng c?i thi?n h?n 60% so v?i th? h? S8. M�n h�nh thi?t b? v?i k�ch th??c 45mm c�ng ?? s�ng t?i ?a l�n 2000 nit mang l?i tr?i nghi?m hi?n th? v??t tr?i. C�ng v?i ?�, ??ng h? Apple Watch s9 n�y c�n ???c trang b? nhi?u t�nh n?ng h? tr? theo d�i s?c kh?e v� t?p luy?n th�ng minh.', 100),
(1, 3, 'Apple Watch Ultra 2 49mm ', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/a/p/apple_watch_ultra_2.png', 20990000, N'??ng h? Apple Watch Ultra 2 s? h?u khung vi?n titan sang tr?ng c�ng con chip S9 SiP th? h? m?i mang l?i m?t tr?i nghi?m d�ng ?n ??nh v� m??t m�. ??ng h? v?i ba phi�n b?n d�y ?eo th� h?p cho t?ng nhu c?u s? d?ng kh�c nhau c?a ng??i d�ng.', 100),
(2, 3, '??ng h? Samsung Galaxy Fit 3', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/a/samsung_3.png', 1290000, N'??ng h? Samsung Galaxy Fit 3 thi?t k? thanh m?nh, g?n g�ng, m�n h�nh AMOLED 1.6 inch, tr?ng l??ng ch? 36.8g, kh�ng n??c 5ATM v� b?i IP68 c�ng vi�n pin 208mAh k�o d�i d?n 13 ng�y ?n t??ng t�ch h?p s?c kh�ng d�y.', 100);

-- Th�m d? li?u v�o b?ng Feedback
INSERT INTO Feedback (userId, pid, comment, rate) VALUES
(1, 1, 'Great phone!', 5),
(2, 2, 'Good value for money.', 4);

-- Th�m d? li?u v�o b?ng Cart
INSERT INTO Cart (userId, pid, quantity, price) VALUES
(1, 1, 1, 13390000),
(2, 2, 2, 16590000);

-- Th�m d? li?u v�o b?ng ProductCart
INSERT INTO ProductCart (pid, cartId) VALUES
(1, 1),
(2, 2);

-- Th�m d? li?u v�o b?ng Order
INSERT INTO [Order] (userId, date, status, total) VALUES
(1, '2024-06-01', 'Delivered', 13390000),
(2, '2024-06-02', 'Processing', 33180000);

-- Th�m d? li?u v�o b?ng OrderDetail
INSERT INTO OrderDetail (oid, pid, price, quantity, total) VALUES
(1, 1, 13390000, 1, 13390000),
(2, 2, 16590000, 2, 33180000);

-- Th�m d? li?u v�o b?ng Payment
INSERT INTO Payment (oid, type, date, amount) VALUES
(1, 1, '2024-06-01', 13390000),
(2, 2, '2024-06-02', 33180000);