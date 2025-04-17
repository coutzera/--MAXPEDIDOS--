-- Consulta principal: Pedidos com benefício fiscal para clientes do tipo 'NRPA'
SELECT
    c.codemitente AS sistema,
    p.*
FROM
    pcpedi p
    INNER JOIN pcpedc c ON p.numped = c.numped
WHERE
    p.codcli IN (
        SELECT codcli
        FROM pcclient
        WHERE tipoempresa = 'NRPA'
          AND codfilialnf = '02'
    )
    AND p.data > TO_DATE('01-04-2025', 'DD-MM-YYYY')
    AND p.codusur = 19
    -- Filtros opcionais (remova os comentários caso necessário)
    -- AND p.codprod = 688
    -- AND p.numped IN (19020114, 19019922)
    -- AND p.percacrescbenffis = 6
ORDER BY
    p.codprod;

-- Verificação de origem de preço para o mesmo cenário de benefício fiscal
SELECT *
FROM pcorigempreco
WHERE data = TO_DATE('01-04-2025', 'DD-MM-YYYY')
  AND codfilial = '02'
  AND percacrescbenffis = 6
ORDER BY numped;
