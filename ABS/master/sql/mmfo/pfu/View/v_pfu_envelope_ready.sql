

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_ENVELOPE_READY.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_ENVELOPE_READY ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_ENVELOPE_READY ("ID", "PFU_ENVELOPE_ID", "PFU_BRANCH_CODE", "PFU_BRANCH_NAME", "REGISTER_DATE", "RECEIVER_MFO", "RECEIVER_BRANCH", "RECEIVER_NAME", "CHECK_SUM", "CHECK_LINES_COUNT", "CRT_DATE", "FILES_DATA", "ECP_LIST", "PAYMENTLISTS", "STATE", "ZIP_DATA") AS 
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
          crt_date,
          files_data,
          ecp_list,
          paymentlists,
          state,
          zip_data
     FROM pfu_envelope_request
    WHERE state = 'ENVELOPE_RECEIVED' order by check_lines_count;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_ENVELOPE_READY.sql =========*** En
PROMPT ===================================================================================== 
