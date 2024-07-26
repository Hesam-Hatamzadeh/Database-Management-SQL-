CREATE DATABASE Sketchy;
USE Sketchy;

CREATE TABLE Destination (
  destination_id TINYINT AUTO_INCREMENT,
  driver_id SMALLINT NOT NULL,
  start_address VARCHAR(60) NOT NULL,
  delivery_address VARCHAR(60) NOT NULL,
  departed_at DATETIME NOT NULL,
  arrived_at DATETIME NOT NULL,
  start_latitude FLOAT NOT NULL,
  start_longitude FLOAT NOT NULL,
  delivery_latitude FLOAT NOT NULL,
  delivery_longitude FLOAT NOT NULL,
  motorcycle_latitude FLOAT NOT NULL,
  motorcycle_longitude FLOAT NOT NULL,
  PRIMARY KEY (destination_id)
);

 CREATE TABLE Food_list (
  food_id SMALLINT AUTO_INCREMENT,
  restaurant_id SMALLINT NOT NULL,
  name VARCHAR(30) NOT NULL,
  description VARCHAR(100) NOT NULL,
  price DECIMAL(6,2) NOT NULL,
  unit VARCHAR(30) NOT NULL, 
  category VARCHAR(30) NOT NULL,
  PRIMARY KEY (food_id)
);

CREATE TABLE Users (
  user_id SMALLINT AUTO_INCREMENT,
  destination_id TINYINT NOT NULL,
  name VARCHAR(35) NOT NULL,
  province VARCHAR(20) NOT NULL,
  city VARCHAR(20) NOT NULL,
  street VARCHAR(20) NOT NULL,
  address VARCHAR(60) NOT NULL,
  email VARCHAR(55) NOT NULL,
  phone_no VARCHAR(20) NOT NULL,
  PRIMARY KEY (user_id),
  FOREIGN KEY (destination_id) REFERENCES Destination (destination_id)
);

CREATE TABLE Restaurant (
  restaurant_id SMALLINT AUTO_INCREMENT,
  food_id SMALLINT NOT Null,
  rest_name VARCHAR(35) NOT NULL,
  province VARCHAR(20) NOT NULL,
  city VARCHAR(20) NOT NULL,
  street VARCHAR(20) NOT NULL,
  address VARCHAR(30) NOT NULL,
  phone_no VARCHAR(20) NOT NULL,
  PRIMARY KEY (restaurant_id),
  FOREIGN KEY (food_id) REFERENCES Food_list (food_id)
);

CREATE TABLE Driver (
  driver_id SMALLINT AUTO_INCREMENT,
  name VARCHAR(35) NOT NULL,
  license_number INT NOT NULL,
  email VARCHAR(55) NOT NULL,
  phone_no VARCHAR(20) NOT NULL,
  availability_status BOOL NOT NULL,
  PRIMARY KEY (driver_id)
);

CREATE TABLE Motorcycle (
  motorcycle_id TINYINT AUTO_INCREMENT,
  driver_id SMALLINT NOT NULL,
  destination_id TINYINT NOT NULL,
  location VARCHAR(60) NOT NULL,
  license_plate VARCHAR(15) NOT NULL,
  PRIMARY KEY (motorcycle_id),
  FOREIGN KEY (driver_id) REFERENCES Driver (driver_id),
  FOREIGN KEY (destination_id) REFERENCES Destination (destination_id)
);

CREATE TABLE Ratings (
  rating_id SMALLINT AUTO_INCREMENT,
  user_id SMALLINT NOT NULL,
  driver_id SMALLINT NOT NULL,
  restaurant_id SMALLINT NOT NULL,
  user_Score TINYINT,
  driver_Score TINYINT,
  restaurant_Score TINYINT,
  rating_time DATETIME Default now(),
  PRIMARY KEY (rating_id),
  FOREIGN KEY (user_id) REFERENCES Users (user_id),
  FOREIGN KEY (driver_id) REFERENCES Driver (driver_id),
  FOREIGN KEY (restaurant_id) REFERENCES Restaurant (restaurant_id)
);

CREATE TABLE Orders (
  order_id SMALLINT AUTO_INCREMENT,
  user_id SMALLINT NOT NULL,
  restaurant_id SMALLINT NOT NULL,
  destination_id TINYINT NOT NULL,
  motorcycle_id TINYINT NOT NULL,
  order_Date DATETIME NOT NULL,
  delivery_date DATETIME NOT NULL,
  order_unit SMALLINT NOT NULL DEFAULT 1,
  order_total DECIMAL(8,2) NOT NULL,
  order_status ENUM('Pending','Processing','Completed','Cancelled'),
  PRIMARY KEY (order_id),
  FOREIGN KEY (user_id) REFERENCES Users (user_id),
  FOREIGN KEY (restaurant_id) REFERENCES Restaurant (restaurant_id),
  FOREIGN KEY (destination_id) REFERENCES Destination (destination_id),
  FOREIGN KEY (motorcycle_id) REFERENCES Motorcycle (motorcycle_id)
);

CREATE TABLE payment (
  payment_id SMALLINT AUTO_INCREMENT,
  user_id SMALLINT NOT NULL,
  order_id SMALLINT NOT NULL,
  amount DECIMAL(8,2) NOT NULL,
  payment_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  payment_method ENUM('credit_card', 'cash', 'sketchy wallet') NOT NULL,
  PRIMARY KEY (payment_id),
  FOREIGN KEY (user_id) REFERENCES Users (user_id),
  FOREIGN KEY (order_id) REFERENCES Orders (order_id)
);

SHOW FULL TABLES;

#Inserting Data

