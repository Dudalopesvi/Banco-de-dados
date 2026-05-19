create table clientes(
cliente_id int primary key,
nome varchar (120) not null,
email varchar (120) unique not null,
telefone varchar (20),
cpf varchar(14) unique not null,
data_cadastro date
);

CREATE TABLE enderecos (
    cliente_id INT PRIMARY KEY,
    rua VARCHAR(120) NOT NULL,
    numero VARCHAR(20),
    bairro VARCHAR(80),
    cidade VARCHAR(80),
    estado CHAR(2),
    cep VARCHAR(10),
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

create table categorias_pratos(
categoria_prato_id int primary key,
nome varchar(80) not null,
descricao text
);

create table pratos(
prato_id int primary key,
nome varchar(120) not null,
descricao text,
preco numeric(10,2) not null,
categoria_prato_id int not null,
estoque int not null default 0,
ativo boolean default true,
foreign key (categoria_prato_id) references categorias_pratos(categoria_prato_id)
);

create table pedidos(
cliente_id int primary key,
data_pedido timestamp default current_timestamp,
endereco_id int not null,
categoria_prato_id int not null,
pedido_id int not null,
status varchar(30) default 'Pendente',
valor_total numeric(10,2) default 0,
foreign key (cliente_id) references clientes(cliente_id),
foreign key (endereco_id) references enderecos(cliente_id),
foreign key (categoria_prato_id) references categorias_pratos(categoria_prato_id)
);

create table itens_pedido(
cliente_id int primary key,
pedido_id int not null,
produto_id int not null,
quantidade int not null,
categoria_prato_id int not null,
preco_unitário numeric(10,2) not null,
subtotal numeric(10,2)not null,
foreign key (pedido_id) references pedidos(cliente_id),
foreign key (categoria_prato_id) references categorias_pratos(categoria_prato_id)
);


create table pagamentos(
pedido_id int primary key,
forma_pagamento varchar(40) not null,
status_pagamento varchar(30) default 'aguardando',
valor_pago numeric(10,2) not null,
foreign key (pedido_id) references pedidos(cliente_id)
);

create table mesas(
mesa_id int primary key,
cliente_id int not  null,
categoria_prato_id int not null,
codigo_rastreio varchar(80),
status_entrega varchar(30) default 'Preparando',
data_envio timestamp,
data_entrega timestamp,
foreign key (cliente_id) references clientes(cliente_id),
foreign key (categoria_prato_id) references categorias_pratos(categoria_prato_id)
);

create table entregas(
pedido_id int primary key,
transportadora varchar(80),
codigo_rastreio varchar(80),
status_entrega varchar(30) default 'Preparando',
data_envio timestamp,
data_entrega timestamp,
foreign key (pedido_id) references pedidos(cliente_id)
);

create table avaliacoes(
avaliacoes int primary key,
cliente_id int not null,
pedidos_id int not null,
nota int check (nota between 1 and 5),
comentário text,
data_avaliacao timestamp default current_timestamp,
foreign key (cliente_id) references clientes(cliente_id),
foreign key (pedidos_id) references pedidos(cliente_id)
);