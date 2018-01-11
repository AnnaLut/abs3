

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_OIC_ATRANSFERS_HIST.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_OIC_ATRANSFERS_HIST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_OIC_ATRANSFERS_HIST ("ID", "IDN", "SYNTHCODE", "DOC_DRN", "DOC_ORN", "DK", "NLSA", "S", "KV", "NLSB", "S2", "KV2", "NAZN", "REF") AS 
  select a.id, a.idn, a.anl_synthcode, a.doc_drn, a.doc_orn, w.dk,
       a.debit_anlaccount, a.debit_amount*100, a.debit_currency,
       a.credit_anlaccount, a.credit_amount*100, a.credit_currency,
       substr(a.anl_trndescr,1,160), a.ref
  from ow_oic_atransfers_hist a, ow_msgcode w
 where a.anl_synthcode = w.synthcode(+);

PROMPT *** Create  grants  V_OW_OIC_ATRANSFERS_HIST ***
grant SELECT                                                                 on V_OW_OIC_ATRANSFERS_HIST to BARSREADER_ROLE;
grant SELECT                                                                 on V_OW_OIC_ATRANSFERS_HIST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_OIC_ATRANSFERS_HIST to OW;
grant SELECT                                                                 on V_OW_OIC_ATRANSFERS_HIST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_OIC_ATRANSFERS_HIST.sql =========*
PROMPT ===================================================================================== 