INSERT INTO Destination (driver_id, start_address, delivery_address, departed_at, arrived_at, start_latitude, start_longitude, delivery_latitude, delivery_longitude, motorcycle_latitude, motorcycle_longitude) VALUES
(1, 'Kadikoy, Istanbul', 'Besiktas, Istanbul', '2023-06-10 09:00:00', '2023-06-10 10:00:00', 41.0065, 29.0288, 41.0427, 29.0078, 41.0424, 29.0075),
(2, 'Bornova, Izmir', 'Karsiyaka, Izmir', '2023-06-10 14:10:00', '2023-06-10 15:15:00', 38.4371, 27.1517, 38.4726, 27.1167, 38.4723, 27.1170),
(3, 'Cankaya, Ankara', 'Kizilay, Ankara', '2023-06-10 15:20:00', '2023-06-10 16:10:00', 39.9212, 32.8540, 39.9205, 32.8545, 39.9207, 32.8543),
(4, 'Muratpasa, Antalya', 'Konyaalti, Antalya', '2023-06-10 15:50:00', '2023-06-10 17:00:00', 36.8842, 30.7056, 36.8775, 30.7112, 36.8778, 30.7109),
(5, 'Mamak, Ankara', 'Cankaya, Ankara', '2023-06-10 16:45:00', '2023-06-10 18:00:00', 39.9590, 32.7939, 39.9212, 32.8540, 39.9210, 32.8542),
(6, 'Cigli, Izmir', 'Konak, Izmir', '2023-06-10 17:40:00', '2023-06-10 19:00:00', 38.5066, 27.0125, 38.4184, 27.1287, 38.4187, 27.1284),
(7, 'Merkez, Bursa', 'Nilufer, Bursa', '2023-06-10 19:10:00', '2023-06-10 20:00:00', 40.1916, 29.0610, 40.2242, 29.0347, 40.2239, 29.0350),
(8, 'Altindag, Ankara', 'Kecioren, Ankara', '2023-06-10 20:00:00', '2023-06-10 21:00:00', 39.9380, 32.8583, 39.9835, 32.8601, 39.9838, 32.8600),
(9, 'Cinar, Diyarbakir', 'Baglar, Diyarbakir', '2023-06-10 20:25:00', '2023-06-10 22:00:00', 37.9155, 40.2044, 37.9177, 40.2073, 37.9179, 40.2072),
(10, 'Gungoren, Istanbul', 'Esenler, Istanbul', '2023-06-10 22:10:00', '2023-06-10 23:00:00', 41.0333, 28.8637, 41.0464, 28.8744, 41.0461, 28.8741),
(11, 'Eskisehir Yolu, Bursa', 'Gemlik, Bursa', '2023-06-10 23:00:00', '2023-06-11 00:00:00', 40.1586, 29.0744, 40.4217, 29.1564, 40.4213, 29.1561),
(12, 'Cayyolu, Ankara', 'Yenimahalle, Ankara', '2023-06-10 00:10:00', '2023-06-11 01:00:00', 40.1074, 32.5524, 39.9774, 32.6815, 39.9777, 32.6812),
(13, 'Kucukpark, Antalya', 'Lara, Antalya', '2023-06-10 01:10:00', '2023-06-11 02:00:00', 36.8866, 30.7100, 36.8624, 30.7352, 36.8627, 30.7349),
(14, 'Yenisehir, Izmir', 'Gaziemir, Izmir', '2023-06-10 02:10:00', '2023-06-11 03:00:00', 38.6124, 27.0498, 38.3223, 27.1359, 38.3220, 27.1362),
(15, 'Cinarli, Mersin', 'Akdeniz, Mersin', '2023-06-10 03:00:00', '2023-06-11 04:15:00', 36.8014, 34.6074, 36.7989, 34.6151, 36.7993, 34.6149),
(16, 'Karsiyaka, Izmir', 'Bornova, Izmir', '2023-06-11 03:45:00', '2023-06-11 05:00:00', 38.4723, 27.1170, 38.4371, 27.1517, 38.4368, 27.1514),
(17, 'Kecioren, Ankara', 'Cankaya, Ankara', '2023-06-11 04:45:00', '2023-06-11 06:00:00', 39.9838, 32.8600, 39.9212, 32.8540, 39.9209, 32.8543),
(18, 'Beyoglu, Istanbul', 'Kadikoy, Istanbul', '2023-06-11 05:30:00', '2023-06-11 07:00:00', 41.0297, 28.9795, 41.0065, 29.0288, 41.0062, 29.0285),
(19, 'Nilufer, Bursa', 'Osmangazi, Bursa', '2023-06-11 07:00:00', '2023-06-11 08:00:00', 40.2242, 29.0347, 40.1860, 29.0609, 40.1857, 29.0611),
(20, 'Bahcelievler, Ankara', 'Yenimahalle, Ankara', '2023-06-11 07:45:00', '2023-06-11 09:00:00', 39.9283, 32.8471, 39.9774, 32.6815, 39.9771, 32.6812);


