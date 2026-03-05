/*
Andre Nogueira Pissuto 03261021
Bruna Marcelino 03261058
Giulia Teixeira 03261036
Matheus da Silva 03261013
Matheus Muniz 03261030
Nicolas Ferro 03261041
Rodrigo Suguiura 03261044
*/



create database hydracoffe;
use hydracoffe;

create table cliente(
	id int primary key auto_increment,
    nome varchar(50) not null,
    endereco varchar(100)  not null,
    cpf char(14) not null unique,
    email varchar(50) not null unique,
    telefone varchar(15) unique
);

create table lavoura(
	id int primary key auto_increment,
    nomelavoura varchar(50) not null unique,
    cnpj char(18) not null unique,
    produtividade decimal(5,2) not null,
    area int not null
);

create table sensores(
	id int primary key auto_increment,
    umidadeDetectada int
);