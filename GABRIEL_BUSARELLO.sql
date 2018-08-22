/*
Matrícula: 1111007801
Nome: Gabriel Dezan Busarello
Prova: 01
*/

CREATE DATABASE Escola3;

USE Escola3;

CREATE TABLE Cursos (
	CursoCodigo int IDENTITY(1,1) CONSTRAINT PK_CURSO PRIMARY KEY,
	CursoNome varchar(80)
)

GO

CREATE TABLE Aluno (
	AlunoCodigo int IDENTITY(1,1) CONSTRAINT PK_ALUNO PRIMARY KEY,
	AlunoNome varchar(80),
	AlunoMatricula varchar(20),
	AlunoMatriculaAno int,
	CursoCodigo int,
	CONSTRAINT FK_CURSOS_ALUNO FOREIGN KEY (CursoCodigo) REFERENCES Cursos(CursoCodigo)
)

GO

INSERT Cursos (CursoNome) VALUES ('INFORMÁTICA');
INSERT Cursos (CursoNome) VALUES ('INGLÊS');

GO

INSERT Aluno (AlunoNome, AlunoMatricula, AlunoMatriculaAno, CursoCodigo)
VALUES ('Gabriel', '123456', '2018', 1);

INSERT Aluno (AlunoNome, AlunoMatricula, AlunoMatriculaAno, CursoCodigo)
VALUES ('Gabriel', '123456', '2018', 2);

GO

SELECT AlunoMatricula, AlunoNome, AlunoMatricula, Cursos.CursoCodigo, AlunoMatriculaAno, Cursos.CursoCodigo, CursoNome
FROM Aluno, Cursos WHERE Aluno.CursoCodigo = Cursos.CursoCodigo;