INSERT INTO Food_list (restaurant_id, name, description, price, unit, category) VALUES
(1, 'Margherita Pizza', 'Classic pizza with tomato sauce, mozzarella cheese, and basil', 55.99, 'piece', 'Pizza'),
(1, 'Spaghetti Bolognese', 'Spaghetti pasta with Bolognese meat sauce', 62.50, 'plate', 'Pasta'),
(1, 'Caesar Salad', 'Romaine lettuce, croutons, Parmesan cheese, and Caesar dressing', 48.99, 'bowl', 'Salad'),
(2, 'Kebab Platter', 'Assortment of grilled kebabs served with rice and salad', 69.99, 'platter', 'Grill'),
(2, 'Lamb Shish Kebab', 'Grilled skewers of marinated lamb cubes', 54.99, 'skewer', 'Grill'),
(2, 'Baklava', 'Traditional Turkish pastry with layers of filo, nuts, and syrup', 36.99, 'piece', 'Dessert'),
(3, 'Sushi Combo', 'Assortment of fresh sushi rolls and nigiri', 82.99, 'platter', 'Japanese'),
(3, 'Miso Soup', 'Traditional Japanese soup with tofu, seaweed, and scallions', 23.99, 'bowl', 'Japanese'),
(3, 'Chicken Teriyaki', 'Grilled chicken with teriyaki sauce served with steamed rice', 43.50, 'plate', 'Japanese'),
(4, 'Hamburger', 'Beef patty, lettuce, tomato, onion, and cheese in a bun', 59.99, 'burger', 'Burger'),
(4, 'French Fries', 'Crispy potato fries seasoned with salt', 23.50, 'portion', 'Side'),
(4, 'Milkshake', 'Creamy milkshake with your choice of flavor', 44.99, 'glass', 'Beverage'),
(5, 'Peking Duck', 'Roasted duck served with pancakes, scallions, and hoisin sauce', 98.99, 'half', 'Chinese'),
(5, 'Sweet and Sour Chicken', 'Crispy chicken in sweet and sour sauce with bell peppers and pineapple', 72.99, 'plate', 'Chinese'),
(5, 'Egg Fried Rice', 'Stir-fried rice with egg, vegetables, and soy sauce', 48.99, 'plate', 'Chinese'),
(6, 'Caprese Salad', 'Fresh mozzarella, tomatoes, and basil with balsamic glaze', 59.99, 'bowl', 'Salad'),
(6, 'Ravioli al Pomodoro', 'Homemade ravioli filled with ricotta cheese in tomato sauce', 64.50, 'plate', 'Pasta'),
(6, 'Tiramisu', 'Classic Italian dessert with layers of ladyfingers, coffee, and mascarpone cream', 57.99, 'piece', 'Dessert'),
(7, 'Chicken Curry', 'Tender chicken in aromatic curry sauce served with rice', 41.99, 'plate', 'Indian'),
(7, 'Garlic Naan', 'Traditional Indian bread brushed with garlic butter', 43.50, 'piece', 'Indian'),
(7, 'Mango Lassi', 'Refreshing yogurt-based drink with mango flavor', 54.99, 'glass', 'Beverage');


INSERT INTO Users (destination_id, name, province, city, street, address, email, phone_no)
VALUES
(1, 'Ali Yılmaz', 'İstanbul', 'Kadıköy', 'Atatürk Caddesi', 'Atatürk Caddesi No: 123', 'ali@example.com', 5551234567),
(2, 'Ayşe Demir', 'İstanbul', 'Beyoğlu', 'İstiklal Caddesi', 'İstiklal Caddesi No: 456', 'ayse@example.com', 5552345678),
(3, 'Mehmet Kaya', 'Ankara', 'Çankaya', 'Tunus Caddesi', 'Tunus Caddesi No: 789', 'mehmet@example.com', 5553456789),
(4, 'Fatma Öztürk', 'İzmir', 'Karşıyaka', 'Mithatpaşa Caddesi', 'Mithatpaşa Caddesi No: 012', 'fatma@example.com', 5554567890),
(5, 'Ahmet Arslan', 'Bursa', 'Osmangazi', 'Cumhuriyet Caddesi', 'Cumhuriyet Caddesi No: 345', 'ahmet@example.com', 5555678901),
(6, 'Zeynep Avcı', 'Antalya', 'Muratpaşa', 'Barbaros Caddesi', 'Barbaros Caddesi No: 678', 'zeynep@example.com', 5556789012),
(7, 'Mustafa Kılıç', 'İstanbul', 'Üsküdar', 'Bağlarbaşı Caddesi', 'Bağlarbaşı Caddesi No: 901', 'mustafa@example.com', 5557890123),
(8, 'Aylin Şahin', 'Ankara', 'Keçiören', 'Eskişehir Yolu', 'Eskişehir Yolu No: 234', 'aylin@example.com', 5558901234),
(9, 'Ömer Şahin', 'İzmir', 'Bornova', 'Doğanlar Caddesi', 'Doğanlar Caddesi No: 567', 'omer@example.com', 5559012345),
(10, 'Selin Yıldırım', 'Bursa', 'Nilüfer', 'Yıldırım Caddesi', 'Yıldırım Caddesi No: 890', 'selin@example.com', 5550123456),
(11, 'Emre Demirci', 'Antalya', 'Konyaaltı', 'Menderes Bulvarı', 'Menderes Bulvarı No: 123', 'emre@example.com', 5551234567),
(12, 'Ceren Aksoy', 'İstanbul', 'Sarıyer', 'Yeni Mahalle', 'Yeni Mahalle No: 456', 'ceren@example.com', 5552345678),
(13, 'Murat Yılmaz', 'Ankara', 'Yenimahalle', 'İstiklal Caddesi', 'İstiklal Caddesi No: 789', 'murat@example.com', 5553456789),
(14, 'Deniz Yıldız', 'İstanbul', 'Beşiktaş', 'Abdi İpekçi Caddesi', 'Abdi İpekçi Caddesi No: 345', 'deniz@example.com', 5554567890),
(15, 'Eren Can', 'Ankara', 'Etimesgut', 'Anıttepe Caddesi', 'Anıttepe Caddesi No: 678', 'eren@example.com', 5555678901),
(16, 'Gizem Özdemir', 'İzmir', 'Konak', 'Gazi Bulvarı', 'Gazi Bulvarı No: 901', 'gizem@example.com', 5556789012),
(17, 'Hasan Yılmaz', 'Bursa', 'Yıldırım', 'İzmir Yolu', 'İzmir Yolu No: 234', 'hasan@example.com', 5557890123),
(18, 'İpek Şahin', 'Antalya', 'Kepez', 'Dumlupınar Bulvarı', 'Dumlupınar Bulvarı No: 567', 'ipek@example.com', 5558901234),
(19, 'Kadir Karadağ', 'İstanbul', 'Bağcılar', 'Maltepe Caddesi', 'Maltepe Caddesi No: 890', 'kadir@example.com', 5559012345),
(20, 'Leyla Doğan', 'Ankara', 'Gölbaşı', 'Çankaya Caddesi', 'Çankaya Caddesi No: 123', 'leyla@example.com', 5550123456);


