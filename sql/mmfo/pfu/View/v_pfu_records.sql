

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_RECORDS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_RECORDS ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_RECORDS ("ID", "FILE_ID", "PFU_ENVELOPE_ID", "MFO", "MFO_NAME", "FILE_NUMBER", "PAYMENT_DATE", "REC_ID", "NUM_ACC", "CODE_VKL", "SUM_PAY", "FULL_NAME", "NUMIDENT", "DATE_ENR", "STATE", "STATE_NAME", "REF", "ERR_MESSAGE", "ERR_MESS_TRACE", "SYS_DATE", "DATE_PAYBACK", "NUM_PAYM") AS 
  select
   r.id,
   r.file_id,
   r.pfu_envelope_id,
   r.mfo,
   (select sp.name from pfu_syncru_params sp where sp.kf = r.mfo) mfo_name,
   r.file_number,
   r.payment_date,
   r.rec_id,
   ltrim(r.num_acc,'0') num_acc,
   r.code_vkl,
   r.sum_pay / 100 sum_pay ,
   translate(r.full_name,'¡°¯','²¯ª') full_name,
   r.numident,
   r.date_enr,
   r.state,
   (select rs.state_name from pfu_record_state rs where rs.state = r.state) state_name,
   r.ref,
   r.err_message,
   r.err_mess_trace,
   r.sys_date,
   r.date_payback,
   r.num_paym
 from pfu_file_records r;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_RECORDS.sql =========*** End *** =
PROMPT ===================================================================================== 
