USE MinhaCaixa;
--1) Mostre quais os clientes tem idade superior a média.
--2) Mostre qual agência tem quantidade de clientes acima da média.
--3) Mostre o nome da agência o saldo total, o mínimo, o máximo e a quantidade de clientes de cada agência.
--4) Mostre o percentual que cada agencia representa no saldo total do banco.
--5) Mostre as duas cidades que tem o maior saldo total
--6) Mostre qual a agência tem o maior montante de emprestimo
--7) Mostre qual o menor valor devido, o maior e o total devido da tabela devedor
--8) Mostre o nome do cliente, se ele tem cartão de crédito, apenas do cliente que é o maior devedor.
--9) Mostre o nome do cliente, a idade, o saldo total em conta, seu total devido, seu total emprestado e se tem cartão de crédito ou não. Os valores nulos devem aparecer como 0.00. A ordenação dever ser sempre pelo maioir devedor.
--10) Utilizando a questão anterior, incluia o sexo do cliente e mostre também a diferença entre o que o ele emprestou e o que ele está devendo.
--11) Insira um novo cliente chamado Silvio Santos, crie uma conta para ele com saldo de R$ 500,00 na agência Beira Mar. Cadastre um cartão de crédito com limite de 5000,00.
--12) Altere a rua do cliente Ana para Rua da Univille.
--13) Apague todos os registros do cliente Vania.
--14) Mostre nome e sobrenome e se o cliente for homem, mostre Sr e se for mulher Sra na frente do nome.Use o MinhaCaixa_Beta para resolver essa questão.
--15) Mostre os bairros que tem mais clientes.
--16) Mostre a renda de cada cliente convertida em dólar.
--17) Mostre o nome do cliente, o número da conta, o saldo da conta, apenas para os 15 melhores clientes
--18) Mostre quais são os 5 dias com maior movimento (valor) no banco
--19) Crie uma função que receba o código do estado civil e mostre ele por extenso
--20) Crie uma função que receba o código do sexo e mostre ele por extenso
--21) Crie um procedure que receba o número da conta e cadastre um cartão de crédito com limite de R$ 500 para o cliente caso ele não tenha (MinhaCaixa).
--22) Use o script abaixo para criar uma procedure que receba a matricula, disciplina, ano e calcule o total de pontos e a média do aluno
/* 23) Use o script abaixo para criar duas procedures:
Uma procedure para cadastrar os alunos em duas matérias (BDA e PRG). Exemplo: exec procedure @matricula, @materia, @ano

(matricular 6 alunos)

Uma procedure que receba a matricula, disciplina, ano, bimestre, aulas dadas, notas e faltas. Quando a condição dentro da procedure identificar que é o quarto bimestre calcule o total de pontos, total de faltas, percentual de frequencia,a média do aluno e calcule o resultado final, A, E ou R.

Exemplo: exec procedure @matricula, @materia, @ano, 1, 32, 7, 0*/


-- Mostre o valor total depositado por agencia e por ano. Se não tiver movimento mostre zero.
SELECT Agencias.AgenciaNome, YEAR(Movimentos.MovimentoData) AS Ano,
CASE WHEN SUM(Movimentos.MovimentoValor) IS NULL THEN 0 ELSE SUM(Movimentos.MovimentoValor) END AS Total
FROM Movimentos
	INNER JOIN Contas
		ON Contas.ContaNumero = Movimentos.ContaNumero
	RIGHT JOIN Agencias
		ON Agencias.AgenciaCodigo = Contas.AgenciaCodigo
	WHERE Movimentos.MovimentoTipo = 1
GROUP BY Agencias.AgenciaNome, YEAR(Movimentos.MovimentoData)
ORDER BY Agencias.AgenciaNome, ano