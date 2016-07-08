SELECT GCOLIGADA.CODCOLIGADA AS 'CODIGOCOLIGADA',
 GCOLIGADA.NOMEFANTASIA AS 'ENTIDADE',
 GFILIAL.NOMEFANTASIA AS 'UNIDADE',
 SMODALIDADECURSO.DESCRICAO AS 'MODALIDADE',
 SCURSO.NOME AS 'CURSO',
 STURNO.NOME AS 'TURNO',
 STURMA.NOME AS 'TURMA',
 STURMA.CODTURMA AS 'CODIGOTURMA',
 GIMAGEM.IMAGEM AS 'IMAGEM',
 SPLETIVO.CODPERLET AS 'CODIGOPERLETIVO',
 SPLETIVO.DESCRICAO AS 'DESCRICAOPERLETIVO',
 PPESSOA.NOME AS 'ALUNO',
 PPESSOA.CPF,
 PPESSOA.CARTIDENTIDADE AS RG,
 ISNULL(PPESSOA.RUA + ', ','') +  ISNULL(PPESSOA.NUMERO + ' - ','') + ISNULL(PPESSOA.COMPLEMENTO + ' - ' ,'') + ISNULL(PPESSOA.BAIRRO + ' - ', '') + ISNULL(PPESSOA.ESTADO + ' - ','') +  ISNULL(PPESSOA.CIDADE + ' - ','') +  ISNULL(PPESSOA.CEP,'')  AS 'ENDERECO',
 PCORRACA.DESCRICAO AS 'COR/RACA',
 PPESSOA.SEXO,
 CASE WHEN (PPESSOA.DEFICIENTEAUDITIVO + PPESSOA.DEFICIENTEFALA + PPESSOA.DEFICIENTEFISICO + PPESSOA.DEFICIENTEMOBREDUZIDA + PPESSOA.DEFICIENTEVISUAL) > 0 THEN 'Sim' else 'N�o' END AS 'PNE' ,
 STIPOINGRESSO.DESCRICAO AS 'PORTADOR NECESSIDADE ESPECIAIS',
 PCODINSTRUCAO.DESCRICAO AS 'GRAU DE INSTRUCAO',
 SSTATUS.DESCRICAO AS 'STATUS DA MATRICULA'

FROM GCOLIGADA (NOLOCK)

INNER JOIN SMATRICPL (NOLOCK)
ON GCOLIGADA.CODCOLIGADA = SMATRICPL.CODCOLIGADA

INNER JOIN GFILIAL (NOLOCK)
ON  SMATRICPL.CODCOLIGADA = GFILIAL.CODCOLIGADA
AND SMATRICPL.CODFILIAL   = GFILIAL.CODFILIAL

INNER JOIN SPLETIVO (NOLOCK)
ON  SMATRICPL.CODCOLIGADA = SPLETIVO.CODCOLIGADA
AND SMATRICPL.CODFILIAL = SPLETIVO.CODFILIAL
AND SMATRICPL.IDPERLET = SPLETIVO.IDPERLET

INNER JOIN SHABILITACAOALUNO(NOLOCK)
ON  SMATRICPL.CODCOLIGADA   = SHABILITACAOALUNO.CODCOLIGADA
AND SMATRICPL.IDHABILITACAOFILIAL = SHABILITACAOALUNO.IDHABILITACAOFILIAL
AND SMATRICPL.RA     = SHABILITACAOALUNO.RA

INNER JOIN SHABILITACAOFILIAL (NOLOCK)
ON  SHABILITACAOALUNO.CODCOLIGADA   = SHABILITACAOFILIAL.CODCOLIGADA
AND SHABILITACAOALUNO.IDHABILITACAOFILIAL = SHABILITACAOFILIAL.IDHABILITACAOFILIAL

INNER JOIN SCURSO (NOLOCK)
ON  SHABILITACAOFILIAL.CODCOLIGADA  = SCURSO.CODCOLIGADA
AND SHABILITACAOFILIAL.CODCURSO  = SCURSO.CODCURSO

