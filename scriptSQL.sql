-- Script Banco de Dados - Projeto Pi

/*
Grupo 9
Andre Nogueira Pissuto 03261021
Bruna Marcelino 03261058
Giulia Teixeira 03261036
Matheus da Silva 03261013
Matheus Muniz 03261030
Nicolas Ferro 03261041
Rodrigo Suguiura 03261044
*/

CREATE DATABASE Hydracoffe;
USE Hydracoffe;

-- TABELA CLIENTE

CREATE TABLE Cliente(
	Id INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    Endereco VARCHAR(100) NOT NULL,
    CPF CHAR(14) NOT NULL UNIQUE,
    Email VARCHAR(50) NOT NULL UNIQUE,
    Telefone VARCHAR(15) UNIQUE,
    CONSTRAINT CHK_Email CHECK (Email LIKE '%@%')
);

INSERT INTO Cliente (Nome, Endereco, CPF, Email, Telefone) VALUES
('João Silva', 'Fazenda Boa Vista, Patrocínio, MG', '123.456.789-00', 'joao.silva@email.com', '31999990001'),
('Maria Oliveira', 'Sítio Recanto Verde, Varginha, MG', '987.654.321-00', 'maria.oliveira@gmail.com', '31988880002'),
('Carlos Souza', 'Fazenda São José, Poços de Caldas, MG', '111.222.333-44', 'carlos.souza@hotmail.com', '35977770003'),
('Ana Pereira', 'Sítio Café Bom, Franca, SP', '555.666.777-88', 'ana.pereira@yahoo.com', '16966660004'),
('Rafael Costa', 'Fazenda Espírito Santo, Campinas, SP', '999.888.777-66', 'rafael.costa@outlook.com', '19955550005'),
('Beatriz Lima', 'Sítio Primavera, Campos do Jordão, SP', '222.333.444-55', 'beatriz.lima@gmail.com', '12944440006'),
('Lucas Fernandes', 'Fazenda Alta Vista, Manhuaçu, MG', '333.444.555-66', 'lucas.fernandes@email.com', '32933330007');

SELECT * FROM Cliente;

SELECT 
CONCAT('Cliente ', Nome, ' localizado em ', Endereco, ' - ',
    CASE
	WHEN Endereco LIKE '%MG%' THEN 'Região de alto potencial de café'
	WHEN Endereco LIKE '%SP%' THEN 'Plantação em São Paulo'
	WHEN Endereco LIKE '%ES%' THEN 'Plantação no Espírito Santo'
	ELSE 'Outra região'
    END
) AS Status_cliente
FROM Cliente;

-- TABELA EMPRESA


CREATE TABLE Empresa(
	Id INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Empresa VARCHAR(50) NOT NULL UNIQUE,
    CNPJ char(18) NOT NULL UNIQUE,
    Produtividade INT NOT NULL, /*Produtividade é correspondente a quantidade de sacas*/
    Area_Plantacao INT NOT NULL
);

INSERT INTO Empresa (Nome_Empresa, CNPJ, Produtividade, Area_Plantacao) VALUES
('Fazenda Boa Safra', '12.345.678/0001-01', 320, 45),
('Sítio Café Verde', '23.456.789/0001-12', 410, 30),
('Fazenda Montanha do Café', '34.567.890/0001-23', 580, 55),
('Fazenda Vale do Grão', '45.678.901/0001-34', 360, 40),
('Sítio Aroma do Café', '56.789.012/0001-45', 305, 25),
('Fazenda Alto Horizonte', '67.890.123/0001-56', 490, 60),
('Fazenda Terra Fértil', '78.901.234/0001-67', 520, 35),
('Sítio Café da Serra', '89.012.345/0001-78', 445, 28);

SELECT * FROM Empresa;

SELECT Empresa, Produtividade, CASE
	WHEN Produtividade >= 500 THEN 'Alta produtividade'
	WHEN Produtividade BETWEEN 400 AND 499 THEN 'Produtividade média'
	ELSE 'Baixa produtividade'
    END AS Classificacao
FROM Empresa;

SELECT CONCAT('A Empresa ', Nome_Empresa, ' possui ', Area_Plantacao, 
    ' hectares e produtividade de ', Produtividade, ' sacas.') AS Descricao
FROM Empresa;

SELECT Nome_Empresa, 
	CONCAT('Área: ', Area_Plantacao, ' hectares') AS Tamanho_Area,
    CASE
	WHEN Area_Plantacao >= 50 THEN 'Lavoura grande'
	WHEN Area_Plantacao BETWEEN 30 AND 49 THEN 'Lavoura média'
	ELSE 'Lavoura pequena'
    END AS Classificacao_Area
FROM Empresa;

SELECT Nome_Empresa, Area_Plantacao,
    CASE
	WHEN Area_Plantacao >= 50 THEN 'Grande'
    WHEN Area_Plantacao BETWEEN 35 AND 49 THEN 'Média'
	ELSE 'Pequena'
    END AS Tamanho_Empresa
FROM Empresa;

DESCRIBE Empresa;


-- TABELA SENSORES

CREATE TABLE Sensores(
	Id INT PRIMARY KEY AUTO_INCREMENT,
    Umidade_Detectada INT,
    Setor VARCHAR(50) NOT NULL
    );

ALTER TABLE Sensores RENAME COLUMN Setor TO Hectare;

DESCRIBE Sensores;

INSERT INTO Sensores (Umidade_Detectada, Hectare) VALUES
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

SELECT * FROM Sensores;

SELECT CONCAT('Coordenada [', Hectare, ']') AS Localizacao,
Umidade_Detectada FROM Sensores;

SELECT CONCAT('Setor ', Hectare, ' - Umidade: ', Umidade_Detectada, '% - ') as 'Umidade detectada',
    CASE
	WHEN Umidade_Detectada < 40 THEN 'Necessita irrigação'
	WHEN Umidade_Detectada BETWEEN 40 AND 55 THEN 'Umidade adequada'
	ELSE 'Solo muito úmido'
    END AS Status_Sensor
FROM Sensores;
