

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OPER_SK_1.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view OPER_SK_1 ***

  CREATE OR REPLACE FORCE VIEW BARS.OPER_SK_1 ("REF", "S", "SK", "VDAT") AS 
  SELECT REF, s, sk, vdat
     FROM oper
    WHERE sk IS NOT NULL AND vdat >= SYSDATE - 35 
 ;

PROMPT *** Create  grants  OPER_SK_1 ***
grant SELECT                                                                 on OPER_SK_1       to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on OPER_SK_1       to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on OPER_SK_1       to PYOD001;
grant UPDATE                                                                 on OPER_SK_1       to START1;
grant SELECT                                                                 on OPER_SK_1       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OPER_SK_1       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OPER_SK_1.sql =========*** End *** ====
PROMPT ===================================================================================== 
