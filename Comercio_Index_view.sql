create index id_pedidos_cliente
on pedidos(id_cliente);

Explain select * from clientes c
where exists(
select 1
from pedidos p
where p.id_cliente = c.id_cliente
and p.valor_pedido > 2000
);