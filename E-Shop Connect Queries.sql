-- a. Consultar todos os produtos existentes na loja.
SELECT 
	PID,
    fk_brand_name,
    product_name,
    product_type,
    price
FROM 
	product;

-- b. Consultar os nomes de todos os usuários.
SELECT userName FROM users;

-- c. Consultar as lojas que vendem produtos.

-- d. Consultar os endereços relacionando com os clientes.
SELECT 
	u.userName,
	a.address_name,
	a.addressID
FROM address AS a
INNER JOIN users AS u ON a.fk_userID = u.userID
INNER JOIN buyer AS b ON u.userID = b.userID;

-- e. Consultar todos os produtos do tipo laptop.
SELECT 
	*
FROM product
WHERE product_type = "laptop";

-- f. Consultar o endereço, hora de inicio (start time) e hora final (end time) dos pontos de serviço da mesma cidade que o usuário cujo ID é 5.
	-- SELECT 
		-- s.SPID,
		-- s.street_address,
		-- s.city,
		-- s.start_time,
		-- s.end_time
	-- FROM users AS u 
	-- INNER JOIN address AS a ON u.userID = a.fk_userID AND u.userID = 5
	-- INNER JOIN service_points AS s ON a.city = s.city;
    
-- g. Consultar a quantidade total de produtos que foram colocados no carrinho (shopping cart), considerando a loja com ID (sid) igual a 8.

-- h. Consultar os comentários do produto 123456789.
SELECT 
	*
FROM comments AS c
INNER JOIN product AS p ON c.fk_PID = p.PID AND c.fk_PID = 1;

SELECT 
	*
FROM comments AS c
INNER JOIN product AS p ON c.fk_PID = p.PID AND c.fk_PID = 2;

SELECT 
	*
FROM comments AS c
INNER JOIN product AS p ON c.fk_PID = p.PID AND c.fk_PID = 3;

SELECT 
	*
FROM comments AS c
INNER JOIN product AS p ON c.fk_PID = p.PID AND c.fk_PID = 4;

SELECT 
	*
FROM comments AS c
INNER JOIN product AS p ON c.fk_PID = p.PID AND c.fk_PID = 5;

SELECT 
	*
FROM comments AS c
INNER JOIN product AS p ON c.fk_PID = p.PID AND c.fk_PID = 6;

SELECT 
	*
FROM comments AS c
INNER JOIN product AS p ON c.fk_PID = p.PID AND c.fk_PID = 7;

SELECT 
	*
FROM comments AS c
INNER JOIN product AS p ON c.fk_PID = p.PID AND c.fk_PID = 8;
