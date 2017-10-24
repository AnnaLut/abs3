

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_P_L_2C.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_P_L_2C ***

  CREATE OR REPLACE FORCE VIEW BARS.V_P_L_2C ("ID", "NAME") AS 
  SELECT id, name
     FROM p_l_2c
    WHERE id IN ('0', '1', '2', '4', '9', 'A', 'B') AND delete_date IS NULL
;

PROMPT *** Create  grants  V_P_L_2C ***
grant SELECT                                                                 on V_P_L_2C        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_P_L_2C        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_P_L_2C.sql =========*** End *** =====
PROMPT ===================================================================================== 
