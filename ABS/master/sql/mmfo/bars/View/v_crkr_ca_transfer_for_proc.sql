

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CRKR_CA_TRANSFER_FOR_PROC.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CRKR_CA_TRANSFER_FOR_PROC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CRKR_CA_TRANSFER_FOR_PROC ("REG_ID", "REF_ID", "REG_DATE", "AMOUNT", "KV", "MFO_CLIENT", "NLS", "TYPE_ID", "OKPO", "SER", "DOCNUM", "FIO", "SECONDARY", "SIGN", "DATE_KEY", "STATE_ID", "LAST_CHANGE", "INFO") AS 
  select "REG_ID","REF_ID","REG_DATE","AMOUNT","KV","MFO_CLIENT","NLS","TYPE_ID","OKPO","SER","DOCNUM","FIO","SECONDARY","SIGN","DATE_KEY","STATE_ID","LAST_CHANGE","INFO" from crkr_ca_transfer
where state_id in (0/*STATE_TRANSFER_NEW*/);

PROMPT *** Create  grants  V_CRKR_CA_TRANSFER_FOR_PROC ***
grant SELECT                                                                 on V_CRKR_CA_TRANSFER_FOR_PROC to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CRKR_CA_TRANSFER_FOR_PROC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CRKR_CA_TRANSFER_FOR_PROC.sql =======
PROMPT ===================================================================================== 
