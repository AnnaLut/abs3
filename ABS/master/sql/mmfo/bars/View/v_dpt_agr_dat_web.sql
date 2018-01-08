

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_AGR_DAT_WEB.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_AGR_DAT_WEB ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_AGR_DAT_WEB ("DPT_ID", "ND", "BRANCH", "RNK", "NMK", "OKPO", "AGRMNT_ID", "AGRMNT_NUM", "AGRMNT_DATE", "DATE_BEGIN", "DATE_END") AS 
  SELECT da.DPT_ID,
          d.ND,
          d.BRANCH,
          c.RNK,
          c.NMK,
          c.OKPO,
          da.AGRMNT_ID,
          da.AGRMNT_NUM,
          da.AGRMNT_DATE,
          da.DATE_BEGIN,
          da.DATE_END
     FROM dpt_agreements da, dpt_deposit d, customer c
    WHERE     da.agrmnt_type = 12
          AND da.dpt_id = d.deposit_id
          AND d.rnk = c.rnk
          AND d.branch LIKE
                 SYS_CONTEXT ('bars_context', 'user_branch') || '%';

PROMPT *** Create  grants  V_DPT_AGR_DAT_WEB ***
grant SELECT                                                                 on V_DPT_AGR_DAT_WEB to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on V_DPT_AGR_DAT_WEB to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_DPT_AGR_DAT_WEB to DPT_ROLE;
grant SELECT                                                                 on V_DPT_AGR_DAT_WEB to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_AGR_DAT_WEB.sql =========*** End 
PROMPT ===================================================================================== 
