
CREATE DATABASE classicmodels;

USE classicmodels;

CREATE TABLE productlines (
  productLine nvarchar(50),  -- Using nvarchar for Unicode support in SQL Server
  textDescription nvarchar(MAX) DEFAULT NULL,  -- nvarchar(MAX) for long text
  htmlDescription nvarchar(MAX),  -- mediumtext becomes nvarchar(MAX)
  image varbinary(MAX),  -- mediumblob becomes varbinary(MAX)
  PRIMARY KEY (productLine)
);

CREATE TABLE products (
  productCode nvarchar(15),  -- varchar becomes nvarchar
  productName nvarchar(70) NOT NULL,
  productLine nvarchar(50) NOT NULL,
  productScale nvarchar(10) NOT NULL,
  productVendor nvarchar(50) NOT NULL,
  productDescription nvarchar(MAX) NOT NULL,  -- text becomes nvarchar(MAX)
  quantityInStock smallint NOT NULL,
  buyPrice decimal(10,2) NOT NULL,
  MSRP decimal(10,2) NOT NULL,
  PRIMARY KEY (productCode),
  FOREIGN KEY (productLine) REFERENCES productlines (productLine)
);





CREATE TABLE offices (
  officeCode nvarchar(10),  -- varchar becomes nvarchar
  city nvarchar(50) NOT NULL,
  phone nvarchar(50) NOT NULL,
  addressLine1 nvarchar(50) NOT NULL,
  addressLine2 nvarchar(50) DEFAULT NULL,
  state nvarchar(50) DEFAULT NULL,
  country nvarchar(50) NOT NULL,
  postalCode nvarchar(15) NOT NULL,
  territory nvarchar(10) NOT NULL,
  PRIMARY KEY (officeCode)
);

CREATE TABLE employees (
  employeeNumber int,
  lastName nvarchar(50) NOT NULL,
  firstName nvarchar(50) NOT NULL,
  extension nvarchar(10) NOT NULL,
  email nvarchar(100) NOT NULL,
  officeCode nvarchar(10) NOT NULL,
  reportsTo int DEFAULT NULL,
  jobTitle nvarchar(50) NOT NULL,
  PRIMARY KEY (employeeNumber),
  FOREIGN KEY (reportsTo) REFERENCES employees (employeeNumber),
  FOREIGN KEY (officeCode) REFERENCES offices (officeCode)
);

CREATE TABLE customers (
  customerNumber int,
  customerName nvarchar(50) NOT NULL,
  contactLastName nvarchar(50) NOT NULL,
  contactFirstName nvarchar(50) NOT NULL,
  phone nvarchar(50) NOT NULL,
  addressLine1 nvarchar(50) NOT NULL,
  addressLine2 nvarchar(50) DEFAULT NULL,
  city nvarchar(50) NOT NULL,
  state nvarchar(50) DEFAULT NULL,
  postalCode nvarchar(15) DEFAULT NULL,
  country nvarchar(50) NOT NULL,
  salesRepEmployeeNumber int DEFAULT NULL,
  creditLimit decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (customerNumber),
  FOREIGN KEY (salesRepEmployeeNumber) REFERENCES employees (employeeNumber)
);

CREATE TABLE payments (
  customerNumber int,
  checkNumber nvarchar(50) NOT NULL,  -- varchar becomes nvarchar
  paymentDate date NOT NULL,
  amount decimal(10,2) NOT NULL,
  PRIMARY KEY (customerNumber, checkNumber),
  FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber)
);

CREATE TABLE orders (
  orderNumber int,
  orderDate date NOT NULL,
  requiredDate date NOT NULL,
  shippedDate date DEFAULT NULL,
  status nvarchar(15) NOT NULL,  -- varchar becomes nvarchar
  comments nvarchar(MAX),  -- text becomes nvarchar(MAX)
  customerNumber int NOT NULL,
  PRIMARY KEY (orderNumber),
  FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber)
);

CREATE TABLE orderdetails (
  orderNumber int,
  productCode nvarchar(15) NOT NULL,
  quantityOrdered int NOT NULL,
  priceEach decimal(10,2) NOT NULL,
  orderLineNumber smallint NOT NULL,
  PRIMARY KEY (orderNumber, productCode),
  FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber),
  FOREIGN KEY (productCode) REFERENCES products (productCode)
);


insert  into productlines(productLine,textDescription,htmlDescription,image) values 
('Classic Cars','Attention car enthusiasts: Make your wildest car ownership dreams come true. Whether you are looking for classic muscle cars, dream sports cars or movie-inspired miniatures, you will find great choices in this category. These replicas feature superb attention to detail and craftsmanship and offer features such as working steering system, opening forward compartment, opening rear trunk with removable spare wheel, 4-wheel independent spring suspension, and so on. The models range in size from 1:10 to 1:24 scale and include numerous limited edition and several out-of-production vehicles. All models include a certificate of authenticity from their manufacturers and come fully assembled and ready for display in the home or office.',NULL,NULL),
('Motorcycles','Our motorcycles are state of the art replicas of classic as well as contemporary motorcycle legends such as Harley Davidson, Ducati and Vespa. Models contain stunning details such as official logos, rotating wheels, working kickstand, front suspension, gear-shift lever, footbrake lever, and drive chain. Materials used include diecast and plastic. The models range in size from 1:10 to 1:50 scale and include numerous limited edition and several out-of-production vehicles. All models come fully assembled and ready for display in the home or office. Most include a certificate of authenticity.',NULL,NULL),
('Planes','Unique, diecast airplane and helicopter replicas suitable for collections, as well as home, office or classroom decorations. Models contain stunning details such as official logos and insignias, rotating jet engines and propellers, retractable wheels, and so on. Most come fully assembled and with a certificate of authenticity from their manufacturers.',NULL,NULL),
('Ships','The perfect holiday or anniversary gift for executives, clients, friends, and family. These handcrafted model ships are unique, stunning works of art that will be treasured for generations! They come fully assembled and ready for display in the home or office. We guarantee the highest quality, and best value.',NULL,NULL),
('Trains','Model trains are a rewarding hobby for enthusiasts of all ages. Whether you are looking for collectible wooden trains, electric streetcars or locomotives, you wll find a number of great choices for any budget within this category. The interactive aspect of trains makes toy trains perfect for young children. The wooden train sets are ideal for children under the age of 5.',NULL,NULL),
('Trucks and Buses','The Truck and Bus models are realistic replicas of buses and specialized trucks produced from the early 1920s to present. The models range in size from 1:12 to 1:50 scale and include numerous limited edition and several out-of-production vehicles. Materials used include tin, diecast and plastic. All models include a certificate of authenticity from their manufacturers and are a perfect ornament for the home and office.',NULL,NULL),
('Vintage Cars','Our Vintage Car models realistically portray automobiles produced from the early 1900s through the 1940s. Materials used include Bakelite, diecast, plastic and wood. Most of the replicas are in the 1:18 and 1:24 scale sizes, which provide the optimum in detail and accuracy. Prices range from $30.00 up to $180.00 for some special limited edition replicas. All models include a certificate of authenticity from their manufacturers and come fully assembled and ready for display in the home or office.',NULL,NULL)

