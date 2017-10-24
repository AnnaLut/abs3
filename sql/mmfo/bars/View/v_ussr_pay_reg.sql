

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USSR_PAY_REG.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USSR_PAY_REG ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USSR_PAY_REG ("BRANCH", "DAT_B", "REF", "CFID", "ND", "SUM", "SUM2", "IDV2", "NMK") AS 
  WITH arc
        AS (SELECT *
              FROM arc_rrp
             WHERE     dat_b IS NOT NULL
                   AND dat_b >= bankdate_g - 2
                   AND dat_b < bankdate_g - 1
                   AND sos >= 5                        --and nlsa like '2906%'
                                                       --and nlsb like '2906%'
           )
   SELECT d.branch,
          a.dat_b,
          a.REF,
          '' cfid,
          d.nd,
          0 "SUM",
          a.s sum2,
          a.kv idv2,
          c.nmk
     FROM arc a,
          dpt_payments_ext@DEPDBTSTM.GRC.UA dpe,
          dpt_deposit@DEPDBTSTM.GRC.UA d,
          customer@DEPDBTSTM.GRC.UA c
    WHERE a.REF = dpe.ext_ref AND dpe.dpt_id = d.deposit_id AND d.rnk = c.rnk
--and d.branch = '/306232/'
--and dat_b>=bankdate_g-3 and dat_b<bankdate_g-2;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USSR_PAY_REG.sql =========*** End ***
PROMPT ===================================================================================== 
