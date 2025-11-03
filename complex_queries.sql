
-- -----------------------------------------------------
-- Query 1: Custo total de OS em Reparo com Atributo Derivado e HAVING
-- Qual o total de custo (mão de obra + peças) das OS "Em Reparo"? (HAVING + Expressão Derivada)
-- Qual é o custo total (Peças + Mão de Obra) de todas as Ordens de Serviço que ainda estão "Em Reparo", e qual o custo médio de mão de obra por hora alocada?
-- -----------------------------------------------------
SELECT
    OS.NumeroOS,
    OS.DataEmissao,
    -- Expressão para gerar atributo derivado: CustoTotalPecas
    SUM(OP.Quantidade * P.ValorUnitario) AS Custo_Total_Pecas,
    -- Expressão para gerar atributo derivado: CustoTotalMaoObra
    SUM(S.ValorMaoObra) AS Custo_Total_MaoObra,
    -- Expressão para gerar atributo derivado: TotalGeral
    (SUM(OP.Quantidade * P.ValorUnitario) + SUM(S.ValorMaoObra)) AS Custo_Geral_OS,
    -- Expressão para gerar atributo derivado: CustoMedioMaoObraPorHora
    (SUM(S.ValorMaoObra) / SUM(OM.HorasTrabalhadas)) AS Custo_Medio_Hora_Mecanico
FROM 
    ORDEM_SERVICO OS
INNER JOIN 
    OS_PECA OP ON OS.idOS = OP.idOS
INNER JOIN 
    PECA P ON OP.idRefPeca = P.idRefPeca
INNER JOIN 
    OS_SERVICO OSV ON OS.idOS = OSV.idOS
INNER JOIN 
    SERVICO S ON OSV.idServico = S.idServico
INNER JOIN
    OS_MECANICO OM ON OS.idOS = OM.idOS
WHERE 
    OS.Status = 'Em Reparo' -- Filtro com WHERE Statement
GROUP BY 
    OS.idOS, OS.NumeroOS, OS.DataEmissao
HAVING 
    Custo_Total_MaoObra > 100.00 -- Condição de filtros aos grupos – HAVING Statement
ORDER BY 
    Custo_Geral_OS DESC; -- Defina ordenações dos dados com ORDER BY

-- -----------------------------------------------------
-- Quais mecânicos trabalharam mais de 3 horas em OS de Veículos Chevrolet? (Junções Múltiplas + Filtros)
-- Quais mecânicos com especialidade em "Motor" ou "Elétrica" foram alocados em Ordens de Serviço de veículos da marca 'Chevrolet' e trabalharam mais de 3 horas?
-- Query 2: Mecânicos de Veículos Chevrolet com horas trabalhadas altas
-- -----------------------------------------------------
SELECT
    M.Nome AS Nome_Mecanico,
    M.Especialidade,
    V.Marca AS Marca_Veiculo,
    OS.NumeroOS,
    OM.HorasTrabalhadas -- Recuperação simples com SELECT Statement
FROM 
    MECANICO M
INNER JOIN 
    OS_MECANICO OM ON M.idMecanico = OM.idMecanico -- Crie junções entre tabelas
INNER JOIN 
    ORDEM_SERVICO OS ON OM.idOS = OS.idOS
INNER JOIN 
    VEICULO V ON OS.idVeiculo = V.idVeiculo
WHERE 
    V.Marca = 'Chevrolet' -- Filtro com WHERE Statement
    AND OM.HorasTrabalhadas > 3.0 -- Filtro com WHERE Statement
    AND M.Especialidade IN ('Motor e Câmbio', 'Elétrica e Eletrônica')
ORDER BY 
    OM.HorasTrabalhadas DESC;

-- -----------------------------------------------------
-- 4.3. Relação de Pagamentos, OS, Veículo e Cliente. (SELECT Simples + Junção)
-- Liste todos os pagamentos realizados, mostrando o nome do cliente, a placa do veículo, o número da OS e a forma de pagamento, ordenado pela data do pagamento.
-- Query 3: Detalhes Completos de Pagamentos
-- -----------------------------------------------------
SELECT
    C.Nome AS Nome_Cliente,
    V.Placa AS Placa_Veiculo,
    OS.NumeroOS,
    P.DataPagamento,
    P.TipoPagamento,
    P.ValorPago -- Recuperação simples com SELECT Statement
FROM 
    PAGAMENTO P
INNER JOIN 
    ORDEM_SERVICO OS ON P.idOS = OS.idOS
INNER JOIN 
    VEICULO V ON OS.idVeiculo = V.idVeiculo
INNER JOIN 
    CLIENTE C ON V.idCliente = C.idCliente
ORDER BY 
    P.DataPagamento DESC; -- Defina ordenações dos dados com ORDER BY
