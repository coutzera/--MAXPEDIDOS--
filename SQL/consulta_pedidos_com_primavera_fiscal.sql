SELECT
    c.codemitente as SISTEMA,
    p.*
FROM
    pcpedi p
    JOIN pcpedc c ON p.numped = c.numped
WHERE
    p.codcli IN (
        --Bloco onde busca todos os clientes que tem o benefício
        SELECT
            codcli
        FROM
            pcclient
        WHERE
            tipoempresa = 'NRPA'
            AND codfilialnf = '02'
            --fim do block
    )
    AND p.data > TO_DATE ('01-08-2024', 'DD-MM-YYYY')
    --AND p.codprod = 2443 -- Procura por produto com benefício Fiscal
    AND p.codusur = 19 -- Código do RCA
    AND p.numped IN (19020114, 19019922) -- Aqui trocar o código dos pedidos
    --19019922, 19020114
ORDER BY
    p.codprod;