INSERT INTO products (productCode, productName, productLine, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP)
VALUES 
('S10_1678', '1969 Harley Davidson Ultimate Chopper', 'Motorcycles', '1:10', 'Min Lin Diecast', 'This replica features working kickstand, front suspension, gear-shift lever, footbrake lever, drive chain, wheels and steering. All parts are particularly delicate due to their precise scale and require special care and attention.', 7933, 48.81, 95.70),
('S10_1949', '1952 Alpine Renault 1300', 'Classic Cars', '1:10', 'Classic Metal Creations', 'Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.', 7305, 98.58, 214.30),
('S10_2016', '1996 Moto Guzzi 1100i', 'Motorcycles', '1:10', 'Highway 66 Mini Classics', 'Official Moto Guzzi logos and insignias, saddle bags located on side of motorcycle, detailed engine, working steering, working suspension, two leather seats, luggage rack, dual exhaust pipes, small saddle bag located on handle bars, two-tone paint with chrome accents, superior die-cast detail , rotating wheels , working kick stand, diecast metal with plastic parts and baked enamel finish.', 6625, 68.99, 118.94),
('S10_4698', '2003 Harley-Davidson Eagle Drag Bike', 'Motorcycles', '1:10', 'Red Start Diecast', 'Model features, official Harley Davidson logos and insignias, detachable rear wheelie bar, heavy diecast metal with resin parts, authentic multi-color tampo-printed graphics, separate engine drive belts, free-turning front fork, rotating tires and rear racing slick, certificate of authenticity, detailed engine, display stand, precision diecast replica, baked enamel finish, 1:10 scale model, removable fender, seat and tank cover piece for displaying the superior detail of the v-twin engine', 5582, 91.02, 193.66),
('S10_4757', '1972 Alfa Romeo GTA', 'Classic Cars', '1:10', 'Motor City Art Classics', 'Features include: Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.', 3252, 85.68, 136.00),
('S10_4962', '1962 LanciaA Delta 16V', 'Classic Cars', '1:10', 'Second Gear Diecast', 'Features include: Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.', 6791, 103.42, 147.74),
('S12_1099', '1968 Ford Mustang', 'Classic Cars', '1:12', 'Autoart Studio Design', 'Hood, doors and trunk all open to reveal highly detailed interior features. Steering wheel actually turns the front wheels. Color dark green.', 68, 95.34, 194.57),
('S12_1108', '2001 Ferrari Enzo', 'Classic Cars', '1:12', 'Second Gear Diecast', 'Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.', 3619, 95.59, 207.80),
('S12_1666', '1958 Setra Bus', 'Trucks and Buses', '1:12', 'Welly Diecast Productions', 'Model features 30 windows, skylights & glare resistant glass, working steering system, original logos', 1579, 77.90, 136.67),
('S12_2823', '2002 Suzuki XREO', 'Motorcycles', '1:12', 'Unimax Art Galleries', 'Official logos and insignias, saddle bags located on side of motorcycle, detailed engine, working steering, working suspension, two leather seats, luggage rack, dual exhaust pipes, small saddle bag located on handle bars, two-tone paint with chrome accents, superior die-cast detail , rotating wheels , working kick stand, diecast metal with plastic parts and baked enamel finish.', 9997, 66.27, 150.62),
('S12_3148', '1969 Corvair Monza', 'Classic Cars', '1:18', 'Welly Diecast Productions', '1:18 scale die-cast about 10 long doors open, hood opens, trunk opens and wheels roll', 6906, 89.14, 151.08),
('S12_3380', '1968 Dodge Charger', 'Classic Cars', '1:12', 'Welly Diecast Productions', '1:12 scale model of a 1968 Dodge Charger. Hood, doors and trunk all open to reveal highly detailed interior features. Steering wheel actually turns the front wheels. Color black', 9123, 75.16, 117.44),
('S12_3891', '1969 Ford Falcon', 'Classic Cars', '1:12', 'Second Gear Diecast', 'Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.', 1049, 83.05, 173.02),
('S12_3990', '1970 Plymouth Hemi Cuda', 'Classic Cars', '1:12', 'Studio M Art Models', 'Very detailed 1970 Plymouth Cuda model in 1:12 scale. The Cuda is generally accepted as one of the fastest original muscle cars from the 1970s. This model is a reproduction of one of the orginal 652 cars built in 1970. Red color.', 5663, 31.92, 79.80),
('S12_4473', '1957 Chevy Pickup', 'Trucks and Buses', '1:12', 'Exoto Designs', '1:12 scale die-cast about 20\" long Hood opens, Rubber wheels', 6125, 55.70, 118.50),
('S12_4675', '1969 Dodge Charger', 'Classic Cars', '1:12', 'Welly Diecast Productions', 'Detailed model of the 1969 Dodge Charger. This model includes finely detailed interior and exterior features. Painted in red and white.', 7323, 58.73, 115.16),
('S18_1097', '1940 Ford Pickup Truck', 'Trucks and Buses', '1:18', 'Studio M Art Models', 'This model features soft rubber tires, working steering, rubber mud guards, authentic Ford logos, detailed undercarriage, opening doors and hood,  removable split rear gate, full size spare mounted in bed, detailed interior with opening glove box', 2613, 58.33, 116.67),
('S18_1129', '1993 Mazda RX-7', 'Classic Cars', '1:18', 'Highway 66 Mini Classics', 'This model features, opening hood, opening doors, detailed engine, rear spoiler, opening trunk, working steering, tinted windows, baked enamel finish. Color red.', 3975, 83.51, 141.54),
('S18_1342', '1937 Lincoln Berline', 'Vintage Cars', '1:18', 'Motor City Art Classics', 'Features opening engine cover, doors, trunk, and fuel filler cap. Color black', 8693, 60.62, 102.74),
('S18_1367', '1936 Mercedes-Benz 500K Special Roadster', 'Vintage Cars', '1:18', 'Studio M Art Models', 'This 1:18 scale replica is constructed of heavy die-cast metal and has all the features of the original: working doors and rumble seat, independent spring suspension, detailed interior, working steering system, and a bifold hood that reveals an engine so accurate that it even includes the wiring. All this is topped off with a baked enamel finish. Color white.', 8635, 24.26, 53.91),
('S18_1589', '1965 Aston Martin DB5', 'Classic Cars', '1:18', 'Classic Metal Creations', 'Die-cast model of the silver 1965 Aston Martin DB5 in silver. This model includes full wire wheels and doors that open with fully detailed passenger compartment. In 1:18 scale, this model measures approximately 10 inches/20 cm long.', 9042, 65.96, 124.44),
('S18_1662', '1980s Black Hawk Helicopter', 'Planes', '1:18', 'Red Start Diecast', '1 :18 scale replica of actual Army''s UH-60L BLACK HAWK Helicopter. 100% hand-assembled. Features rotating rotor blades, propeller blades and rubber wheels.', 5330, 77.27, 157.69),
('S18_1749', '1917 Grand Touring Sedan', 'Vintage Cars', '1:18', 'Welly Diecast Productions', 'This 1:18 scale replica of the 1917 Grand Touring car has all the features you would expect from museum quality reproductions: all four doors and bi-fold hood opening, detailed engine and instrument panel, chrome-look trim, and tufted upholstery, all topped off with a factory baked-enamel finish.', 2724, 86.70, 170.00),
('S18_1889', '1948 Porsche 356-A Roadster', 'Classic Cars', '1:18', 'Gearbox Collectibles', 'This precision die-cast replica features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.', 8826, 53.90, 77.00),
('S18_1984', '1995 Honda Civic', 'Classic Cars ', '1:18', 'Min Lin Diecast', 'This model features, opening hood, opening doors, detailed engine, rear spoiler, opening trunk, working steering, tinted windows, baked enamel finish. Color yellow.', 9772, 93.89, 142.25),
('S18_2238', '1998 Chrysler Plymouth Prowler', 'Classic Cars', '1:18', 'Gearbox Collectibles', 'Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.', 4724, 101.51, 163.73),
('S18_2248', '1911 Ford Town Car', 'Vintage Cars', '1:18', 'Motor City Art Classics', 'Features opening hood, opening doors, opening trunk, wide white wall tires, front door arm rests, working steering system.', 540, 33.30, 60.54),
('S18_2319', '1964 Mercedes Tour Bus', 'Trucks and Buses', '1:18', 'Unimax Art Galleries', 'Exact replica. 100+ parts. working steering system, original logos', 8258, 74.86, 122.73),
('S18_2325', '1932 Model A Ford J-Coupe', 'Vintage Cars', '1:18', 'Autoart Studio Design', 'This model features grille-mounted chrome horn, lift-up louvered hood, fold-down rumble seat, working steering system, chrome-covered spare, opening doors, detailed and wired engine', 9354, 58.48, 127.13),
('S18_2432', '1926 Ford Fire Engine', 'Trucks and Buses', '1:18', 'Carousel DieCast Legends', 'Gleaming red handsome appearance. Everything is here the fire hoses, ladder, axes, bells, lanterns, ready to fight any inferno.', 2018, 24.92, 60.77),
('S18_2581', 'P-51-D Mustang', 'Planes', '1:72', 'Gearbox Collectibles', 'Has retractable wheels and comes with a stand', 992, 49.00, 84.48),
('S18_2625', '1936 Harley Davidson El Knucklehead', 'Motorcycles', '1:18', 'Welly Diecast Productions', 'Intricately detailed with chrome accents and trim, official die-struck logos and baked enamel finish.', 4357, 24.23, 60.57),
('S18_2795', '1928 Mercedes-Benz SSK', 'Vintage Cars', '1:18', 'Gearbox Collectibles', 'This 1:18 replica features grille-mounted chrome horn, lift-up louvered hood, fold-down rumble seat, working steering system, chrome-covered spare, opening doors, detailed and wired engine. Color black.', 548, 72.56, 168.75),
('S18_2870', '1999 Indy 500 Monte Carlo SS', 'Classic Cars', '1:18', 'Red Start Diecast', 'Features include opening and closing doors. Color: Red', 8164, 56.76, 132.00),
('S18_2949', '1913 Ford Model T Speedster', 'Vintage Cars', '1:18', 'Carousel DieCast Legends', 'This 250 part reproduction includes moving handbrakes, clutch, throttle and foot pedals, squeezable horn, detailed wired engine , removable water, gas, and oil cans, pivoting monocle windshield, all topped with a baked enamel red finish. Each replica comes with an Owners Title and Certificate of Authenticity. Color red.', 4189, 60.78, 101.31),
('S18_2957', '1934 Ford V8 Coupe', 'Vintage Cars', '1:18', 'Min Lin Diecast', 'Chrome Trim, Chrome Grille, Opening Hood, Opening Doors, Opening Trunk, Detailed Engine, Working Steering System', 5649, 34.35, 62.46),
('S18_3029', '1999 Yamaha Speed Boat', 'Ships', '1:18', 'Min Lin Diecast', 'Exact replica. Wood and Metal. Many extras including rigging, long boats, pilot house, anchors, etc. Comes with three masts, all square-rigged.', 4259, 51.61, 86.02),
('S18_3136', '18th Century Vintage Horse Carriage', 'Vintage Cars', '1:18', 'Red Start Diecast', 'Hand crafted diecast-like metal horse carriage is re-created in about 1:18 scale of antique horse carriage. This antique style metal Stagecoach is all hand-assembled with many different parts. This collectible metal horse carriage is painted in classic Red, and features turning steering wheel and is entirely hand-finished.', 5992, 60.74, 104.72),
('S18_3140', '1903 Ford Model A', 'Vintage Cars', '1:18', 'Unimax Art Galleries', 'Features opening trunk,  working steering system', 3913, 68.30, 136.59),
('S18_3232', '1992 Ferrari 360 Spider red', 'Classic Cars', '1:18', 'Unimax Art Galleries', 'his replica features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.', 8347, 77.90, 169.34),
('S18_3233', '1985 Toyota Supra', 'Classic Cars', '1:18', 'Highway 66 Mini Classics', 'This model features soft rubber tires, working steering, rubber mud guards, authentic Ford logos, detailed undercarriage, opening doors and hood, removable split rear gate, full size spare mounted in bed, detailed interior with opening glove box', 7733, 57.01, 107.57),
('S18_3259', 'Collectable Wooden Train', 'Trains', '1:18', 'Carousel DieCast Legends', 'Hand crafted wooden toy train set is in about 1:18 scale, 25 inches in total length including 2 additional carts, of actual vintage train. This antique style wooden toy train model set is all hand-assembled with 100% wood.', 6450, 67.56, 100.84),
('S18_3278', '1969 Dodge Super Bee', 'Classic Cars', '1:18', 'Min Lin Diecast', 'This replica features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.', 1917, 49.05, 80.41),
('S18_3320', '1917 Maxwell Touring Car', 'Vintage Cars', '1:18', 'Exoto Designs', 'Features Gold Trim, Full Size Spare Tire, Chrome Trim, Chrome Grille, Opening Hood, Opening Doors, Opening Trunk, Detailed Engine, Working Steering System', 7913, 57.54, 99.21),
('S18_3482', '1976 Ford Gran Torino', 'Classic Cars', '1:18', 'Gearbox Collectibles', 'Highly detailed 1976 Ford Gran Torino \"Starsky and Hutch\" diecast model. Very well constructed and painted in red and white patterns.', 9127, 73.49, 146.99),
('S18_3685', '1948 Porsche Type 356 Roadster', 'Classic Cars', '1:18', 'Gearbox Collectibles', 'This model features working front and rear suspension on accurately replicated and actuating shock absorbers as well as opening engine cover, rear stabilizer flap,  and 4 opening doors.', 8990, 62.16, 141.28),
('S18_3782', '1957 Vespa GS150', 'Motorcycles', '1:18', 'Studio M Art Models', 'Features rotating wheels , working kick stand. Comes with stand.', 7689, 32.95, 62.17),
('S18_3856', '1941 Chevrolet Special Deluxe Cabriolet', 'Vintage Cars', '1:18', 'Exoto Designs', 'Features opening hood, opening doors, opening trunk, wide white wall tires, front door arm rests, working steering system, leather upholstery. Color black.', 2378, 64.58, 105.87),
('S18_4027', '1970 Triumph Spitfire', 'Classic Cars', '1:18', 'Min Lin Diecast', 'Features include opening and closing doors. Color: White.', 5545, 91.92, 143.62),
('S18_4409', '1932 Alfa Romeo 8C2300 Spider Sport', 'Vintage Cars', '1:18', 'Exoto Designs', 'This 1:18 scale precision die cast replica features the 6 front headlights of the original, plus a detailed version of the 142 horsepower straight 8 engine, dual spares and their famous comprehensive dashboard. Color black.', 6553, 43.26, 92.03),
('S18_4522', '1904 Buick Runabout', 'Vintage Cars', '1:18', 'Exoto Designs', 'Features opening trunk,  working steering system', 8290, 52.66, 87.77),
(' S18_4600', '1940s Ford truck', 'Trucks and Buses', '1:18', 'Motor City Art Classics', 'This 1940s Ford Pick-Up truck is re-created in 1:18 scale of original 1940s Ford truck. This antique style metal 1940''s Pick-Up truck is all hand-assembled. This collectible 1940''s Pick-Up truck is painted in classic dark green color, and features rotating wheels.', 3128, 84.76, 121.08),
('S18_4668', '1939 Cadillac Limousine', 'Vintage Cars', '1:18', 'Studio M Art Models', 'Features completely detailed interior including Velvet flocked drapes,deluxe wood grain floor, and a wood grain casket with seperate chrome handles', 6645, 23.14, 50.31),
('S18_4721', '1957 Corvette Convertible', 'Classic Cars', '1:18', 'Classic Metal Creations', '1957 die cast Corvette Convertible in Roman Red with white sides and whitewall tires. 1:18 scale quality die-cast with detailed engine and underbvody. Now you can own The Classic Corvette.', 1249, 69.93, 148.80)

