USE MinhaCaixa;

DROP TABLE Feriados;

CREATE TABLE Feriados (
	FeriadoCodigo int IDENTITY(1,1) CONSTRAINT PK_FERIADO PRIMARY KEY,
	FeriadoNome VARCHAR(100),
	FeriadoData DATE
);

GO

INSERT Feriados (FeriadoNome, FeriadoData) VALUES ('Confraterniza��o Universal', '2018-01-01');
INSERT Feriados (FeriadoNome, FeriadoData) VALUES ('Tiradentes', '2018-04-21');
INSERT Feriados (FeriadoNome, FeriadoData) VALUES ('Dia do Trabalhador', '2018-05-01');
INSERT Feriados (FeriadoNome, FeriadoData) VALUES ('Dia da P�tria', '2018-09-07');
INSERT Feriados (FeriadoNome, FeriadoData) VALUES ('Nossa Senhora Aparecida', '2018-10-12');
INSERT Feriados (FeriadoNome, FeriadoData) VALUES ('Finados', '2018-11-02');
INSERT Feriados (FeriadoNome, FeriadoData) VALUES ('Proclama��o da Rep�blica', '2018-11-15');
INSERT Feriados (FeriadoNome, FeriadoData) VALUES ('Confraterniza��o Universal', '2018-12-25');

GO

SELECT * FROM Feriados;

GO
-- 1) Fa�a um consulta que retorne o nome e sobrenome do cliente, seu bairro, e os valores das suas movimenta��es, a data ordenando as movimenta��es pelas mais recentes.
SELECT Clientes.ClienteNome, Clientes.ClienteSobrenome, Clientes.ClienteBairro, Movimentos.MovimentoValor, Movimentos.MovimentoData
FROM Movimentos, Contas, Clientes
WHERE Movimentos.ContaNumero=Contas.ContaNumero AND Contas.AgenciaCodigo=Clientes.ClienteCodigo ORDER BY Movimentos.MovimentoData DESC;

GO

-- 2) Mostre o nome do cliente, sobrenome e a sua renda convertida em dolar e euro.
SELECT ClienteNome, ClienteSobrenome, (ClienteRendaAnual / 3.80) AS Dolar, (ClienteRendaAnual / 4.46) AS Euro FROM Clientes;

GO

-- 3) Traga o nome dos clientes, o sobrenome, o bairro, o estado civil (descrito), o sexo (descrito) e classifique o cliente de acordo com a sua renda anual
-- C - Tem renda menor que 50.000
-- B - Tem renda menor que 70.000
-- A - Tem renda acima de 70.000

SELECT ClienteNome, ClienteSobrenome, ClienteBairro,
CASE WHEN ClienteEstadoCivil = 'S' THEN 'SOLTEIRO' ELSE 'CASADO' END AS EstadoCivilExtenso,
CASE WHEN ClienteSexo = 'M' THEN 'MASCULINO' ELSE 'FEMININO' END AS SexoExtenso,
CASE WHEN ClienteRendaAnual <= 50000 THEN 'C'
WHEN ClienteRendaAnual <= 70000 THEN 'B'
WHEN ClienteRendaAnual > 70000 THEN 'A' END AS Classificacao
FROM Clientes

GO

-- XX) Escolha 5 clientes e cadastre cart�es de cr�dito para eles

INSERT INTO CartaoCredito (AgenciaCodigo, ContaNumero, ClienteCodigo, CartaoCodigo, CartaoLimite, CartaoExpira, CartaoCodigoSeguranca)
SELECT AgenciaCodigo, ContaNumero, ClienteCodigo, '5205-2164-9909-2561', '2500.00', '2019-10-07', '176' FROM Contas WHERE ClienteCodigo = 1;
INSERT INTO CartaoCredito (AgenciaCodigo, ContaNumero, ClienteCodigo, CartaoCodigo, CartaoLimite, CartaoExpira, CartaoCodigoSeguranca)
SELECT AgenciaCodigo, ContaNumero, ClienteCodigo, '5328-4733-8086-0752', '3000.00', '2019-12-07', '492' FROM Contas WHERE ClienteCodigo = 2;
INSERT INTO CartaoCredito (AgenciaCodigo, ContaNumero, ClienteCodigo, CartaoCodigo, CartaoLimite, CartaoExpira, CartaoCodigoSeguranca)
SELECT AgenciaCodigo, ContaNumero, ClienteCodigo, '5319-5966-3010-7706', '5000.00', '2020-05-07', '846' FROM Contas WHERE ClienteCodigo = 3;
INSERT INTO CartaoCredito (AgenciaCodigo, ContaNumero, ClienteCodigo, CartaoCodigo, CartaoLimite, CartaoExpira, CartaoCodigoSeguranca)
SELECT AgenciaCodigo, ContaNumero, ClienteCodigo, '5420-2053-1354-7370', '8500.00', '2019-10-07', '567' FROM Contas WHERE ClienteCodigo = 4;
INSERT INTO CartaoCredito (AgenciaCodigo, ContaNumero, ClienteCodigo, CartaoCodigo, CartaoLimite, CartaoExpira, CartaoCodigoSeguranca)
SELECT AgenciaCodigo, ContaNumero, ClienteCodigo, '5528-4944-4505-2944', '5500.00', '2018-11-07', '633' FROM Contas WHERE ClienteCodigo = 5;
SELECT TOP(5) ClienteCodigo FROM Clientes;

SELECT TOP(5) ClienteCodigo FROM Clientes
SELECT AgenciaCodigo FROM Contas WHERE ClienteCodigo IN (SELECT TOP(5) ClienteCodigo FROM Clientes);
SELECT * FROM CartaoCredito WHERE ClienteCodigo IN (1, 2, 3, 4, 5)