LEFT JOIN SMODALIDADECURSO (NOLOCK)
ON  SCURSO.CODCOLIGADA   = SMODALIDADECURSO.CODCOLIGADA
AND SCURSO.CODMODALIDADECURSO = SMODALIDADECURSO.CODMODALIDADECURSO

INNER JOIN STURNO (NOLOCK)
ON  SHABILITACAOFILIAL.CODCOLIGADA = STURNO.CODCOLIGADA
AND SHABILITACAOFILIAL.CODTURNO  = STURNO.CODTURNO

INNER JOIN STURMA (NOLOCK)
ON  SMATRICPL.CODCOLIGADA = STURMA.CODCOLIGADA
AND SMATRICPL.CODFILIAL   = STURMA.CODFILIAL
AND SMATRICPL.CODTURMA   = STURMA.CODTURMA
AND SMATRICPL.IDPERLET   = STURMA.IDPERLET

INNER JOIN GIMAGEM (NOLOCK)
ON  GCOLIGADA.IDIMAGEM = GIMAGEM.ID

INNER JOIN SALUNO (NOLOCK)
ON  SMATRICPL.CODCOLIGADA = SALUNO.CODCOLIGADA
AND SMATRICPL.RA   = SALUNO.RA

INNER JOIN SPESSOA (NOLOCK)
ON  SALUNO.CODPESSOA = SPESSOA.CODIGO

INNER JOIN PPESSOA (NOLOCK)
ON  SPESSOA.CODIGO = PPESSOA.CODIGO

LEFT JOIN PCORRACA (NOLOCK)
ON  PPESSOA.CORRACA = PCORRACA.CODCLIENTE

LEFT JOIN STIPOINGRESSO(NOLOCK)
ON STIPOINGRESSO.CODCOLIGADA  = SHABILITACAOALUNO.CODCOLIGADA
AND STIPOINGRESSO.CODTIPOINGRESSO = SHABILITACAOALUNO.CODTIPOINGRESSO

LEFT JOIN PCODINSTRUCAO (NOLOCK)
ON  PPESSOA.GRAUINSTRUCAO = PCODINSTRUCAO.CODCLIENTE

INNER JOIN SSTATUS (NOLOCK)
ON  SMATRICPL.CODCOLIGADA = SSTATUS.CODCOLIGADA
AND SMATRICPL.CODSTATUS = SSTATUS.CODSTATUS

-- INNER JOIN
-- SHABILITACAOFILIALPL (NOLOCK)
-- ON SHABILITACAOFILIALPL.CODCOLIGADA = SHABILITACAOFILIAL.CODCOLIGADA
-- AND SHABILITACAOFILIALPL.IDHABILITACAOFILIAL = SHABILITACAOFILIAL.IDHABILITACAOFILIAL


-- INNER JOIN
-- SPLANOPGTO (NOLOCK)
-- ON SPLANOPGTO.CODPLANOPGTO = SHABILITACAOFILIALPL.CODPLANOPGTO
-- AND SPLANOPGTO.CODCOLIGADA = SHABILITACAOFILIALPL.CODCOLIGADA
-- AND SPLANOPGTO.IDPERLET = SHABILITACAOFILIALPL.IDPERLET


-- INNER JOIN
-- SPARCPLANO (NOLOCK)
-- ON SPARCPLANO.CODCOLIGADA = SPLANOPGTO.CODCOLIGADA
-- AND SPARCPLANO.IDPERLET = SPLANOPGTO.IDPERLET
-- AND SPARCPLANO.CODPLANOPGTO = SPLANOPGTO.CODPLANOPGTO

--INNER JOIN
--SPARCELA (NOLOCK)
--ON SPARCELA.CODCOLIGADA = SPARCPLANO.CODCOLIGADA
--AND SPARCELA.IDPERLET = SPARCPLANO.IDPERLET
--AND SPARCEL

--WHERE SHABILITACAOFILIAL.CODCOLIGADA  = :$CODCOLIGADA
--AND STURMA.CODTURMA        = :$CODTURMA
--AND SPLETIVO.CODPERLET        = :$CODPERLET