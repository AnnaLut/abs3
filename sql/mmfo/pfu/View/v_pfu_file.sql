

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_FILE.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_FILE ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_FILE ("ID", "ENVELOPE_REQUEST_ID", "PFU_ENVELOPE_ID", "FILE_NAME", "CRT_DATE_CONVERT", "PAYMENT_DATE", "FILE_NUMBER", "FILE_SUM", "FILE_LINES_COUNT", "MAIN_REQUEST_ID", "CRT_DATE", "PAY_DATE", "MATCH_DATE") AS 
  SELECT f.id,
          f.envelope_request_id,
          er.pfu_envelope_id,
          f.file_name,
          er.crt_date crt_date_convert,
          f.payment_date,
          f.file_number,
          (f.check_sum/100) as file_sum,
          f.check_lines_count as file_lines_count,
          r.parent_request_id main_request_id,
          f.crt_date,
          f.pay_date,
          f.match_date
     FROM pfu_file f
          JOIN pfu_envelope_request er ON er.id = f.envelope_request_id
          JOIN pfu_request r ON r.id = er.id;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_FILE.sql =========*** End *** ====
PROMPT ===================================================================================== 
