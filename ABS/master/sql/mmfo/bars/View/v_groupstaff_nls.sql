

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_GROUPSTAFF_NLS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_GROUPSTAFF_NLS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_GROUPSTAFF_NLS ("GROUPACC_ID", "GROUPACC_NAME", "GROUPSTAFF_ID", "GROUPSTAFF_NAME", "ACC", "NLS", "KV", "BRANCH", "KF") AS 
  SELECT ga.id groupacc_id,
          ga.name groupacc_name,
          gu.id groupstaff_id,
          gu.name groupstaff_name,
          a.acc,
          a.nls,
          a.kv,
          a.branch,
          a.kf
     FROM groups_acc ga,
          groups_staff_acc gua,
          groups gu,
          accounts a
    WHERE     gu.id = gua.idg
          AND ga.id = gua.ida
          AND sec.fit_gmask (a.sec, ga.id) > 0;

PROMPT *** Create  grants  V_GROUPSTAFF_NLS ***
grant SELECT                                                                 on V_GROUPSTAFF_NLS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_GROUPSTAFF_NLS.sql =========*** End *
PROMPT ===================================================================================== 
