

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAPROS2.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAPROS2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAPROS2 ("NBS", "TXT") AS 
  SELECT   r020, txt
       FROM   kl_r020
      WHERE   r020 IN ('2625', '2620', '2630', '2635')
   ORDER BY   r020;

PROMPT *** Create  grants  V_ZAPROS2 ***
grant SELECT                                                                 on V_ZAPROS2       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ZAPROS2       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAPROS2.sql =========*** End *** ====
PROMPT ===================================================================================== 
