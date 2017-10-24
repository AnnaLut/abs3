

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_ENVELOPE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_ENVELOPE ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_ENVELOPE ("ID", "PFU_ENVELOPE_ID", "PFU_BRANCH_CODE", "PFU_BRANCH_NAME", "REGISTER_DATE", "RECEIVER_MFO", "RECEIVER_BRANCH", "RECEIVER_NAME", "CHECK_SUM", "CHECK_LINES_COUNT", "STATE") AS 
  SELECT id,
          pfu_envelope_id,
          pfu_branch_code,
          pfu_branch_name,
          register_date,
          receiver_mfo,
          receiver_branch,
          receiver_name,
          check_sum,
          check_lines_count,
          crt_date state
     FROM pfu_envelope_request;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_ENVELOPE.sql =========*** End *** 
PROMPT ===================================================================================== 
