CREATE SCHEMA trab_final3;

USE trab_final3;

-- definir um tipo de delete --
 
CREATE TABLE lobby (
ID_lobby INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
servidor VARCHAR(50),
num_players INT NOT NULL
);

CREATE TABLE Player (
ID_player INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50),
nickname VARCHAR(20),
nivel INT NOT NULL, 
iniciante VARCHAR(50) NOT NULL,
credibilidade INT NOT NULL
);

CREATE TABLE stats (
ID_K_D INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
K_D VARCHAR(50) NOT NULL,
kills INT NOT NULL,
deaths INT NOT NULL
);

CREATE TABLE skin (
ID_skin INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100),
raridade VARCHAR(50),
sazonal VARCHAR(50) NOT NULL
CHECK (sazonal = 'Verdadeiro' OR 'Falso')
);

CREATE TABLE ELO (
ID_rank  INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
season VARCHAR(100),
nome VARCHAR(50),
nivel_rank INT NOT NULL
);

CREATE TABLE mapa (
ID_mapa  INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100),
rotation_comp VARCHAR(50) NOT NULL,
id_partidas INT NOT NULL,
CONSTRAINT fk_idpartidas FOREIGN KEY (ID_partidas)
REFERENCES partidas (ID_partidas)
ON DELETE CASCADE
);
 -- ao deletar uma partida(tabela mae) o mapa com o id correspondente sera deletado da tabela mapa(tabela filha) --

CREATE TABLE partidas (
ID_partidas  INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
modo VARCHAR(100),
num_rounds INT NOT NULL ,
num_players INT NOT NULL,
ID_lobby INT NOT NULL,
CONSTRAINT fk_idlobby FOREIGN KEY (ID_lobby)
REFERENCES lobby (ID_lobby)
ON DELETE CASCADE
); 
-- ao deletar um lobby(tabela mae) a partida com o id correspondente sera deletada na tabela partidas(tabela filha) --



-- comandos basicos -- 
-- tabelas -- 
select*from lobby;
select*from mapa;
select*from elo;
select*from partidas;
select*from skin;
select*from player;
select*from stats;

-- visoes -- 
SELECT*FROM rarity_skin;
SELECT*FROM lobby_br;
SELECT*FROM mapa_comp;
SELECT*FROM player_newb;
SELECT*FROM game_tdm;

-- drops -- 
drop table lobby;
drop table mapa;
drop table elo;
drop table partidas;
drop table skin;
drop table player;
drop table stats;

-- criar o bagui do constraint -- 


-- consultas com Join --


-- 1.Escreva uma consulta SQL para imprimir os players com elo ouro -- 

SELECT player.nome, elo.nome FROM Player INNER JOIN elo ON player.ID_player = elo.id_rank
WHERE elo.nome LIKE "ouro";

-- 2. Escreva uma consulta SQL para imprimir o mapas com modo TDM --

SELECT mapa.nome, partidas.modo FROM Mapa INNER JOIN partidas ON mapa.ID_mapa = partidas.ID_partidas
WHERE partidas.modo LIKE "TDM";

-- 3. Escreva uma consulta para imprimir os players que possuem skin de raridade lendaria -- 

SELECT player.nickname, skin.nome, skin.raridade FROM player INNER JOIN skin ON player.ID_player = skin.ID_skin
WHERE skin.raridade LIKE "lendario";

-- 4. Escreva uma consulta SQL para imprimir os mapas com modo  Casual -- 

SELECT mapa.nome, partidas.modo FROM mapa INNER JOIN partidas ON mapa.ID_mapa = partidas.ID_partidas 
WHERE partidas.modo LIKE "Casual";

-- 5. Escreva uma consulta SQL para imprimir os players com elo prata --

SELECT player.nome, elo.nome FROM Player INNER JOIN elo ON player.ID_player = elo.id_rank
WHERE elo.nome LIKE "prata";


-- consultas com order by -- 


