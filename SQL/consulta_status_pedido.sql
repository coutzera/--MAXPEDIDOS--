SELECT
    MIN(p.codfilial) AS codfilial,
    p.codusur,
    u.nome,
    MIN(p.importado) AS importado,
    MIN(p.numped) AS numped,
    MIN(p.numpedrca) AS numpedrca,      
    MIN(p.idpedidonv) AS idpedidonv,
    MIN(p.dtinclusao) AS dtinclusao,
    MIN(p.importado) AS importado
FROM
    pcpedcfv p
    INNER JOIN pcusuari u ON p.codusur = u.codusur
WHERE
    TRUNC(p.dtinclusao) = TO_DATE('11-02-2025', 'DD-MM-YYYY')  
    AND p.idpedidonv IS  NULL
    AND p.importado IN (1, 2, 3, 4)
    AND p.codusur IN (
        SELECT codusur
        FROM pcusuari
        WHERE codfilial IN ('03', '09', '52', '53')
        AND dttermino IS NULL
    )
GROUP BY p.codusur, u.nome;
