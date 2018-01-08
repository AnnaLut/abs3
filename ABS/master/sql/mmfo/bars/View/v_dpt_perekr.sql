

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_PEREKR.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_PEREKR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_PEREKR ("DPT_ID", "VIDD", "DAT_BEGIN", "DAT_END", "RNK", "DPT_D", "MFO_D", "NLS_D", "NMS_D", "ACC_D") AS 
  SELECT deposit_id, vidd, dat_begin, dat_end, rnk, dpt_d, mfo_d, nls_d, nms_d, acc_d
  FROM dpt_deposit
 WHERE nls_d IS NOT NULL;

PROMPT *** Create  grants  V_DPT_PEREKR ***
grant SELECT                                                                 on V_DPT_PEREKR    to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_PEREKR    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_PEREKR    to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DPT_PEREKR    to VKLAD;
grant FLASHBACK,SELECT                                                       on V_DPT_PEREKR    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_PEREKR.sql =========*** End *** =
PROMPT ===================================================================================== 
