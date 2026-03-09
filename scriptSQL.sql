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
('Beatriz Lima', 'Fazenda Boa Colheita, Vitória da Conquista, BA', '222.333.444-55', 'beatriz.lima@gmail.com', '77944440006'),
('Lucas Fernandes', 'Sítio Montanhas do Café, Venda Nova do Imigrante, ES', '333.444.555-66', 'lucas.fernandes@email.com', '28933330007');

SELECT * FROM Cliente;

SELECT 
	CONCAT('Cliente ', Nome, ' localizado em ', Endereco, ' - ',
    CASE
	WHEN Endereco LIKE '%MG%' THEN 'Plantação em Minas Gerais'
	WHEN Endereco LIKE '%SP%' THEN 'Plantação em São Paulo'
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
('Fazenda Boa Vista', '12.345.678/0001-01', 320, 45),
('Sítio Recanto Verde', '23.456.789/0001-12', 410, 30),
('Fazenda São José', '34.567.890/0001-23', 580, 55),
('Sítio Café Bom', '45.678.901/0001-34', 360, 40),
('Fazenda Espírito Santo', '56.789.012/0001-45', 305, 25),
('Fazenda Boa Colheita', '67.890.123/0001-56', 490, 60),
('Sítio Montanhas do Café', '78.901.234/0001-67', 520, 35);

SELECT * FROM Empresa;

SELECT Nome_Empresa, Produtividade, 
	CASE
	WHEN Produtividade >= 500 THEN 'Alta produtividade'
	WHEN Produtividade BETWEEN 400 AND 499 THEN 'Média produtividade'
	ELSE 'Baixa produtividade'
    END AS Classificacao
FROM Empresa;

SELECT 
	CONCAT('A Empresa ', Nome_Empresa, ' possui ', Area_Plantacao, 
    ' hectares e produtividade de ', Produtividade, ' sacas.') AS Descricao
FROM Empresa;

SELECT Nome_Empresa, 
	CONCAT('Área: ', Area_Plantacao, ' hectares') AS Tamanho_Area,
    CASE
	WHEN Area_Plantacao >= 50 THEN 'Plantação grande'
	WHEN Area_Plantacao BETWEEN 30 AND 49 THEN 'Plantação média'
	ELSE 'Plantação pequena'
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
(97, 'A1'),
(95, 'A2'),
(97, 'A3'),
(99, 'A4'),
(41, 'B1'),
(44, 'B2'),
(50, 'B3'),
(52, 'B4'),
(49, 'C1'),
(36, 'C2'),
(38, 'C3'),
(40, 'C4'),
(65, 'D1'),
(63, 'D2'),
(67, 'D3'),
(46, 'D4'),
(78, 'E1'),
(74, 'E2'),
(73, 'E3'),
(72, 'E4');

SELECT * FROM Sensores;

SELECT 
	CONCAT('Coordenada [', Hectare, ']') AS Localizacao, Umidade_Detectada 
FROM Sensores;

SELECT 
	CONCAT('Setor ', Hectare, ' - Umidade: ', Umidade_Detectada, '% - ') as 'Umidade detectada',
    CASE
	WHEN Umidade_Detectada < 54 THEN 'Necessita irrigação'
	WHEN Umidade_Detectada BETWEEN 55 AND 80 THEN 'Umidade adequada'
	ELSE 'Solo muito úmido'
    END AS Status_Sensor
FROM Sensores;



