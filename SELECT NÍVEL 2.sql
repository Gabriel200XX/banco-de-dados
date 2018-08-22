USE MinhaCaixa
GO
SELECT Clientes.ClienteNome, CartaoCredito.CartaoCodigoSeguranca FROM Clientes, CartaoCredito
WHERE Clientes.ClienteCodigo=CartaoCredito.ClienteCodigo
GO
SELECT Clientes.ClienteNome, CartaoCredito.CartaoCodigoSeguranca FROM Clientes
INNER JOIN CartaoCredito ON CartaoCredito.ClienteCodigo=Clientes.ClienteCodigo
GO
SELECT Clientes.ClienteNome, CartaoCredito.CartaoCodigoSeguranca FROM Clientes
LEFT JOIN CartaoCredito ON CartaoCredito.ClienteCodigo=Clientes.ClienteCodigo
GO
SELECT Grupo.GrupoNome, Filial.FilialNome, Agencias.AgenciaNome, Contas.ContaNumero FROM Grupo
INNER JOIN Filial ON Filial.GrupoCodigo=Grupo.GrupoCodigo
INNER JOIN Agencias ON (Agencias.FilialCodigo = Filial.FilialCodigo AND Agencias.GrupoCodigo=Grupo.GrupoCodigo)
LEFT JOIN Contas ON Contas.AgenciaCodigo=Agencias.AgenciaCodigo
GO
SELECT TOP(5) TipoMovimento.TipoMovimentoDescricao, Clientes.ClienteBairro, SUM(Movimentos.MovimentoValor) AS TOTAL FROM Movimentos
INNER JOIN TipoMovimento ON TipoMovimento.TipoMovimentoCodigo = Movimentos.MovimentoTipo
INNER JOIN Contas ON Contas.ContaNumero = Movimentos.ContaNumero
INNER JOIN Clientes ON Clientes.ClienteCodigo = Contas.ClienteCodigo
WHERE Movimentos.MovimentoTipo = 1
GROUP BY TipoMovimento.TipoMovimentoDescricao, Clientes.ClienteBairro
ORDER BY TOTAL DESC
GO
SELECT COUNT(*) FROM Clientes
GO
SELECT COUNT(ClienteCodigo) AS QtdCliente, ClienteBairro FROM Clientes
GROUP BY ClienteBairro ORDER BY ClienteBairro
GO
SELECT AVG(MovimentoValor) AS media, MAX(MovimentoValor) AS maximo, MIN(MovimentoValor) AS minimo FROM
Movimentos
/*SELECT MIN(MovimentoValor) FROM
Movimentos
SELECT MAX(MovimentoValor) FROM
Movimentos*/
GO
SELECT * FROM CartaoCredito AS CC
WHERE EXISTS(SELECT * FROM Contas AS CT WHERE CC.AgenciaCodigo = CT.AgenciaCodigo AND CC.ClienteCodigo = CT.ClienteCodigo)

SELECT Agencias.AgenciaBairro, SUM(Movimentos.MovimentoValor) AS TOTAL FROM Movimentos
INNER JOIN Contas ON Contas.ContaNumero = Movimentos.ContaNumero
INNER JOIN Agencias ON Agencias.AgenciaCodigo = Contas.AgenciaCodigo
GROUP BY AgenciaBairro
HAVING SUM(Movimentos.MovimentoValor) > (

SELECT AVG(Movimentos.MovimentoValor) AS MEDIA FROM Movimentos
INNER JOIN Contas ON Contas.ContaNumero = Movimentos.ContaNumero
INNER JOIN Agencias ON Agencias.AgenciaCodigo = Contas.AgenciaCodigo)

CREATE TABLE Notas
(
	NOME VARCHAR(10),
	MATERIA VARCHAR(3),
	NOTA FLOAT
)

GO

CREATE TABLE Faltas
(
	NOME VARCHAR(10),
	BIMESTRE VARCHAR(3),
	FALTA int
)

GO

INSERT Notas (NOME, MATERIA, NOTA)
VALUES 
('GABRIEL', 'BDA', 10),
('DORNEL', 'BDA', 5),
('RODRIGO', 'BDA', 10),
('LUIZA', 'BDA', 6),
('ELIBOSTEL', 'BDA', 2)

GO

INSERT Faltas(NOME, BIMESTRE, FALTA)
VALUES 
('GABRIEL', '1BI', 2),
('GABRIEL', '2BI', 1),
('DORNEL', '1BI', 1),
('DORNEL', '2BI', 2),
('LUIZA', '1BI', 2),
('LUIZA', '2BI', 1)

GO

SELECT NOME, NOTA, SUM(NOTA) FROM Notas WHERE MATERIA = 'BDA'
AND NOTA > (SELECT AVG(NOTA) FROM Notas WHERE MATERIA = 'BDA')

SELECT NOME, SUM(FALTA) AS TOTAL_FALTAS FROM Faltas GROUP BY NOME
HAVING SUM(FALTA) > (SELECT AVG(FALTA) FROM Faltas);