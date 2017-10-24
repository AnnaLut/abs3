

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_KF_PARAMS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KF_PARAMS ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_KF_PARAMS ("KF", "PAR", "VAL", "COMM") AS 
  select kf, par, val, comm
    from bars.params$base;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_KF_PARAMS.sql =========*** End *** 
PROMPT ===================================================================================== 
