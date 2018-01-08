

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_KL_S180.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KL_S180 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_KL_S180 ("S180", "TXT", "DATA_C") AS 
  SELECT s180, txt,DATA_C from kl_s180
   union all
select '*','Ћюбий термiн',to_date(null) from dual 
 ;

PROMPT *** Create  grants  V_KL_S180 ***
grant SELECT                                                                 on V_KL_S180       to BARSREADER_ROLE;
grant SELECT                                                                 on V_KL_S180       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_KL_S180       to SALGL;
grant SELECT                                                                 on V_KL_S180       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_KL_S180       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_KL_S180.sql =========*** End *** ====
PROMPT ===================================================================================== 
