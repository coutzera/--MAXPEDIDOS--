SELECT 
    CASE 
        WHEN r.codusur IN (c.codusur1, c.codusur2, c.codusur3) THEN 'VINCULADO'
        ELSE 'NÃO VINCULADO'
    END AS status_vinculo,
    r.*
FROM 
    pcrotacli r
JOIN 
    pcclient c ON r.codcli = c.codcli
WHERE 
    r.codusur = 19
    AND r.DTPROXVISITA = '22-04-2025'
ORDER BY 
    CASE 
        WHEN r.codusur IN (c.codusur1, c.codusur2, c.codusur3) THEN 0
        ELSE 1
    END,
    r.diasemana,
    r.sequencia;
