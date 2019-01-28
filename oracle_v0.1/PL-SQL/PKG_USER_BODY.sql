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

--- CRIAÇÃO DO PACKAGE USER BODY ---
create or replace PACKAGE BODY PKG_USER IS
--- A FUNÇÃO GET_FORM É RESPONSÁVEL POR TRAZER TODOS OS DADOS DE UM USUÁRIO DO SISTEMA ---
FUNCTION get_form (

v_cpf IN usuario.cpf%Type

)

RETURN usuario%rowtype

AS
l_user_record usuario%rowtype;

BEGIN

SELECT * INTO l_user_record FROM usuario

WHERE cpf=v_cpf;

RETURN(l_user_record);

END;

END;

/* BLOCO PLSQL ANÔNIMO PARA GET_FORM 

SET SERVEROUTPUT ON
DECLARE
  rec_user usuario%ROWTYPE;
BEGIN
  rec_user := PKG_USER.GET_FORM('070.680.938-68');
DBMS_OUTPUT.PUT_LINE ('NOME: '||(rec_user.nome));
DBMS_OUTPUT.PUT_LINE ('SOBRENOME: '||(rec_user.sobrenome));
DBMS_OUTPUT.PUT_LINE ('LOGIN: '||(rec_user.login));
DBMS_OUTPUT.PUT_LINE ('NOME DA MÃE: '||(rec_user.nome_da_mae));
DBMS_OUTPUT.PUT_LINE ('E-MAIL: '||(rec_user.email));
DBMS_OUTPUT.PUT_LINE ('DATA DE NASCIMENTO: '||(rec_user.data_nascimento));
DBMS_OUTPUT.PUT_LINE ('CELULAR: '||(rec_user.celular));
END;

/*
