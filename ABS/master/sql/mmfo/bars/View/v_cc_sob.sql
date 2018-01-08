

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CC_SOB.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CC_SOB ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CC_SOB ("ID", "BRANCH", "ND", "FDAT", "FIO", "ISP", "TXT", "OTM", "FREQ", "PSYS", "FACT_DATE", "DIFF_DAYS", "VIDD", "INSP", "NMK", "CC_ID") AS 
  SELECT cb.id ,
          d.branch,
          cb.nd,
          TO_CHAR (cb.fdat, 'dd/mm/yyyy')  FDAT,
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
             diff_days,
          d.vidd,
          cb.isp insp,
          c.nmk,
          d.cc_id
     FROM cc_sob cb, cc_deal d, customer c
    WHERE     cb.nd = d.nd
          AND d.rnk = c.rnk
--          AND cb.psys >= 1
--          AND (otm < 6 OR otm = 6 AND fdat > gl.bd - 30)
          AND d.branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask');

PROMPT *** Create  grants  V_CC_SOB ***
grant SELECT                                                                 on V_CC_SOB        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_CC_SOB        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_CC_SOB        to RCC_DEAL;
grant SELECT                                                                 on V_CC_SOB        to UPLD;
grant FLASHBACK,SELECT                                                       on V_CC_SOB        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CC_SOB.sql =========*** End *** =====
PROMPT ===================================================================================== 
