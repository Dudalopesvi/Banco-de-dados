INSERT INTO clientes (cliente_id, nome, email, telefone, cpf, data_cadastro) VALUES
(1, 'Ana Souza', 'ana@email.com', '4899999-1111', '111.111.111-11', DEFAULT),
(2, 'Carlos Lima', 'carlos@email.com', '4899999-2222', '222.222.222-22', DEFAULT),
(3, 'Mariana Alves', 'mariana@email.com', '4899999-3333', '333.333.333-33', DEFAULT);

INSERT INTO enderecos (cliente_id, rua, numero, bairro, cidade, estado, cep) VALUES
(1, 'Rua das Flores', '100', 'Centro', 'Florianópolis', 'SC','50000000'),
(2, 'Av Brasil', '250', 'Trindade', 'Florianópolis', 'SC', '48010000'),
(3, 'Rua Comércio', '45', 'Campinas', 'São José', 'SC', '88100000');

INSERT INTO categorias_pratos (categoria_prato_id, nome, descricao) VALUES
(1, 'Prato Principal', 'salgados'),
(2, 'Bebidas', 'refrescos e refrigerantes'), 
(3, 'Sobremesas', 'doces e sobremesas');

INSERT INTO pratos (prato_id, categoria_prato_id, nome, descricao, preco, estoque, ativo) VALUES
(1, 1, 'Hambúrguer Artesanal', 'Blend 150g, queijo e maionese da casa', 35.00, 100, TRUE),
(2, 1, 'Batata Frita Especial', 'Batata com cheddar e bacon', 18.00, 50, TRUE),
(3, 2, 'Suco Natural de Laranja', 'Copo de 400ml 100% fruta', 9.00, 200, TRUE),
(4, 2, 'Refrigerante em Lata', 'Lata de 350ml', 6.00, 150, TRUE),
(5, 3, 'Pudim de Leite Moça', 'Fatia de pudim com calda de caramelo', 12.00, 30, TRUE);

INSERT INTO pedidos (pedido_id,cliente_id, data_pedido,categoria_prato_id,status,endereco_id, valor_total) VALUES
(1, 1, CURRENT_TIMESTAMP,1, 'Recebido',1, 53.00),     
(2, 2, CURRENT_TIMESTAMP,3,'Em Preparo',2, 15.00),   
(3, 3, CURRENT_TIMESTAMP,2, 'Finalizado',3, 12.00);   

INSERT INTO itens_pedido (cliente_id,pedido_id,produto_id,quantidade,categoria_prato_id, preco_unitário, subtotal) VALUES
(1,1,2,1, 1, 36.00, 35.00), 
(2,2,3,2, 1, 18.00, 18.00), 
(3,3,1,2, 2, 9.00, 9.00);


INSERT INTO pagamentos (pedido_id,forma_pagamento,status_pagamento,valor_pago) VALUES
(1, 'Pix', 'Aguardando', 53.00 ),
(2, 'Cartão de Crédito', 'Pago', 15.00),
(3, 'Dinheiro', 'Pago', 12.00);

INSERT INTO entregas (pedido_id, transportadora, codigo_rastreio, status_entrega, data_envio, data_entrega) VALUES
(1, NULL, NULL, 'Aguardando na Cozinha', NULL, NULL),
(2, 'Motoboy Próprio', 'Rota-Centro', 'Embalando', NULL, NULL),
(3, 'IFood Entrega', 'Pedido #987', 'Entregue', CURRENT_TIMESTAMP, NULL);

INSERT INTO avaliacoes (avaliacoes, cliente_id, pedidos_id, nota, comentário, data_avaliacao) VALUES
(1, 1, 1, 5, 'Ótimo produto', DEFAULT),
(2, 2, 2, 4, 'Muito bom', DEFAULT),
(3, 3, 3, 5, 'Excelente', DEFAULT);