-- 1. Escreva uma consulta SQL para imprimir todos os detalhes de player da tabela player por nome ascendente. -- 

 SELECT * FROM player ORDER BY nome ASC;

 -- 2. Escreva uma consulta SQL para imprimir todos os detalhes do players da tabela player ordenados por nickname ascendente e nome descendente na mesma query. --

 SELECT * FROM player
 ORDER BY nickname ASC, nome DESC;
 
-- 3. Escreva uma consulta SQL para mostrar os 10 players com maior nivel da tabela player -- 

SELECT * FROM player ORDER BY nivel DESC LIMIT 10;

-- 4. Escreva uma consulta SQL para imprimir todos os detalhes de player da tabela player por nome decrescente. -- 

 SELECT * FROM player ORDER BY nome DESC;

-- 5. Escreav uma consulta SQL para os 10 palyers com menor nivel da tabela player -- 

SELECT*FROM player ORDER BY nivel ASC LIMIT 10;

 
 -- consultas com group by -- 


-- 1. Escreva uma consulta SQL para buscar o número de players para cada nivel em ordem decrescente. -- 

select nivel, COUNT(ID_player)  AS QUANTIDADE FROM player
GROUP BY nivel ORDER BY QUANTIDADE DESC;

-- 2. Escreva uma consulta SQL para buscar os niveis que têm mais de 2 pessoas. --

SELECT nivel, COUNT(ID_player) AS 'numero de players' 
FROM player
GROUP BY nivel HAVING COUNT(ID_player) > 2;

-- 3. Escreva uma consulta SQL para o número de players para cada nivel em ordem crescente. --
 
 select nivel, COUNT(ID_player)  AS QUANTIDADE FROM player
GROUP BY nivel ORDER BY QUANTIDADE ASC;

-- 4. Escreva uma consulta SQL para imprimir a quantidade de skins sazonais e nao sazonais -- 

 select sazonal, COUNT(ID_skin)  AS QUANTIDADE FROM skin
GROUP BY sazonal ORDER BY QUANTIDADE ASC;


-- 5. escreva uma consulta SQL para imprimir as skins sazonais e suas respectivas raridades-- 

SELECT nome, raridade FROM skin WHERE sazonal = 'TRUE'
GROUP BY nome ;

-- Trazer 3 consultas com join e order by -- 

-- 1 escreva uma consulta SQL para mostrar os mapas, os modos jogados em cada mapa e o numero de rounds --

SELECT nome, modo, num_rounds FROM mapa 
INNER JOIN partidas ON mapa.ID_mapa = partidas.id_partidas
ORDER BY num_rounds DESC, mapa.nome ASC;

-- 2. escreva uma consulta SQL para mostrar os players, os ranks de cada player e o nivel de rank de cada player -- 

SELECT nickname, elo.nome, nivel_rank FROM player
INNER JOIN elo ON player.ID_player = elo.ID_rank 
ORDER BY nivel_rank ASC, player.nome;

-- 3. escreva uma consulta SQL para imprimir os players, seus respectivos K.Ds e seus ranks --

SELECT 	player, K_D, elo.nome FROM stats
INNER JOIN elo ON stats.ID_K_D = elo.ID_rank 
ORDER BY K_D DESC, elo.nome;

-- trazer 7 consultas com funcoes matematicas -- 

-- 1. escreva uma consulta SQL para imprimir a média de credibilidade de todos os jogadores -- 

SELECT ROUND(AVG(credibilidade)) FROM player ;

-- 2. escreva uma consulta SQL para imprimir a média de niveis dentre todos os players -- 

SELECT ROUND(AVG(nivel))FROM player ;

-- 3. escreva uma consulta SQL para mostrar o player com nivel mais baixo --

SELECT MIN(nivel) FROM player;

-- 4. escreva uma consulta SQL para mostrar a menor quantidade de credibilidade dentre todos os players -- 

SELECT MIN(credibilidade) FROM player;