select productCode from prod

insert  into offices(officeCode,city,phone,addressLine1,addressLine2,state,country,postalCode,territory) values 
('1','San Francisco','+1 650 219 4782','100 Market Street','Suite 300','CA','USA','94080','NA'),
('2','Boston','+1 215 837 0825','1550 Court Place','Suite 102','MA','USA','02107','NA'),
('3','NYC','+1 212 555 3000','523 East 53rd Street','apt. 5A','NY','USA','10022','NA'),
('4','Paris','+33 14 723 4404','43 Rue Jouffroy Dabbans',NULL,NULL,'France','75017','EMEA'),
('5','Tokyo','+81 33 224 5000','4-1 Kioicho',NULL,'Chiyoda-Ku','Japan','102-8578','Japan'),
('6','Sydney','+61 2 9264 2451','5-11 Wentworth Avenue','Floor #2',NULL,'Australia','NSW 2010','APAC'),
('7','London','+44 20 7877 2041','25 Old Broad Street','Level 7',NULL,'UK','EC2N 1HN','EMEA');



select * from employees
insert  into employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) values
(1002,'Murphy','Diane','x5800','dmurphy@classicmodelcars.com','1',NULL,'President'),
(1056,'Patterson','Mary','x4611','mpatterso@classicmodelcars.com','1',1002,'VP Sales'),
(1076,'Firrelli','Jeff','x9273','jfirrelli@classicmodelcars.com','1',1002,'VP Marketing'),
(1088,'Patterson','William','x4871','wpatterson@classicmodelcars.com','6',1056,'Sales Manager (APAC)'),
(1102,'Bondur','Gerard','x5408','gbondur@classicmodelcars.com','4',1056,'Sale Manager (EMEA)'),
(1143,'Bow','Anthony','x5428','abow@classicmodelcars.com','1',1056,'Sales Manager (NA)'),
(1165,'Jennings','Leslie','x3291','ljennings@classicmodelcars.com','1',1143,'Sales Rep'),
(1166,'Thompson','Leslie','x4065','lthompson@classicmodelcars.com','1',1143,'Sales Rep'),
(1188,'Firrelli','Julie','x2173','jfirrelli@classicmodelcars.com','2',1143,'Sales Rep'),
(1216,'Patterson','Steve','x4334','spatterson@classicmodelcars.com','2',1143,'Sales Rep'),
(1286,'Tseng','Foon Yue','x2248','ftseng@classicmodelcars.com','3',1143,'Sales Rep'),
(1323,'Vanauf','George','x4102','gvanauf@classicmodelcars.com','3',1143,'Sales Rep'),
(1337,'Bondur','Loui','x6493','lbondur@classicmodelcars.com','4',1102,'Sales Rep'),
(1370,'Hernandez','Gerard','x2028','ghernande@classicmodelcars.com','4',1102,'Sales Rep'),
(1401,'Castillo','Pamela','x2759','pcastillo@classicmodelcars.com','4',1102,'Sales Rep'),
(1501,'Bott','Larry','x2311','lbott@classicmodelcars.com','7',1102,'Sales Rep'),
(1504,'Jones','Barry','x102','bjones@classicmodelcars.com','7',1102,'Sales Rep'),
(1611,'Fixter','Andy','x101','afixter@classicmodelcars.com','6',1088,'Sales Rep'),
(1612,'Marsh','Peter','x102','pmarsh@classicmodelcars.com','6',1088,'Sales Rep'),
(1619,'King','Tom','x103','tking@classicmodelcars.com','6',1088,'Sales Rep'),
(1621,'Nishi','Mami','x101','mnishi@classicmodelcars.com','5',1056,'Sales Rep'),
(1625,'Kato','Yoshimi','x102','ykato@classicmodelcars.com','5',1621,'Sales Rep'),
(1702,'Gerard','Martin','x2312','mgerard@classicmodelcars.com','4',1102,'Sales Rep');