INSERT INTO Restaurant (food_id, rest_name, province, city, street, address, phone_no)
VALUES
(1, 'Lezzet Pide', 'İstanbul', 'Kadıköy', 'Rasimpaşa Mahallesi', 'Rasimpaşa Caddesi No: 123', '5551234567'),
(2, 'Mangal Keyfi', 'İstanbul', 'Beyoğlu', 'İstiklal Caddesi', 'İstiklal Caddesi No: 456', '5552345678'),
(3, 'Ankara Sofrası', 'Ankara', 'Çankaya', 'Tunus Caddesi', 'Tunus Caddesi No: 789', '5553456789'),
(4, 'İzmir Balıkçısı', 'İzmir', 'Karşıyaka', 'Mithatpaşa Caddesi', 'Mithatpaşa Caddesi No: 012', '5554567890'),
(5, 'Bursa Kebap Evi', 'Bursa', 'Osmangazi', 'Cumhuriyet Caddesi', 'Cumhuriyet Caddesi No: 345', '5555678901'),
(6, 'Antalya Restoranı', 'Antalya', 'Muratpaşa', 'Barbaros Caddesi', 'Barbaros Caddesi No: 678', '5556789012'),
(7, 'Üsküdar Lezzetleri', 'İstanbul', 'Üsküdar', 'Bağlarbaşı Caddesi', 'Bağlarbaşı Caddesi No: 901', '5557890123'),
(8, 'Ankara Et Lokantası', 'Ankara', 'Keçiören', 'Eskişehir Yolu', 'Eskişehir Yolu No: 234', '5558901234'),
(9, 'İzmir Ev Yemekleri', 'İzmir', 'Bornova', 'Doğanlar Caddesi', 'Doğanlar Caddesi No: 567', '5559012345'),
(10, 'Bursa İskender', 'Bursa', 'Nilüfer', 'Yıldırım Caddesi', 'Yıldırım Caddesi No: 890', '5550123456'),
(11, 'Antalya Dönercisi', 'Antalya', 'Konyaaltı', 'Menderes Bulvarı', 'Menderes Bulvarı No: 123', '5551234567'),
(12, 'Sarıyer Balık Evi', 'İstanbul', 'Sarıyer', 'Yeni Mahalle', 'Yeni Mahalle No: 456', '5552345678'),
(13, 'Ankara Lahmacunu', 'Ankara', 'Yenimahalle', 'İstiklal Caddesi', 'İstiklal Caddesi No: 789', '5553456789'),
(14, 'İstanbul Pide Salonu', 'İstanbul', 'Fatih', 'Hoca Paşa Mahallesi', 'Hoca Paşa Caddesi No: 012', '5554567890'),
(15, 'İzmir Köfteci', 'İzmir', 'Konak', 'Gazi Bulvarı', 'Gazi Bulvarı No: 345', '5555678901'),
(16, 'Bursa Mantıcı', 'Bursa', 'Yıldırım', 'Yavuz Selim Caddesi', 'Yavuz Selim Caddesi No: 678', '5556789012'),
(17, 'Antalya Deniz Mahsulleri', 'Antalya', 'Lara', 'Yunus Nadi Caddesi', 'Yunus Nadi Caddesi No: 901', '5557890123'),
(18, 'Ankara Kebapçısı', 'Ankara', 'Sincan', 'İnönü Caddesi', 'İnönü Caddesi No: 234', '5558901234'),
(19, 'İzmir Pideci', 'İzmir', 'Buca', 'Ege Caddesi', 'Ege Caddesi No: 567', '5559012345'),
(20, 'Bursa Et Lokantası', 'Bursa', 'Gürsu', 'Necatibey Caddesi', 'Necatibey Caddesi No: 890', '5550123456');



INSERT INTO Driver (name, license_number, email, phone_no, availability_status)
VALUES
('Ahmet Yılmaz', 123456789, 'ahmet@example.com', 5551234567, 1),
('Ayşe Demir', 987654321, 'ayse@example.com', 5552345678, 1),
('Mehmet Kaya', 456789123, 'mehmet@example.com', 5553456789, 1),
('Fatma Öztürk', 321654987, 'fatma@example.com', 5554567890, 1),
('Ali Arslan', 159753468, 'ali@example.com', 5555678901, 1),
('Zeynep Avcı', 654321987, 'zeynep@example.com', 5556789012, 1),
('Mustafa Kılıç', 852963741, 'mustafa@example.com', 5557890123, 1),
('Aylin Şahin', 741852963, 'aylin@example.com', 5558901234, 1),
('Ömer Şahin', 369258147, 'omer@example.com', 5559012345, 1),
('Selin Yıldırım', 147258369, 'selin@example.com', 5550123456, 1),
('Emre Demirci', 258369147, 'emre@example.com', 5551234567, 1),
('Ceren Aksoy', 963852741, 'ceren@example.com', 5552345678, 1),
('Murat Yılmaz', 456789123, 'murat@example.com', 5553456789, 1),
('Ebru Aydın', 987654321, 'ebru@example.com', 5554567890, 1),
('Gökhan Koç', 123456789, 'gokhan@example.com', 5555678901, 1),
('Elif Uzun', 369258147, 'elif@example.com', 5556789012, 1),
('Oğuzhan Güneş', 741852963, 'oguzhan@example.com', 5557890123, 1),
('Seda Yıldız', 852963741, 'seda@example.com', 5558901234, 1),
('Kadir Çelik', 654321987, 'kadir@example.com', 5559012345, 1),
('Gizem Yılmaz', 258369147, 'gizem@example.com', 5550123456, 1);



