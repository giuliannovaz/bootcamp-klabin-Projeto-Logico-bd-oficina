USE oficina;

-- Inserção de Clientes
INSERT INTO CLIENTE (idCliente, Nome, CPF, Endereco, Telefone) VALUES
(1, 'Alice Pereira', '11122233344', 'Rua das Flores, 123', '98888-1111'),
(2, 'Bruno Santos', '55566677788', 'Av. Central, 456', '97777-2222'),
(3, 'Carla Lima', '99900011122', 'Estrada Velha, 789', '96666-3333');

-- Inserção de Veículos
INSERT INTO VEICULO (idVeiculo, Placa, Marca, Modelo, Ano, idCliente) VALUES
(1, 'ABC1234', 'Chevrolet', 'Onix', 2020, 1),
(2, 'XYZ5678', 'Ford', 'Ka', 2018, 2),
(3, 'DEF9012', 'Fiat', 'Toro', 2022, 3),
(4, 'GHI3456', 'Chevrolet', 'Corsa', 1999, 1); -- Cliente Alice tem 2 carros

-- Inserção de Mecânicos
INSERT INTO MECANICO (idMecanico, Nome, Especialidade, Endereco, Codigo) VALUES
(1, 'Daniel Rocha', 'Motor e Câmbio', 'Rua dos Mecânicos, 10', 'MEC001'),
(2, 'Eduarda Silva', 'Elétrica e Eletrônica', 'Av. das Ferramentas, 20', 'MEC002'),
(3, 'Felipe Souza', 'Suspensão e Freios', 'Travessa do Óleo, 30', 'MEC003');

-- Inserção de Peças
INSERT INTO PECA (idRefPeca, Descricao, ValorUnitario, QuantidadeEstoque) VALUES
(1, 'Filtro de Óleo Original', 35.00, 50),
(2, 'Pastilha de Freio Dianteira', 120.00, 25),
(3, 'Vela de Ignição Iridium', 45.00, 100),
(4, 'Óleo Motor 5W30', 40.00, 200);

-- Inserção de Serviços
INSERT INTO SERVICO (idServico, NomeServico, ValorMaoObra, Descricao) VALUES
(1, 'Troca de Óleo e Filtro', 50.00, 'Serviço padrão de troca'),
(2, 'Revisão de Freios', 150.00, 'Verificação e troca de pastilhas/lonas'),
(3, 'Diagnóstico Elétrico', 80.00, 'Verificação de falhas elétricas'),
(4, 'Reparo Geral Motor', 500.00, 'Serviço complexo de motor');

-- Inserção de Ordens de Serviço (OS)
INSERT INTO ORDEM_SERVICO (idOS, NumeroOS, DataEmissao, DataConclusao, Status, ValorTotal, idVeiculo) VALUES
(1, 2025001, '2025-10-01', '2025-10-02', 'Concluído', 0.00, 1), -- Alice, Onix
(2, 2025002, '2025-10-05', NULL, 'Em Reparo', 0.00, 2), -- Bruno, Ka
(3, 2025003, '2025-10-10', '2025-10-10', 'Concluído', 0.00, 3), -- Carla, Toro
(4, 2025004, '2025-10-15', NULL, 'Aguardando', 0.00, 4); -- Alice, Corsa

-- Inserção de OS_SERVICO
INSERT INTO OS_SERVICO (idOS, idServico) VALUES
(1, 1), -- OS 1: Troca de Óleo
(2, 2), -- OS 2: Revisão de Freios
(2, 3), -- OS 2: Diagnóstico Elétrico
(3, 1), -- OS 3: Troca de Óleo
(4, 4); -- OS 4: Reparo Geral Motor

-- Inserção de OS_PECA
INSERT INTO OS_PECA (idOS, idRefPeca, Quantidade) VALUES
(1, 1, 1), -- OS 1: Filtro de Óleo
(1, 4, 4), -- OS 1: 4L Óleo
(2, 2, 1), -- OS 2: Pastilha de Freio
(3, 1, 1), -- OS 3: Filtro de Óleo
(3, 4, 5); -- OS 3: 5L Óleo

-- Inserção de OS_MECANICO
INSERT INTO OS_MECANICO (idOS, idMecanico, DataAtribuicao, HorasTrabalhadas) VALUES
(1, 1, '2025-10-01', 1.5), -- Daniel na OS 1
(2, 2, '2025-10-05', 4.0), -- Eduarda na OS 2
(3, 3, '2025-10-10', 2.0), -- Felipe na OS 3
(2, 1, '2025-10-06', 2.0); -- Daniel também ajudou na OS 2

-- Inserção de PAGAMENTO (Valores totais fictícios para teste)
INSERT INTO PAGAMENTO (idPagamento, idOS, TipoPagamento, ValorPago, DataPagamento) VALUES
(1, 1, 'Pix', 205.00, '2025-10-02'),
(2, 3, 'Cartão Crédito', 285.00, '2025-10-10');