INSERT INTO customers (
    customerNumber,
    customerName,
    contactLastName,
    contactFirstName,
    phone,
    addressLine1,
    addressLine2,
    city,
    state,
    postalCode,
    country,
    salesRepEmployeeNumber,
    creditLimit
) VALUES 
    (103, 'Atelier graphique', 'Schmitt', 'Carine', '40.32.2555', '54, rue Royale', NULL, 'Nantes', NULL, '44000', 'France', 1370, 21000.00),
    (112, 'Signal Gift Stores', 'King', 'Jean', '7025551838', '8489 Strong St.', NULL, 'Las Vegas', 'NV', '83030', 'USA', 1166, 71800.00),
    (114, 'Australian Collectors, Co.', 'Ferguson', 'Peter', '03 9520 4555', '636 St Kilda Road', 'Level 3', 'Melbourne', 'Victoria', '3004', 'Australia', 1611, 117300.00),
    (119, 'La Rochelle Gifts', 'Labrune', 'Janine', '40.67.8555', '67, rue des Cinquante Otages', NULL, 'Nantes', NULL, '44000', 'France', 1370, 118200.00),
    (121, 'Baane Mini Imports', 'Bergulfsen', 'Jonas', '07-98 9555', 'Erling Skakkes gate 78', NULL, 'Stavern', NULL, '4110', 'Norway', 1504, 81700.00),
    (124, 'Mini Gifts Distributors Ltd.', 'Nelson', 'Susan', '4155551450', '5677 Strong St.', NULL, 'San Rafael', 'CA', '97562', 'USA', 1165, 210500.00),
    (125, 'Havel & Zbyszek Co', 'Piestrzeniewicz', 'Zbyszek', '(26) 642-7555', 'ul. Filtrowa 68', NULL, 'Warszawa', NULL, '01-012', 'Poland', NULL, 0.00),
    (128, 'Blauer See Auto, Co.', 'Keitel', 'Roland', '+49 69 66 90 2555', 'Lyonerstr. 34', NULL, 'Frankfurt', NULL, '60528', 'Germany', 1504, 59700.00),
    (129, 'Mini Wheels Co.', 'Murphy', 'Julie', '6505555787', '5557 North Pendale Street', NULL, 'San Francisco', 'CA', '94217', 'USA', 1165, 64600.00),
    (131, 'Land of Toys Inc.', 'Lee', 'Kwai', '2125557818', '897 Long Airport Avenue', NULL, 'NYC', 'NY', '10022', 'USA', 1323, 114900.00),
    (141, 'Euro+ Shopping Channel', 'Freyre', 'Diego', '(91) 555 94 44', 'C/ Moralzarzal, 86', NULL, 'Madrid', NULL, '28034', 'Spain', 1370, 227600.00),
    (144, 'Volvo Model Replicas, Co', 'Berglund', 'Christina', '0921-12 3555', 'Berguvsvägen 8', NULL, 'Luleå', NULL, 'S-958 22', 'Sweden', 1504, 53100.00),
    (145, 'Danish Wholesale Imports', 'Petersen', 'Jytte', '31 12 3555', 'Vinbæltet 34', NULL, 'Kobenhavn', NULL, '1734 ', 'Denmark', 1401, 83400.00),
    (146, 'Saveley & Henriot, Co.', 'Saveley', 'Mary', '78.32.5555', '2, rue du Commerce', NULL, 'Lyon', NULL, '69004', 'France', 1337, 123900.00),
    (148, 'Dragon Souveniers, Ltd.', 'Natividad', 'Eric', '+65 221 7555', 'Bronz Sok.', 'Bronz Apt. 3/6 Tesvikiye', 'Singapore', NULL, '079903', 'Singapore', 1621, 103800.00),
    (151, 'Muscle Machine Inc', 'Young', 'Jeff', '2125557413', '4092 Furth Circle', 'Suite 400', 'NYC', 'NY', '10022', 'USA', 1286, 138500.00),
    (157, 'Diecast Classics Inc.', 'Leong', 'Kelvin', '2155551555', '7586 Pompton St.', NULL, 'Allentown', 'PA', '70267', 'USA', 1216, 100600.00),
    (161, 'Technics Stores Inc.', 'Hashimoto', 'Juri', '6505556809', '9408 Furth Circle', NULL, 'Burlingame', 'CA', '94217', 'USA', 1165, 84600.00),
    (166, 'Handji Gifts & Co', 'Victorino', 'Wendy', '+65 224 1555', '106 Linden Road Sandown', '2nd Floor', 'Singapore', NULL, '069045', 'Singapore', 1612, 97900.00),
    (167, 'Herkku Gifts', 'Oeztan', 'Veysel', '+47 2267 3215', 'Brehmen St. 121', 'PR 334 Sentrum', 'Bergen', NULL, 'N 5804', 'Norway', 1504, 96800.00),
    (168, 'American Souvenirs Inc', 'Franco', 'Keith', '2035557845', '149 Spinnaker Dr.', 'Suite 101', 'New Haven', 'CT', '97823', 'USA', 1286, 0.00),
    (169, 'Porto Imports Co.', 'de Castro', 'Isabel', '(1) 356-5555', 'Estrada da saúde n. 58', NULL, 'Lisboa', NULL, '1756', 'Portugal', NULL, 0.00),
    (171, 'Daedalus Designs Imports', 'Rancé', 'Martine', '20.16.1555', '184, chaussée de Tournai', NULL, 'Lille', NULL, '59000', 'France', 1370, 82900.00),
    (172, 'La Corne Dabondance, Co.', 'Bertrand', 'Marie', '(1) 42.34.2555', '265, boulevard Charonne', NULL, 'Paris', NULL, '75012', 'France', 1337, 84300.00);


