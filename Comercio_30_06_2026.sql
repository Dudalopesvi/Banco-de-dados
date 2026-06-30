-- ==========================================
-- 1. CRIAÇÃO DAS TABELAS
-- ==========================================

CREATE TABLE clientes (
    id_cliente INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome_cliente VARCHAR(100) NOT NULL,
    email VARCHAR(100)
);

CREATE TABLE pedidos (
    id_pedido INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_cliente INT NOT NULL,
    data_pedido DATE NOT NULL,
    valor_pedido NUMERIC(10,2) NOT NULL,

    CONSTRAINT fk_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
);

-- ==========================================
-- 2. INSERÇÃO DOS DADOS
-- ==========================================

INSERT INTO clientes (nome_cliente, email) VALUES
('Ana Souza', 'ana@email.com'),
('Bruno Silva', 'bruno@email.com'),
('Carlos Oliveira', 'carlos@email.com'),
('Daniela Costa', 'daniela@email.com'),
('Eduardo Santos', 'eduardo@email.com');

INSERT INTO pedidos (id_cliente, data_pedido, valor_pedido) VALUES
(1, '2025-01-10', 450.00),
(1, '2025-01-25', 1200.00),
(2, '2025-02-05', 800.00),
(2, '2025-02-18', 1500.00),
(3, '2025-03-12', 300.00),
(3, '2025-03-20', 600.00),
(4, '2025-04-08', 2500.00),
(5, '2025-04-15', 700.00),
(5, '2025-05-10', 1300.00);

-- ==========================================
-- 3. VIEW DE VENDAS POR MÊS
-- ==========================================

CREATE VIEW v_vendas_por_mes AS
SELECT
    EXTRACT(YEAR FROM data_pedido) AS ano,
    EXTRACT(MONTH FROM data_pedido) AS mes,
    SUM(valor_pedido) AS total_vendas
FROM pedidos
GROUP BY
    EXTRACT(YEAR FROM data_pedido),
    EXTRACT(MONTH FROM data_pedido);

-- consultar a view

select * from v_vendas_por_mes order by ano,mes;


--consulta utilizando IN 

select nome_cliente from clientes
where id_cliente IN (
select id_cliente from pedidos
where valor_pedido > 1000
);

-- 4 consulta utilizando exists
select * from clientes c where EXISTS (
select 1 from pedidos p where p.id_cliente = c.id_cliente and p.valor_pedido >700
);

-- 5 analisando consulta aeu indice

EXPLAIN 
select * from clientes c where EXISTS (
select 1 from pedidos p where p.id_cliente = c.id_cliente and p.valor_pedido >700
);

-- 6 criando do indice.
create index idx_pedidos_clientes on pedidos (id_cliente);

--verificar se o indice existe.
select * from pg_indexes where tablename = 'pedidos';

-- 7 analisando consulta com indice
EXPLAIN
select * from clientes c where EXISTS (
select 1 from pedidos p where p.id_cliente = c.id_cliente and p.valor_pedido >600

);


