CREATE OR REPLACE FORCE VIEW BARS.OPER_XOZ_ADD
(
   REC,
   NLSA,
   REF,
   S,
   RI
)
AS
   SELECT rec,
          NLSA,
          REF,
          s / 100,
          ROWID RI
     FROM bars.tmp_oper
    WHERE REF = TO_NUMBER (bars.pul.Get_Mas_Ini_Val ('REFX'));

/