-- 4) Liste todos os cliente que moram no mesmo bairro das ag�ncia do banco.
SELECT TOP(1) * FROM Clientes;
SELECT TOP(1) * FROM Agencias;

SELECT Clientes.ClienteNome, Clientes.ClienteBairro, Agencias.AgenciaNome, Agencias.AgenciaBairro
FROM Clientes, Agencias WHERE Clientes.ClienteBairro=Agencias.AgenciaBairro

-- 5) Mostre todos os clientes que possuem n�mero no seu e-mail
SELECT ClienteNome, ClienteEmail FROM Clientes WHERE ClienteEmail LIKE '%[0-9]%';

-- 6) Mostre todos os clientes em que o nome da rua come�a com R. e n�o com Rua.
SELECT ClienteRua FROM Clientes WHERE ClienteRua LIKE 'R.%' AND ClienteRua NOT LIKE 'Rua%';

-- 7) Mostre o nome do cliente e a renda apenas do 5 melhores clientes com base na sua renda.
SELECT TOP(5) ClienteNome, ClienteRendaAnual FROM Clientes ORDER BY ClienteRendaAnual DESC;

-- 8) Mostre o nome do cliente e a renda apenas do 5 piores clientes com base na sua renda.
SELECT TOP(5) ClienteNome, ClienteRendaAnual FROM Clientes ORDER BY ClienteRendaAnual;

-- 9) Mostre o nome e a rua dos clientes que moram em residencias cujo n�mero est� entre 300 e 500.
SELECT ClienteNome, ClienteRua, ClienteNumero FROM Clientes WHERE ClienteNumero BETWEEN 300 AND 500;

-- 10) Utilizando o conceito de sub consulta mostre quais clientes n�o possuem cart�o de cr�dito.
SELECT * FROM Clientes WHERE ClienteCodigo NOT IN (SELECT ClienteCodigo FROM CartaoCredito);

-- 11) Mostre o nome do cliente, o nome da ag�mncia e o bairro da ag�ncia, as movimenta��es do clientes e o limite do cart�o de cr�dito dele somente para os clientes em que a conta foi aberta a partir de 2008.
SELECT Clientes.ClienteNome, Agencias.AgenciaNome, Agencias.AgenciaBairro, Movimentos.MovimentoValor, CartaoCredito.CartaoLimite
FROM Clientes, Contas, Agencias, Movimentos, CartaoCredito WHERE Clientes.ClienteCodigo=Contas.ClienteCodigo
AND Contas.AgenciaCodigo=Agencias.AgenciaCodigo AND Contas.ContaNumero=Movimentos.ContaNumero AND
Clientes.ClienteCodigo=CartaoCredito.ClienteCodigo AND Contas.ContaAbertura >= '2008-01-01';

-- 12) Fa�a uma consulta que classifique os clientes em Regi�es conforme o bairro que moram.
SELECT ClienteNome, ClienteBairro,
	CASE WHEN ClienteBairro IN ('ZONA INDUSTRIAL', 'COSTA E SILVA', 'SANTO ANTONIO', 'BOM RETIRO', 'GLORIA', 'AMERICA', 'SAGACU', 'SAGUACU', 'ATIRADORES', 'CENTRO', 'ANITA GARIBALDI', 'BUCAREIN') THEN 'CENTRO-NORTE'
	WHEN ClienteBairro = 'PIRABEIRABA' THEN 'DISTRITO DE PIRABEIRABA'
	WHEN ClienteBairro IN ('IRIRIU', 'JARDIM IRIRIU', 'COMASA', 'ESPINHEIROS') THEN 'LESTE'
	WHEN ClienteBairro IN ('JARDIM PARAISO', 'JARDIM SOFIA', 'CUBATAO', 'AVENTUREIRO', 'VIGORELLI') THEN 'NORDESTE'
	WHEN ClienteBairro IN ('VILA NOVA') THEN 'OESTE'
	WHEN ClienteBairro IN ('GUANABARA', 'FATIMA', 'ADEMAR GARCIA', 'JARIVATUBA', 'JOAO COSTA', 'PARANAGUAMIRIM', 'ULYSSES GUIMARAES', 'MORRO DO AMARAL') THEN 'SUDESTE'
	WHEN ClienteBairro IN ('MORRO DO MEIO', 'SAO MARCOS', 'NOVA BRASILIA', 'JATIVOCA') THEN 'SUDOESTE'
	WHEN ClienteBairro IN ('FLORESTA', 'ITAUM', 'PETROPOLIS', 'SANTA CATARINA', 'PROFIPO', 'BOEHMERWALDT', 'PARQUE GUARANI', 'ITINGA') THEN 'SUL'
	ELSE 'SEM BAIRRO' END AS [REGI�O]
FROM Clientes ORDER BY ClienteBairro;

-- 13) Mostra o nome do cliente e o tipo de movimenta��o, apenas para as movimenta��es de d�bito.
SELECT Clientes.ClienteNome, Movimentos.MovimentoValor, Movimentos.MovimentoTipo, TipoMovimento.TipoMovimentoDescricao
FROM Clientes, Contas, Movimentos, TipoMovimento WHERE Clientes.ClienteCodigo=Contas.ClienteCodigo AND
Contas.ContaNumero=Movimentos.ContaNumero AND Movimentos.MovimentoTipo = TipoMovimento.TipoMovimentoCodigo
AND TipoMovimento.TipoMovimentoCodigo = -1;