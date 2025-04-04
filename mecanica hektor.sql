-- Criação do banco de dados
CREATE DATABASE mecanica_hektor;
USE mecanica_hektor;

-- Tabela Clientes
CREATE TABLE Clientes (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(11) UNIQUE,
    CNPJ VARCHAR(14) UNIQUE,
    Endereco VARCHAR(255),
    Telefone VARCHAR(11),
    Email VARCHAR(100)
);

-- Tabela Veículos
CREATE TABLE Veiculos (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Modelo VARCHAR(50),
    Marca VARCHAR(50),
    Cor VARCHAR(20),
    Ano INT,
    Placa VARCHAR(10) UNIQUE,
    Tipo VARCHAR(30),
    Id_Cliente INT,
    FOREIGN KEY (Id_Cliente) REFERENCES Clientes(ID)
);

-- Tabela Empregados
CREATE TABLE Empregados (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100),
    CPF VARCHAR(11) UNIQUE,
    Profissao VARCHAR(50),
    Endereco VARCHAR(255),
    Telefone VARCHAR(20),
    Email VARCHAR(100)
);

-- Tabela Fornecedores
CREATE TABLE Fornecedores (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    CNPJ VARCHAR(14) UNIQUE,
    Endereco VARCHAR(255),
    Telefone VARCHAR(20),
    Email VARCHAR(100)
);

-- Tabela Estoque
CREATE TABLE Estoque (
    Id_Pecas INT PRIMARY KEY AUTO_INCREMENT,
    Preco_Revenda DECIMAL(10,2),
    Preco_Compra DECIMAL(10,2),
    Quantidade INT,
    Id_Fornecedor INT,
    FOREIGN KEY (Id_Fornecedor) REFERENCES Fornecedores(ID)
);

-- Tabela Serviços Oferecidos
CREATE TABLE Servicos_Oferecidos (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Tipo_Servico VARCHAR(100),
    Preco DECIMAL(10,2),
    Duracao INT,
    Descricao TEXT
);

-- Tabela Ordem de Serviço
CREATE TABLE Ordem_de_Servico (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Status VARCHAR(50),
    Data_Inicio DATE,
    Data_Conclusao DATE,
    Preco DECIMAL(10,2),
    Data_Pagamento DATE,
    Id_Veiculo INT,
    Id_Cliente INT,
    Id_Empregado INT,
    FOREIGN KEY (Id_Veiculo) REFERENCES Veiculos(ID),
    FOREIGN KEY (Id_Cliente) REFERENCES Clientes(ID),
    FOREIGN KEY (Id_Empregado) REFERENCES Empregados(ID)
);

-- Recuperação Simples
SELECT * FROM Clientes;

-- Filtros com WHERE
SELECT * FROM Ordem_de_Servico WHERE Status = 'Concluída';

-- Atributos Derivados
SELECT ID, Preco_Revenda - Preco_Compra AS Lucro FROM Estoque;

-- Ordenação
SELECT * FROM Veiculos ORDER BY Ano DESC;

-- Filtrando grupos com HAVING
SELECT Id_Cliente, COUNT(*) AS Total_Ordens 
FROM Ordem_de_Servico 
GROUP BY Id_Cliente 
HAVING COUNT(*) > 5;

-- Junções entre tabelas
SELECT OS.ID, C.Nome, V.Modelo, E.Nome AS Mecanico, OS.Status
FROM Ordem_de_Servico OS
JOIN Clientes C ON OS.Id_Cliente = C.ID
JOIN Veiculos V ON OS.Id_Veiculo = V.ID
JOIN Empregados E ON OS.Id_Empregado = E.ID;


