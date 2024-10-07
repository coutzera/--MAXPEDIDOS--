SELECT
    pi.numped,
    pc.codcli,
    c.cliente,
    pc.codusur,
    u.nome
FROM
    pcpedi pi
    INNER JOIN pcpedc pc ON (pi.numped = pc.numped)
    INNER JOIN pcclient c ON (pc.codcli = c.codcli)
    INNER JOIN pcusuari u ON (pc.codusur = u.codusur)
WHERE
    1 = 1
    -- AND pi.codfilialretira = '06'
    AND pc.data >= '01-set-2024'
    AND pc.posicao = 'F'
    AND pc.numregiao IN (
        SELECT
            numregiao
        FROM
            pcregiao
        WHERE
            codfilial = '06'
    )
    -- AND pi.coddesconto IS NOT NULL
    AND pi.codprod IN (
        SELECT
            codprod
        FROM
            pcprodut
        WHERE
            codfornec = 4
    )