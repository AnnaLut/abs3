

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OPER_XOZ_ADD.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view OPER_XOZ_ADD ***

  CREATE OR REPLACE FORCE VIEW BARS.OPER_XOZ_ADD ("REC", "NLSA", "REF", "S", "RI") AS 
  SELECT rec,
          NLSA,
          REF,
          s / 100,
          ROWID RI
     FROM bars.tmp_oper
    WHERE REF = TO_NUMBER (bars.pul.Get_Mas_Ini_Val ('REFX'));

PROMPT *** Create  grants  OPER_XOZ_ADD ***
grant SELECT                                                                 on OPER_XOZ_ADD    to BARSREADER_ROLE;
grant SELECT                                                                 on OPER_XOZ_ADD    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OPER_XOZ_ADD    to START1;
grant SELECT                                                                 on OPER_XOZ_ADD    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OPER_XOZ_ADD.sql =========*** End *** =
PROMPT ===================================================================================== 
