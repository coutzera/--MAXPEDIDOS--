-- Buscar dados de usuários e pedidos que:
-- - Fizeram pedidos diretamente (não por MaxPedidos)
-- - Pertencem a filiais específicas
-- - Não possuem pedidos feitos pelo MaxPedidos no mesmo período
-- - Dentro do período de 01/04/2025 a 27/04/2025

WITH
-- CTE 1: Usuários ativos em filiais específicas
usuarios_filiais AS (
    SELECT codusur
    FROM pcusuari
    WHERE codfilial IN ('02', '15', '16', '18')
      AND dttermino IS NULL
),

-- CTE 2: Usuários que fizeram pedidos via MaxPedidos
usuarios_maxpedidos AS (
    SELECT DISTINCT p2.codusur
    FROM pcpedcfv p2
    WHERE p2.dtinclusao BETWEEN TO_DATE('01-04-2025', 'DD-MM-YYYY') 
                            AND TO_DATE('27-04-2025', 'DD-MM-YYYY')
      AND p2.idpedidonv IS NOT NULL
      AND p2.importado IN (1, 2, 3, 4)
)

SELECT
    MIN(p.codfilial) AS codfilial,  -- menor filial (normalmente só tem uma, mas por segurança)
    p.codusur,                      -- código do usuário (vendedor)
    u.nome,                         -- nome do usuário
    COUNT(p.importado) AS qtd,       -- quantidade de pedidos
    MIN(p.numped) AS pedido_winthor, -- primeiro número de pedido WinThor
    MIN(p.numpedrca) AS pedido_rca,  -- primeiro número de pedido RCA
    MAX(p.dtinclusao) AS data,       -- data mais recente de pedido
    MIN(p.importado) AS situacao     -- menor status de importação
FROM
    pcpedcfv p
    INNER JOIN pcusuari u ON p.codusur = u.codusur
WHERE
    p.dtinclusao BETWEEN TO_DATE('01-04-2025', 'DD-MM-YYYY') 
                    AND TO_DATE('27-04-2025', 'DD-MM-YYYY')
    AND p.idpedidonv IS NULL
    AND p.importado IN (1, 2, 3, 4)
    AND p.codusur IN (SELECT codusur FROM usuarios_filiais)  -- só usuários das filiais desejadas
    AND NOT EXISTS (                                         -- usuários que NÃO fizeram pedido via MaxPedidos
        SELECT 1
        FROM usuarios_maxpedidos um
        WHERE um.codusur = p.codusur
    )
GROUP BY
    p.codusur,
    u.nome
ORDER BY
    u.nome;
