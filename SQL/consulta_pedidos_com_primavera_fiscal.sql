-- Consulta que retorna pedidos de clientes com benefício fiscal do tipo 'NRPA',
-- relacionando os produtos com origem de preço que tenham o percentual de benefício aplicado.

SELECT
    c.codemitente AS sistema,          -- Código do sistema emissor do pedido
    p.*,                               -- Todos os campos da tabela de itens do pedido (pcpedi)
    op.origempreco,                    -- Origem do preço aplicada ao item
    op.percacrescbenffis AS perc_beneficio, -- Percentual de acréscimo de benefício fiscal
    op.data AS data_origem_preco       -- Data de aplicação da origem do preço
FROM
    pcpedi p                           -- Tabela de itens do pedido
    INNER JOIN pcpedc c ON p.numped = c.numped -- Cabeçalho do pedido, vinculando pelo número do pedido
    INNER JOIN pcclient cli ON p.codcli = cli.codcli -- Dados do cliente do pedido
    INNER JOIN pcorigempreco op ON     -- Tabela que define a origem do preço dos itens
        p.numped = op.numped           -- Mesma nota/pedido
        AND p.codprod = op.codprod     -- Mesmo produto
        AND op.codfilial = '02'        -- Filial específica
        AND op.percacrescbenffis = 6   -- Apenas pedidos com percentual de benefício fiscal = 6%
        AND op.data BETWEEN TRUNC(SYSDATE) - 7 AND TRUNC(SYSDATE) -- Últimos 7 dias
WHERE
    cli.tipoempresa = 'NRPA'          -- Apenas clientes do tipo NRPA (com benefício fiscal)
    AND cli.codfilialnf = '02'        -- Filial de nota fiscal do cliente
    AND p.data BETWEEN TRUNC(SYSDATE) - 7 AND TRUNC(SYSDATE) -- Data do item do pedido nos últimos 7 dias
--    AND p.codusur = 19               -- (Opcional) Filtro por código do usuário
--    AND p.codprod = 688              -- (Opcional) Filtro por código do produto
--    AND p.numped IN (19020114, 19019922) -- (Opcional) Filtro por número do pedido
ORDER BY
    p.numped;                         -- Ordena o resultado pelo número do pedido