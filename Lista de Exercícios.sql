-- Funções de agregação
	-- Count
    -- Sum
    -- AVG
    -- Max
    -- Min
    
-- GROUP BY / ORDER BY: As funções de agregação devem ser seguidas de GROUP BY

-- JOIN
-- DISTINCT: Remover duplicatas

USE e_shop__connect;

-- Exercício 01: Selecione todos os nomes e números de telefone dos usuários.
SELECT userName, phoneNumber 
FROM users;

-- Exercício 02: Liste os nomes dos compradores.
SELECT userName AS Nome 
FROM users 
WHERE userID IN (SELECT userID FROM buyer);

-- Exercício 03: Liste os nomes dos vendedores.
Select userName as Nome 
FROM users
WHERE userID IN (SELECT userID FROM seller);

-- Exercício 04: Encontre todas as informações de cartão de crédito dos usuários.
SHOW COLUMNS FROM bank_card;

SELECT 
	bank_card.card_number AS 'Número do Cartão',
    bank_card.expiry_date AS 'Validade',
    bank_card.bank,
    
    credit_card.userID,
    credit_card.organization_name
FROM 
	bank_card AS Banco
JOIN credit_card AS Credito
ON bank.card_number = credito.card_number;

-- Exercício 05: Selecione os nomes dos produtos e seus preços.
SELECT 
	product_name AS Nome, 
	price AS Preço 
FROM 
	product;

-- Exercício 06: Liste todos os produtos de uma determinada marca (por exemplo, "Microsoft")
SELECT * FROM 
	product
WHERE 
	fk_brand_name = "Microsoft";
    
-- Exercício 07:  Encontre o número de itens em cada pedido
SELECT 
	fk_order_number AS Pedido,
    SUM(quantity) AS QTDE_Itens
FROM contain
GROUP BY Pedido
ORDER BY QTDE_Itens DESC;

-- Exercício 08: Calcule o total de vendas por loja.
SELECT 
	s.store_name,
    SUM(o.price)
FROM store AS s
INNER JOIN product AS p ON s.SID = p.fk_SID
INNER JOIN order_item AS o ON p.PID = o.fk_PID
GROUP BY store_name;

-- Total de todas as lojas.
SELECT 
    SUM(o.price)
FROM store AS s
INNER JOIN product AS p ON s.SID = p.fk_SID
INNER JOIN order_item AS o ON p.PID = o.fk_PID;
	-- Quando há apenas uma coluna selecionada, não é necessária a utilização do GROUP BY.

-- Exercício 09: Liste as avaliações dos produtos (grade) com seus nomes e conteúdo de usuário.
SELECT 
	p.product_name,
    c.grade,
    c.content
FROM product AS p
INNER JOIN comments AS c ON p.PID = c.fk_PID;

-- Exercício 10: Selecione os nomes dos compradores que fizeram pedidos.
SELECT 
	u.userName
FROM buyer AS b
INNER JOIN users AS u ON b.userID = u.userID
INNER JOIN address AS a ON a.fk_userID = u.userID
INNER JOIN deliver_to AS d ON d.fk_addressID = a.addressID;

-- Exercício 11: Encontre os vendedores que gerenciam várias lojas.
SELECT 
	u.userName,
    COUNT(s.userID) AS QTD
FROM users AS u
INNER JOIN seller AS s ON u.userID = s.userID
INNER JOIN manage AS m ON s.userID = m.fk_userID
GROUP BY u.userName
HAVING QTD > 1;

-- Exercício 12: Liste os nomes das lojas que oferecem produtos de uma determinada marca (por exemplo, "Apple").
SELECT 
	DISTINCT 
    p.fk_brand_name,
    s.store_name,
    p.fk_SID
FROM store AS s
INNER JOIN product AS p ON s.SID = p.fk_SID AND p.fk_brand_name = "Microsoft";

-- Exercício 13: Encontre as informações de entrega de um pedido específico (por exemplo, orderNumber = 123).
SELECT
	d.fk_addressID,
    d.fk_order_number,
    d.time_delivered
FROM orders AS o
INNER JOIN deliver_to as d ON o.order_number = d.fk_order_number
WHERE o.order_number = 12992012;

-- Exercício 14: Calcule o valor médio das compras dos compradores.
SELECT 
    b.userID,
    AVG(o.total_amount) AS avg_total_amount