INSERT INTO Motorcycle (driver_id, destination_id, location, license_plate)
VALUES
(1, 1, 'İstanbul', '34 AB 1234'),
(2, 2, 'İstanbul', '34 CD 5678'),
(3, 3, 'Ankara', '06 EF 9012'),
(4, 4, 'İzmir', '35 GH 3456'),
(5, 5, 'Bursa', '16 IJ 7890'),
(6, 6, 'Antalya', '07 KL 2345'),
(7, 7, 'İstanbul', '34 MN 6789'),
(8, 8, 'Ankara', '06 OP 0123'),
(9, 9, 'İzmir', '35 QR 4567'),
(10, 10, 'Bursa', '16 ST 8901'),
(11, 11, 'Antalya', '07 UV 2345'),
(12, 12, 'İstanbul', '34 WX 6789'),
(13, 13, 'Ankara', '06 YZ 0123'),
(14, 14, 'İzmir', '35 AB 4567'),
(15, 15, 'Bursa', '16 CD 8901'),
(16, 16, 'Antalya', '07 EF 2345'),
(17, 17, 'İstanbul', '34 GH 6789'),
(18, 18, 'Ankara', '06 IJ 0123'),
(19, 19, 'İzmir', '35 KL 4567'),
(20, 20, 'Bursa', '16 MN 8901');



INSERT INTO Ratings (user_id, driver_id, restaurant_id, user_Score, driver_Score, restaurant_Score)
VALUES
(1, 1, 1, 4.5, 4.8, 4.2),
(2, 2, 2, 3.7, 4.2, 3.9),
(3, 3, 3, 4.2, 4.5, 4.6),
(4, 4, 4, 4.8, 4.7, 4.4),
(5, 5, 5, 3.5, 3.9, 3.8),
(6, 6, 6, 4.6, 4.5, 4.7),
(7, 7, 7, 4.2, 4.1, 4.3),
(8, 8, 8, 4.7, 4.6, 4.5),
(9, 9, 9, 3.9, 3.7, 4.0),
(10, 10, 10, 4.3, 4.2, 4.1),
(11, 11, 11, 4.5, 4.8, 4.6),
(12, 12, 12, 4.2, 4.4, 4.3),
(13, 13, 13, 4.7, 4.6, 4.8),
(14, 14, 14, 4.0, 4.1, 3.9),
(15, 15, 15, 4.6, 4.5, 4.7),
(16, 16, 16, 4.2, 4.3, 4.1),
(17, 17, 17, 4.8, 4.7, 4.6),
(18, 18, 18, 3.7, 3.9, 4.0),
(19, 19, 19, 4.1, 4.3, 4.2),
(20, 20, 20, 4.5, 4.6, 4.4);


INSERT INTO Orders (user_id, restaurant_id, destination_id, motorcycle_id, order_Date, delivery_date, order_unit, order_total, order_status)
VALUES
(1, 1, 1, 1, '2023-06-01 12:00:00', '2023-06-01 12:30:00', 2, 50.00, 'Completed'),
(1, 2, 1, 2, '2023-06-02 12:30:00', '2023-06-01 13:40:00', 2, 75.00, 'Completed'),
(2, 2, 4, 3, '2023-06-02 12:30:00', '2023-06-02 12:50:00', 2, 100.00, 'Processing'),
(2, 3, 8, 2, '2023-06-04 14:30:00', '2023-06-04 15:40:00', 2, 30.00, 'Completed'),
(3, 5, 10, 4, '2023-06-03 13:30:00', '2023-06-03 14:40:00', 2, 40.00, 'Processing'),
(4, 5, 9, 2, '2023-06-02 12:30:00', '2023-06-02 12:50:00', 2, 60.00, 'Pending'),
(2, 4, 8, 2, '2023-06-03 15:30:00', '2023-06-03 16:40:00', 2, 35.00, 'Completed'),
(3, 4, 12, 3, '2023-06-04 16:30:00', '2023-06-04 17:40:00', 2, 55.00, 'Completed'),
(2, 2, 2, 2, '2023-06-02 13:30:00', '2023-06-02 14:00:00', 3, 75.00, 'Processing'),
(3, 3, 3, 3, '2023-06-03 18:00:00', '2023-06-03 18:30:00', 1, 30.00, 'Pending'),
(4, 4, 4, 4, '2023-06-04 20:30:00', '2023-06-04 21:00:00', 2, 55.00, 'Completed'),
(5, 5, 5, 5, '2023-06-05 14:30:00', '2023-06-05 15:00:00', 1, 25.00, 'Completed'),
(6, 5, 4, 7, '2023-06-05 14:30:00', '2023-06-05 15:20:00', 1, 35.00, 'Cancelled'),
(7, 6, 4, 5, '2023-06-05 15:30:00', '2023-06-05 17:00:00', 1, 25.00, 'Completed'),
(8, 7, 6, 5, '2023-06-05 14:30:00', '2023-06-05 15:00:00', 1, 25.00, 'Cancelled'),
(5, 8, 6, 5, '2023-06-05 14:30:00', '2023-06-05 15:00:00', 1, 25.00, 'Cancelled'),
(6, 6, 6, 6, '2023-06-06 17:00:00', '2023-06-06 17:30:00', 4, 100.00, 'Completed'),
(7, 7, 7, 7, '2023-06-07 11:30:00', '2023-06-07 12:00:00', 2, 60.00, 'Processing'),
(8, 8, 8, 8, '2023-06-08 15:30:00', '2023-06-08 16:00:00', 1, 35.00, 'Completed'),
(9, 9, 9, 9, '2023-06-09 19:00:00', '2023-06-09 19:30:00', 3, 80.00, 'Processing'),
(10, 10, 10, 10, '2023-06-10 16:30:00', '2023-06-10 17:00:00', 2, 50.00, 'Completed'),
(11, 11, 11, 11, '2023-06-11 12:00:00', '2023-06-11 12:30:00', 1, 30.00, 'Completed'),
(12, 12, 12, 12, '2023-06-12 14:30:00', '2023-06-12 15:00:00', 2, 55.00, 'Processing'),
(13, 13, 13, 13, '2023-06-13 18:30:00', '2023-06-13 19:00:00', 1, 25.00, 'Pending'),
(14, 14, 14, 14, '2023-06-14 20:00:00', '2023-06-14 20:30:00', 3, 85.00, 'Processing'),
(15, 15, 15, 15, '2023-06-15 15:30:00', '2023-06-15 16:00:00', 2, 50.00, 'Completed'),
(16, 16, 16, 16, '2023-06-16 13:00:00', '2023-06-16 13:30:00', 1, 30.00, 'Completed'),
(17, 17, 17, 17, '2023-06-17 17:30:00', '2023-06-17 18:00:00', 4, 105.00, 'Cancelled'),
(18, 18, 18, 18, '2023-06-18 11:30:00', '2023-06-18 12:00:00', 2, 60.00, 'Processing'),
(19, 19, 19, 19, '2023-06-19 16:00:00', '2023-06-19 16:30:00', 1, 35.00, 'Completed'),
(20, 20, 20, 20, '2023-06-20 19:30:00', '2023-06-20 20:00:00', 3, 90.00, 'Processing');


