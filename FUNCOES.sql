USE MinhaCaixa;

DROP FUNCTION dbo.fnRetornaAno;
DROP FUNCTION dbo.fnRetornaIdade;

CREATE FUNCTION fnRetornaAno (@data DATETIME)
RETURNS int
AS
  BEGIN
  DECLARE @ano int
  SET @ano = YEAR(@data)

      RETURN @ano

END

CREATE FUNCTION fnRetornaIdade (@data DATETIME)
RETURNS int
AS
BEGIN
	DECLARE @idade int
	SET @idade = YEAR(GETDATE()) - YEAR(@data);
	RETURN @idade;
END

SELECT dbo.fnRetornaAno(GETDATE()) AS ANO

SELECT dbo.fnRetornaIdade(Clientes.ClienteNascimento) AS Idade FROM dbo.Clientes