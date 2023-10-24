-- Exclusão das Entidades

DROP TABLE users;
DROP TABLE buyer;
DROP TABLE seller;
DROP TABLE bank_card;
DROP TABLE credit_card;
DROP TABLE debit_card;
DROP TABLE store;
DROP TABLE product;
DROP TABLE order_item;
DROP TABLE orders;
DROP TABLE address;
DROP TABLE comments;
DROP TABLE service_point;
DROP TABLE save_to_shopping_cart;
DROP TABLE contain;
DROP TABLE payment;
DROP TABLE deliver_to;
DROP TABLE manage;
DROP TABLE brand;

-- Criação do Banco de Dados

CREATE DATABASE E_SHOP__CONNECT;
USE E_SHOP__CONNECT;

-- Criação das Entidades

CREATE TABLE users(
	userID INT NOT NULL AUTO_INCREMENT, -- AUTO_INCREMENT: adiciona-se uma unidade a cada ID criado.
    userName VARCHAR(40) NOT NULL,
    phoneNumber VARCHAR(12) NOT NULL,
    
    PRIMARY KEY (userID)
);

CREATE TABLE buyer(
	userID INT NOT NULL AUTO_INCREMENT, -- AUTO_INCREMENT: adiciona-se uma unidade a cada ID criado.
    
    PRIMARY KEY (userID),
    FOREIGN KEY (userID) REFERENCES users (userID)
);

CREATE TABLE seller(
	userID INT NOT NULL AUTO_INCREMENT, -- AUTO_INCREMENT: adiciona-se uma unidade a cada ID criado.
    
    PRIMARY KEY (userID),
    FOREIGN KEY (userID) REFERENCES users (userID)
);

CREATE TABLE bank_card (
	card_number CHAR(16) NOT NULL,
    expiry_date DATE NOT NULL,
    bank VARCHAR (20),
    
    PRIMARY KEY (card_number)
);

CREATE TABLE credit_card (
	card_number CHAR(16) NOT NULL,
    fk_userID INT NOT NULL,
    organization_name VARCHAR(50),
    
    PRIMARY KEY (card_number),
    FOREIGN KEY (card_number) REFERENCES bank_card(card_number),
    FOREIGN KEY (fk_userID) REFERENCES users(userID)
);

ALTER TABLE debit_card
DROP COLUMN organization_name;

CREATE TABLE debit_card (
	card_number CHAR(16) NOT NULL,
    fk_userID INT NOT NULL,
    organization_name VARCHAR(50),
    
    PRIMARY KEY (card_number),
    FOREIGN KEY (card_number) REFERENCES bank_card(card_number),
    FOREIGN KEY (fk_userID) REFERENCES users(userID)
);

ALTER TABLE STORE
MODIFY start_time DATE;

CREATE TABLE store (
	SID INT NOT NULL,
	store_name VARCHAR(50) NOT NULL,
    province VARCHAR(35) NOT NULL,
    city VARCHAR(40) NOT NULL,
    street_addres VARCHAR(40),
    customer_grade INT,
    start_time TIME,
    
    PRIMARY KEY (SID)
);

CREATE TABLE brand(
	brand_name VARCHAR(50) NOT NULL,
    
    PRIMARY KEY (brand_name)
);

SET FOREIGN_KEY_CHECKS = 0; -- Desabilita a Verificação das chaves estrangeiras
DROP TABLE product;
SET FOREIGN_KEY_CHECKS = 1; -- Habilita a Verificação das chaves estrangeiras

CREATE TABLE product (
	PID INT NOT NULL,
    fk_SID INT NOT NULL,
    fk_brand_name VARCHAR(50) NOT NULL,
    product_name VARCHAR(120) NOT NULL,
    product_type VARCHAR (50),
    model_number VARCHAR (50),
    color VARCHAR(20),
    amount INT DEFAULT NULL,
    price DECIMAL(6, 2) NOT NULL, -- DECIMAL: permite ajustar a quantidade de algarismos inteiros e de casas decimais (6 algarismos inteiros e duas casas decimais).
    
    
    PRIMARY KEY (PID),
    FOREIGN KEY (fk_SID) REFERENCES store(SID),
    FOREIGN KEY (fk_brand_name) REFERENCES brand(brand_name)
);

