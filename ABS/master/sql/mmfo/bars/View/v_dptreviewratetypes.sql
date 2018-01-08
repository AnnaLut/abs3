

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPTREVIEWRATETYPES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPTREVIEWRATETYPES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPTREVIEWRATETYPES ("VIDD", "MNTH_CNT", "DAYS_CNT") AS 
  select vidd,
       to_number(substr(val, 1, instr(val, ':')-1)) MNTH_CNT,
       to_number(substr(val, instr(val, ':')+1))    DAYS_CNT
  from dpt_vidd_params
 where tag = 'RATE_REVIEW'
 ;

PROMPT *** Create  grants  V_DPTREVIEWRATETYPES ***
grant SELECT                                                                 on V_DPTREVIEWRATETYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPTREVIEWRATETYPES to DPT_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPTREVIEWRATETYPES to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPTREVIEWRATETYPES.sql =========*** E
PROMPT ===================================================================================== 
