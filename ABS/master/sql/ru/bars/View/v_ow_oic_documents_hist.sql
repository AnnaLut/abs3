

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_OIC_DOCUMENTS_HIST.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_OIC_DOCUMENTS_HIST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_OIC_DOCUMENTS_HIST ("ID", "IDN", "NLSA", "KV", "S", "MFOB", "ID_B", "NAM_B", "NLSB", "KV2", "S2", "NAZN") AS 
  select id, idn, org_cbsnumber nlsa, bill_currency kv, bill_amount*100 s,
       dest_institution mfob, cnt_clientregnumber id_b,
       substr(cnt_clientname,1,38) nam_b,
       cnt_contractnumber nlsb, bill_currency kv2, bill_amount*100 s2,
       substr(nvl(doc_socmnt,doc_descr), 1, 160) nazn
  from ow_oic_documents_hist;

PROMPT *** Create  grants  V_OW_OIC_DOCUMENTS_HIST ***
grant SELECT                                                                 on V_OW_OIC_DOCUMENTS_HIST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_OIC_DOCUMENTS_HIST to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_OIC_DOCUMENTS_HIST.sql =========**
PROMPT ===================================================================================== 
