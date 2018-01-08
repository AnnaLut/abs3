
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_client_requisites.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_CLIENT_REQUISITES AS OBJECT(
                       RNK NUMBER (38),
                       CUSTTYPE NUMBER (1),
                       COUNTRY NUMBER (3),
                       NMK VARCHAR2 (70 BYTE),
                       NMKV VARCHAR2 (70 BYTE),
                       NMKK VARCHAR2 (38 BYTE),
                       CODCAGENT NUMBER (1),
                       PRINSIDER NUMBER (38),
                       OKPO VARCHAR2 (14 BYTE),
                       ADR VARCHAR2 (70 BYTE),
                       C_REG NUMBER (2),
                       C_DST NUMBER (2),
                       RGTAX VARCHAR2 (30 BYTE),
                       ADM VARCHAR2 (70 BYTE),
                       DATE_ON DATE,
                       DATE_OFF DATE,
                       CRISK NUMBER (38),
                       ND VARCHAR2 (10 BYTE),
                       ISE CHAR (5 BYTE),
                       FS CHAR (2 BYTE),
                       OE CHAR (5 BYTE),
                       VED CHAR (5 BYTE),
                       SED CHAR (4 BYTE),
                       MB CHAR (1 BYTE),
                       RGADM VARCHAR2 (30 BYTE),
                       BC NUMBER (1),
                       BRANCH VARCHAR2 (30 BYTE),
                       TOBO VARCHAR2 (30 BYTE),
                       K050 CHAR (3 BYTE),
                       NREZID_CODE VARCHAR2 (20 BYTE))
/

 show err;
 
PROMPT *** Create  grants  T_CLIENT_REQUISITES ***
grant EXECUTE                                                                on T_CLIENT_REQUISITES to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_client_requisites.sql =========*** En
 PROMPT ===================================================================================== 
 