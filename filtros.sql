
select * from pedidos;

SELECT p.nome AS prato, p.preco,
       c.nome AS categoria
FROM   pratos p
JOIN   categorias_pratos c
    ON p.categoria_prato_id = c.categoria_prato_id
ORDER BY c.nome, p.nome;

ALTER TABLE clientes
    ADD COLUMN data_nascimento DATE,
    ADD COLUMN observacoes     TEXT;

-- tempo de preparo nos pratos
ALTER TABLE pratos
    ADD COLUMN tempo_preparo_min INT DEFAULT 0;

ALTER TABLE pagamentos
    ADD COLUMN comprovante VARCHAR(120);
	
UPDATE pagamentos
SET    status_pagamento = 'Pago',
       comprovante       = 'TXN-PIX-20240601'
WHERE  pedido_id = 1;