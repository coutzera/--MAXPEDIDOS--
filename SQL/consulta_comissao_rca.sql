select sum (comissao) from 
(
select numped, codusur, codprod, qt, pvenda, percom, (qt * pvenda) total, (qt*pvenda)*(percom/100) comissao, posicao  from pcpedi
--SELECT * from pcpedi
where 1=1
and codfilialretira = '07'
and data BETWEEN '01-10-2024' and '06-10-2024'
and codusur=1702
and posicao='F'
)