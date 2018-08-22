--ALTER TABLE Clientes ADD CONSTRAINT TESTE CHECK ([ClienteNascimento] < GETDATE());
--ALTER TABLE Clientes ADD CONSTRAINT chk_cliente_saldo CHECK ([ClienteNascimento] < GETDATE() AND ClienteNome <> 'Sara');
CREATE DATABASE Gabriel

GO

USE Gabriel

GO

CREATE TABLE Pessoas (
	PessoaCodigo INT,
	PessoaNome VARCHAR(100),
	PessoaEstado CHAR(2)
)
GO

ALTER TABLE Pessoas ALTER COLUMN PessoaCodigo INT NOT NULL

GO

ALTER TABLE Pessoas ADD CONSTRAINT PK_PESSOA PRIMARY KEY (PessoaCodigo)

GO

ALTER TABLE Pessoas ADD CONSTRAINT PK_PESSOA PRIMARY KEY (PessoaCodigo)

GO

ALTER TABLE Pessoas ALTER COLUMN PessoaSexo CHAR(1)

GO

ALTER TABLE Pessoas ADD CONSTRAINT ValidaSexo CHECK (PessoaSexo IN ('F', 'M'))

GO

CREATE TABLE Estado (
	EstadoCodigo CHAR(2),
	EstadoNome VARCHAR(100)
)

GO

ALTER TABLE Estado ALTER COLUMN EstadoCodigo CHAR(2) NOT NULL

GO

ALTER TABLE Estado ADD CONSTRAINT PK_ESTADO PRIMARY KEY (EstadoCodigo)

GO

ALTER TABLE Pessoas ADD CONSTRAINT FK_PESSOA_ESTADO FOREIGN KEY (PessoaEstado)
REFERENCES Estado (EstadoCodigo)

GO

SELECT * FROM Pessoas