

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DPT_ACC.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view DPT_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.DPT_ACC ("ACC", "DEPOSIT_ID", "VIDD", "RNK", "DATN", "DATK", "BRANCH") AS 
  SELECT distinct acc, deposit_id, vidd, rnk, dat_begin, dat_end
      ,branch
FROM dpt_deposit_clos WHERE action_id=0
 ;

PROMPT *** Create  grants  DPT_ACC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_ACC         to ABS_ADMIN;
grant SELECT                                                                 on DPT_ACC         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_ACC         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_ACC         to DPT;
grant SELECT                                                                 on DPT_ACC         to START1;
grant SELECT                                                                 on DPT_ACC         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_ACC         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DPT_ACC.sql =========*** End *** ======
PROMPT ===================================================================================== 
