
CREATE OR REPLACE VIEW v_pfu_registers_arc_error (
   arcdate,
   arcdateuser,
   id,
   receiver_mfo,
   envelope_request_id,
   date_env_crt,
   pfu_branch_name,
   file_name,
   register_date,
   env_id,
   payment_date,
   file_sum,
   file_lines_count,
   file_sum_rec,
   file_count_rec,
   payed_sum,
   payed_cnt,
   payback_sum,
   payback_cnt,
   pay_date,
   state,
   state_name,
   crt_date,
   rest,
   restdate,
   rest_2909,
   acc ,file_type )
AS
SELECT f.arcdate,
       f.arcdateuser,
           f.id,
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
                FROM   pfu_file_records r
                WHERE      r.file_id = f.id
                       AND r.state IN
                               (CASE f.state WHEN 'IN_PAY' THEN 20 ELSE 0 END)),
               0)
               file_sum_rec,
           (SELECT COUNT (1)
            FROM   pfu_file_records r
            WHERE      r.file_id = f.id
                   AND r.state =
                           (CASE f.state WHEN 'IN_PAY' THEN 20 ELSE 0 END)
                   AND SIGN IS NOT NULL)
               file_count_rec,
           (SELECT SUM (sum_pay) / 100
            FROM   pfu_file_records r
            WHERE  r.file_id = f.id AND r.state = 10)
               payed_sum,
           (SELECT COUNT (1)
            FROM   pfu_file_records r
            WHERE  r.file_id = f.id AND r.state = 10)
               payed_cnt,
           (SELECT SUM (sum_pay) / 100
            FROM   pfu_file_records r
            WHERE  r.file_id = f.id AND r.state = 40)
               payback_sum,
           (SELECT COUNT (1)
            FROM   pfu_file_records r
            WHERE  r.file_id = f.id AND r.state = 40)
               payback_cnt,
           f.pay_date,
           f.state,
           fs.state_name,
           f.crt_date,
           ar.rest / 100 rest,
           ar.restdate,
           (SELECT a.ostc / 100
            FROM   bars.accounts a
            WHERE  a.nls = (SELECT at2.acc_num
                            FROM   pfu_acc_trans_2909 at2
                            WHERE  at2.kf = LTRIM (er.receiver_mfo, '0')
                            AND at2.file_type = f.file_type ))
               rest_2909,
           pat.acc_num acc , f.file_type
    FROM   pfu_file_arc f
           JOIN pfu_envelope_request er
               ON er.id = f.envelope_request_id
           JOIN pfu_file_state fs
               ON fs.state = f.state
           LEFT JOIN pfu_acc_rest ar
               ON ar.fileid = f.id
           LEFT JOIN pfu_acc_trans_2560 pat
               ON pat.kf = LTRIM (er.receiver_mfo, '0')
                  and pat.file_type = f.file_type  
where f.state <> 'MATCH_SEND'
/

-- Grants for View
GRANT SELECT ON v_pfu_registers_arc_error TO bars
/
GRANT SELECT ON v_pfu_registers_arc_error TO bars_access_defrole
/
GRANT SELECT ON v_pfu_registers_arc_error TO upld
/
GRANT SELECT ON v_pfu_registers_arc_error TO barsreader_role
/

