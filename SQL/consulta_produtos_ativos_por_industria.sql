/*
    Este script Oracle SQL retorna todos os produtos do fornecedor 37
    que estão ATIVOS (ENVIARFORCAVENDAS = 'S' na PCPRODFILIAL)
    e que possuem ESTOQUE > 0 (QTEST > 0 na PCEST).

    Ele ignora a filial — ou seja, considera o produto como um todo,
    independentemente de em qual filial ele tenha estoque ou esteja ativo.
*/

-- CTE 1: lista todos os produtos cujo fornecedor cadastrado é o 37
WITH PRODUTOS_FORNECEDOR_37 AS (
    SELECT
        CODPROD
    FROM
        PCPRODUT
    WHERE
        CODFORNEC = 37
),

-- CTE 2: lista todos os produtos (distintos) que:
-- - estão ativos (ENVIARFORCAVENDAS = 'S' na PCPRODFILIAL)
-- - possuem estoque positivo (QTEST > 0 na PCEST)
PRODUTOS_ATIVOS_ESTOQUE AS (
    SELECT DISTINCT
        E.CODPROD
    FROM
        PCEST E
        JOIN PCPRODFILIAL PF
          ON PF.CODPROD = E.CODPROD
         AND PF.CODFILIAL = E.CODFILIAL
    WHERE
        E.QTEST > 0                -- estoque maior que zero
        AND PF.ENVIARFORCAVENDAS = 'S'  -- produto está marcado como ativo
)

-- Resultado final:
-- Retorna apenas os produtos que aparecem nas duas listas acima,
-- ou seja, produtos do fornecedor 37 que estão ativos e têm estoque.
SELECT
    PA.CODPROD
FROM
    PRODUTOS_FORNECEDOR_37 PF37
    JOIN PRODUTOS_ATIVOS_ESTOQUE PA
      ON PA.CODPROD = PF37.CODPROD
ORDER BY
    PA.CODPROD;
