

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_RECORDS_FOR_PAY.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_RECORDS_FOR_PAY ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_RECORDS_FOR_PAY ("ID", "FILE_ID", "PFU_ENVELOPE_ID", "MFO", "FILE_NUMBER", "PAYMENT_DATE", "REC_ID", "NUM_ACC", "NUM_FILIA", "CODE_VKL", "SUM_PAY", "FULL_NAME", "NUMIDENT", "DATE_ENR", "STATE", "REF", "SIGN", "FULL_REC", "ERR_MESSAGE", "ERR_MESS_TRACE", "SYS_DATE", "DATE_INCOME", "EBP_NMK", "STATE_NAME", "REC_BUFF", "HEX_BUFF") AS 
  select r."ID",r."FILE_ID",r."PFU_ENVELOPE_ID",r."MFO",r."FILE_NUMBER",r."PAYMENT_DATE",r."REC_ID",r."NUM_ACC",r."NUM_FILIA",r."CODE_VKL",r."SUM_PAY",r."FULL_NAME",r."NUMIDENT",r."DATE_ENR",r."STATE",r."REF",r."SIGN",r."FULL_REC",r."ERR_MESSAGE",r."ERR_MESS_TRACE",r."SYS_DATE",r."DATE_INCOME",r."EBP_NMK", (select state_name from pfu_record_state s where s.state = r.state) state_name,
pfu_files_utl.get_record_buffer(r.id) rec_buff, rawtohex(pfu_files_utl.get_record_buffer(r.id)) hex_buff
from pfu_file_records r
where  r.state = 19;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_RECORDS_FOR_PAY.sql =========*** E
PROMPT ===================================================================================== 
