-- Soma do valor total arrecadado pelas multas
SELECT SUM(valor_multa) AS soma_multas FROM emprestimo;

-- Quantos dias em média os clientes solicitam ficar com os livros
SELECT AVG(num_dias) AS media_dias FROM emprestimo;

-- Quantidade máxima de dias que alguém ficou com algum livro
SELECT
	MAX(DATEDIFF(data_entrada, data_saida)) AS maximo_dias
FROM emprestimo;

-- Livro mais antigo (título e ano)
SELECT titulo, ano_publicacao
FROM livro
WHERE ano_publicacao = (SELECT MIN(ano_publicacao) FROM livro);

-- Livros que pertencem às categorias de literatura (título, autor, editora e ano de publicação)
SELECT titulo, autor, editora, ano_publicacao
FROM livro
WHERE id_categoria IN (
	SELECT id_categoria FROM categoria WHERE nome LIKE 'Literatura%'
);

-- Livros que nunca foram requisitados (título, autor, editora e ano de publicação)
SELECT titulo, autor, editora, ano_publicacao
FROM livro
WHERE (
	(SELECT count(id_livro) FROM livro_emprestimo WHERE isbn = id_livro) = 0
);

-- Os 10 livros mais requisitados da biblioteca, do mais requisitado para o menos requisitado (título e quantidade de vezes que foi emprestado)
SELECT
	titulo,
    count(id_livro) AS quantidade_emprestimos
FROM livro_emprestimo, livro
WHERE livro_emprestimo.id_livro = livro.isbn
GROUP BY id_livro
ORDER BY count(id_livro) DESC
LIMIT 10;

-- Clientes que não devolveram os livros e estão com atraso (nome, endereço, telefone e e-mail)
-- Também inclui quantidade de dias atrasado, data de saída e número de dias solicitado
-- Observação: simulando que o dia de hoje é 19/02/2025
SELECT
	nome,
    endereco,
    telefone,
    email,
    data_saida,
    num_dias,
    DATEDIFF('2025-02-19', data_saida) - num_dias AS dias_atrasado
FROM emprestimo, cliente
WHERE emprestimo.id_cliente = cliente.cpf
AND data_entrada IS NULL
AND DATEDIFF('2025-02-19', data_saida) - num_dias > 0;

-- Clientes que reservaram livros há mais de uma semana, mas que não vieram buscar (nome, endereço, telefone e e-mail)
-- Também inclui data da reserva e dias desde a reserva
SELECT
	nome,
    endereco,
    telefone,
    email,
    data_reserva,
    DATEDIFF('2025-02-19', data_reserva) AS dias_desde_a_reserva
FROM emprestimo, cliente
WHERE emprestimo.id_cliente = cliente.cpf
AND data_saida IS NULL
AND DATEDIFF('2025-02-19', data_reserva) > 7;

-- Livros que Rafael Santos pegou (título, autor e editora)
SELECT titulo, autor, editora
FROM livro, livro_emprestimo, emprestimo, cliente
WHERE livro_emprestimo.id_livro = livro.isbn
AND livro_emprestimo.id_emprestimo = emprestimo.id_emprestimo
AND emprestimo.id_cliente = cliente.cpf
AND cliente.nome = 'Rafael Santos';

-- Títulos dos livros que estão com os clientes no momento, e nome de quem pegou emprestado
SELECT titulo, nome
FROM emprestimo, livro_emprestimo, livro, cliente
WHERE emprestimo.id_cliente = cliente.cpf
AND livro_emprestimo.id_livro = livro.isbn
AND livro_emprestimo.id_emprestimo = emprestimo.id_emprestimo
AND data_entrada IS NULL
AND data_reserva IS NULL;

-- Livros reservados (título, data de reserva, nome do cliente)
SELECT titulo, data_reserva, nome
FROM emprestimo, livro_emprestimo, livro, cliente
WHERE emprestimo.id_cliente = cliente.cpf
AND livro_emprestimo.id_livro = livro.isbn
AND livro_emprestimo.id_emprestimo = emprestimo.id_emprestimo
AND data_reserva IS NOT NULL
AND data_saida IS NULL;
