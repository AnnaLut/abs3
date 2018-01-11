

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OPER_OB40.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view OPER_OB40 ***

  CREATE OR REPLACE FORCE VIEW BARS.OPER_OB40 ("REF", "S", "VALUE", "VDAT") AS 
  SELECT op.REF, op.s, w.value, op.vdat
     FROM oper op, operw w
    WHERE op.vdat >= SYSDATE - 30
      AND op.ref = w.ref(+)
      AND EXISTS ( SELECT 1
                   FROM opldok o
                   WHERE op.REF = o.REF
                     AND o.acc IN ( SELECT acc
                                    FROM accounts a
                                    WHERE a.nbs LIKE '4%' ) ) 
 ;

PROMPT *** Create  grants  OPER_OB40 ***
grant SELECT                                                                 on OPER_OB40       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OPER_OB40       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OPER_OB40       to PYOD001;
grant UPDATE                                                                 on OPER_OB40       to START1;
grant SELECT                                                                 on OPER_OB40       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OPER_OB40       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OPER_OB40.sql =========*** End *** ====
PROMPT ===================================================================================== 
