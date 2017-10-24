

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_PORTFOLIO_SHORT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_PORTFOLIO_SHORT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_PORTFOLIO_SHORT ("DPT_ID", "DPT_RNK", "DPT_VIDD", "DPT_KV", "DPT_DATN", "DPT_DATK", "DPT_ND", "DPT_PENALTY") AS 
  SELECT d.deposit_id,
          d.rnk,
          d.vidd,
          d.kv,
          d.dat_begin,
          d.dat_end,
          d.nd,
          d.stop_id
     FROM dpt_deposit d;

PROMPT *** Create  grants  V_DPT_PORTFOLIO_SHORT ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_PORTFOLIO_SHORT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_PORTFOLIO_SHORT to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DPT_PORTFOLIO_SHORT to VKLAD;
grant FLASHBACK,SELECT                                                       on V_DPT_PORTFOLIO_SHORT to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_PORTFOLIO_SHORT.sql =========*** 
PROMPT ===================================================================================== 
