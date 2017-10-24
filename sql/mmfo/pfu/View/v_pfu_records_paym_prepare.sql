

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_RECORDS_PAYM_PREPARE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_RECORDS_PAYM_PREPARE ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_RECORDS_PAYM_PREPARE ("ID", "FILE_ID", "PFU_ENVELOPE_ID", "MFO", "FILE_NUMBER", "PAYMENT_DATE", "REC_ID", "NUM_ACC", "CODE_VKL", "SUM_PAY", "FULL_NAME", "NUMIDENT", "DATE_ENR", "STATE", "STATE_NAME", "REF", "ERR_MESSAGE", "ERR_MESS_TRACE", "SYS_DATE", "DATE_INCOME") AS 
  select
   r.id,
   r.file_id,
   r.pfu_envelope_id,
   r.mfo,
   r.file_number,
   r.payment_date,
   r.rec_id,
   r.num_acc,
   r.code_vkl,
   r.sum_pay,
   r.full_name,
   r.numident,
   r.date_enr,
   r.state,
   (select state_name from PFU_RECORD_STATE s where s.state = r.state) state_name,
   r.ref,
   r.err_message,
   r.err_mess_trace,
   r.sys_date,
   r.date_income
 from pfu_file_records r
where r.state = 0;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_RECORDS_PAYM_PREPARE.sql =========
PROMPT ===================================================================================== 
