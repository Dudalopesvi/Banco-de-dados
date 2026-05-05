select produtos.nome, categorias.nome AS categoria, produtos.preco
from produtos 
join categorias
on produtos.categoria_id = categorias.id;

select pedidos.id, clientes.nome, pedidos.valor_total
from pedidos 
join clientes
on pedidos.cliente_id = clientes.id;


select pedidos.id, produtos.nome, itens_pedido.quantidade, itens_pedido.subtotal
from itens_pedido
join pedidos on itens_pedido.pedido_id = pedidos.id
join produtos on itens_pedido.produto_id = produtos.id;

select AVG(produtos.preco) AS media_de_preco from produtos;



select count(clientes.id) AS tqtal_clientes from clientes;



select sum(pedidos.valor_total) AS Total_vendas from pedidos;


select produtos.nome, produtos.preco from produtos order by produtos.preco desc;

select min(produtos.preco) AS menor_preco,
max(produtos.preco ) AS maior_preco from produtos;




select produtos.nome, produtos.preco from produtos where produtos.nome like '%Mouse%';



select


