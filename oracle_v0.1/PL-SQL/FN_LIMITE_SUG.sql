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


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                                   #
#   ESSA FUNÇÃO LIMITA O USUÁRIO PELO CPF AO NÚMERO MÁXIMO DE                       #
#   DUAS SUGESTÕES POR DIA.                                                         #
#   CASO O USUÁRIO ULTRAPASSE ESSE LIMITE, A NOVA SUGESTÃO NÃO SERÁ CADASTRADA      #
#   E O USUÁRIO SERÁ INSERIDO NA 'BLACK_LIST'                                       #
#                                                                                   #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

*/

create or replace FUNCTION FN_LIMITE_SUGESTAO (
v_cpf_in IN VARCHAR2)
return number
IS
v_qry number;

BEGIN

v_qry := 0;

SELECT count(*) INTO v_qry
    FROM sugestao
    where trunc(data) = trunc(current_date) AND
    (cpf = v_cpf_in);
    IF v_qry >= 3 THEN
        INSERT INTO BLACK_LIST (ID_BLIST, MOTIVO, CPF) VALUES (BLACKLIST_SEQ.nextval, 'SPAM', v_cpf_in);
        COMMIT;
        RETURN 0;

    ELSE
        RETURN 1;
       -- Raise_Application_Error (-20343, 'Limite de 3 três sugestões excedido. Usuário bloqueado temporariamente');
    END IF;

END;
