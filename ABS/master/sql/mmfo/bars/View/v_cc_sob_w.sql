

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CC_SOB_W.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CC_SOB_W ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CC_SOB_W ("ID", "BRANCH", "ND", "FDAT", "RNK", "FIO", "ISP", "TXT", "OTM", "FREQ", "PSYS", "FACT_DATE", "DIFF_DAYS") AS 
  SELECT cb.id,
          d.branch,
          cb.nd,
          TO_CHAR (cb.fdat, 'dd/mm/yyyy') FDAT,
          D.RNK,
          c.nmk,
          cb.isp,
          cb.txt,
          cb.otm,
          cb.freq,
          cb.psys,
          TO_CHAR (cb.fact_date, 'dd/mm/yyyy') fact_date,
          (CASE
              WHEN cb.fact_date IS NULL THEN NULL
              ELSE cb.fdat - cb.fact_date
           END)
             diff_days
     FROM cc_sob cb, cc_deal d, customer c
    WHERE     cb.nd = d.nd
          AND d.vidd IN (1, 2, 3, 11, 12, 13)
          AND d.sos < 14
          AND d.rnk = c.rnk
          AND cb.psys >= 1
          AND (cb.otm < 6 OR cb.otm = 6 AND cb.fdat > gl.bd - 30)
          AND d.branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask');

PROMPT *** Create  grants  V_CC_SOB_W ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_CC_SOB_W      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_CC_SOB_W      to RCC_DEAL;
grant FLASHBACK,SELECT                                                       on V_CC_SOB_W      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CC_SOB_W.sql =========*** End *** ===
PROMPT ===================================================================================== 
