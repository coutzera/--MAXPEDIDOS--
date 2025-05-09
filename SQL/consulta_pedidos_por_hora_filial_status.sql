-- CTE (Common Table Expression) que seleciona os usuários ativos
-- com base em determinadas filiais e que ainda não possuem data de término (usuários em atividade).
WITH usuarios_ativos AS (
    SELECT codusur
    FROM pcusuari
    WHERE codfilial IN (
        '01','02','03','04','05','06','07','08','09','10',
        '11','12','13','14','15','16','18','52','53' -- Lista de filiais consideradas
    )
    AND dttermino IS NULL -- Usuário ainda está ativo
),

-- CTE que filtra os pedidos realizados no dia 09/05/2025
-- Inclui apenas pedidos com ID novo (idpedidonv) e com status de importação entre 1 e 4
-- Além disso, considera apenas pedidos feitos por usuários ativos definidos anteriormente
pedidos_filtrados AS (
    SELECT
        p.codfilial,   -- Código da filial onde o pedido foi realizado
        p.importado    -- Status de importação do pedido
    FROM
        pcpedcfv p     -- Tabela de pedidos
    WHERE
        p.dtinclusao >= TO_DATE('09-05-2025', 'DD-MM-YYYY') -- Início do intervalo de data
        AND p.dtinclusao < TO_DATE('10-05-2025', 'DD-MM-YYYY') -- Fim do intervalo (exclusivo)
        AND p.idpedidonv IS NOT NULL -- Garante que o pedido tenha sido gerado no novo sistema
        AND p.importado IN (1, 2, 3, 4) -- Considera apenas os pedidos com status entre 1 e 4
        AND p.codusur IN (SELECT codusur FROM usuarios_ativos) -- Feito por usuário ativo
)

-- Consulta final que agrupa os pedidos por status de importação
-- e apresenta a soma de cada tipo de status
SELECT
    SYSDATE AS data_execucao, -- Data e hora da execução da query
    MIN(p.codfilial) AS codfilial, -- Código da filial (menor valor encontrado no filtro)
    -- Contadores por status de importação
    SUM(CASE WHEN p.importado = 1 THEN 1 ELSE 0 END) AS qtd_status_1,
    SUM(CASE WHEN p.importado = 2 THEN 1 ELSE 0 END) AS qtd_status_2,
    SUM(CASE WHEN p.importado = 3 THEN 1 ELSE 0 END) AS qtd_status_3,
    SUM(CASE WHEN p.importado = 4 THEN 1 ELSE 0 END) AS qtd_status_4
FROM
    pedidos_filtrados p; -- Fonte de dados já filtrada na CTE anterior
