

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_RECORDS_FOR_SIGN.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_RECORDS_FOR_SIGN ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_RECORDS_FOR_SIGN ("ID", "FILE_ID", "PFU_ENVELOPE_ID", "MFO", "FILE_NUMBER", "PAYMENT_DATE", "REC_ID", "NUM_ACC", "NUM_FILIA", "CODE_VKL", "SUM_PAY", "FULL_NAME", "NUMIDENT", "DATE_ENR", "STATE", "REF", "SIGN", "FULL_REC", "ERR_MESSAGE", "ERR_MESS_TRACE", "SYS_DATE", "DATE_INCOME", "EBP_NMK", "HEX_BUFF") AS 
  select r."ID",r."FILE_ID",r."PFU_ENVELOPE_ID",r."MFO",r."FILE_NUMBER",r."PAYMENT_DATE",r."REC_ID",r."NUM_ACC",r."NUM_FILIA",r."CODE_VKL",r."SUM_PAY",r."FULL_NAME",r."NUMIDENT",r."DATE_ENR",r."STATE",r."REF",r."SIGN",r."FULL_REC",r."ERR_MESSAGE",r."ERR_MESS_TRACE",r."SYS_DATE",r."DATE_INCOME",r."EBP_NMK",
	   rawtohex(r.mfo || to_char(r.payment_date, 'DD.MM.YYYY') || r.num_acc || r.num_filia || r.code_vkl || to_char(r.sum_pay) || r.full_name || r.numident || r.date_enr || r.full_rec) as hex_buff
       --pfu_files_utl.get_record_buffer(r.id) rec_buff,
       --RAWTOHEX(pfu_files_utl.get_record_buffer(r.id)) hex_buff
       from PFU_FILE_RECORDS r
where sign is null
;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_RECORDS_FOR_SIGN.sql =========*** 
PROMPT ===================================================================================== 
