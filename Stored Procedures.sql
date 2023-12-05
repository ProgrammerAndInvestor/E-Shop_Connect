-- Ativação do Banco de Dados
USE e_shop__connect;

-- STORED PROCEDURES

-- 1. Crie uma stored procedure que retorne todos os usuários que são compradores.

DELIMITER $$
 -- Cláusula complementar para alterar o delimitador, não fazendo parte da procedure

DROP PROCEDURE IF EXISTS getBuyers $$

CREATE PROCEDURE getBuyers()
BEGIN
    SELECT * FROM users WHERE userID IN (SELECT userID FROM buyer);
END $$

DELIMITER ;

-- Ativar a PROCEDURE
CALL getBuyers();

-- 2. Crie uma PROCEDURE para retornar os usuários sellers
DELIMITER $$
 -- Cláusula complementar para alterar o delimitador, não fazendo parte da procedure

DROP PROCEDURE IF EXISTS getSellers $$

CREATE PROCEDURE getSellers()
BEGIN
    SELECT * FROM users WHERE userID IN (SELECT userID FROM seller);
END $$

DELIMITER ;

-- Ativar a PROCEDURE
CALL getSellers();

-- 3. Crie uma PROCEDURE para retornar os números dos cartões de crédito
DELIMITER $$
 -- Cláusula complementar para alterar o delimitador, não fazendo parte da procedure

DROP PROCEDURE IF EXISTS getCreditCards $$

CREATE PROCEDURE getCreditCards()
BEGIN
    SELECT card_number FROM credit_card;
END $$

DELIMITER ;

-- Ativar a PROCEDURE
CALL getCreditCards();

-- 4 Crie uma PROCEDURE que insira um novo produto na tabela Product.
DELIMITER $$
 -- Cláusula complementar para alterar o delimitador, não fazendo parte da procedure

CREATE PROCEDURE insertNewProduct(
	IN p_PID INT,
    IN p_SID INT,
    IN p_brand VARCHAR(50),
    IN p_name VARCHAR(120),
    IN p_type VARCHAR(50),
    IN p_model_number VARCHAR(50),
    IN p_color VARCHAR(20),
    IN p_amount INT, 
    IN p_price	DECIMAL(6, 2)
) 
BEGIN
	INSERT INTO product (PID, fk_SID, fk_brand_name, product_name, product_type, model_number, color, amount, price)
    VALUES (p_PID, p_SID, p_brand, p_name, p_type, p_model_number, p_color, p_amount, p_price);
END $$

DELIMITER ;

-- Ativar a PROCEDURE
CALL insertNewProduct(
	9,
    39,
    "GoPro",
    "GoPro Hero 10",
    "Cameras",
    1525118841,
    "black",
    10,
	525
);

-- 5. Crie uma PROCEDURE para cadastrar Marcas
DELIMITER $$
 -- Cláusula complementar para alterar o delimitador, não fazendo parte da procedure
CREATE PROCEDURE insertNewBrand(
	IN p_brand_name VARCHAR(50)
) 
BEGIN
	INSERT INTO brand (brand_name)
    VALUES (p_brand_name);
END $$

DELIMITER ;

-- Ativar a PROCEDURE
CALL insertNewBrand(
	"Sony"
);
-- 6. Crie uma PROCEDURE para cadastrar Users
DELIMITER $$
 -- Cláusula complementar para alterar o delimitador, não fazendo parte da procedure
CREATE PROCEDURE insertNewUser(
	IN p_userName VARCHAR(40),
    IN p_phoneNumber VARCHAR(12)
) 
BEGIN
	INSERT INTO users (userName, phoneNumber)
    VALUES (p_userName, p_phoneNumber);
END $$

DELIMITER ;

-- Ativar a PROCEDURE
CALL insertNewUser(
	"Inocencio",
    "40028922"
);

-- 7. Crie uma PROCEDURE para cadastrar Stores
DELIMITER $$
 -- Cláusula complementar para alterar o delimitador, não fazendo parte da procedure
CREATE PROCEDURE insertNewStore(
	IN p_SID INT,
    IN p_store_name VARCHAR(50),
    IN p_province VARCHAR(35),
    IN p_city VARCHAR(40),
    IN p_street_addres VARCHAR(40),
    IN p_customer_grade INT,
    IN p_start_time DATE
) 
BEGIN
	INSERT INTO store (SID, store_name, province, city, street_addres, customer_grade, start_time)
    VALUES (p_SID, p_store_name, p_province, p_city, p_street_addres, p_customer_grade, p_start_time);
END $$

DELIMITER ;

-- Ativar a PROCEDURE
CALL insertNewStore(
	1,
    "Inocencio's",
    "Ontario",
    "Toronto",
    "No.123 Yonge Street",
    "5",
    "2005-02-28"
);

-- 8. Crie uma PROCEDURE que atualize a quantidade de um produto com base no seu ID
DELIMITER $$
 -- Cláusula complementar para alterar o delimitador, não fazendo parte da procedure
CREATE PROCEDURE updateProductAmount(
	IN p_PID INT, -- ID do produto
    IN p_new_amount VARCHAR(50) -- Nova quantidade em estoque
) 
BEGIN
	UPDATE product SET amount = p_new_amount WHERE PID = p_PID;
END $$

DELIMITER ;

-- Ativar a PROCEDURE
CALL updateProductAmount(
	9,
    200
);

-- 9. Crie uma PROCEDURE para atualizar o número de telefone do usuário com base no ID
DELIMITER $$
 -- Cláusula complementar para alterar o delimitador, não fazendo parte da procedure
CREATE PROCEDURE updatePhoneNumber(
	IN p_userID INT, -- ID do produto
    IN p_phoneNumber VARCHAR(12) -- Nova quantidade em estoque
) 
BEGIN
	UPDATE users SET phoneNumber = p_phoneNumber WHERE userID = p_userID;
END $$

DELIMITER ;

-- Ativar a PROCEDURE
CALL updatePhoneNumber(
	101,
    "000-000-0000"
);