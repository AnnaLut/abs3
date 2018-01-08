
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/sys_plsql_71650_249_1.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.SYS_PLSQL_71650_249_1 as object (BRANCH VARCHAR2(30),
DOCID NUMBER,
REF NUMBER,
STMT NUMBER,
FDAT DATE,
USERID NUMBER,
NEED_SIGN CHAR(1),
NEED_TRANSFER CHAR(1),
MFOA VARCHAR2(12),
NLSA VARCHAR2(15),
MFOB VARCHAR2(12),
NLSB VARCHAR2(15),
DK NUMBER(1),
S NUMBER,
VOB NUMBER(2),
ND VARCHAR2(10),
KV NUMBER(3),
DATD DATE,
DATP DATE,
NAM_A VARCHAR2(38),
NAM_B VARCHAR2(38),
NAZN VARCHAR2(160),
D_REC VARCHAR2(60),
NAZNK VARCHAR2(3),
NAZNS VARCHAR2(2),
ID_A VARCHAR2(14),
ID_B VARCHAR2(14),
REF_A NUMBER(9),
ID_O VARCHAR2(6),
BIS NUMBER(2),
RESERVED VARCHAR2(8),
SIGN RAW(128),
SIGN_TIME DATE,
TT CHAR(3));
/

 show err;
 
PROMPT *** Create  grants  SYS_PLSQL_71650_249_1 ***
grant EXECUTE                                                                on SYS_PLSQL_71650_249_1 to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/sys_plsql_71650_249_1.sql =========*** 
 PROMPT ===================================================================================== 
 