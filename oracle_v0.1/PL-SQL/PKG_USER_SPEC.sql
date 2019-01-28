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

/* CRIAÇÃO DO PACKAGE USER (ESPECIFICAÇÃO) */

create or replace PACKAGE PKG_USER IS
TYPE l_user_record IS RECORD (
     CPF             VARCHAR2(14),
     NOME            VARCHAR2(20),
     SOBRENOME       VARCHAR2(30),
     LOGIN           VARCHAR2(20),
     SENHA           VARCHAR2(12),
     CELULAR         NUMBER,
     TELEFONE        NUMBER,
     NOME_DA_MAE     VARCHAR2(50),
     DATA_NASCIMENTO DATE,
     ID_PERFIL       NUMBER(38),
     EMAIL           VARCHAR2(50)
);

SUBTYPE v_cpf IS usuario.cpf%TYPE;
FUNCTION GET_FORM
(
     v_cpf    IN usuario.cpf%Type
)

RETURN usuario%rowtype;
END PKG_USER;
