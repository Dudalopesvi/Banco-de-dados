-- CRIAÇÃO DAS TABELAS

CREATE TABLE Clientes
(id_cliente INT PRIMARY KEY,
nome_cliente VARCHAR(100));

CREATE TABLE Pedidos 
(id_pedido INT PRIMARY KEY, 
id_cliente INT, 
valor_pedido DECIMAL(10,2),
data_pedido DATE,
id_produto INT,
FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente));

CREATE TABLE Produtos 
(id_produto INT PRIMARY KEY,
nome_produto VARCHAR(100), 
preco_produto DECIMAL(10,2));

CREATE TABLE Pessoas 
(id_pessoa INT PRIMARY KEY,
nome_pessoa VARCHAR(100));

CREATE TABLE Documentos 
(id_documento INT PRIMARY KEY, 
id_pessoa INT UNIQUE,
numero_documento VARCHAR(50),
FOREIGN KEY (id_pessoa) REFERENCES Pessoas(id_pessoa));

CREATE TABLE Autores 
(id_autor INT PRIMARY KEY,
nome_autor VARCHAR(100));

CREATE TABLE Livros 
(id_livro INT PRIMARY KEY,
id_autor INT, nome_livro VARCHAR(150),
FOREIGN KEY (id_autor) REFERENCES Autores(id_autor));

CREATE TABLE Alunos 
(id_aluno INT PRIMARY KEY, 
nome_aluno VARCHAR(100));

CREATE TABLE Cursos (id_curso INT PRIMARY KEY, 
nome_curso VARCHAR(100));

CREATE TABLE Matriculas 
(id_aluno INT,
id_curso INT, 
data_matricula DATE,
PRIMARY KEY (id_aluno, id_curso),
FOREIGN KEY (id_aluno) REFERENCES Alunos(id_aluno),
FOREIGN KEY (id_curso) REFERENCES Cursos(id_curso));

-- INSERÇÃO DE DADOS DE EXEMPLO

INSERT INTO Clientes VALUES
(1, 'Ana Silva'), 
(2, 'Bruno Costa'), 
(3, 'Carla Souza');

INSERT INTO Produtos VALUES (
1, 'Notebook', 3500.00),
(2, 'Mouse', 150.00), 
(3, 'Teclado', 250.00);

INSERT INTO Pedidos VALUES 
(1, 1, 3500.00, '2024-01-10', 1), 
(2, 1, 150.00, '2024-02-05', 2), 
(3, 2, 250.00, '2024-03-15', 3), 
(4, 3, 3500.00, '2024-04-20', NULL);

INSERT INTO Pessoas VALUES 
(1, 'João Pereira'),
(2, 'Maria Oliveira'), 
(3, 'Pedro Santos');

INSERT INTO Documentos VALUES 
(1, 1, '123.456.789-00'), 
(2, 2, '987.654.321-00'), 
(3, 3, '111.222.333-44');

INSERT INTO Autores VALUES 
(1, 'Machado de Assis'), 
(2, 'Clarice Lispector'), 
(3, 'Jorge Amado');

INSERT INTO Livros VALUES 
(1, 1, 'Dom Casmurro'), 
(2, 1, 'Memórias Póstumas de Brás Cubas'), 
(3, 2, 'A Hora da Estrela'), 
(4, 2, 'Perto do Coração Selvagem'), 
(5, 3, 'Gabriela, Cravo e Canela');

INSERT INTO Alunos VALUES 
(1, 'Lucas Mendes'), 
(2, 'Fernanda Lima'), 
(3, 'Rafael Torres');

INSERT INTO Cursos VALUES 
(1, 'Banco de Dados'), 
(2, 'Programação Web'), 
(3, 'Redes de Computadores');

INSERT INTO Matriculas VALUES 
(1, 1, '2024-02-01'), 
(1, 2, '2024-02-01'), 
(2, 1, '2024-03-10'), 
(3, 2, '2024-03-15'), 
(3, 3, '2024-04-01');

-- CONSULTAS (QUESTÕES 1 A 7)

-- Q1: INNER JOIN — clientes com pedidos
SELECT c.nome_cliente, p.valor_pedido FROM Clientes c INNER JOIN Pedidos p ON c.id_cliente = p.id_cliente;

-- Q2: LEFT JOIN — todos os clientes, inclusive sem pedidos
SELECT c.nome_cliente, p.valor_pedido FROM Clientes c LEFT JOIN Pedidos p ON c.id_cliente = p.id_cliente;

-- Q3: RIGHT JOIN — todos os pedidos, inclusive sem produto
SELECT p.id_pedido, p.valor_pedido, pr.nome_produto FROM Produtos pr RIGHT JOIN Pedidos p ON pr.id_produto = p.id_produto;

-- Q4: 1-1 — pessoas e documentos
SELECT pe.nome_pessoa, d.numero_documento FROM Pessoas pe INNER JOIN Documentos d ON pe.id_pessoa = d.id_pessoa;

-- Q5: 1-N — autores e seus livros
SELECT a.nome_autor, l.nome_livro FROM Autores a INNER JOIN Livros l ON a.id_autor = l.id_autor;

-- Q6: N-N — alunos e cursos matriculados
SELECT a.nome_aluno, c.nome_curso FROM Alunos a INNER JOIN Matriculas m ON a.id_aluno = m.id_aluno INNER JOIN Cursos c ON m.id_curso = c.id_curso;

-- Q7: Desafio — alunos, cursos e data de matrícula
SELECT a.nome_aluno, c.nome_curso, m.data_matricula FROM Alunos a INNER JOIN Matriculas m ON a.id_aluno = m.id_aluno INNER JOIN Cursos c ON m.id_curso = c.id_curso;