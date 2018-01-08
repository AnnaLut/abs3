

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NBU23_NLO.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view NBU23_NLO ***

  CREATE OR REPLACE FORCE VIEW BARS.NBU23_NLO ("RNK", "ND", "WDATE", "CC_ID", "VIDD", "FIN23", "OBS23", "KAT23", "K23", "TOBO") AS 
  SELECT a.RNK,
          a.acc,
          a.mdate,
          a.nls,
          TO_NUMBER (a.nbs),
          q.FIN,
          q.OBS,
          q.KAT,
          q.K,
          a.tobo
     FROM acc_nlo lo, v_gl a, ACC_FIN_OBS_KAT q
    WHERE lo.acc = a.acc AND a.acc = q.acc(+)
--   and not exists (select 1 from nd_acc where acc=a.acc)
;

PROMPT *** Create  grants  NBU23_NLO ***
grant SELECT,UPDATE                                                          on NBU23_NLO       to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on NBU23_NLO       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NBU23_NLO.sql =========*** End *** ====
PROMPT ===================================================================================== 
