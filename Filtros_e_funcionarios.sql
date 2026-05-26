-- ============================================================
-- PARTE 3 – CONSULTAS NO BANCO (DQL)
-- ============================================================
 
-- 1. Listar todos os pratos
SELECT
    p.prato_id,
    p.nome         AS prato,
    p.descricao,
    p.preco,
    p.estoque,
    p.ativo
FROM pratos p
ORDER BY p.prato_id;
 
 
-- 2. Mostrar pratos com suas categorias
SELECT
    p.prato_id,
    p.nome          AS prato,
    p.preco,
    c.nome          AS categoria,
    c.descricao     AS descricao_categoria
FROM pratos p
JOIN categorias_pratos c
    ON p.categoria_prato_id = c.categoria_prato_id
ORDER BY c.nome, p.nome;
 
 
-- 3. Listar todos os pedidos com nome do cliente e status
SELECT
    pd.pedido_id,
    cl.nome         AS cliente,
    pd.data_pedido,
    pd.status,
    pd.valor_total
FROM pedidos pd
JOIN clientes cl
    ON pd.cliente_id = cl.cliente_id
ORDER BY pd.pedido_id;
 
 
-- 4. Consultar clientes com seus endereços
SELECT
    cl.cliente_id,
    cl.nome,
    cl.email,
    cl.telefone,
    CONCAT(en.rua, ', ', en.numero, ' — ', en.bairro, ', ', en.cidade, '/', en.estado) AS endereco_completo
FROM clientes cl
LEFT JOIN enderecos en
    ON cl.cliente_id = en.cliente_id
ORDER BY cl.nome;
 
 
-- 5. Filtrar pratos com preço acima de R$ 15,00
SELECT
    p.nome  AS prato,
    p.preco,
    c.nome  AS categoria
FROM pratos p
JOIN categorias_pratos c
    ON p.categoria_prato_id = c.categoria_prato_id
WHERE p.preco > 15.00
ORDER BY p.preco DESC;
 
 
-- 5b. Filtrar pratos com preço abaixo de R$ 10,00
SELECT
    p.nome  AS prato,
    p.preco,
    c.nome  AS categoria
FROM pratos p
JOIN categorias_pratos c
    ON p.categoria_prato_id = c.categoria_prato_id
WHERE p.preco < 10.00
ORDER BY p.preco;
 
 
-- ============================================================
-- PARTE 4 – ALTERAÇÕES NA ESTRUTURA E NOS DADOS
-- ============================================================
 
-- ── UPDATE: atualizar informações ───────────────────────────
 
-- Atualiza tempo de preparo dos pratos
UPDATE pratos SET tempo_preparo_min = 15 WHERE prato_id = 1;
UPDATE pratos SET tempo_preparo_min = 10 WHERE prato_id = 2;
UPDATE pratos SET tempo_preparo_min = 5  WHERE prato_id = 3;
UPDATE pratos SET tempo_preparo_min = 2  WHERE prato_id = 4;
UPDATE pratos SET tempo_preparo_min = 8  WHERE prato_id = 5;
 
-- Atualiza telefone de um cliente
UPDATE clientes
SET telefone = '4899900-0001'
WHERE cliente_id = 1;
 
-- Atualiza o status de um pedido para 'Finalizado'
UPDATE pedidos
SET status = 'Finalizado'
WHERE pedido_id = 1;
 
-- Marca pagamento como pago
UPDATE pagamentos
SET status_pagamento = 'Pago',
    comprovante       = 'TXN-PIX-20240601'
WHERE pedido_id = 1;
 
-- Inativa um prato temporariamente (estoque zerado)
UPDATE pratos
SET ativo    = FALSE,
    estoque  = 0
WHERE prato_id = 5;
 
 
-- ── DELETE: remover registros ───────────────────────────────
 
-- Remove avaliação específica (antes de remover pedido dependente)
DELETE FROM avaliacoes
WHERE avaliacoes = 3;
 
-- Remove item de pedido cancelado
DELETE FROM itens_pedido
WHERE pedido_id = 3
  AND cliente_id = 3;
 
 