FROM 
    buyer AS b 
INNER JOIN 
    users AS u ON u.userID = b.userID
LEFT JOIN 
    (
        SELECT 
            card_number, 
            fk_userID 
        FROM 
            debit_card
        UNION 
        SELECT 
            card_number, 
            fk_userID 
        FROM 
            credit_card
    ) AS cards ON u.userID = cards.fk_userID
LEFT JOIN 
    bank_card AS bc ON cards.card_number = bc.card_number
LEFT JOIN 
    payment AS p ON p.fk_card_number = bc.card_number
LEFT JOIN 
    orders AS o ON o.order_number = p.fk_order_number
GROUP BY 
    b.userID;

-- Exercício 15: Liste as marcas que têm pontos de serviço em uma determinada cidade (por exemplo, "Nova York").
SELECT 
	DISTINCT brand_name AS Brand,
    City
FROM brand AS b 
INNER JOIN after_sales_service_at AS a ON b.brand_name = a.fk_brand_name
INNER JOIN service_points AS s ON s.SPID = a.fk_SPID
WHERE s.city = "Montreal"; -- Alterar o nome a depender da cidade que se queira obter os resultados.

-- Exercício 16: Encontre o nome e o endereço das lojas com uma classificação de cliente superior a 4.
SELECT 
	* 
FROM STORE WHERE customer_grade > 4;

-- Exercício 17: Liste os produtos com estoque esgotado. 
SELECT 
	*
FROM product WHERE amount = 0;

-- Exercício 18: Encontre os produtos mais caros em cada marca.
SELECT 
	b.brand_name,
	MAX(price) AS "Maior Preço"
FROM product AS p
INNER JOIN brand AS b where p.fk_brand_name = b.brand_name
GROUP BY b.brand_name;

-- Exercício 19: Calcule o total de pedidos em que um determinado cartão de crédito (por exemplo, cardNumber = '1234567890') foi usado.
SELECT 
	b.card_number,
	COUNT(b.card_number) AS "Orders Amount"
FROM credit_card AS c
INNER JOIN bank_card AS b ON c.card_number = b.card_number
INNER JOIN payment AS p ON p.fk_card_number = b.card_number
INNER JOIN orders AS o ON o.order_number = p.fk_order_number
WHERE b.card_number = 4902921234028831
GROUP BY b.card_number;

-- Exercício 20: Liste os nomes e números de telefone dos usuários que não fizeram pedidos.
SELECT 
	DISTINCT us.userName, us.phoneNumber, us.userID
FROM users AS us
WHERE us.userID NOT IN (
	SELECT 
		DISTINCT u.userID
	FROM orders AS o
	INNER JOIN payment AS p ON o.order_number = p.fk_order_number
	INNER JOIN bank_card AS bc ON p.fk_card_number = bc.card_number
	INNER JOIN (
		SELECT cc.card_number, cc.fk_userID FROM credit_card AS cc
		UNION ALL
		SELECT dc.card_number, dc.fk_userID FROM debit_card AS dc
	) AS cards ON cards.card_number = bc.card_number
	INNER JOIN users AS u ON cards.fk_userID = u.userID
);

-- Exercício 21: Liste os nomes dos produtos que foram revisados por compradores com uma classificação superior a 4.
SELECT 
	DISTINCT p.product_name 
FROM product AS P
INNER JOIN comments AS c ON c.fk_PID = p.PID AND c.grade > 4
INNER JOIN users AS u ON u.userID = c.fk_userID
INNER JOIN buyer AS b ON b.userID = u.userID;

-- Exercício 22: Encontre os nomes dos vendedores que não gerenciam nenhuma loja.
SELECT 
	userName
FROM users
WHERE userName NOT IN (
	SELECT 
		DISTINCT u.userName 
	FROM users AS u
	INNER JOIN seller AS s ON u.userID = s.userID
	INNER JOIN manage AS m ON m.fk_userID = u.userID
);

-- Exercício 23: Liste os nomes dos compradores que fizeram pelo menos 3 pedidos.
SELECT c.fk_userID, COUNT(*) as num_orders
FROM orders AS o 
INNER JOIN payment AS p ON o.order_number = p.fk_order_number
INNER JOIN bank_card AS b ON p.fk_card_number = b.card_number
INNER JOIN 
	(
    SELECT card_number, fk_userID FROM debit_card
    UNION ALL
    SELECT card_number, fk_userID FROM credit_card
    ) AS c ON c.card_number = b.card_number
