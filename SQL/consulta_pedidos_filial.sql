WITH usuarios_ativos AS (
    SELECT codusur
    FROM pcusuari
    WHERE codfilial IN (
        '01','02','03','04','05','06','07','08','09','10',
        '11','12','13','14','15','16','18','52','53'
    )
    AND dttermino IS NULL
),
pedidos_filtrados AS (
    SELECT
        p.codfilial,
        p.codusur,
        p.numped,
        p.numpedrca,
        p.idpedidonv,
        p.importado,
        p.dtinclusao
    FROM
        pcpedcfv p
    WHERE
        p.dtinclusao >= TO_DATE('30-04-2025', 'DD-MM-YYYY')
        AND p.dtinclusao < TO_DATE('01-05-2025', 'DD-MM-YYYY')
        AND p.importado IN (1, 4)
        AND p.codusur IN (SELECT codusur FROM usuarios_ativos)
),
resumo_filial AS (
    SELECT
        p.codfilial              AS codfilial,
        COUNT(1)                 AS qtd_pedidos
    FROM
        pedidos_filtrados p
    GROUP BY
        p.codfilial
),
resumo_com_total AS (
    SELECT
        codfilial,
        qtd_pedidos
    FROM
        resumo_filial

    UNION ALL

    SELECT
        'TOTAL' AS codfilial,
        SUM(qtd_pedidos) AS qtd_pedidos
    FROM
        resumo_filial
)
SELECT
    codfilial,
    qtd_pedidos
FROM
    resumo_com_total
ORDER BY
    CASE 
        WHEN codfilial = 'TOTAL' THEN 999999 -- Colocando 'TOTAL' no final
        ELSE TO_NUMBER(codfilial)            -- Ordenação numérica das filiais
    END;