INSERT INTO orders (
    orderNumber,
    orderDate,
    requiredDate,
    shippedDate,
    status,
    comments,
    customerNumber
) VALUES 
    (10100, '2003-01-06', '2003-01-13', '2003-01-10', 'Shipped', NULL, 103),
    (10101, '2003-01-09', '2003-01-18', '2003-01-11', 'Shipped', 'Check on availability.', 112),
    (10102, '2003-01-10', '2003-01-18', '2003-01-14', 'Shipped', NULL, 114),
    (10103, '2003-01-29', '2003-02-07', '2003-02-02', 'Shipped', NULL, 119),
    (10104, '2003-01-31', '2003-02-09', '2003-02-01', 'Shipped', NULL, 121),
    (10105, '2003-02-11', '2003-02-21', '2003-02-12', 'Shipped', NULL, 124),
    (10106, '2003-02-17', '2003-02-24', '2003-02-21', 'Shipped', NULL, 125),
    (10107, '2003-02-24', '2003-03-03', '2003-02-26', 'Resolved', 'This order was disputed, but resolved on 11/1/2003; Customer doesnt like the colors and precision of the models.', 128),
    (10108, '2003-03-03', '2003-03-12', '2003-03-08', 'Shipped', NULL, 129),
    (10109, '2003-03-10', '2003-03-19', '2003-03-11', 'Shipped', 'Customer requested that FedEx Ground is used for this shipping', 131),
    (10110, '2003-03-18', '2003-03-24', '2003-03-20', 'Shipped', NULL, 141),
    (10111, '2003-03-25', '2003-03-31', '2003-03-30', 'Shipped', NULL, 144),
    (10112, '2003-03-24', '2003-04-03', '2003-03-29', 'Shipped', 'Customer requested that ad materials (such as posters, pamphlets) be included in the shippment', 145),
    (10113, '2003-03-26', '2003-04-02', '2003-03-27', 'Shipped', NULL, 146),
    (10114, '2003-04-01', '2003-04-07', '2003-04-02', 'Shipped', NULL, 148),
    (10115, '2003-04-04', '2003-04-12', '2003-04-07', 'Shipped', NULL, 151),
    (10116, '2003-04-11', '2003-04-19', '2003-04-13', 'Shipped', NULL, 157),
    (10117, '2003-04-16', '2003-04-24', '2003-04-17', 'Shipped', NULL, 161),
    (10118, '2003-04-21', '2003-04-29', '2003-04-26', 'Disputed', 'Customer claims container with shipment was damaged during shipping and some items were missing. I am talking to FedEx about this.', 166),
    (10119, '2003-04-28', '2003-05-05', '2003-05-02', 'Shipped', NULL, 167),
    (10120, '2003-04-29', '2003-05-08', '2003-05-01', 'Shipped', NULL, 168),
    (10121, '2003-05-07', '2003-05-13', '2003-05-13', 'Shipped', NULL, 169),
    (10122, '2003-05-08', '2003-05-16', '2003-05-13', 'Shipped', NULL, 171),
    (10123 , '2003-05-20', '2003-05-29', '2003-05-22', 'Shipped', NULL, 172),
    (10124, '2003-05-21', '2003-05-29', '2003-05-25', 'Cancelled', 'Customer cancelled due to urgent budgeting issues. Must be cautious when dealing with them in the future. Since order shipped already we must discuss who would cover the shipping charges.', 141),
    (10125, '2003-05-21', '2003-05-27', '2003-05-24', 'Shipped', NULL, 144),
    (10126, '2003-05-28', '2003-06-07', '2003-06-02', 'Shipped', NULL, 145);



