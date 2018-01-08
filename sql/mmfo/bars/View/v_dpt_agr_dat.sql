

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_AGR_DAT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_AGR_DAT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_AGR_DAT ("DPT_ID", "ND", "BRANCH", "RNK", "NMK", "OKPO", "AGRMNT_ID", "AGRMNT_NUM", "AGRMNT_DATE", "DATE_BEGIN", "DATE_END") AS 
  select da.DPT_ID, d.ND, d.BRANCH, c.RNK, c.NMK,  c.OKPO,
       da.AGRMNT_ID   , da.AGRMNT_NUM  ,
       to_char(da.AGRMNT_DATE,'dd/mm/yyyy') AGRMNT_DATE,
       to_char(da.DATE_BEGIN ,'dd/mm/yyyy') DATE_BEGIN,
       to_char(da.DATE_END   ,'dd/mm/yyyy') DATE_END
  from dpt_agreements da,       dpt_deposit d,    customer c
 where da.agrmnt_type=12   and da.dpt_id=d.deposit_id  and d.rnk=c.rnk
   and (da.date_begin is null OR da.date_end is null)
   and d.branch like sys_context('bars_context','user_branch')||'%' 
 ;

PROMPT *** Create  grants  V_DPT_AGR_DAT ***
grant SELECT                                                                 on V_DPT_AGR_DAT   to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on V_DPT_AGR_DAT   to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_DPT_AGR_DAT   to DPT_ROLE;
grant SELECT                                                                 on V_DPT_AGR_DAT   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_AGR_DAT.sql =========*** End *** 
PROMPT ===================================================================================== 