-- ============================================================
-- DESAFIOS EXTRAS – TABELA FUNCIONARIOS
-- ============================================================
 
-- ── Criar a tabela funcionarios ─────────────────────────────
CREATE TABLE funcionarios (
    funcionario_id  INT          PRIMARY KEY,
    nome            VARCHAR(120) NOT NULL,
    cpf             VARCHAR(14)  UNIQUE NOT NULL,
    cargo           VARCHAR(60)  NOT NULL,
    salario         NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    data_admissao   DATE         NOT NULL DEFAULT CURRENT_DATE,
    ativo           BOOLEAN      DEFAULT TRUE
);
 
 
-- ── Cadastrar funcionários ───────────────────────────────────
INSERT INTO funcionarios (funcionario_id, nome, cpf, cargo, salario, data_admissao) VALUES
(1, 'Fernanda Costa',    '444.444.444-44', 'Gerente',          4500.00, '2022-03-15'),
(2, 'Bruno Ferreira',    '555.555.555-55', 'Cozinheiro',       2800.00, '2023-01-10'),
(3, 'Larissa Mendes',    '666.666.666-66', 'Atendente',        1800.00, '2023-06-01'),
(4, 'Rafael Oliveira',   '777.777.777-77', 'Entregador',       1600.00, '2024-02-20'),
(5, 'Isabela Santos',    '888.888.888-88', 'Cozinheira',       2900.00, '2022-11-05');
 
 
-- ── Consultas envolvendo salários ───────────────────────────
 
-- Lista todos os funcionários com salário
SELECT
    f.funcionario_id,
    f.nome,
    f.cargo,
    f.salario,
    f.data_admissao
FROM funcionarios f
ORDER BY f.salario DESC;
 
 
-- Média de salário por cargo
SELECT
    f.cargo,
    COUNT(*)                            AS total_funcionarios,
    AVG(f.salario)                      AS media_salarial,
    MIN(f.salario)                      AS menor_salario,
    MAX(f.salario)                      AS maior_salario
FROM funcionarios f
GROUP BY f.cargo
ORDER BY media_salarial DESC;
 
 
-- Funcionários com salário acima da média geral
SELECT
    f.nome,
    f.cargo,
    f.salario
FROM funcionarios f
WHERE f.salario > (
    SELECT AVG(salario) FROM funcionarios
)
ORDER BY f.salario DESC;
 
 
-- Folha de pagamento total (apenas ativos)
SELECT
    SUM(f.salario) AS folha_total
FROM funcionarios f
WHERE f.ativo = TRUE;
 
 
-- ── Adicionar novas colunas ──────────────────────────────────
ALTER TABLE funcionarios
    ADD COLUMN email        VARCHAR(120),
    ADD COLUMN telefone     VARCHAR(20),
    ADD COLUMN turno        VARCHAR(20) DEFAULT 'Integral';
 
 
-- ── Atualizar dados dos funcionários ────────────────────────
UPDATE funcionarios SET email = 'fernanda@restaurante.com', turno = 'Integral'  WHERE funcionario_id = 1;
UPDATE funcionarios SET email = 'bruno@restaurante.com',    turno = 'Integral'  WHERE funcionario_id = 2;
UPDATE funcionarios SET email = 'larissa@restaurante.com',  turno = 'Manhã'     WHERE funcionario_id = 3;
UPDATE funcionarios SET email = 'rafael@restaurante.com',   turno = 'Tarde'     WHERE funcionario_id = 4;
UPDATE funcionarios SET email = 'isabela@restaurante.com',  turno = 'Integral'  WHERE funcionario_id = 5;
 
-- Reajuste salarial de 10% para cozinheiros
UPDATE funcionarios
SET salario = salario * 1.10
WHERE cargo IN ('Cozinheiro', 'Cozinheira');
 
 
-- ── Remover registros ────────────────────────────────────────
 
-- Desativa funcionário (soft delete — preserva histórico)
UPDATE funcionarios
SET ativo = FALSE
WHERE funcionario_id = 4;
 
-- Remove funcionário que nunca chegou a trabalhar (hard delete)
DELETE FROM funcionarios
WHERE funcionario_id = 4
  AND ativo = FALSE;