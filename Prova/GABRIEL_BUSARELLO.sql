/*
Nome: Gabriel Dezan Busarello
Matr�cula: 1111007801
*/

USE MinhaCaixa;

--1) Boa Noite Dornel, preciso de um relat�rio de quantidade de clientes por bairro para a nova campanha de capata��o de clientes do banco. 
--Vamos precisar trabalhar no bairros onde temos mais clientes para aumentar ainda mais. A id�ia � come�ar com 5 bairros.
SELECT TOP(5) ClienteBairro, COUNT(ClienteCodigo) AS TotalClientes
	FROM Clientes GROUP BY ClienteBairro ORDER BY TotalClientes DESC;

GO
--2) Boa Noite Dornel, preciso de um relat�rio de quantidade de clientes por sexo para a nova campanha de capata��o de clientes do banco, por�m
--eu vi no sistema que eles est�o como M ou F, tem como trazer Masculino e Feminino?
SELECT CASE WHEN ClienteSexo = 'M'
		THEN 'Masculino'
		ELSE 'Feminino' END AS SexoCliente, COUNT(ClienteCodigo) AS TotalClientes
	FROM Clientes GROUP BY ClienteSexo ORDER BY TotalClientes DESC;

GO
--3) Boa Noite Dornel, preciso tamb�m de um relat�rio de quantidade de clientes por estado civil, trazendo a descri��o tamb�m?
SELECT CASE WHEN ClienteEstadoCivil = 'S'
		THEN 'Solteiro'
		ELSE 'Casado' END AS EstadoCivilCliente, COUNT(ClienteCodigo) AS TotalClientes
	FROM Clientes GROUP BY ClienteEstadoCivil ORDER BY TotalClientes DESC;

GO
--4) Boa noite Dornel, precisamos de uma lista do valor sacado por agencia de todas as agencias para enviar ao banco central. 
--As agencias em que n�o tenham movimenta��o de saque dever�o vir com o valor zerado.
SELECT Agencias.AgenciaNome
		, CASE WHEN SUM(Movimentos.MovimentoValor) IS NULL THEN 0 ELSE SUM(Movimentos.MovimentoValor) END AS Total
	FROM Agencias
	LEFT JOIN Contas ON Contas.AgenciaCodigo = Agencias.AgenciaCodigo
	LEFT JOIN Movimentos ON Movimentos.ContaNumero = Contas.ContaNumero
	WHERE Movimentos.MovimentoTipo = -1
	GROUP BY Agencias.AgenciaNome, Movimentos.MovimentoTipo
	ORDER BY Total DESC;

GO
--5) Boa noite Dornel, precisamos do nome do cliente a idade e sua data de nascimento e o e-mail para enviarmos o vale brinde de anivers�rio
SELECT ClienteNome, YEAR(GETDATE()) - YEAR(ClienteNascimento) AS Idade, ClienteNascimento, ClienteEmail
	FROM Clientes;

GO
--6) Boa noite Dornel, precisamos de uma lista do valor m�dio sacado por m�s para enviar ao banco central. Considere todos os anos.
SELECT AVG(MovimentoValor) AS ValorMedio, MONTH(MovimentoData) AS Mes FROM Movimentos
	WHERE MovimentoTipo = -1
	GROUP BY MONTH(MovimentoData) ORDER BY Mes;
