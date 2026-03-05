-- Script Banco de Dados - Projeto Pi

/*
Andre Nogueira Pissuto 03261021
Bruna Marcelino 03261058
Giulia Teixeira 03261036
Matheus da Silva 03261013
Matheus Muniz 03261030
Nicolas Ferro 03261041
Rodrigo Suguiura 03261044
*/



CREATE DATABASE hydracoffe;
USE hydracoffe;

-- TABELA CLIENTE

CREATE TABLE CLIENTE(
	ID INT PRIMARY KEY AUTO_INCREMENT,
    NOME VARCHAR(50) NOT NULL,
    ENDERECO VARCHAR(100) NOT NULL,
    CPF CHAR(14) NOT NULL UNIQUE,
    EMAIL VARCHAR(50) NOT NULL UNIQUE,
    TELEFONE VARCHAR(15) UNIQUE,
    CONSTRAINT CHK_EMAIL CHECK (EMAIL LIKE '%@%')
);

INSERT INTO CLIENTE (NOME, ENDERECO, CPF, EMAIL, TELEFONE) VALUES
('João Silva', 'Fazenda Boa Vista, Patrocínio, MG', '123.456.789-00', 'joao.silva@email.com', '31999990001'),
('Maria Oliveira', 'Sítio Recanto Verde, Varginha, MG', '987.654.321-00', 'maria.oliveira@gmail.com', '31988880002'),
('Carlos Souza', 'Fazenda São José, Poços de Caldas, MG', '111.222.333-44', 'carlos.souza@hotmail.com', '35977770003'),
('Ana Pereira', 'Sítio Café Bom, Franca, SP', '555.666.777-88', 'ana.pereira@yahoo.com', '16966660004'),
('Rafael Costa', 'Fazenda Espírito Santo, Campinas, SP', '999.888.777-66', 'rafael.costa@outlook.com', '19955550005'),
('Beatriz Lima', 'Sítio Primavera, Campos do Jordão, SP', '222.333.444-55', 'beatriz.lima@gmail.com', '12944440006'),
('Lucas Fernandes', 'Fazenda Alta Vista, Manhuaçu, MG', '333.444.555-66', 'lucas.fernandes@email.com', '32933330007');

SELECT * FROM cliente;

SELECT 
CONCAT('Cliente ', NOME, ' localizado em ', ENDERECO, ' - ',
    CASE
	WHEN ENDERECO LIKE '%MG%' THEN 'Região de alto potencial de café'
	WHEN ENDERECO LIKE '%SP%' THEN 'Plantação em São Paulo'
	WHEN ENDERECO LIKE '%ES%' THEN 'Plantação no Espírito Santo'
	ELSE 'Outra região'
    END
) AS status_cliente
FROM CLIENTE;

-- TABELA LAVOURA


CREATE TABLE lavoura(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nomelavoura VARCHAR(50) NOT NULL UNIQUE,
    cnpj char(18) NOT NULL UNIQUE,
    produtividade DECIMAL(5,2) NOT NULL,
    area INT NOT NULL
);

INSERT INTO lavoura (nomelavoura, cnpj, produtividade, area) VALUES
('Fazenda Boa Safra', '12.345.678/0001-01', 320.50, 45),
('Sítio Café Verde', '23.456.789/0001-12', 410.70, 30),
('Fazenda Montanha do Café', '34.567.890/0001-23', 580.10, 55),
('Fazenda Vale do Grão', '45.678.901/0001-34', 360.40, 40),
('Sítio Aroma do Café', '56.789.012/0001-45', 305.90, 25),
('Fazenda Alto Horizonte', '67.890.123/0001-56', 490.22, 60),
('Fazenda Terra Fértil', '78.901.234/0001-67', 520.41, 35),
('Sítio Café da Serra', '89.012.345/0001-78', 445.55, 28);

SELECT * FROM lavoura;

SELECT nomelavoura, produtividade, CASE
	WHEN produtividade >= 500 THEN 'Alta produtividade'
	WHEN produtividade BETWEEN 400 AND 499.99 THEN 'Produtividade média'
	ELSE 'Baixa produtividade'
    END AS classificacao
FROM lavoura;

SELECT CONCAT('A lavoura ', nomelavoura, ' possui ', area, 
    ' hectares e produtividade de ', produtividade, ' sacas.') AS descricao
FROM lavoura;

SELECT nomelavoura, 
	CONCAT('Área: ', area, ' hectares') AS tamanho_area,
    CASE
	WHEN area >= 50 THEN 'Lavoura grande'
	WHEN area BETWEEN 30 AND 49 THEN 'Lavoura média'
	ELSE 'Lavoura pequena'
    END AS classificacao_area
FROM lavoura;

SELECT nomelavoura, area,
    CASE
	WHEN area >= 50 THEN 'Grande'
    WHEN area BETWEEN 35 AND 49 THEN 'Média'
	ELSE 'Pequena'
    END AS tamanho_lavoura
FROM lavoura;

DESCRIBE lavoura;


-- TABELA SENSORES

CREATE TABLE sensores(
	id INT PRIMARY KEY AUTO_INCREMENT,
    umidadeDetectada INT,
    setor VARCHAR(50) NOT NULL
    );

ALTER TABLE sensores RENAME COLUMN setor TO hectare;

DESCRIBE sensores;

INSERT INTO sensores (umidadeDetectada, hectare) VALUES
(42, 'A1'),
(45, 'A2'),
(47, 'A3'),
(39, 'A4'),
(41, 'B1'),
(44, 'B2'),
(50, 'B3'),
(52, 'B4'),
(49, 'C1'),
(36, 'C2'),
(38, 'C3'),
(40, 'C4'),
(55, 'D1'),
(53, 'D2'),
(57, 'D3'),
(46, 'D4'),
(48, 'E1'),
(44, 'E2'),
(60, 'E3'),
(58, 'E4');

SELECT * FROM sensores;

SELECT CONCAT('Coordenada [', hectare, ']') AS localizacao,
umidadeDetectada FROM sensores;

SELECT CONCAT('Setor ', hectare, ' - Umidade: ', umidadeDetectada, '% - ') as 'umidade detectada',
    CASE
	WHEN umidadeDetectada < 40 THEN 'Necessita irrigação'
	WHEN umidadeDetectada BETWEEN 40 AND 55 THEN 'Umidade adequada'
	ELSE 'Solo muito úmido'
    END AS status_sensor
FROM sensores;

