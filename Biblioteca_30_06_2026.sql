-- ==========================================
-- 1. CRIAÇÃO DAS TABELAS
-- ==========================================
CREATE TABLE leitores (
    id_leitor INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome_leitor VARCHAR(100) NOT NULL,
    email VARCHAR(100)
);

CREATE TABLE emprestimos (
    id_emprestimo INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_leitor INT NOT NULL,
    data_emprestimo DATE NOT NULL,
    valor_multa NUMERIC(10,2) NOT NULL DEFAULT 0,
    CONSTRAINT fk_leitor
        FOREIGN KEY (id_leitor)
        REFERENCES leitores(id_leitor)
);

-- ==========================================
-- 2. INSERÇÃO DOS DADOS
-- ==========================================
INSERT INTO leitores (nome_leitor, email) VALUES
('Ana Souza', 'ana@email.com'),
('Bruno Silva', 'bruno@email.com'),
('Carlos Oliveira', 'carlos@email.com'),
('Daniela Costa', 'daniela@email.com'),
('Eduardo Santos', 'eduardo@email.com');

INSERT INTO emprestimos (id_leitor, data_emprestimo, valor_multa) VALUES
(1, '2025-01-10', 4.50),
(1, '2025-01-25', 12.00),
(2, '2025-02-05', 8.00),
(2, '2025-02-18', 15.00),
(3, '2025-03-12', 3.00),
(3, '2025-03-20', 6.00),
(4, '2025-04-08', 25.00),
(5, '2025-04-15', 7.00),
(5, '2025-05-10', 13.00);

-- ==========================================
-- 3. VIEW DE EMPRÉSTIMOS POR MÊS
-- ==========================================
CREATE VIEW v_emprestimos_por_mes AS
SELECT
    EXTRACT(YEAR FROM data_emprestimo) AS ano,
    EXTRACT(MONTH FROM data_emprestimo) AS mes,
    SUM(valor_multa) AS total_multas
FROM emprestimos
GROUP BY
    EXTRACT(YEAR FROM data_emprestimo),
    EXTRACT(MONTH FROM data_emprestimo);

-- consultar a view
SELECT * FROM v_emprestimos_por_mes ORDER BY ano, mes;

-- consulta utilizando IN
SELECT nome_leitor FROM leitores
WHERE id_leitor IN (
    SELECT id_leitor FROM emprestimos
    WHERE valor_multa > 10
);

-- 4. consulta utilizando EXISTS
SELECT * FROM leitores l WHERE EXISTS (
    SELECT 1 FROM emprestimos e WHERE e.id_leitor = l.id_leitor AND e.valor_multa > 7
);

-- 5. analisando consulta sem índice
EXPLAIN
SELECT * FROM leitores l WHERE EXISTS (
    SELECT 1 FROM emprestimos e WHERE e.id_leitor = l.id_leitor AND e.valor_multa > 7
);

-- 6. criando o índice
CREATE INDEX idx_emprestimos_leitor ON emprestimos (id_leitor);

-- verificar se o índice existe
SELECT * FROM pg_indexes WHERE tablename = 'emprestimos';

-- 7. analisando consulta com índice
EXPLAIN
SELECT * FROM leitores l WHERE EXISTS (
    SELECT 1 FROM emprestimos e WHERE e.id_leitor = l.id_leitor AND e.valor_multa > 6
);



