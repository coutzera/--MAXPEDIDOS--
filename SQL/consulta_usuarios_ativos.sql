SELECT
    US.CODFILIAL,
    F.FANTASIA,
    U.CODUSUR,
    U.LOGIN,
    US.CODSUPERVISOR,
    S.NOME AS NOME_SUPERVISOR,
    S.CODGERENTE,
    G.NOMEGERENTE AS NOME_GERENTE
FROM
    MXSPEDIDOVENDA.MXSUSUARIOS U
    INNER JOIN PCUSUARI US ON (U.CODUSUR = US.CODUSUR)
    INNER JOIN PCSUPERV S ON (US.CODSUPERVISOR = S.CODSUPERVISOR)
    INNER JOIN PCFILIAL F ON (US.CODFILIAL = F.CODIGO)
    INNER JOIN PCGERENTE G ON (S.CODGERENTE = G.CODGERENTE)
WHERE
    U.STATUS IN ('A', 'B')
    AND US.CODFILIAL IN ('05', '13', '14');




--------------------------------------------------------------------------------------


SELECT codfilial, codusur, NOME, dttermino  -- Liste todas as colunas necessárias aqui
FROM (
    SELECT codfilial, codusur, NOME, dttermino  -- Liste todas as colunas necessárias aqui
    FROM pcusuari 
    WHERE dttermino IS NULL
      AND codusur NOT IN (
          SELECT cod_cadrca 
          FROM pcsuperv 
          WHERE cod_cadrca IS NOT NULL
      )
      AND NOME NOT LIKE '%ECOMMERCE%'
      AND NOME NOT LIKE '%DIRETA%'
      AND NOME NOT LIKE '%ORFAO%'
      AND NOME NOT LIKE '%USO EXCLUSIVO%'
) usuarios_filtrados
WHERE codfilial IN ('05', '10', '13', '14')
ORDER BY codfilial;
