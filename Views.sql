-- 1. Crie  uma  view  que  liste  o  nome  e  número  de  telefone  de  todos  os usuários.
CREATE VIEW User_Details AS
SELECT name, phoneNumber
FROM users;

SELECT * FROM User_Details;

-- 2. Crie uma view que mostre os detalhes dos produtos, incluindo nome, tipo, e preço.
CREATE VIEW Product_Details AS
SELECT name, type, price
FROM Product;

SELECT * FROM Product_Details;

-- 3.Crie  uma  view  que  exiba  os  comentários  dos  compradores,  incluindo nome do comprador, nome do produto e conteúdo do comentário.
CREATE VIEW Buyer_Comments AS
SELECT u.name AS Buyer_Name, p.name AS Product_Name, c.content AS Comment_Content
FROM comments c
JOIN users u ON c.fk_userid = u.pk_userid
JOIN Product p ON c.fk_pid = p.pk_pid;

SELECT * FROM Buyer_Comments;

-- 4.Crie uma view que mostre informações de entrega, incluindo endereço, cidade e data de entrega.
CREATE VIEW Delivery_Info AS
SELECT a.streetaddr AS Address, a.city AS City, dt.timeDelivered AS Delivery_Date
FROM deliver_To dt
JOIN Address a ON dt.fk_addrid = a.pk_addrid;

SELECT * FROM Delivery_Info;

-- 5.Crie uma view que liste todas as lojas com suas classificações de cliente.
CREATE VIEW Store_Ratings AS
SELECT s.name AS Store_Name, s.customerGrade AS Customer_Rating
FROM store s;

SELECT * FROM Store_Ratings;

-- 6.Crie uma view que mostre os produtos agrupados por marca, incluindo a contagem de produtos em cada marca.
CREATE VIEW Products_By_Brand AS
SELECT brand.pk_brandName AS Brand_Name, COUNT(Product.pk_pid) AS Product_Count
FROM Product
JOIN brand ON Product.fk_brand = brand.pk_brandName
GROUP BY brand.pk_brandName;

SELECT * FROM Products_By_Brand;

-- 7.Crie  uma  view  que  exiba  os  pedidos  com  detalhes  de  pagamento, incluindo  número  do  pedido,  estado  de  pagamento  e  método  de pagamento.
CREATE VIEW Order_Payment_Details AS
SELECT o.pk_orderNumber AS Order_Number, o.paymentState AS Payment_State, p.fk_cardNumber AS Payment_Method
FROM orders o
JOIN payment p ON o.pk_orderNumber = p.fk_orderNumber;

SELECT * FROM Order_Payment_Details;

-- 8.Crie  uma  view  que  liste  os  produtos  em  estoque,  incluindo  nome, quantidade e preço.
CREATE VIEW Stock_Products AS
SELECT name, amount AS Quantity, price AS Price
FROM Product;

SELECT * FROM Stock_Products;

-- 9.Crie uma view que mostre a quantidade total de itens em cada pedido.
CREATE VIEW Total_Items_Per_Order AS
SELECT oi.pk_orderNumber AS Order_Number, COUNT(*) AS Total_Items
FROM orders oi
GROUP BY oi.pk_orderNumber;

SELECT * FROM Total_Items_Per_Order;

-- 10.Crie uma view que exiba o total de vendas por loja, incluindo nome da loja e total de vendas.
CREATE VIEW Store_Total_Sales AS
SELECT s.name AS Store_Name, SUM(oi.price) AS Total_Sales
FROM store s
JOIN Product p ON s.pk_sid = p.fk_sid
JOIN orderItem oi ON p.pk_pid = oi.fk_pid
GROUP BY s.name;

SELECT * FROM Store_Total_Sales;

-- 11.Crie uma view que liste os produtos com suas avaliações médias.
CREATE VIEW Product_Average_Ratings AS
SELECT p.name AS Product_Name, AVG(c.grade) AS Average_Rating
FROM Product p
LEFT JOIN comments c ON p.pk_pid = c.fk_pid
GROUP BY p.name;

SELECT * FROM Product_Average_Ratings;

-- 12.Crie  uma  view  que  exiba  informações  de  cartão  de  crédito,  incluindo número do cartão e data de validade.
CREATE VIEW Credit_Card_Info AS
SELECT c.pk_cardNumber AS Credit_Card_Number, b.expiryDate AS Expiry_Date
FROM creditCard AS c
INNER JOIN bankCard AS b ON b.pk_cardNumber = c.pk_cardNumber;

SELECT * FROM Credit_Card_Info;

-- 13.Crie uma view que liste as marcas e a quantidade total de produtos de cada marca.
CREATE VIEW Brand_Product_Count AS
SELECT b.pk_brandName AS Brand_Name, COUNT(p.pk_pid) AS Total_Products
FROM brand b
LEFT JOIN Product p ON b.pk_brandName = p.fk_brand
GROUP BY b.pk_brandName;

SELECT * FROM Brand_Product_Count;

-- 14.Crie  uma  view  que  mostre  os  produtos  mais  caros,  incluindo  nome  e preço.
CREATE VIEW Most_Expensive_Products AS
SELECT name AS Product_Name, price AS Product_Price
FROM Product
ORDER BY price DESC;

SELECT * FROM Most_Expensive_Products;

-- 15.Crie  uma  view  que  exiba  as  informações  de  gerenciamento  de  loja, incluindo nome do vendedor e nome da loja
CREATE VIEW Store_Management_Info AS
SELECT u.name AS Seller_Name, s.name AS Store_Name
FROM Manage m
JOIN users u ON m.fk_userid = u.pk_userid
JOIN store s ON m.fk_sid = s.pk_sid;

SELECT * FROM Store_Management_Info;