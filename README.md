# Biblioteca

Alunos:
- José Jefferson Dantas Araújo
- Marcos Paulo Santos Lira

## Modelo Lógico 

Cliente(**CPF**, Nome, Endereco, Email, Telefone)

Categoria(**ID_Categoria**, Nome, Descricao, Num_Estante)

Livro(**ISBN**, Titulo, Autor, Editora, Ano_Publicacao, _ID_Categoria_)
- ID_Categoria referencia Categoria

Bibliotecario(**ID_Bibliotecario**, Nome, Endereco, Email, Telefone)

Emprestimo(**ID_Emprestimo**, Num_Dias, Data_Saida, Data_Entrada, Data_Reserva, Valor_Multa, _ID_Cliente_, _ID_Bibliotecario_)
- ID_Cliente referencia Cliente\
- ID_Bibliotecario referencia Bibliotecario

Livro_Emprestimo(_ID_Emprestimo_, _ID_Livro_)
- ID_Emprestimo referencia Emprestimo\
- ID_Livro referencia Livro