GROUP BY c.fk_userID
HAVING COUNT(*) >= 3;

-- Exercício 24: Encontre o total de pedidos pagos com cartão de crédito versus cartão de débito. 
WITH UserOrders AS (
    SELECT c.fk_userID, COUNT(*) as num_orders
    FROM orders AS o 
    INNER JOIN payment AS p ON o.order_number = p.fk_order_number
    INNER JOIN bank_card AS b ON p.fk_card_number = b.card_number
    INNER JOIN 
    	(
        SELECT card_number, fk_userID FROM debit_card
        UNION ALL
        SELECT card_number, fk_userID FROM credit_card
        ) AS c ON c.card_number = b.card_number
    GROUP BY c.fk_userID
    HAVING COUNT(*) >= 3
)

SELECT 
    COALESCE(SUM(CASE WHEN c.card_type = 'credit_card' THEN 1 ELSE 0 END), 0) AS total_credit_orders,
    COALESCE(SUM(CASE WHEN c.card_type = 'debit_card' THEN 1 ELSE 0 END), 0) AS total_debit_orders
FROM 
    (
        SELECT 
            card_number, 
            'credit_card' AS card_type 
        FROM 
            credit_card
        UNION ALL
        SELECT 
            card_number, 
            'debit_card' AS card_type 
        FROM 
            debit_card
    ) AS c
LEFT JOIN 
    payment AS p ON c.card_number = p.fk_card_number
WHERE 
    p.fk_order_number IN (SELECT fk_order_number FROM UserOrders);

-- Exercício 25: Liste as marcas (brandName) que não têm produtos na loja com ID 1.
SELECT 
	* 
FROM brand AS bn 
WHERE bn.brand_name NOT IN (
SELECT 
	b.brand_name 
FROM brand AS b
INNER JOIN product AS p ON b.brand_name = p.fk_brand_name
INNER JOIN store AS s ON s.SID = p.fk_SID AND s.SID = 1
);

-- Exercício 26: Calcule a quantidade média de produtos disponíveis em todas as lojas.
SELECT 
	AVG(p.amount) AS Média
FROM store AS s
INNER JOIN product AS p ON s.SID = p.fk_SID;

-- Exercício 27: Encontre os nomes das lojas que não têm produtos em estoque (amount = 0).
SELECT 
	* 
FROM store AS s
INNER JOIN product AS p ON s.SID = p.fk_SID
WHERE p.amount = 0; -- Alterar a quantidade conforme a necessidade.

-- Exercício 28: Liste os nomes dos vendedores que gerenciam uma loja localizada em "São Paulo"
SELECT 
	*
FROM users AS u
INNER JOIN seller AS s ON u.userID = s.userID
INNER JOIN manage AS m ON m.fk_userID = u.userID
INNER JOIN store AS st ON st.SID = m.fk_SID
WHERE st.city = "São Paulo"; -- Alterar cidade conforme a necessidade.

-- Exercício 29: Encontre o número total de produtos de uma marca específica (por exemplo, "Sony") disponíveis em todas as lojas.
SELECT 
	SUM(amount) AS SOMA 
FROM 
	product AS p
INNER JOIN 
	store AS s
ON s.SID = p.fk_SID
WHERE 
	fk_brand_name = "Microsoft";

-- Exercício 30: Calcule o valor total de todas as compras feitas por um comprador específico (por exemplo, userid = 1)
SELECT 
	SUM(o.total_amount) AS Total 
FROM buyer AS b
INNER JOIN users AS u ON b.userID = u.userID
INNER JOIN (
	SELECT cc.card_number, cc.fk_userID FROM credit_card AS cc
	UNION ALL
	SELECT dc.card_number, dc.fk_userID FROM debit_card AS dc
) AS cards ON cards.fk_userID = u.userID
INNER JOIN bank_card AS bc ON bc.card_number = cards.card_number
INNER JOIN payment AS p ON p.fk_card_number = bc.card_number
INNER JOIN orders AS o ON o.order_number = p.fk_order_number
WHERE u.userID = 12;