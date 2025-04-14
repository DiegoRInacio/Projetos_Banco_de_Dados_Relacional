-- Criação do database
-- CREATE DATABASE P1_nome_aluno_20251;

-- Tabela Clientes
CREATE TABLE Clientes (
    id_cliente SERIAL PRIMARY KEY,
    nome_cliente VARCHAR(100) NOT NULL,
    cpf_cliente VARCHAR(14) NOT NULL UNIQUE,
    email_cliente VARCHAR(100) NOT NULL
);

-- Tabela Produtos
CREATE TABLE Produtos (
    id_produto SERIAL PRIMARY KEY,
    descricao_produto VARCHAR(100) NOT NULL,
    preco_produto DECIMAL(10,2) NOT NULL
);

-- Tabela Pedidos
CREATE TABLE Pedidos (
    id_pedido SERIAL PRIMARY KEY,
    data_pedido DATE NOT NULL,
    id_cliente INT NOT NULL REFERENCES Clientes(id_cliente)
);

-- Tabela Itens_dos_Pedidos
CREATE TABLE Itens_dos_Pedidos (
    id_item SERIAL PRIMARY KEY,
    id_pedido INT NOT NULL REFERENCES Pedidos(id_pedido),
    id_produto INT NOT NULL REFERENCES Produtos(id_produto),
    quantidade INT NOT NULL,
    total_item DECIMAL(10,2) NOT NULL
);

-- questão 2
-- Inserção de clientes
INSERT INTO Clientes (nome_cliente, cpf_cliente, email_cliente) VALUES
('João Silva', '12345678901', 'joao@email.com'),
('José da Silva', '12345678910', 'jose@email.com'),
('Maria Souza', '98765432109', 'maria@email.com'),
('Diego Ramos Inácio', '11122233344', 'diego@email.com'), -- Aluno que realizou a prova
('Beltrano Silva', '55566677788', 'beltrano@email.com');

-- Inserção de produtos
INSERT INTO Produtos (descricao_produto, preco_produto) VALUES
('Notebook Dell', 5200.00),
('Mouse Wireless', 120.00),
('Teclado Mecânico', 250.00),
('Notebook Lenovo', 3500.00),
('Mouse Wireless G', 2135.00),
('Teclado Mecânico G', 2265.00),
('Monitor 24"', 1500.00),
('HD Externo 1TB', 350.00);

-- Inserção de pedidos
INSERT INTO Pedidos (data_pedido, id_cliente) VALUES
('2023-05-10', 1),
('2023-05-10', 2),
('2023-05-11', 3),
('2023-05-10', 1),
('2023-05-10', 2),
('2023-05-11', 3),
('2023-05-12', 4),
('2023-05-13', 5);

-- Inserção de itens dos pedidos
INSERT INTO Itens_dos_Pedidos (id_pedido, id_produto, quantidade, total_item) VALUES
(1, 1, 2, 10400.00),
(2, 2, 1, 120.00),
(3, 3, 3, 750.00),
(4, 4, 1, 3500.00),
(5, 5, 3, 405.00),
(6, 6, 2, 530.00),
(7, 7, 1, 1500.00),
(8, 8, 2, 700.00);

-- Questão 3
-- UPDATE em todas as tabelas
UPDATE Clientes SET email_cliente = 'joao.silva@novoemail.com' WHERE id_cliente = 1;
UPDATE Produtos SET preco_produto = 5300.00 WHERE id_produto = 1;
UPDATE Pedidos SET data_pedido = '2023-05-15' WHERE id_pedido = 7;
UPDATE Itens_dos_Pedidos SET quantidade = 2 WHERE id_item = 2;

-- DELETE (lembrando da regra de FK - deve excluir primeiro os itens dependentes)
DELETE FROM Itens_dos_Pedidos WHERE id_pedido = 8;
DELETE FROM Pedidos WHERE id_pedido = 8;

-- Questão 4:
-- Primeiro caso: Quantos produtos um cliente comprou (considerando id_cliente = 1)
SELECT 
    c.id_cliente, 
    c.nome_cliente,
    (SELECT SUM(quantidade) 
     FROM Itens_dos_Pedidos ip
     JOIN Pedidos p ON ip.id_pedido = p.id_pedido
     WHERE p.id_cliente = c.id_cliente) AS total_produtos_comprados
FROM 
    Clientes c;

-- 2ª forma de resolver o problema
-- Forma não apresentada em sala de aula uso indevido caso seja realizada.
SELECT c.id_cliente, c.nome_cliente, SUM(ip.quantidade) AS total_produtos_comprados
FROM Clientes c
JOIN Pedidos p ON c.id_cliente = p.id_cliente
JOIN Itens_dos_Pedidos ip ON p.id_pedido = ip.id_pedido
GROUP BY c.id_cliente, c.nome_cliente;

-- Segundo caso: Lucro na data 10/05/2023
SELECT SUM(ip.total_item) AS lucro_total
FROM Pedidos p
JOIN Itens_dos_Pedidos ip ON p.id_pedido = ip.id_pedido
WHERE p.data_pedido = '2023-05-10';

-- Comentário: O resultado mostra o total vendido nessa data específica.
-- Se a data fosse alterada, o resultado mostraria o total para a nova data especificada,
-- ou nenhum resultado se não houvesse vendas na data alterada.

-- Questão 5:
SELECT 
    c.id_cliente,
    c.nome_cliente,
    c.cpf_cliente,
    c.email_cliente,
    pr.id_produto,
    p.data_pedido,
    pr.descricao_produto,
    pr.preco_produto,
    ip.quantidade,
    ip.total_item
FROM 
    Clientes c
JOIN 
    Pedidos p ON c.id_cliente = p.id_cliente
JOIN 
    Itens_dos_Pedidos ip ON p.id_pedido = ip.id_pedido
JOIN 
    Produtos pr ON ip.id_produto = pr.id_produto
ORDER BY 
    p.data_pedido, c.nome_cliente;