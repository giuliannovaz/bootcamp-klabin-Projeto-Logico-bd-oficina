-- Criação do Esquema (Database)
CREATE SCHEMA IF NOT EXISTS oficina;
USE oficina;

-- -----------------------------------------------------
-- Tabela CLIENTE
-- -----------------------------------------------------
CREATE TABLE CLIENTE (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    CPF CHAR(11) NOT NULL UNIQUE,
    Endereco VARCHAR(255),
    Telefone VARCHAR(15)
);

-- -----------------------------------------------------
-- Tabela VEICULO
-- -----------------------------------------------------
CREATE TABLE VEICULO (
    idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    Placa CHAR(7) NOT NULL UNIQUE,
    Marca VARCHAR(45) NOT NULL,
    Modelo VARCHAR(45),
    Ano INT,
    idCliente INT NOT NULL,
    CONSTRAINT fk_veiculo_cliente FOREIGN KEY (idCliente) REFERENCES CLIENTE (idCliente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- -----------------------------------------------------
-- Tabela MECANICO
-- -----------------------------------------------------
CREATE TABLE MECANICO (
    idMecanico INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Especialidade VARCHAR(100),
    Endereco VARCHAR(255),
    Codigo VARCHAR(20) NOT NULL UNIQUE -- Código de registro ou matrícula
);

-- -----------------------------------------------------
-- Tabela PECA (Estoque de Peças)
-- -----------------------------------------------------
CREATE TABLE PECA (
    idRefPeca INT AUTO_INCREMENT PRIMARY KEY,
    Descricao VARCHAR(255) NOT NULL UNIQUE,
    ValorUnitario DECIMAL(10, 2) NOT NULL,
    QuantidadeEstoque INT DEFAULT 0
);

-- -----------------------------------------------------
-- Tabela SERVICO (Tabela de preços de mão de obra)
-- -----------------------------------------------------
CREATE TABLE SERVICO (
    idServico INT AUTO_INCREMENT PRIMARY KEY,
    NomeServico VARCHAR(100) NOT NULL UNIQUE,
    ValorMaoObra DECIMAL(10, 2) NOT NULL,
    Descricao VARCHAR(255)
);

-- -----------------------------------------------------
-- Tabela ORDEM_SERVICO (Entidade Central)
-- -----------------------------------------------------
CREATE TABLE ORDEM_SERVICO (
    idOS INT AUTO_INCREMENT PRIMARY KEY,
    NumeroOS INT NOT NULL UNIQUE,
    DataEmissao DATE NOT NULL,
    DataConclusao DATE,
    Status ENUM('Aguardando', 'Em Reparo', 'Concluído', 'Cancelado') DEFAULT 'Aguardando',
    ValorTotal DECIMAL(10, 2) DEFAULT 0.00, -- Pode ser calculado via trigger ou aplicação
    idVeiculo INT NOT NULL,
    CONSTRAINT fk_os_veiculo FOREIGN KEY (idVeiculo) REFERENCES VEICULO (idVeiculo)
);

-- -----------------------------------------------------
-- Tabela OS_SERVICO (Serviços aplicados na OS)
-- -----------------------------------------------------
CREATE TABLE OS_SERVICO (
    idOS INT NOT NULL,
    idServico INT NOT NULL,
    CONSTRAINT pk_os_servico PRIMARY KEY (idOS, idServico),
    CONSTRAINT fk_os_servico_os FOREIGN KEY (idOS) REFERENCES ORDEM_SERVICO (idOS),
    CONSTRAINT fk_os_servico_servico FOREIGN KEY (idServico) REFERENCES SERVICO (idServico)
);

-- -----------------------------------------------------
-- Tabela OS_PECA (Peças usadas na OS)
-- -----------------------------------------------------
CREATE TABLE OS_PECA (
    idOS INT NOT NULL,
    idRefPeca INT NOT NULL,
    Quantidade INT NOT NULL,
    CONSTRAINT pk_os_peca PRIMARY KEY (idOS, idRefPeca),
    CONSTRAINT fk_os_peca_os FOREIGN KEY (idOS) REFERENCES ORDEM_SERVICO (idOS),
    CONSTRAINT fk_os_peca_peca FOREIGN KEY (idRefPeca) REFERENCES PECA (idRefPeca)
);

-- -----------------------------------------------------
-- Tabela OS_MECANICO (Mecânicos alocados na OS)
-- -----------------------------------------------------
CREATE TABLE OS_MECANICO (
    idOS INT NOT NULL,
    idMecanico INT NOT NULL,
    DataAtribuicao DATE,
    HorasTrabalhadas DECIMAL(5, 2) DEFAULT 0.0,
    CONSTRAINT pk_os_mecanico PRIMARY KEY (idOS, idMecanico),
    CONSTRAINT fk_os_mecanico_os FOREIGN KEY (idOS) REFERENCES ORDEM_SERVICO (idOS),
    CONSTRAINT fk_os_mecanico_mecanico FOREIGN KEY (idMecanico) REFERENCES MECANICO (idMecanico)
);

-- -----------------------------------------------------
-- Tabela PAGAMENTO (Pagamento da OS)
-- -----------------------------------------------------
CREATE TABLE PAGAMENTO (
    idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    idOS INT NOT NULL UNIQUE, -- 1:1 com OS (uma OS pode ter um pagamento)
    TipoPagamento ENUM('Cartão Crédito', 'Débito', 'Pix', 'Boleto') NOT NULL,
    ValorPago DECIMAL(10, 2) NOT NULL,
    DataPagamento DATE NOT NULL,
    CONSTRAINT fk_pagamento_os FOREIGN KEY (idOS) REFERENCES ORDEM_SERVICO (idOS)
);
