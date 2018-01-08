

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_PERELIK_KF.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_PERELIK_KF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_PERELIK_KF ("KF", "CODE_REG") AS 
  select m.kf, r.code code_reg
from mv_kf m, regions r
where M.KF = r.kf;

PROMPT *** Create  grants  V_NBUR_PERELIK_KF ***
grant SELECT                                                                 on V_NBUR_PERELIK_KF to BARSREADER_ROLE;
grant SELECT                                                                 on V_NBUR_PERELIK_KF to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_PERELIK_KF to RPBN002;
grant SELECT                                                                 on V_NBUR_PERELIK_KF to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_PERELIK_KF.sql =========*** End 
PROMPT ===================================================================================== 