INSERT INTO payment (user_id, order_id, amount, payment_method)
VALUES
(1, 1, 50.00, 'credit_card'),
(2, 2, 75.00, 'cash'),
(3, 3, 30.00, 'sketchy wallet'),
(4, 4, 55.00, 'credit_card'),
(5, 5, 25.00, 'cash'),
(6, 6, 100.00, 'sketchy wallet'),
(7, 7, 60.00, 'credit_card'),
(8, 8, 35.00, 'cash'),
(9, 9, 80.00, 'sketchy wallet'),
(10, 10, 50.00, 'credit_card'),
(11, 11, 30.00, 'cash'),
(12, 12, 55.00, 'sketchy wallet'),
(13, 13, 25.00, 'credit_card'),
(14, 14, 85.00, 'cash'),
(15, 15, 50.00, 'sketchy wallet'),
(16, 16, 30.00, 'credit_card'),
(17, 17, 105.00, 'cash'),
(18, 18, 60.00, 'sketchy wallet'),
(19, 19, 35.00, 'credit_card'),
(20, 20, 90.00, 'sketchy wallet'),
(10, 21, 80.00, 'credit_card'),
(11, 22, 70.00, 'sketchy wallet'),
(12, 23, 190.00, 'credit_card'),
(13, 24, 190.00, 'cash'),
(14, 25, 70.00, 'sketchy wallet'),
(15, 26, 50.00, 'credit_card'),
(16, 27, 35.00, 'cash'),
(17, 28, 45.00, 'credit_card'),
(18, 29, 75.00, 'cash'),
(19, 30, 65.00, 'credit_card'),
(20, 31, 60.00, 'sketchy wallet');

#distance between the start location and the motorcycle location in kilometers.
CREATE VIEW DestinationDistance AS
SELECT destination_id, driver_id, start_address, delivery_address,
  departed_at, arrived_at, start_latitude, start_longitude,
  delivery_latitude, delivery_longitude,
  motorcycle_latitude, motorcycle_longitude,
  ROUND(6371 * 2 * ASIN(SQRT(
    POWER(SIN((RADIANS(motorcycle_latitude) - RADIANS(start_latitude)) / 2), 2) +
    COS(RADIANS(start_latitude)) * COS(RADIANS(motorcycle_latitude)) *
    POWER(SIN((RADIANS(motorcycle_longitude) - RADIANS(start_longitude)) / 2), 2)
  )), 2) AS distance_km
FROM Destination;

#View to get all completed orders with order details:
CREATE VIEW CompletedOrders AS
SELECT O.order_id, O.order_Date, O.delivery_date, U.name AS user_name, R.rest_name AS restaurant_name, O.order_total
FROM Orders O
JOIN Users U ON O.user_id = U.user_id
JOIN Restaurant R ON O.restaurant_id = R.restaurant_id
WHERE O.order_status = 'Completed';

#View to get the average ratings for each driver:
CREATE VIEW DriverRatings AS
SELECT D.driver_id, D.name, AVG(R.driver_Score) AS average_rating
FROM Driver D
JOIN Ratings R ON D.driver_id = R.driver_id
GROUP BY D.driver_id, D.name;

#View to get the total revenue for each restaurant:
CREATE VIEW RestaurantRevenue AS
SELECT R.restaurant_id, R.rest_name, SUM(O.order_total) AS total_revenue
FROM Restaurant R
JOIN Orders O ON R.restaurant_id = O.restaurant_id
WHERE O.order_status = 'Completed'
GROUP BY R.restaurant_id, R.rest_name;

#View to get the count of orders placed by each user:
CREATE VIEW UserOrderCount AS
SELECT U.user_id, U.name, COUNT(*) AS order_count
FROM Users U
JOIN Orders O ON U.user_id = O.user_id
GROUP BY U.user_id, U.name;

#View to get the top-rated restaurants based on average ratings:
CREATE VIEW TopRatedRestaurants AS
SELECT R.restaurant_id, R.rest_name, AVG(RT.restaurant_Score) AS average_rating
FROM Restaurant R
JOIN Ratings RT ON R.restaurant_id = RT.restaurant_id
GROUP BY R.restaurant_id, R.rest_name
HAVING AVG(RT.restaurant_Score) >= 4.5;

#View to get the list of drivers available for delivery:
CREATE VIEW AvailableDrivers AS
SELECT driver_id, name, email, phone_no
FROM Driver
WHERE availability_status = 1;

#View to get the total count of orders for each day:
CREATE VIEW DailyOrderCount AS
SELECT DATE(order_Date) AS order_day, COUNT(*) AS order_count
FROM Orders
GROUP BY order_day;

#View to get the average order total for each restaurant:
CREATE VIEW AverageOrderTotal AS
SELECT restaurant_id, AVG(order_total) AS average_total
FROM Orders
WHERE order_status = 'Completed'
GROUP BY restaurant_id;

#View to get the busiest delivery locations:
CREATE VIEW BusiestDeliveryLocations AS
SELECT delivery_address, COUNT(*) AS delivery_count
FROM Destination
GROUP BY delivery_address
ORDER BY delivery_count DESC;

#View to get the list of users who have made payments through Sketchy Wallet:
CREATE VIEW UsersWithSketchyWallet AS
SELECT U.user_id, U.name, U.email
FROM Users U
JOIN payment P ON U.user_id = P.user_id
WHERE P.payment_method = 'sketchy wallet';

