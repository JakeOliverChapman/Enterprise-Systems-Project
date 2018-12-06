
CREATE TABLE customer_table (
	customerID int NOT NULL GENERATED ALWAYS AS IDENTITY
        (START WITH 1, INCREMENT BY 1),
	firstName  varchar(20) NOT NULL,
	lastName  varchar(20) NOT NULL,
	email  varchar(50) NOT NULL,
	password  varchar(20) NOT NULL,
	dateOfBirth Date NOT NULL,

	PRIMARY KEY (customerID)
) ;
INSERT INTO customer_table (firstName, lastName, email, password, dateOfBirth) VALUES('Robert', 'Thomas', 'ramon1984@gmail.com', 'Qwerty', '1990-12-01');
INSERT INTO customer_table (firstName, lastName, email, password, dateOfBirth) VALUES('Thomas', 'Farmer', 'wilford.erns@yahoo.com', 'abcdefg', '1972-10-12');
INSERT INTO customer_table (firstName, lastName, email, password, dateOfBirth) VALUES('Gertie', 'Leonard', 'addie_erdma5@hotmail.com', 'MiraTheDog', '1987-05-23');

CREATE TABLE driver_table (
	driverID int NOT NULL GENERATED ALWAYS AS IDENTITY
        (START WITH 1, INCREMENT BY 1),
	firstName  varchar(20) NOT NULL,
	lastName  varchar(20) NOT NULL,
	email  varchar(50) NOT NULL,
	password  varchar(20) NOT NULL,
	dateOfBirth Date NOT NULL,
	isDriving boolean,

	PRIMARY KEY (driverID)
) ;
INSERT INTO driver_table (firstName, lastName, email, password, dateOfBirth, isDriving) VALUES('Roger', 'Thomas', 'stacey1989@gmail.com', '123', '1976-04-09', 'true');
INSERT INTO driver_table (firstName, lastName, email, password, dateOfBirth, isDriving) VALUES('April', 'Garcia', 'brett19802015@gmail.com', '1234', '1993-03-21', 'false');
INSERT INTO driver_table (firstName, lastName, email, password, dateOfBirth, isDriving) VALUES('Kimberly', 'Zepeda', 'aliya.hirth1@hotmail.com', '12345', '1966-06-23', 'true');


CREATE TABLE booking_table (
	driverID int,
	startTime  timestamp NOT NULL,
	endTime  time,
	customerID  int NOT NULL,
	bookingReference  varchar(20),
	distanceInMiles float NOT NULL,
	paymentAmount float(12) DEFAULT 0.0,
	paymentTime  timestamp NOT NULL,
    jobCompleted boolean default false,
	originName varchar(255),
	destinationName varchar(255),
	PRIMARY KEY (bookingReference)
) ;
INSERT INTO booking_table (driverID, startTime, endTime, customerID, bookingReference, distanceInMiles, paymentAmount, paymentTime, jobCompleted, originName, destinationName) VALUES(1, '2018-11-05 09:30:00', '10:00:00', 2, 'DFRA8LXBPNMMGKQ3HAEL', 9, 17.98, '2018-11-05 09:31:51', 'false', 'Clifton Observatory, Bristol', 'Temple Meads, Bristol');
INSERT INTO booking_table (driverID, startTime, endTime, customerID, bookingReference, distanceInMiles, paymentAmount, paymentTime, jobCompleted, originName, destinationName) VALUES(3, '2018-11-05 10:30:00', '11:00:00', 1, 'I40DNT3J98419ZQXMMEZ', 9, 17.98, '2018-11-05 10:31:51', 'false', 'Temple Meads, Bristol', 'Clifton Observatory, Bristol');
INSERT INTO booking_table (driverID, startTime, endTime, customerID, bookingReference, distanceInMiles, paymentAmount, paymentTime, jobCompleted, originName, destinationName) VALUES(2, '2018-11-05 11:00:00', '11:30:00', 1, 'TTB2EJ9L0R53VIOFDYZ0', 22, 37.98, '2018-11-05 11:00:21', 'false', 'Bond Street South, Bristol', 'Green Park, Bath');


CREATE TABLE driver_invoice (
	invoiceID  int NOT NULL GENERATED ALWAYS AS IDENTITY
        (START WITH 1, INCREMENT BY 1),
	driverID int NOT NULL,
	paymentTime timestamp NOT NULL,
	paymentAmount float(12) DEFAULT 0.00,
	journeyStart timestamp,
	journeyEnd timestamp,
	
	PRIMARY KEY (invoiceID) 
) ;
INSERT INTO driver_invoice (driverID, paymentTime, paymentAmount, journeyStart, journeyEnd) VALUES(1, '2018-11-05 14:00:00',55.00, '2018-11-05 14:25:00','2018-11-05 15:50:08');
INSERT INTO driver_invoice (driverID, paymentTime, paymentAmount, journeyStart, journeyEnd) VALUES(2, '2018-11-05 17:36:20',28.00, '2018-11-05 17:59:30','2018-11-05 18:25:11');
INSERT INTO driver_invoice (driverID, paymentTime, paymentAmount, journeyStart, journeyEnd) VALUES(3, '2018-11-05 11:22:05',34.00, '2018-11-05 11:44:12','2018-11-05 12:25:33');


CREATE TABLE customer_invoice (
	invoiceID  int NOT NULL GENERATED ALWAYS AS IDENTITY
        (START WITH 1, INCREMENT BY 1),
	customerID int NOT NULL,
	paymentTime timestamp NOT NULL,
	paymentAmount float(12) DEFAULT 0.00,
	journeyStart timestamp,
	journeyEnd timestamp,
	
	PRIMARY KEY (invoiceID) 
) ;
INSERT INTO customer_invoice (customerID, paymentTime, paymentAmount, journeyStart, journeyEnd) VALUES(1, '2018-11-05 14:00:00', 55.00, '2018-11-11 14:25:00','2018-11-05 15:50:08');
INSERT INTO customer_invoice (customerID, paymentTime, paymentAmount, journeyStart, journeyEnd) VALUES(1, '2018-11-05 17:36:20', 28.00, '2018-11-11 17:59:30','2018-11-05 18:25:11');
INSERT INTO customer_invoice (customerID, paymentTime, paymentAmount, journeyStart, journeyEnd) VALUES(2, '2018-11-05 11:22:05', 34.00, '2018-11-11 11:44:12','2018-11-05 12:25:33');


CREATE TABLE head_office (
	adminID int NOT NULL GENERATED ALWAYS AS IDENTITY
        (START WITH 1, INCREMENT BY 1),
	firstName varchar(20) NOT NULL,
	lastName varchar(20) NOT NULL,
	email varchar(50) NOT NULL,
	password varchar(20) NOT NULL,
	
	PRIMARY KEY (adminID) 
) ;
INSERT INTO head_office (firstName, lastName, email, password) VALUES('Mathias', 'Sibman','gqrekovsky16@yopmail.com', 'a123');
INSERT INTO head_office (firstName, lastName, email, password) VALUES('Benjamin', 'Hubert','ingerk13@yopmail.com', 'a234');
INSERT INTO head_office (firstName, lastName, email, password) VALUES('Ebbe', 'Streme','bjebbe9@yopmail.com', 'a2345');