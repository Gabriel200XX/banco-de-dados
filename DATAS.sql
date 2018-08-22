USE MinhaCaixa;

SELECT ClienteCodigo
	,ClienteNome
	,ClienteNascimento
	,DAY(ClienteNascimento) AS Dia
	,MONTH(ClienteNascimento) AS Mes
	,YEAR(ClienteNascimento) AS Ano
	,GETDATE() AS DataAtual
	,YEAR(GETDATE()) AS AnoAtual
	,YEAR(GETDATE()) - YEAR(ClienteNascimento) AS Idade
	,DATENAME(MONTH,(GETDATE()))
FROM Clientes WHERE ClienteCodigo = 1;

SET DATEFORMAT YDM

SET LANGUAGE PORTUGUESE

SELECT YEAR(getdate()) -YEAR( Clientes.ClienteNascimento),
  DATEDIFF(YEAR,ClienteNascimento,GETDATE()),
  DATEPART(yy,ClienteNascimento),
  dateadd(yy,1,ClienteNascimento),
  EOMONTH(GETDATE()),
  DATENAME(MONTH,(GETDATE()))
FROM Clientes;