insert  into payments(customerNumber,checkNumber,paymentDate,amount) values 
(103,'HQ336336','2004-10-19','6066.78'),
(103,'JM555205','2003-06-05','14571.44'),
(103,'OM314933','2004-12-18','1676.14'),
(112,'BO864823','2004-12-17','14191.12'),
(112,'HQ55022','2003-06-06','32641.98'),
(112,'ND748579','2004-08-20','33347.88'),
(114,'GG31455','2003-05-20','45864.03'),
(114,'MA765515','2004-12-15','82261.22'),
(114,'NP603840','2003-05-31','7565.08'),
(114,'NR27552','2004-03-10','44894.74'),
(119,'DB933704','2004-11-14','19501.82'),
(119,'LN373447','2004-08-08','47924.19'),
(119,'NG94694','2005-02-22','49523.67'),
(121,'DB889831','2003-02-16','50218.95'),
(121,'FD317790','2003-10-28','1491.38'),
(121,'KI831359','2004-11-04','17876.32'),
(121,'MA302151','2004-11-28','34638.14'),
(124,'AE215433','2005-03-05','101244.59'),
(124,'BG255406','2004-08-28','85410.87'),
(124,'CQ287967','2003-04-11','11044.30'),
(124,'ET64396','2005-04-16','83598.04'),
(124,'HI366474','2004-12-27','47142.70'),
(124,'HR86578','2004-11-02','55639.66'),
(124,'KI131716','2003-08-15','111654.40'),
(124,'LF217299','2004-03-26','43369.30'),
(124,'NT141748','2003-11-25','45084.38'),
(128,'DI925118','2003-01-28','10549.01'),
(128,'FA465482','2003-10-18','24101.81'),
(128,'FH668230','2004-03-24','33820.62'),
(128,'IP383901','2004-11-18','7466.32'),
(129,'DM826140','2004-12-08','26248.78'),
(129,'ID449593','2003-12-11','23923.93'),
(129,'PI42991','2003-04-09','16537.85'),
(131,'CL442705','2003-03-12','22292.62'),
(131,'MA724562','2004-12-02','50025.35'),
(131,'NB445135','2004-09-11','35321.97'),
(141,'AU364101','2003-07-19','36251.03'),
(141,'DB583216','2004-11-01','36140.38'),
(141,'DL460618','2005-05-19','46895.48'),
(141,'HJ32686','2004-01-30','59830.55'),
(141,'ID10962','2004-12-31','116208.40'),
(141,'IN446258','2005-03-25','65071.26'),
(141,'JE105477','2005-03-18','120166.58'),
(141,'JN355280','2003-10-26','49539.37'),
(141,'JN722010','2003-02-25','40206.20'),
(141,'KT52578','2003-12-09','63843.55'),
(141,'MC46946','2004-07-09','35420.74'),
(141,'MF629602','2004-08-16','20009.53'),
(141,'NU627706','2004-05-17','26155.91'),
(144,'IR846303','2004-12-12','36005.71'),
(144,'LA685678','2003-04-09','7674.94'),
(145,'CN328545','2004-07-03','4710.73'),
(145,'ED39322','2004-04-26','28211.70'),
(145,'HR182688','2004-12-01','20564.86'),
(145,'JJ246391','2003-02-20','53959.21'),
(146,'FP549817','2004-03-18','40978.53'),
(146,'FU793410','2004-01-16','49614.72'),
(146,'LJ160635','2003-12-10','39712.10'),
(148,'BI507030','2003-04-22','44380.15'),
(148,'DD635282','2004-08-11','2611.84'),
(148,'KM172879','2003-12-26','105743.00'),
(148,'ME497970','2005-03-27','3516.04'),
(151,'BF686658','2003-12-22','58793.53'),
(151,'GB852215','2004-07-26','20314.44'),
(151,'IP568906','2003-06-18','58841.35'),
(151,'KI884577','2004-12-14','39964.63'),
(157,'HI618861','2004-11-19','35152.12'),
(157,'NN711988','2004-09-07','63357.13'),
(161,'BR352384','2004-11-14','2434.25'),
(161,'BR478494','2003-11-18','50743.65'),
(161,'KG644125','2005-02-02','12692.19'),
(161,'NI908214','2003-08-05','38675.13'),
(166,'BQ327613','2004-09-16','38785.48'),
(166,'DC979307','2004-07-07','44160.92'),
(166,'LA318629','2004-02-28','22474.17'),
(167,'ED743615','2004-09-19','12538.01'),
(167,'GN228846','2003-12-03','85024.46'),
(171,'GB878038','2004-03-15','18997.89'),
(171,'IL104425','2003-11-22','42783.81'),
(172,'AD832091','2004-09-09','1960.80'),
(172,'CE51751','2004-12-04','51209.58'),
(172,'EH208589','2003-04-20','33383.14')