#View to get the average ratings for each restaurant:
CREATE VIEW RestaurantRatings AS
SELECT R.restaurant_id, R.rest_name, AVG(RT.restaurant_Score) AS average_rating
FROM Restaurant R
JOIN Ratings RT ON R.restaurant_id = RT.restaurant_id
GROUP BY R.restaurant_id, R.rest_name;

#View to get the total number of orders for each restaurant:
CREATE VIEW TotalOrdersPerRestaurant AS
SELECT R.restaurant_id, R.rest_name, COUNT(*) AS total_orders
FROM Restaurant R
JOIN Orders O ON R.restaurant_id = O.restaurant_id
GROUP BY R.restaurant_id, R.rest_name;

#View to get the most popular food items by order count:
CREATE VIEW PopularFoodItems AS
SELECT F.food_id, F.name, COUNT(*) AS order_count
FROM Food_list F
JOIN Orders O ON F.restaurant_id = O.restaurant_id
GROUP BY F.food_id, F.name
ORDER BY order_count DESC;

#View to get the list of drivers with their current location:
CREATE VIEW DriverLocations AS
SELECT D.driver_id, D.name, M.location
FROM Driver D
JOIN Motorcycle M ON D.driver_id = M.driver_id;

#View to get the count of orders by order status:
CREATE VIEW OrderStatusCount AS
SELECT order_status, COUNT(*) AS order_count
FROM Orders
GROUP BY order_status;

#View to get the average ratings for each user:
CREATE VIEW UserRatings AS
SELECT U.user_id, U.name, AVG(R.user_Score) AS average_rating
FROM Users U
JOIN Ratings R ON U.user_id = R.user_id
GROUP BY U.user_id, U.name;

#View to get the total revenue for each day:
CREATE VIEW DailyRevenue AS
SELECT DATE(order_Date) AS order_day, SUM(order_total) AS total_revenue
FROM Orders
WHERE order_status = 'Completed'
GROUP BY order_day;

#View to get the list of drivers with their average ratings:
CREATE VIEW DriverAverageRatings AS
SELECT D.driver_id, D.name, AVG(R.driver_Score) AS average_rating
FROM Driver D
JOIN Ratings R ON D.driver_id = R.driver_id
GROUP BY D.driver_id, D.name;

#View to get the count of orders for each food category:
CREATE VIEW OrdersPerCategory AS
SELECT F.category, COUNT(*) AS order_count
FROM Food_list F
JOIN Orders O ON F.restaurant_id = O.restaurant_id
GROUP BY F.category;

#View to get the list of users who have placed the highest number of orders:
CREATE VIEW TopOrderingUsers AS
SELECT U.user_id, U.name, COUNT(*) AS order_count
FROM Users U
JOIN Orders O ON U.user_id = O.user_id
GROUP BY U.user_id, U.name
ORDER BY order_count DESC;

#View to get the top-rated food items with their respective restaurants and average ratings:
CREATE VIEW TopRatedFoodItems AS
SELECT F.food_id, F.name AS food_name, R.rest_name AS restaurant_name, AVG(RT.restaurant_Score) AS average_rating
FROM Food_list F
JOIN Restaurant R ON F.restaurant_id = R.restaurant_id
JOIN Ratings RT ON R.restaurant_id = RT.restaurant_id
GROUP BY F.food_id, F.name, R.rest_name
HAVING AVG(RT.restaurant_Score) >= 4.5;

#View to get the most active drivers with their total completed orders and average ratings:
CREATE VIEW MostActiveDrivers AS
SELECT D.driver_id, D.name, COUNT(*) AS total_orders, AVG(R.driver_Score) AS average_rating
FROM Driver D
JOIN Motorcycle M ON D.driver_id = M.driver_id
JOIN Orders O ON M.motorcycle_id = O.motorcycle_id
JOIN Ratings R ON D.driver_id = R.driver_id
WHERE O.order_status = 'Completed'
GROUP BY D.driver_id, D.name
ORDER BY total_orders DESC;

#View to get the orders with their respective users, restaurants, and delivery locations:
CREATE VIEW OrderDetails AS
SELECT O.order_id, U.name AS user_name, R.rest_name AS restaurant_name, D.delivery_address, D.arrived_at
FROM Orders O
JOIN Users U ON O.user_id = U.user_id
JOIN Restaurant R ON O.restaurant_id = R.restaurant_id
JOIN Destination D ON O.destination_id = D.destination_id;

# View to indicate the customers, orders, and average income of restaurants
CREATE VIEW RestTransactionsInfo AS
SELECT
  t2.restaurant_id,
  t2.rest_name,
  COUNT(t1.order_id) AS order_count,
  COUNT(DISTINCT t3.user_id) AS customer_count,
  SUM(t4.amount) AS total_income
FROM
  Orders t1
  INNER JOIN Restaurant t2 ON t1.restaurant_id = t2.restaurant_id
  INNER JOIN Users t3 ON t1.user_id = t3.user_id
  INNER JOIN payment t4 ON t1.order_id = t4.order_id
GROUP BY t2.restaurant_id, t2.rest_name;

select * from RestTransactionsInfo;

# View to get closest motorcycle to the destination
CREATE VIEW ClosestMotorcycle AS
SELECT destination_id, motorcycle_id, driver_id, start_address, delivery_address, departed_at, arrived_at, start_latitude, start_longitude,delivery_latitude, delivery_longitude, motorcycle_latitude, motorcycle_longitude, ROUND(6371 * 2 * ASIN(SQRT(POWER(SIN((RADIANS(motorcycle_latitude) - RADIANS(start_latitude)) / 2), 2) +
COS(RADIANS(start_latitude)) * COS(RADIANS(motorcycle_latitude)) *
POWER(SIN((RADIANS(motorcycle_longitude) - RADIANS(start_longitude)) / 2), 2))), 2) AS distance_km
FROM Destination t1 
INNER JOIN Driver t2 on t1.driver_id = t2.driver_id
INNER JOIN Motorcycle t3 on t2.motorcycle_id = t3.motorcycle_id
ORDER BY distance_km ASC;

