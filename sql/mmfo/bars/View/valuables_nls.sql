

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VALUABLES_NLS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view VALUABLES_NLS ***

  CREATE OR REPLACE FORCE VIEW BARS.VALUABLES_NLS ("OB22", "BRANCH", "NLS_9819", "NLS_9812", "NLS_9899", "NLS_9899SPL", "NLS_2905", "NLS_2805") AS 
  SELECT /*+ ordered index(a) */
    ob22, CASH_SXO.BC,
                   SUBSTR (nbs_ob22_bra  (SUBSTR (ob22,1,4),SUBSTR(ob22,5,2), CASH_SXO.BC ), 1, 15) nls_9819,
                   SUBSTR (nbs_ob22_bra  (      '9812',            ob22_spl , CASH_SXO.BC ), 1, 15) nls_9812,
                   SUBSTR (nbs_ob22_null (
                DECODE(SUBSTR(ob22,1,4),'9810', '9899',
                                        '9812', '9899',
                                        '9819', '9899',
                                        '9820', '9891',
                                        '9821', '9893',
                                                   ''),            ob22_dor , CASH_SXO.BS ), 1, 15) nls_9899,
                   SUBSTR (nbs_ob22_null(
                DECODE(SUBSTR(ob22,1,4),'9819', '9899', ''),       ob22_dors, CASH_SXO.BS ), 1, 15) nls_9899spl,
                   SUBSTR (nbs_ob22_null (      '2905',            ob22_205 , CASH_SXO.BC ), 1, 15) nls_2905,
                   SUBSTR (nbs_ob22_null (      '2805',            ob22_205 , CASH_SXO.BC ), 1, 15) nls_2805
     FROM valuables;

PROMPT *** Create  grants  VALUABLES_NLS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VALUABLES_NLS   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on VALUABLES_NLS   to PYOD001;
grant SELECT                                                                 on VALUABLES_NLS   to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VALUABLES_NLS   to WR_ALL_RIGHTS;
grant SELECT                                                                 on VALUABLES_NLS   to WR_DOC_INPUT;
grant FLASHBACK,SELECT                                                       on VALUABLES_NLS   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VALUABLES_NLS.sql =========*** End *** 
PROMPT ===================================================================================== 