insert  into orderdetails(orderNumber,productCode,quantityOrdered,priceEach,orderLineNumber) values 
(10100,'S18_1749',30,'136.00',3),
(10100,'S18_2248',50,'55.09',2),
(10101,'S18_2325',25,'108.06',4),
(10101,'S18_2795',26,'167.06',1),
(10103,'S10_1949',26,'214.30',12),
(10103,'S18_1097',35,'94.50',9),
(10103,'S18_2432',22,'58.34',10),
(10103,'S18_2949',27,'92.19',11),
(10103,'S18_3136',25,'86.92',13),
(10103,'S18_2957',35,'61.84',14),
(10103,'S18_4668',41,'40.75',5),
(10104,'S10_1949',33,'114.59',7),
(10104,'S18_2238',24,'135.90',8),
(10106,'S18_2957',39,'35.78',6)
  
 --productlines,products,offices, employees,customers,payments,orders,orderdetails
select * from orderdetails



--Here are 30 beginner-level data engineering queries for the provided dataset:



--1 Retrieve all products with a stock quantity of less than 1000.

select quantityInStock
from products
where quantityInStock<1000


--2 Find all customers who have made a payment.
--Write a query that retrieves the customer number and total payment amount for customers who have made more than two payments

select * from payments
select * from customers

select distinct c.customerNumber,c.customerName,sum(p.amount) as Total_Amount 
from customers as c
inner join payments as p on c.customerNumber=p.customerNumber 
group by c.customerNumber,c.customerName
having count(checkNumber)>2
--3 List all employees working in the 'USA' office.


select (firstName+lastName) as Name, o.country as Country from employees as e
inner join offices as o 
on e.officeCode=o.officeCode
where o.country like '%USA%'

-- Retrieve all orders that have a status of 'Cancelled'.

select * from orders
where status like '%Cancelled%'

--5 Find the total number of products available in each product line.

select * from products
select productline,count(*) as Total_Products 
from  products 
group by productline


--6 Calculate the average buyPrice of products in the 'Motorcycles' product line.


select avg(buyPrice) as Avg_Price
from products
where productLine='Motorcycles'


--7 Find all employees who report to a specific manager.

select * from employees


select employeeNumber,firstName,lastName,jobTitle
from employees
WHERE reportsTo = 1088; --assume we find for Sales Manager (APAC)


--8 List all offices located in a specific country (e.g., 'France').

select * from offices
where country='France'

--9 Find the top 5 products with the highest MSRP.
select  top 5 productCode,productName,buyPrice, quantityInStock, MSRP as Highest_MSRP
from products
order by MSRP desc
--10 Retrieve all customers who have a credit limit greater than 80,000.

select * 
from  customers
where creditLimit>80000

--11 List all payments made by customers in the year 2003.