# View to get closest motorcycle to the destination
CREATE VIEW ClosestMotorcycle AS
SELECT t1.destination_id, motorcycle_id, t1.driver_id, start_address, delivery_address, departed_at, arrived_at, start_latitude, start_longitude, delivery_latitude, delivery_longitude, motorcycle_latitude, motorcycle_longitude, ROUND(6371 * 2 * ASIN(SQRT(POWER(SIN((RADIANS(motorcycle_latitude) - RADIANS(start_latitude)) / 2), 2) +
COS(RADIANS(start_latitude)) * COS(RADIANS(motorcycle_latitude)) *
POWER(SIN((RADIANS(motorcycle_longitude) - RADIANS(start_longitude)) / 2), 2))), 2) AS distance_km
FROM Destination t1 
INNER JOIN Driver t2 ON t1.driver_id = t2.driver_id
INNER JOIN Motorcycle t3 ON t1.destination_id = t3.motorcycle_id AND t1.driver_id = t3.driver_id
ORDER BY distance_km ASC;

SHOW FULL TABLES WHERE Table_Type = 'VIEW';

###Insert Triggers:

#Creating Notification Table for Triggers

CREATE TABLE Notifications (
  notification_id SMALLINT AUTO_INCREMENT,
  user_id SMALLINT NOT NULL,
  message VARCHAR(100) NOT NULL,
  PRIMARY KEY (notification_id),
  FOREIGN KEY (user_id) REFERENCES Users (user_id)
);


#Insert trigger for adding a new destination in the Destination table:
DELIMITER //
CREATE TRIGGER trg_insert_destination
AFTER INSERT ON Destination
FOR EACH ROW
BEGIN
  INSERT INTO Notifications (user_id, message) VALUES ((SELECT user_id FROM Users WHERE destination_id = NEW.destination_id), 'New destination added');
  
  UPDATE Orders SET motorcycle_id = (
    SELECT motorcycle_id FROM Motorcycle
    WHERE destination_id = NEW.destination_id
    ORDER BY SQRT(POW(start_latitude - NEW.start_latitude, 2) + POW(start_longitude - NEW.start_longitude, 2))
    LIMIT 1
  ) WHERE destination_id = NEW.destination_id AND order_status = 'Pending';
END//
DELIMITER ;

#Insert trigger for adding a new driver in the Driver table:
DELIMITER //
CREATE TRIGGER trg_insert_driver
AFTER INSERT ON Driver
FOR EACH ROW
BEGIN
  INSERT INTO Availability (driver_id, availability_status) VALUES (NEW.driver_id, NEW.availability_status);
END//
DELIMITER ;

#Insert trigger for adding a new order in the Orders table:
DELIMITER //
CREATE TRIGGER trg_insert_order
AFTER INSERT ON Orders
FOR EACH ROW
BEGIN
  UPDATE Inventory SET quantity = quantity + NEW.order_unit WHERE food_id = (SELECT food_id FROM Restaurant WHERE restaurant_id = NEW.restaurant_id);
END//
DELIMITER ;

#Insert trigger for adding a new rating in the Ratings table:
DELIMITER //
CREATE TRIGGER trg_insert_rating
AFTER INSERT ON Ratings
FOR EACH ROW
BEGIN
  UPDATE Users SET overall_rating = (SELECT AVG(user_Score) FROM Ratings WHERE user_id = NEW.user_id) WHERE user_id = NEW.user_id;
  UPDATE Driver SET overall_rating = (SELECT AVG(driver_Score) FROM Ratings WHERE driver_id = NEW.driver_id) WHERE driver_id = NEW.driver_id;
END//
DELIMITER ;

#Insert trigger for adding a new payment in the payment table:
DELIMITER //
CREATE TRIGGER trg_insert_payment
AFTER INSERT ON payment
FOR EACH ROW
BEGIN
  UPDATE Orders SET order_status = 'Completed' WHERE order_id = NEW.order_id;
  INSERT INTO Notifications (user_id, message) VALUES ((SELECT user_id FROM Orders WHERE order_id = NEW.order_id), 'Payment received');
END//
DELIMITER ;

###Delete Triggers:

#Delete trigger for deleting a destination from the Destination table:
DELIMITER //
CREATE TRIGGER trg_delete_destination
AFTER DELETE ON Destination
FOR EACH ROW
BEGIN
  DELETE FROM Motorcycle WHERE destination_id = OLD.destination_id;
END//
DELIMITER ;

#Delete trigger for deleting a food item from the Food_list table:
DELIMITER //
CREATE TRIGGER trg_delete_food_item
AFTER DELETE ON Food_list
FOR EACH ROW
BEGIN
  DELETE FROM Orders WHERE restaurant_id = OLD.restaurant_id AND food_id = OLD.food_id;
END//
DELIMITER;

#Delete trigger for deleting a user from the Users table:
DELIMITER //
CREATE TRIGGER trg_delete_user
AFTER DELETE ON Users
FOR EACH ROW
BEGIN
  DELETE FROM Ratings WHERE user_id = OLD.user_id;
  DELETE FROM Orders WHERE user_id = OLD.user_id;
END//
DELIMITER;

#Delete trigger for deleting a driver from the Driver table:
DELIMITER //
CREATE TRIGGER trg_delete_driver
AFTER DELETE ON Driver
FOR EACH ROW
BEGIN
  DELETE FROM Motorcycle WHERE driver_id = OLD.driver_id;
  DELETE FROM Ratings WHERE driver_id = OLD.driver_id;
END//
DELIMITER ;

#Delete trigger for deleting an order from the Orders table:
DELIMITER //
CREATE TRIGGER trg_delete_order
AFTER DELETE ON Orders
FOR EACH ROW 
BEGIN
  DELETE FROM Ratings WHERE order_id = OLD.order_id;
  DELETE FROM payment WHERE order_id = OLD.order_id;
END//
DELIMITER ;





