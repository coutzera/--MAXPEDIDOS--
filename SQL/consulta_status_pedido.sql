select
    p.codfilial,
    p.codusur,
    u.nome,
    p.importado,
    p.numped,
    p.numpedrca,
    p.dtinclusao,
    p.idpedidonv
from
    pcpedcfv p
    inner join pcusuari u on (p.codusur = u.codusur)
where
    1 = 1
    AND TRUNC (p.dtinclusao) = '26-09-2024'
    AND p.IDPEDIDONV IS NOT NULL
    AND p.codusur IN (
        select
            codusur
        from
            pcusuari
        where
            codfilial in (
                '01',
                '02',
                '04',
                '06',
                '07',
                '08',
                '11',
                '12',
                '15',
                '16',
                '18'
            )
            and dttermino is null
    )
    and importado in (1)

-- 1 = pendente
-- 2 = importado (sucesso)
-- 3 = importado (com erro)