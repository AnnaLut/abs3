

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_KF.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KF ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_KF ("KF", "NB") AS 
  select m.kf, b.nb from bars.banks$base b, bars.mv_kf m
    where m.kf=b.mfo;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_KF.sql =========*** End *** =======
PROMPT ===================================================================================== 
