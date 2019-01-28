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

/* FUNÇÃO PARA CONSULTAR SE O USUÁRIO ENCONTRA-SE NA BLACKLIST. SE SIM, É RETORNADO O MOTIVO PELO QUAL O USUÁRIO FOI BANIDO */

create or replace function CPF_BLIST
   ( vcpf_in IN varchar2 )
   RETURN varchar2
IS
   cmotivo varchar2(100);
   naoencontrado exception;

   CURSOR c1
   IS
        SELECT motivo
        FROM black_list
        WHERE cpf = vcpf_in;

BEGIN

   OPEN c1;
   FETCH c1 INTO cmotivo;

   IF c1%notfound THEN
      RAISE naoencontrado;
   END IF;

   CLOSE c1;
RETURN cmotivo;

EXCEPTION
  WHEN naoencontrado THEN
    DBMS_OUTPUT.PUT_LINE('CPF NÃO ENCONTRADO');
END;
