SELECT * FROM pcbrindeex WHERE codbrex = 50251
 
-- Consulta 3320 - (codpromocao campo tabela)
SELECT * FROM PCPEDI 
WHERE codpromocao = 20159
AND data >= '01-04-2024'
 
--Consulta 561 - (coddesconto campo da tabela)
SELECT CODDESCONTO, CODUSUR, CODCLI, CODPROD, DTINICIO, DTFIM, CODFILIAL, PERCDESC, NUMREGIAO FROM pcdesconto 
WHERE 1 = 1
AND DTFIM BETWEEN '01-01-2024' AND '01-10-2030'
AND codfilial = '13'
AND codusur is not null
AND codcli is not null
AND codprod is not null
 
 
SELECT * FROM pcpedi
WHERE coddesconto = 2753015
AND data >= '01-08-2024'
 
--Consulta 3306 - (pesquisar campo da tabela)
SELECT P.CODUSUR, P.NUMPED, P.DATA, P.CODCLI, P.CODFILIALRETIRA, P.CODCOMBO FROM pcpedi P
INNER JOIN pcdescontoc D ON (P.CODCOMBO = D.CODIGO)
WHERE P.codcombo is not null
AND D.TIPOCAMPANHA = 'MQT'
AND DATA > '01-04-2024'
 
-- RESULTA O CODCOMBO - MQT
SELECT * FROM pcpedi
WHERE codcombo = 3233
AND data >= '01-03-2024'
AND codprod = 2176
 
 
-- RESULTA O CODCOMBO - SQP
SELECT P.CODUSUR, P.NUMPED, P.DATA, P.CODCLI, P.CODFILIALRETIRA, P.CODCOMBO FROM pcpedi P
INNER JOIN pcdescontoc D ON (P.CODCOMBO = D.CODIGO)
WHERE P.codcombo is not null
AND D.TIPOCAMPANHA = 'SQP'
AND DATA > '01-04-2024'
 
SELECT * FROM pcpedi
WHERE codcombo = 7728
AND codcli = 97674
 
 
-- RESULTA O CODCOMBO - MIQ
SELECT P.CODUSUR, P.NUMPED, P.DATA, P.CODCLI, P.CODFILIALRETIRA, P.CODCOMBO FROM pcpedi P
INNER JOIN pcdescontoc D ON (P.CODCOMBO = D.CODIGO)
WHERE P.codcombo is not null
AND D.TIPOCAMPANHA = 'MIQ'
AND DATA > '01-04-2024'
 
SELECT * FROM pcpedi
WHERE codcombo = 7410
AND codcli = 138438
AND codprod = 8836