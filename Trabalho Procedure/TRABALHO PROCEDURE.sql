-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************
USE master
ALTER DATABASE Universidade SET SINGLE_USER WITH ROLLBACK IMMEDIATE

GO

DROP DATABASE IF EXISTS Universidade

GO

USE master
--************************************** DataBase Universidade
CREATE DATABASE Universidade

GO

USE Universidade

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



--************************************** [Materias]

CREATE TABLE [Materias]
(
 [idMateria]    INT IDENTITY (1, 1) NOT NULL ,
 [idCursos]     INT NOT NULL ,
 [idProfessor]  INT NOT NULL ,
 [nome]         VARCHAR(250) NOT NULL ,
 [cargaHoraria] INT NOT NULL ,

 CONSTRAINT [PK_Materias] PRIMARY KEY CLUSTERED ([idMateria] ASC, [idCursos] ASC, [idProfessor] ASC),
 CONSTRAINT [FK_67] FOREIGN KEY ([idCursos])
  REFERENCES [Cursos]([idCursos]),
 CONSTRAINT [FK_71] FOREIGN KEY ([idProfessor])
  REFERENCES [Professores]([idProfessor])
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
 [N1]          DECIMAL(4,2) NULL ,
 [F1]          INT NULL ,
 [N2]          DECIMAL(4,2) NULL ,
 [F2]          INT NULL ,
 [N3]          DECIMAL(4,2) NULL ,
 [F3]          INT NULL ,
 [N4]          DECIMAL(4,2) NULL ,
 [F4]          INT NULL ,
 [totalPontos] DECIMAL(4,2) NULL ,
 [totalFaltas] INT NULL ,
 [frequencia]  INT NULL ,
 [mediaFinal]  DECIMAL(4,2) NULL ,

 CONSTRAINT [PK_Matricula] PRIMARY KEY CLUSTERED ([matricula] ASC, [idProfessor] ASC, [idCursos] ASC, [idMateria] ASC, [ano] ASC),
 CONSTRAINT [FK_31] FOREIGN KEY ([idProfessor])
  REFERENCES [Professores]([idProfessor]),
 CONSTRAINT [FK_35] FOREIGN KEY ([idCursos])
  REFERENCES [Cursos]([idCursos]),
 CONSTRAINT [FK_39] FOREIGN KEY ([idMateria], [idCursos], [idProfessor])
  REFERENCES [Materias]([idMateria], [idCursos], [idProfessor]),
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

INSERT Professores (nome) VALUES ('Rodrigo Ramos Dornel');
INSERT Professores (nome) VALUES ('Walter Coan');

GO

INSERT Materias (idCursos, idProfessor, nome, cargaHoraria) VALUES (1, 1, 'Banco de Dados', 144);
INSERT Materias (idCursos, idProfessor, nome, cargaHoraria) VALUES (1, 2, 'Programação Orientada a Objetos', 144);

GO

CREATE PROCEDURE procMatricula
@nome VARCHAR(250), @curso VARCHAR(250)
AS
BEGIN
	DECLARE @idAluno int;
	SELECT @idAluno = Alunos.idAluno FROM Alunos WHERE nome = @nome;

	INSERT INTO Matricula (idProfessor, idCursos, idMateria, ano, idAluno)
	SELECT Materias.idProfessor, Cursos.idCursos, Materias.idMateria, YEAR(GETDATE()), @idAluno
	FROM Cursos INNER JOIN Materias ON Cursos.idCursos = Materias.idCursos;
END

GO

CREATE PROCEDURE procNota
@materia int, @ano int, @aluno int, @bimestre int, @nota decimal(4,2), @falta int
AS
BEGIN
	IF @bimestre = 1 BEGIN
		UPDATE Matricula SET N1 = @nota, F1 = @falta, totalPontos = @nota, totalFaltas = @falta, mediaFinal = @nota / @bimestre
		WHERE Matricula.idMateria = @materia AND Matricula.ano = @ano AND Matricula.idAluno = @aluno;
	END ELSE IF @bimestre = 2 BEGIN
		UPDATE Matricula SET N2 = @nota, F2 = @falta, totalPontos = N1 + @nota, totalFaltas = F1 + @falta, mediaFinal = (N1 + @nota) / @bimestre
		WHERE Matricula.idMateria = @materia AND Matricula.ano = @ano AND Matricula.idAluno = @aluno;
	END ELSE IF @bimestre = 3 BEGIN
		UPDATE Matricula SET N3 = @nota, F3 = @falta, totalPontos = N1 + N2 + @nota, totalFaltas = F1 + F2 + @falta, mediaFinal = (N1 + N2 + @nota) / @bimestre
		WHERE Matricula.idMateria = @materia AND Matricula.ano = @ano AND Matricula.idAluno = @aluno;
	END ELSE IF @bimestre = 4 BEGIN
		UPDATE Matricula SET N4 = @nota, F4 = @falta, totalPontos = N1 + N2 + N3 + @nota,
		totalFaltas = F1 + F2 + F3 + @falta, mediaFinal = (N1 + N2 + N3 + @nota) / @bimestre,
		frequencia = (144 - (F1 + F2 + F3 + @falta)) * 100 / 144
		WHERE Matricula.idMateria = @materia AND Matricula.ano = @ano AND Matricula.idAluno = @aluno;
	END
	
END

GO

EXEC procMatricula 'Gabriel Dezan Busarello', 'Sistemas de Informação';
EXEC procMatricula 'Rodrigo da Silva Peruzzo', 'Sistemas de Informação';

GO

EXEC procNota 1, 2018, 1, 1, 10, 0;
EXEC procNota 1, 2018, 1, 2, 10, 0;
EXEC procNota 1, 2018, 1, 3, 10, 0;
EXEC procNota 1, 2018, 1, 4, 10, 0;

EXEC procNota 1, 2018, 2, 1, 9, 2;
EXEC procNota 1, 2018, 2, 2, 9, 3;
EXEC procNota 1, 2018, 2, 3, 9, 5;
EXEC procNota 1, 2018, 2, 4, 9, 10;

SELECT * FROM Matricula;