ALTER TABLE order_item
MODIFY creation_time DATE NOT NULL;

CREATE TABLE order_item(
	itemID INT NOT NULL AUTO_INCREMENT,
    fk_PID INT NOT NULL,
    price DECIMAL(6, 2),
    creation_time TIME NOT NULL,
    
    PRIMARY KEY (itemID),
    FOREIGN KEY (fk_PID) REFERENCES product(PID)
);

ALTER TABLE orders
MODIFY creation_time DATE NOT NULL;

CREATE TABLE orders (
	order_number INT NOT NULL,
    payment_state ENUM('Paid', 'Unpaid'),
    creation_time TIME NOT NULL, 
    total_amount DECIMAL(10, 2),
    
    PRIMARY KEY (order_number)
);

CREATE TABLE address (
	addressID INT NOT NULL,
    fk_userID INT NOT NULL,
    address_name VARCHAR(50),
    contact_phone_number VARCHAR(20),
    province VARCHAR(100),
    city VARCHAR(100),
    street_address VARCHAR(100),
    post_code VARCHAR(12),

	PRIMARY KEY(addressID),
    FOREIGN KEY (fk_userID) REFERENCES users(userID)
);

CREATE TABLE comments ( -- Entidade fraca.
	creation_time DATE NOT NULL,
    fk_userID INT NOT NULL,
    fk_PID INT NOT NULL,
    grade FLOAT,
    content VARCHAR(500),

	PRIMARY KEY (creation_time, fk_userID, fk_PID),
    FOREIGN KEY (fk_userID) REFERENCES users(userID),
    FOREIGN KEY (fk_PID) REFERENCES product(PID)
);

CREATE TABLE service_points (
	SPID INT NOT NULL,
    street_address VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    province VARCHAR(50),
    start_time VARCHAR(20),
    end_time VARCHAR (20),
    
    PRIMARY KEY (SPID)
);

CREATE TABLE save_to_shopping_cart (
	fk_userID INT NOT NULL,
    fk_PID INT NOT NULL,
    add_time DATE NOT NULL,
    quantity INT,
    
    PRIMARY KEY (fk_userID, fk_PID),
    FOREIGN KEY (fk_userID) REFERENCES users(userID),
    FOREIGN KEY (fk_PID) REFERENCES product(PID)
);

CREATE TABLE contain (
    fk_order_number INT NOT NULL,
    fk_itemID INT NOT NULL,
    quantity INT,
    
    PRIMARY KEY (fk_order_number, fk_itemID),
	FOREIGN KEY (fk_order_number) REFERENCES orders(order_number),
    FOREIGN KEY (fk_itemID) REFERENCES order_item(itemID)
);

CREATE TABLE payment (
	fk_order_number INT NOT NULL,
    fk_card_number CHAR(16) NOT NULL,
    pay_time DATE,
    
    PRIMARY KEY (fk_order_number, fk_card_number),
    FOREIGN KEY (fk_order_number) REFERENCES orders(order_number),
	FOREIGN KEY (fk_card_number) REFERENCES bank_card(card_number)
);	

CREATE TABLE deliver_to (
	fk_addressID INT NOT NULL,
    fk_order_number INT NOT NULL,
    time_delivered DATE,
    
    PRIMARY KEY (fk_addressID, fk_order_number),
    FOREIGN KEY (fk_addressID) REFERENCES address(addressID),
    FOREIGN KEY (fk_order_number) REFERENCES orders(order_number)
);

CREATE TABLE manage (
	fk_userID INT NOT NULL,
    fk_SID INT NOT NULL,
    set_up_time DATE,
    
    PRIMARY KEY (fk_userID,fk_SID),
    FOREIGN KEY (fk_userid) REFERENCES seller(userID),
    FOREIGN KEY (fk_SID) REFERENCES store(SID)
);

 

CREATE TABLE After_Sales_Service_At(
    fk_brand_name VARCHAR(20) NOT NULL,
    fk_SPID INT NOT NULL,
    
    PRIMARY KEY(fk_brand_name, fk_SPID),
    FOREIGN KEY(fk_brand_name) REFERENCES brand(brand_name),
    FOREIGN KEY(fk_SPID) REFERENCES service_points(SPID)
);