select * from customers
select * from payments


select p.customerNumber, c.customerName, p.checkNumber, p.paymentDate, p.amount
from payments as p
inner join customers as c on p.customerNumber = c.customerNumber
where year(p.paymentDate) = 2003;


--12 Find the total number of employees working in each office.

select * from employees,offices

select o.officeCode,o.city,o.country,count(employeeNumber) as total_Employees
from employees as e
inner join offices as o on e.officeCode=o.officeCode
group by o.officeCode,o.city,o.country

--13 Calculate the total amount paid by each customer.
select * from customers
select * from payments


select p.customerNumber,c.customerName,sum(p.amount) as total_amount 
from payments as p
inner join customers as c on p.customerNumber=c.customerNumber
group by p.customerNumber,c.customerName


--14 Retrieve all orders placed between January 1, 2023, and July 1, 2023.

select c.customerNumber,o.orderNumber ,c.customerName ,o.status
from orders as o
inner join customers as c  on o.customerNumber=c.customerNumber
where o.orderDate between '2002-01-01' and '2003-06-01'
group by c.customerNumber,o.orderNumber,o.status ,c.customerName

--15 Find all products that are currently out of stock (i.e., quantityInStock = 0).
 
 select * from products
 where quantityInStock<1000


--16 List all customers along with their sales representative’s (employee) name.
select *
from customers
select * from employees


select c.customerNumber,c.customerName, c.salesRepEmployeeNumber,e.employeeNumber,(e.firstName+e.lastName) as Employee_Name
from customers as c
inner join employees as e on c.salesRepEmployeeNumber=e.employeeNumber
group by  c.salesRepEmployeeNumber, c.customerNumber,c.customerName,e.employeeNumber,e.firstName,e.lastName


--17 Calculate the total value of all products in stock for each product line.
SELECT 
    productLine, 
    SUM(quantityInStock * buyPrice) AS totalStockValue
FROM 
    products
GROUP BY 
    productLine;
--18 Find the average buyPrice of all products sold by a specific vendor.
select productName,avg(buyPrice)  as AVG_BuyPrice
from products
where productVendor='Welly Diecast Productions'
group by productName


select * from products

--19 List all orders and their corresponding total amounts (quantityOrdered * priceEach).
select o.orderNumber, p.productName,sum(od.quantityOrdered * od.priceEach) as total_amount 
from orderdetails  as od
inner join products as p on od.productCode=p.productCode

inner join orders as o on od.orderNumber=o.orderNumber
group by p.productName,o.orderNumber


select * from orderdetails
--20 Retrieve the names of customers who have placed more than 5 orders.

select c.customerName  from orders as o 
inner join customers as c on o.customerNumber=c.customerNumber
group by c.customerName
having count(o.orderNumber)>1


--21 Find all employees whose email domain is 'example.com'.
select * from employees
where email like '%classicmodelcar%'

--22 List all employees along with their office location.

select (firstName+lastName) as Name,o.city as City, o.country as Country from employees as e
inner join offices as o 
on e.officeCode=o.officeCode


--23 Find all products that have been ordered more than 100 times.
SELECT 
    p.productCode,p.productName,SUM(od.quantityOrdered) AS totalOrdered
FROM 
    products p
JOIN 
    orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode, p.productName
HAVING SUM(od.quantityOrdered) > 20;


--24 Retrieve the total amount of payments made for each year.
select year(paymentDate) as Per_Year, round(sum(amount),0) as Toatal_Amount 
from payments

group by year(paymentDate)

--25 Find the top 3 employees who manage the most customers.

SELECT 
    top 3 e.employeeNumber, e.firstName,  e.lastName, COUNT(c.customerNumber) AS customerCount 
	FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY  e.employeeNumber, e.firstName, e.lastName
ORDER BY customerCount DESC

select * from customers

select * from employees;



--26 CTE Query: Retrieve Employees with High Credit Customers
-- Write a CTE that shows each employee along with the total credit limit of their customers.
--Include employees only if their customers' total credit exceeds 100,000.

WITH employee_credit AS (
    SELECT e.employeeNumber, e.firstName, e.lastName, SUM(c.creditLimit) AS totalCreditLimit
    FROM employees e
    INNER JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
    GROUP BY e.employeeNumber, e.firstName, e.lastName
    HAVING SUM(c.creditLimit) > 100000
)
SELECT employeeNumber, firstName, lastName, totalCreditLimit
FROM employee_credit;

--27 Window Function: Running Total of Payments for Each Customer
--Write a query to calculate the running total of payments for each customer.
--Use a window function to get the cumulative sum of the amount column in the payments table.
select c.customerNumber,c.customerName,sum(p.amount) over (partition by c.customerNumber order by p.paymentDate) as Cumulative_Sum_Amount 
from payments as p
inner join customers as c on p.customerNumber=c.customerNumber

order by c.customerNumber,p.paymentDate

--28 CTE Query: Find Orders that Have Not Shipped in Time
--Create a CTE to list orders where the shippedDate is later than the requiredDate or where the shippedDate is NULL.
--Retrieve relevant order details like order number, order date, and customer name.
with order_cte as(

select orderNumber,orderDate,customerNumber from orders
where shippedDate>requiredDate or shippedDate is null
)

select oc.orderNumber,oc.orderDate,c.customerName from order_cte as oc
inner join customers as c on oc.customerNumber=c.customerNumber
group by oc.orderNumber,oc.orderDate,c.customerName;

select* from orders


--29 Window Function: Rank Products by Price Within Each Product Line
--Write a query using a window function to rank products within each product line based on their buyPrice.
--Return the product name, product line, buy price, and rank.

select productName,productLine,buyPrice,
--row_number() over (partition by productLine order by buyPrice)  as Row_Number,
rank() over (partition by productLine order by buyPrice) as Rank,
--dense_rank() over (partition by productLine order by buyPrice)  as Dense_Rank,
percent_rank() over (partition by productLine order by buyPrice)  as Percent_Rank

from products



--30 Subquery:
--Find the product code, product name, and product line of products that have a higher MSRP 
--than the average MSRP of all products in their respective product line.

SELECT 
    productCode, 
    productName, 
    productLine
FROM 
    products p
WHERE 
    MSRP > (SELECT AVG(MSRP) 
            FROM products 
            WHERE productLine = p.productLine);




	
