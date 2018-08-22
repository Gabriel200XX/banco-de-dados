--DECLARE @CODIGOCLIENTE INT
--SET @CODIGOCLIENTE = 1
USE MinhaCaixa;

GO

CREATE PROCEDURE procRetornaCliente
@CODIGOCLIENTE INT, @SEXO CHAR(1)
AS
IF (@SEXO = 'M' OR @SEXO = 'F')
	BEGIN
		SELECT * FROM Clientes
		WHERE ClienteCodigo = @CODIGOCLIENTE
		AND ClienteSexo = @SEXO
	END
ELSE
	BEGIN
		PRINT 'Parâmetro de sexo errado!';
	END
EXEC procRetornaCliente 1, 'M';
-- DROP PROCEDURE procRetornaCliente;


/*
GO
SP_HELP 'procRetornaCliente';
GO
SP_HELPTEXT 'procRetornaCliente';
*/
