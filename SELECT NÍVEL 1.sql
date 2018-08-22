USE MinhaCaixa
GO
SELECT ClienteNome AS Nome, ClienteSobrenome, ClienteNumero, ClienteBairro FROM Clientes
WHERE ClienteNumero >= 100 AND ClienteNumero <= 300 AND ClienteBairro = 'BOM RETIRO'
ORDER BY ClienteNome

GO

SELECT TOP 10 ClienteNome, ClienteSobrenome FROM Clientes ORDER BY ClienteNome

GO

SELECT Clientes.ClienteNome, Contas.ContaNumero, Movimentos.MovimentoValor FROM Clientes, Contas, Movimentos
WHERE Clientes.ClienteCodigo=Contas.ClienteCodigo AND Contas.ContaNumero=Movimentos.ContaNumero

GO

SELECT DISTINCT ClienteBairro FROM Clientes
WHERE ClienteBairro LIKE 'P%'

GO
SELECT DISTINCT ClienteBairro FROM Clientes
WHERE ClienteBairro LIKE '%RO'

GO

SELECT DISTINCT ClienteBairro FROM Clientes
WHERE ClienteBairro LIKE '%AV%'

GO 

SELECT ClienteNome,

ClienteSexo,

CASE WHEN ClienteSexo = 'M' THEN 'Masculino'
	WHEN ClienteSexo = 'F' AND ClienteBairro = 'BOM RETIRO' THEN 'Feminino'
	ELSE 'NÃO INFORMADO' END AS 'Sexo'

FROM Clientes 

GO

SELECT Clientes.ClienteNome, Clientes.ClienteNumero FROM Clientes
WHERE Clientes.ClienteNumero >= 100 AND ClienteNumero <= 300

GO

SELECT Clientes.ClienteNome, Clientes.ClienteNumero FROM Clientes
WHERE Clientes.ClienteNumero BETWEEN 100 AND 300

GO

SELECT * FROM Clientes WHERE ClienteNome IN ('JESSIE', 'XAVIER')

GO

SELECT ClienteNome FROM Clientes
WHERE ClienteCodigo IN (
SELECT Clientes.ClienteCodigo FROM Clientes
	WHERE ClienteNome = 'Jessie' OR ClienteNome = 'Xavier'
)
GO

