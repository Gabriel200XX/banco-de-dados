-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************
USE master

GO

DROP DATABASE IF EXISTS Universidade

GO

--************************************** DataBase Universidade
CREATE DATABASE Universidade

GO

USE Universidade

--************************************** [Materias]

CREATE TABLE [Materias]
(
 [idMateria]    INT IDENTITY (1, 1) NOT NULL ,
 [nome]         VARCHAR(250) NOT NULL ,
 [cargaHoraria] INT NOT NULL ,

 CONSTRAINT [PK_Materias] PRIMARY KEY CLUSTERED ([idMateria] ASC)
);
GO



--************************************** [Cursos]

CREATE TABLE [Cursos]
(
 [idCursos] INT IDENTITY (1, 1) NOT NULL ,
 [nome]     VARCHAR(250) NOT NULL ,

 CONSTRAINT [PK_Cursos] PRIMARY KEY CLUSTERED ([idCursos] ASC)
);
GO



--************************************** [Professores]

CREATE TABLE [Professores]
(
 [idProfessor] INT IDENTITY (1, 1) NOT NULL ,
 [nome]        VARCHAR(250) NOT NULL ,

 CONSTRAINT [PK_Professor] PRIMARY KEY CLUSTERED ([idProfessor] ASC)
);
GO



--************************************** [Alunos]

CREATE TABLE [Alunos]
(
 [idAluno] INT IDENTITY (1, 1) NOT NULL ,
 [nome]    VARCHAR(250) NOT NULL ,

 CONSTRAINT [PK_Alunos] PRIMARY KEY CLUSTERED ([idAluno] ASC)
);
GO



--************************************** [Matricula]

CREATE TABLE [Matricula]
(
 [matricula]   INT IDENTITY (1, 1) NOT NULL ,
 [idProfessor] INT NOT NULL ,
 [idCursos]    INT NOT NULL ,
 [idMateria]   INT NOT NULL ,
 [ano]         INT NOT NULL ,
 [idAluno]     INT NOT NULL ,
 [N1]          DECIMAL(2,2) NULL ,
 [F1]          INT NULL ,
 [N2]          DECIMAL(2,2) NULL ,
 [F2]          INT NULL ,
 [N3]          DECIMAL(2,2) NULL ,
 [F3]          INT NULL ,
 [N4]          DECIMAL(2,2) NULL ,
 [F4]          INT NULL ,
 [totalPontos] DECIMAL(2,2) NULL ,
 [totalFaltas] INT NULL ,
 [frequencia]  INT NULL ,
 [mediaFinal]  DECIMAL(2,2) NULL ,

 CONSTRAINT [PK_Matricula] PRIMARY KEY CLUSTERED ([matricula] ASC, [idProfessor] ASC, [idCursos] ASC, [idMateria] ASC, [ano] ASC),
 CONSTRAINT [FK_31] FOREIGN KEY ([idProfessor])
  REFERENCES [Professores]([idProfessor]),
 CONSTRAINT [FK_35] FOREIGN KEY ([idCursos])
  REFERENCES [Cursos]([idCursos]),
 CONSTRAINT [FK_39] FOREIGN KEY ([idMateria])
  REFERENCES [Materias]([idMateria]),
 CONSTRAINT [FK_57] FOREIGN KEY ([idAluno])
  REFERENCES [Alunos]([idAluno])
);
GO

INSERT Alunos (nome) VALUES ('Gabriel Dezan Busarello')
INSERT Alunos (nome) VALUES ('Rodrigo da Silva Peruzzo')

GO

INSERT Cursos (nome) VALUES ('Sistemas de Informação')
INSERT Cursos (nome) VALUES ('Engenharia de Software')

GO

INSERT Materias (nome, cargaHoraria) VALUES ('Banco de Dados', 144);
INSERT Materias (nome, cargaHoraria) VALUES ('Programação Orientada a Objetos', 144);

GO

INSERT dbo.Professores (nome) VALUES ('Rodrigo Ramos Dornel');
INSERT dbo.Professores (nome) VALUES ('Walter Coan');

GO

INSERT INTO Matricula (idProfessor, idCursos, idMateria, ano, idAluno) VALUES (1, 1, 1, 2018, 1);
INSERT INTO Matricula (idProfessor, idCursos, idMateria, ano, idAluno) VALUES (1, 1, 2, 2018, 1);

GO

SELECT * FROM Alunos;
SELECT * FROM Cursos;
SELECT * FROM Materias;
SELECT * FROM Professores;
SELECT * FROM Matricula;

GO

CREATE PROCEDURE
@matricula int, @bimestre int, @nota decimal(2,2), @falta int
AS
BEGIN
	IF @bimestre = 1 BEGIN
		UPDATE Matricula SET N1 = @nota, F1 = @falta WHERE matricula = @matricula
	END ELSE IF @bimestre = 2 BEGIN
		UPDATE Matricula SET N2 = @nota, F2 = @falta WHERE matricula = @matricula
	END ELSE IF @bimestre = 3 BEGIN
		UPDATE Matricula SET N3 = @nota, F3 = @falta WHERE matricula = @matricula
	END ELSE IF @bimestre = 4 BEGIN
		UPDATE Matricula SET N4 = @nota, F4 = @falta WHERE matricula = @matricula
		totalPontos
		totalFaltas
		frequencia
		mediaFinal
	END
	
END