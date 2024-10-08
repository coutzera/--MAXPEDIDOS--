SELECT
    U.CODUSUR,
    U.LOGIN,
    US.CODFILIAL,
    F.FANTASIA,
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
    AND US.CODFILIAL NOT IN ('01', '04');
