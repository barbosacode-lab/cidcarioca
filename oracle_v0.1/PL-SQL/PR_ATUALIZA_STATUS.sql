/*

# # # # # # # # # # # # # # # # # # # # # # # #
#          ===  CIDCARIOCA v0.1 ===           #
#                                             #
#      .: BANCO DE DADOS ORACLE 2018/2019 :.  #
#                                             #
#  -----------------------------------------  #
#    ->  DESENVOLVIDO POR LEANDRO BARBOSA     #
#                                             #
# # # # # # # # # # # # # # # # # # # # # # # #

*/

/* PROCEDURE RESPONSÁVEL PELA CLASSIFICAÇÃO AUTOMÁTICA DAS SUGESTÕES DE ACORDO COM O SENTIMENTO (POSITIVO E NEGATIVO) DOS USUÁRIOS */

create or replace procedure PR_ATUALIZA_STATUS
IS
	cursor cmetricas is
    SELECT s.status, s.id_sugestao, m.positivo, m.negativo FROM sugestao s
    INNER JOIN metricas m ON s.id_sugestao = m.id_sugestao;

BEGIN
	for x in cmetricas loop
    IF x.positivo > 100 then
		update sugestao set status = 'APROVADO'
        where sugestao.id_sugestao = x.id_sugestao;
    elsif x.negativo > 100 then
        update sugestao set status = 'REPROVADO'
        where sugestao.id_sugestao = x.id_sugestao;
    else
		update sugestao set status = 'EM ANALISE'
        where sugestao.id_sugestao = x.id_sugestao;
	   end if;
	end loop;

EXCEPTION
  When others then
    DBMS_OUTPUT.PUT_LINE('OCORREU UM ERRO! POR FAVOR TENTE MAIS TARDE');
END;
