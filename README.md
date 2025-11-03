# Desafio de Projeto: Modelagem de Banco de Dados para Oficina Mecânica

Este projeto é a implementação completa do esquema lógico para o contexto de uma oficina mecânica, partindo da definição do modelo conceitual (ER) e aplicando todas as melhores práticas de modelagem relacional.

## Modelo Lógico Aplicado

O esquema foi projetado para gerenciar clientes, veículos, ordens de serviço (OS), peças, serviços e mecânicos.

### Entidades Chave:

* **CLIENTE** e **VEICULO**: Um cliente pode ter vários veículos (1:N).
* **MECANICO**: Profissionais da oficina com suas especialidades e código de registro.
* **PECA** e **SERVICO**: Tabelas de cadastro de itens de consumo e mão de obra, respectivamente.
* **ORDEM_SERVICO (OS)**: Entidade central que registra o trabalho, vinculada a um veículo.
* **Relações N:M**:
    * `OS_SERVICO`: Vincula quais serviços foram realizados em cada OS.
    * `OS_PECA`: Registra o consumo de peças na OS, com a respectiva quantidade.
    * `OS_MECANICO`: Aloca múltiplos mecânicos a uma OS e registra suas horas trabalhadas.

## Estrutura do Repositório

* `schema_creation.sql`: Script SQL para a criação de todas as tabelas e constraints.
* `data_persistence.sql`: Script SQL contendo os comandos `INSERT` para popular o banco de dados.
* `complex_queries.sql`: Script SQL contendo as consultas complexas com `SELECT`, `WHERE`, `HAVING` e `JOIN`.
