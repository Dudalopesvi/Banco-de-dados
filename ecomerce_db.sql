create table clientes(
id int primary key,
nome varchar (120) not null,
email varchar (120) unique not null,
telefone varchar (20),
cpf varchar(14) unique not null,
data_cadastro timestamp default current_timestamp

);


create table enderecos(
id int primary key,
cliente_id int not null,
rua varchar (120) unique not null,
numero varchar (80) not null,
bairro varchar(80) ,
cidade varchar(80) ,
estado varchar(2) ,
cep varchar(10) ,
foreign key (cliente_id) references clientes(id)
);

create table categorias(
id int primary key,
nome varchar(80) not null,
descricao text
);

create table produtos(
id int primary key,
categoria_id int not null,
nome varchar(120) not null,
descricao text,
preco numeric(10,2) not null,
estoque int not null default 0,
ativo boolean default true,
foreign key (categoria_id) references categorias(id)
);

create table pedidos(
id int primary key,
cliente_id int not null,
endereco_id int not null,
data_pedido timestamp default current_timestamp,
status varchar(30) default 'Pendente',
valor_total numeric(10,2) default 0,
foreign key (cliente_id) references clientes(id),
foreign key (endereco_id) references enderecos(id)
);

create table itens_pedido(
id int primary key,
pedido_id int not null,
produto_id int not null,
quantidade int not null,
preco_unitário numeric(10,2) not null,
subtotal numeric(10,2)not null,
foreign key (pedido_id) references pedidos(id),
foreign key (produto_id) references produtos(id)
);


create table pagamentos(
id int primary key,
pedido_id int not null,
forma_pagamento varchar(40) not null,
status_pagamento varchar(30) default 'aguardando',
valor_pago numeric(10,2) not null,
foreign key (pedido_id) references pedidos(id)
);


create table pagamentos(
id int primary key,
pedido_id int not null,
forma_pagamento varchar(40) not null,
status_pagamento varchar(30) default 'aguardando',
valor_pago numeric(10,2) not null,
data_pagamento timestamp,
foreign key (pedido_id) references pedidos(id)
);


create table entregas(
id int primary key,
pedido_id int not  null,
transportadora varchar(80),
codigo_rastreio varchar(80),
status_entrega varchar(30) default 'Preparando',
data_envio timestamp,
data_entrega timestamp,
foreign key (pedido_id) references pedidos(id)
);

create table avaliacoes(
id int primary key,
cliente_id int not null,
produto_id int not null,
nota int check (nota between 1 and 5),
comentário text,
data_avaliacao timestamp default current_timestamp,
foreign key (cliente_id) references clientes(id),
foreign key (produto_id) references produtos(id)
);

