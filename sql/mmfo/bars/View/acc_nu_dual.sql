

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ACC_NU_DUAL.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view ACC_NU_DUAL ***

  CREATE OR REPLACE FORCE VIEW BARS.ACC_NU_DUAL ("NLS1", "NMS1", "OSTC1", "DAOS1", "DAZS1", "NLS2", "NMS2", "OSTC2", "DAOS2", "DAZS2") AS 
  SELECT a.nls nls1, SUBSTR (a.nms, 1, 20) nms1, a.ostc ostc1, a.daos daos1,
          a.dazs dazs1,
                       b.nls nls2, SUBSTR (b.nms, 1, 20) nms2, b.ostc ostc2,
          b.daos daos2, b.dazs dazs2
     FROM accounts a, accounts b, specparam_int ai, specparam_int bi
    WHERE a.nbs = b.nbs
      AND a.acc = ai.acc
      AND b.acc = bi.acc
      AND a.dazs IS NULL
      AND b.dazs IS NULL
      AND a.nls IN (SELECT nlsn
                      FROM v_ob22nu_n)
      AND b.nls IN (SELECT nlsn
                      FROM v_ob22nu_n)
      AND ai.ob22 = bi.ob22
      AND ai.p080 = bi.p080
      AND ai.r020_fa = bi.r020_fa
      AND a.nls <> b.nls
      AND a.daos<=b.daos
 ;

PROMPT *** Create  grants  ACC_NU_DUAL ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACC_NU_DUAL     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_NU_DUAL     to NALOG;
grant SELECT                                                                 on ACC_NU_DUAL     to START1;
grant FLASHBACK,SELECT                                                       on ACC_NU_DUAL     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ACC_NU_DUAL.sql =========*** End *** ==
PROMPT ===================================================================================== 
