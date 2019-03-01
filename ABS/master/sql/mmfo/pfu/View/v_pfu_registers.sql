

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_REGISTERS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_REGISTERS ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_REGISTERS ("ID", "RECEIVER_MFO", "ENVELOPE_REQUEST_ID", "DATE_ENV_CRT", "PFU_BRANCH_NAME", "FILE_NAME", "REGISTER_DATE", "ENV_ID", "PAYMENT_DATE", "FILE_SUM", "FILE_LINES_COUNT", "FILE_SUM_REC", "FILE_COUNT_REC", "PAYED_SUM", "PAYED_CNT", "PAYBACK_SUM", "PAYBACK_CNT", "PAY_DATE", "STATE", "STATE_NAME", "CRT_DATE", "REST", "RESTDATE", "REST_2909", "ACC", "FILE_TYPE") AS 
  SELECT f.id,
          er.receiver_mfo,
          f.envelope_request_id,
          er.crt_date date_env_crt,
          er.pfu_branch_name,
          f.file_name,
          er.register_date,
          f.envelope_request_id env_id,
          --er.pfu_envelope_id,
          --er.pfu_branch_code,
          --er.pfu_branch_name,
          --er.receiver_branch,
          f.payment_date,
          --f.file_number,
          f.check_sum / 100 AS file_sum,
          f.check_lines_count AS file_lines_count,
          NVL (
             (SELECT SUM (sum_pay) / 100
                FROM pfu_file_records r
               WHERE r.file_id = f.id
                     AND r.state IN
                            (CASE f.state WHEN 'IN_PAY' THEN 20 ELSE 0 END)),
             0)
             file_sum_rec,
          (SELECT COUNT (1)
             FROM pfu_file_records r
            WHERE r.file_id = f.id
                  AND r.state =
                         (CASE f.state WHEN 'IN_PAY' THEN 20 ELSE 0 END)
                  AND SIGN IS NOT NULL)
             file_count_rec,
          (SELECT SUM (sum_pay) / 100
             FROM pfu_file_records r
            WHERE r.file_id = f.id AND r.state = 10)
             payed_sum,
          (SELECT COUNT (1)
             FROM pfu_file_records r
            WHERE r.file_id = f.id AND r.state = 10)
             payed_cnt,
          (SELECT SUM (sum_pay) / 100
             FROM pfu_file_records r
            WHERE r.file_id = f.id AND r.state = 40)
             payback_sum,
          (SELECT COUNT (1)
             FROM pfu_file_records r
            WHERE r.file_id = f.id AND r.state = 40)
             payback_cnt,
          f.pay_date,
          f.state,
          fs.state_name,
          f.crt_date,
          ar.rest / 100 rest,
          ar.restdate,
(SELECT a.ostc / 100
             FROM bars.accounts a
            WHERE a.nls = (SELECT at2.acc_num
                             FROM pfu_acc_trans_2909 at2
                            WHERE at2.kf = LTRIM (er.receiver_mfo, '0')
                              AND at2.file_type = f.file_type))
                                  rest_2909,
          pat.acc_num acc,
          f.file_type
     FROM pfu_file f
          JOIN pfu_envelope_request er
             ON er.id = f.envelope_request_id
          JOIN pfu_file_state fs
             ON fs.state = f.state
          LEFT JOIN pfu_acc_rest ar
             ON ar.fileid = f.id
          LEFT JOIN pfu_acc_trans_2560 pat
             ON pat.kf = LTRIM (er.receiver_mfo, '0')
;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_REGISTERS.sql =========*** End ***
PROMPT ===================================================================================== 