-- 5. escreva uma consulta SQL para mostrar a média de player dentre todos os lobbys -- 

SELECT ROUND(AVG(num_players)) FROM lobby;

-- 6. escreva uma consulta SQL para imprimir a soma do nivel de todos os players -- 

SELECT SUM(nivel) FROM player;

-- 7. escreva uma consulta SQL para soma da credibilidade de todos os player --

SELECT SUM(credibilidade) FROM player;

-- criar 5 visoes -- 

-- 1. criar uma visao com a coluna raridade onde mostram apenas skins epicas da tabela skin -- 

CREATE VIEW rarity_skin
AS SELECT raridade, nome
FROM skin 
WHERE raridade LIKE 'epico';

-- 2. criar uma visao onde mostram apenas os servidores brasileiros -- 

CREATE VIEW lobby_br
AS SELECT  servidor, num_players
FROM lobby
WHERE servidor LIKE 'BR';

-- 3. Criar uma visao onde sao listados apenas os mapas na rotacao do competitivo -- 

CREATE VIEW mapa_comp
AS SELECT nome 
FROM mapa
WHERE rotation_comp LIKE 'TRUE';

-- 4. criar uma visao onde sao listados apenas os jogadores iniciantes -- 

CREATE VIEW player_newb
AS SELECT nome, nickname
FROM player 
WHERE iniciante LIKE 'verdadeiro';

-- 5. criar uma visao onde sao listadas apenas partidas do modo TDM -- 

CREATE  VIEW game_tdm 
AS SELECT * FROM partidas 
WHERE modo LIKE 'TDM';

-- criar 5 savepoints -- 
 
 START TRANSACTION;
 
 SAVEPOINT savepoint1;
 INSERT INTO lobby VALUES(16,'APAC',7);
 
 SAVEPOINT savepoint2;
 INSERT INTO lobby VALUES(17,'APAC',9);
 
 SAVEPOINT savepoint3;
 INSERT INTO lobby VALUES(18,'BR',5);
 
 SAVEPOINT savepoint4;
 INSERT INTO lobby VALUES(19,'EU',9);
 
 SAVEPOINT savepoint5;
 INSERT INTO lobby VALUES(20,'APAC',3);


-- Criar 3 usuarios disntintos -- 

-- 1. criar um usuario que só podera ter acesso as views -- 

CREATE USER 'cara das views'@'localhost';
GRANT ALL ON rarity_skin.*  TO 'cara das views'@'localhost';
GRANT ALL ON lobby_br.*  TO 'cara das views'@'localhost';
GRANT ALL ON mapa_comp.*  TO 'cara das views'@'localhost';
GRANT ALL ON player_newb.*  TO 'cara das views'@'localhost';
GRANT ALL ON game_tdm.*  TO 'cara das views'@'localhost';

-- 2. criar um usuario que só podera inserir -- 

CREATE USER 'cara do insert'@'localhost';
GRANT INSERT ON rarity_skin.*  TO  'cara do insert'@'localhost';
GRANT INSERT ON lobby_br.*  TO  'cara do insert'@'localhost';
GRANT INSERT ON mapa_comp.*  TO  'cara do insert'@'localhost';
GRANT INSERT ON player_newb.*  TO  'cara do insert'@'localhost';
GRANT INSERT ON game_tdm.*  TO  'cara do insert'@'localhost';

-- 3. criar um usuario que só podera ver sem nenhum outro privilegio --

CREATE USER 'cara do select'@'localhost';
GRANT SELECT ON rarity_skin.*  TO  'cara do select'@'localhost';
GRANT SELECT ON lobby_br.*  TO  'cara do select'@'localhost';
GRANT SELECT ON mapa_comp.*  TO  'cara do select'@'localhost';
GRANT SELECT ON player_newb.*  TO  'cara do select'@'localhost';
GRANT SELECT ON game_tdm.*  TO  'cara do select'@'localhost';

