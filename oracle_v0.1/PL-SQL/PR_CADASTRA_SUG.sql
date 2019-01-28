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

/* PROCEDURE RESPONSÁVEL PELO CADASTRO DE SUGESTÕES */

create or replace PROCEDURE CADASTRAR_SUGESTAO
(

v_cpf VARCHAR2,
v_id_sugestao IN sugestao.id_sugestao%type,
v_titulo IN sugestao.titulo%type,
v_desc IN sugestao.descricao%type,
v_status IN sugestao.status%type,
v_id_categoria IN sugestao.id_categoria%type,
v_data IN sugestao.data%type,
v_return OUT number

)

IS
v_validacao number;

BEGIN
/* A FUNÇÃO FN_LIMITE_SUGESTAO VERIFICA SE O USUÁRIO JÁ CHEGOU AO SEU LIMITE MÁXIMO DE SUGESTÕES DURANTE O DIA */
v_validacao := FN_LIMITE_SUGESTAO (v_cpf);
    IF v_validacao = 0 THEN
        v_return := 0;
        dbms_output.put_line('Atenção: Usuário inserido na BlackList');
        Raise_Application_Error (-20000, 'Limite de 3 três sugestões excedido. Usuário bloqueado temporariamente');


    ELSE
        INSERT INTO SUGESTAO (cpf, id_sugestao, titulo, descricao, status, id_categoria, data) VALUES (v_cpf, v_id_sugestao, v_titulo, v_desc, v_status, v_id_categoria, v_data);
        v_return := 1;

    END IF;
END;

--- PR C/ PARÂMETRO OUT ---
/*

DECLARE
    retorno number := 0;
BEGIN
    CADASTRAR_SUGESTAO ('123.456.789-00', SUGESTAO_SEQ.nextval, 'MAIS SEGURANÇA NA LAPA!', 'Diversos Assaltos estão ocorrendo à luz do dia! Precisamos de policiamento!', 'ABERTO',11, current_date, retorno);
END;

*/
