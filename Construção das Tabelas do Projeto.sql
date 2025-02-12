CREATE TABLE
    cliente (
        cpf CHAR(11) NOT NULL,
        nome VARCHAR(50) NOT NULL,
        endereco VARCHAR(100) NOT NULL,
        email VARCHAR(45) NOT NULL,
        telefone VARCHAR(18) NOT NULL,
        PRIMARY KEY (cpf),
        UNIQUE (cpf),
        UNIQUE (email),
        UNIQUE (telefone)
    );

CREATE TABLE
    categoria (
        id_categoria INT NOT NULL AUTO_INCREMENT,
        nome VARCHAR(20) NOT NULL,
        descricao VARCHAR(200),
        num_estante INT,
        PRIMARY KEY (id_categoria),
        UNIQUE (id_categoria),
        UNIQUE (nome)
    );

CREATE TABLE
    livro (
        isbn VARCHAR(13) NOT NULL,
        titulo VARCHAR(45) NOT NULL,
        autor VARCHAR(45),
        editora VARCHAR(45),
        ano_publicacao INT,
        id_categoria INT,
        PRIMARY KEY (isbn),
        FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria),
        UNIQUE (isbn)
    );

CREATE TABLE
    bibliotecario (
        id_bibliotecario INT NOT NULL AUTO_INCREMENT,
        nome VARCHAR(50) NOT NULL,
        endereco VARCHAR(100) NOT NULL,
        email VARCHAR(45) NOT NULL,
        telefone VARCHAR(18) NOT NULL,
        PRIMARY KEY (id_bibliotecario),
        UNIQUE (id_bibliotecario),
        UNIQUE (email),
        UNIQUE (telefone)
    );

CREATE TABLE
    emprestimo (
        id_emprestimo INT NOT NULL AUTO_INCREMENT,
        num_dias INT NOT NULL,
        data_saida DATETIME,
        data_entrada DATETIME,
        data_reserva DATETIME,
        valor_multa DECIMAL(5, 2),
        id_cliente CHAR(11) NOT NULL,
        id_bibliotecario INT NOT NULL,
        FOREIGN KEY (id_bibliotecario) REFERENCES bibliotecario (id_bibliotecario),
        FOREIGN KEY (id_cliente) REFERENCES cliente (cpf),
        PRIMARY KEY (id_emprestimo),
        UNIQUE (id_emprestimo)
    );

CREATE TABLE
    livro_emprestimo (
        id_emprestimo INT NOT NULL,
        id_livro VARCHAR(13) NOT NULL,
        FOREIGN KEY (id_emprestimo) REFERENCES emprestimo (id_emprestimo),
        FOREIGN KEY (id_livro) REFERENCES livro (isbn)
    );



