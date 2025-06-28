/*
    -------------------------------------------------------------
    SCRIPT: Consulta de produtos ativos com estoque por filial
    -------------------------------------------------------------
    Objetivo:
    - Retornar, por filial, a quantidade de produtos distintos
      do fornecedor 37 que:
        * estão marcados como ATIVOS (ENVIARFORCAVENDAS = 'S')
        * possuem ESTOQUE > 0
*/

-- CTE 1: lista todos os produtos cadastrados com o fornecedor 37
WITH PRODUTOS_FORNECEDOR_37 AS (
    SELECT
        CODPROD
    FROM
        PCPRODUT
    WHERE
        CODFORNEC = 37
),

-- CTE 2: lista todos os produtos que estão ATIVOS e com ESTOQUE > 0
-- em cada filial
PRODUTOS_ATIVOS_ESTOQUE AS (
    SELECT
        E.CODPROD,
        E.CODFILIAL
    FROM
        PCEST E
        JOIN PCPRODFILIAL PF
          ON PF.CODPROD = E.CODPROD
         AND PF.CODFILIAL = E.CODFILIAL
    WHERE
        E.QTEST > 0                -- tem estoque disponível
        AND PF.ENVIARFORCAVENDAS = 'S'  -- produto ativo para venda
)

-- Resultado final:
-- Para cada filial, conta quantos produtos distintos do fornecedor 37
-- estão ativos e com estoque
SELECT
    PA.CODFILIAL,                                -- filial
    COUNT(DISTINCT PA.CODPROD) AS QTDE_PRODUTOS  -- quantidade de produtos distintos
FROM
    PRODUTOS_FORNECEDOR_37 PF37
    JOIN PRODUTOS_ATIVOS_ESTOQUE PA
      ON PA.CODPROD = PF37.CODPROD               -- considera só produtos do fornecedor 37
GROUP BY
    PA.CODFILIAL
ORDER BY
    PA.CODFILIAL;
