CREATE DATABASE AULA;
USE AULA;
CREATE TABLE prods
(codigo NUMERIC(3) NOT NULL,
nome VARCHAR(50) NOT NULL,
preco NUMERIC (5,2) NOT NULL,
tipo CHAR(1) NULL,
-- [S]uprimento, [C]omponente,[P]eriférico
CONSTRAINT PK1 PRIMARY KEY (codigo));


INSERT INTO PRODS VALUES
(10,'HD',200,'C'),
(11,'Memoria',250,'C'),
(12,'Impressora',680,'P'),
(13, 'Processador' ,600, 'C'),
(14,'DVD-RW',2,'S'),
(15,'Papel A4',19,'S'),
(16,'Scanner',199,'P');

SELECT * FROM PRODS;

-- QUESTÃO A -- 7 Produtos --
SELECT COUNT(nome) 
FROM PRODS ;

-- QUESTÃO B -- 3 tipos --
SELECT COUNT( DISTINCT tipo) FROM PRODS;

-- QUESTÃO C -- Tipo C = 3 -- Tipo P = 2 -- Tipo S = 2 --
SELECT COUNT(tipo) AS C FROM PRODS WHERE tipo = 'C' ;
SELECT COUNT(tipo) AS P FROM PRODS WHERE tipo = 'P' ;
SELECT COUNT(tipo) AS S FROM PRODS WHERE tipo = 'S';

-- QUESTÃO D -- A média é de R$278 -- 
SELECT AVG(preco) FROM PRODS;

-- QUESTÃO E -- A média é de R$ 10,5 --
SELECT AVG(preco) FROM PRODS WHERE tipo = 'S';

-- QUESTÃO F -- As médias são:  tipo C = R$350 -- Tipo P = R$439,5 -- Tipo S = R$10,5 -- 
SELECT AVG(preco) FROM PRODS WHERE tipo = 'S';
SELECT AVG(preco) FROM PRODS WHERE tipo = 'P';
SELECT AVG(preco) FROM PRODS WHERE tipo = 'C';
