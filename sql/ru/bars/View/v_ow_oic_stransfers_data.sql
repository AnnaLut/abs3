

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_OIC_STRANSFERS_DATA.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_OIC_STRANSFERS_DATA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_OIC_STRANSFERS_DATA ("ID", "IDN", "NLSA", "S", "KV", "NLSB", "S2", "KV2", "NAZN", "ERR_TEXT") AS 
  select id, idn, debit_syntaccount, debit_amount*100, debit_currency,
       credit_syntaccount, credit_amount*100, credit_currency,
       substr(synth_trndescr,1,160), err_text
  from ow_oic_stransfers_data;

PROMPT *** Create  grants  V_OW_OIC_STRANSFERS_DATA ***
grant SELECT                                                                 on V_OW_OIC_STRANSFERS_DATA to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_OIC_STRANSFERS_DATA to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_OIC_STRANSFERS_DATA.sql =========*
PROMPT ===================================================================================== 
