

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_ENVELOPE_WFILE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_ENVELOPE_WFILE ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_ENVELOPE_WFILE ("ID", "PFU_ENVELOPE_ID", "PFU_BRANCH_CODE", "PFU_BRANCH_NAME", "REGISTER_DATE", "RECEIVER_MFO", "RECEIVER_BRANCH", "CHECK_SUM", "CHECK_LINES_COUNT", "CRT_DATE", "STATE", "COUNT_FILES") AS 
  select
           id,
           pfu_envelope_id,
           pfu_branch_code,
           pfu_branch_name,
           register_date,
           receiver_mfo,
           receiver_branch,
           check_sum,
           check_lines_count,
           crt_date,
           state,
           (select count(1) from pfu_file f where er.id = f.envelope_request_id) count_files
     from pfu_envelope_request er
    where exists (select null
                    from pfu_file f
                   where er.id = f.envelope_request_id);



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_ENVELOPE_WFILE.sql =========*** En
PROMPT ===================================================================================== 
