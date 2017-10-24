

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DWH_PAR.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DWH_PAR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DWH_PAR ("GROUP_PAR", "PARAM", "PARAM_VAL", "DESC_VAL", "KF") AS 
  SELECT g.group_name AS group_par,
            p.param AS param,
            SUBSTR (p.VALUE, 1, 253) AS param_val,
            SUBSTR (p.descript, 1, 253) AS desc_val,
            p.kf as KF
       FROM barsupl.upl_params p, barsupl.upl_param_groups g
      WHERE p.GROUP_ID = g.GROUP_ID AND NVL (g.issystem, 0) = 0
   ORDER BY g.GROUP_ID;

PROMPT *** Create  grants  V_DWH_PAR ***
grant SELECT                                                                 on V_DWH_PAR       to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DWH_PAR.sql =========*** End *** ====
PROMPT ===================================================================================== 
