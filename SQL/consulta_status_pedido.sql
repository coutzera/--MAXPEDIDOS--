SELECT
    MIN(p.codfilial) AS codfilial,
    p.codusur,
    u.nome,
    COUNT(p.importado) AS QTD,
    MIN(p.numped) AS PEDIDO_WINTHOR,
    MIN(p.numpedrca) AS PEDIDO_RCA,      
    MIN(p.idpedidonv) AS ID_PEDIDO,
    MAX(p.dtinclusao) AS DATA,
    MIN(p.importado) AS SITUACAO
FROM
    pcpedcfv p
    INNER JOIN pcusuari u ON p.codusur = u.codusur
WHERE
    TRUNC(p.dtinclusao) = TO_DATE('13-02-2025', 'DD-MM-YYYY')  
    AND p.idpedidonv IS  NULL
    AND p.importado IN (1, 2, 3, 4)
    AND p.codusur IN (
        SELECT codusur
        FROM pcusuari
        WHERE codfilial IN ('03', '09', '52', '53')
        AND dttermino IS NULL
    )
GROUP BY p.codusur, u.nome;
