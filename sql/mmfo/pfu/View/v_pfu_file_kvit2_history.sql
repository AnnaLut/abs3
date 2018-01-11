

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_FILE_KVIT2_HISTORY.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_FILE_KVIT2_HISTORY ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_FILE_KVIT2_HISTORY ("ID", "ENVELOPE_REQUEST_ID", "CHECK_SUM", "CHECK_LINES_COUNT", "PAYMENT_DATE", "FILE_NUMBER", "FILE_NAME", "FILE_DATA", "STATE", "STATE_NAME", "CRT_DATE", "DATA_SIGN", "USERID", "PAY_DATE", "MATCH_DATE") AS 
  SELECT pf."ID",
          pf."ENVELOPE_REQUEST_ID",
          pf."CHECK_SUM",
          pf."CHECK_LINES_COUNT",
          pf."PAYMENT_DATE",
          pf."FILE_NUMBER",
          pf."FILE_NAME",
          pf."FILE_DATA",
          pf."STATE",
          (select pfs.state_name
             from pfu.pfu_file_state pfs
            where pfs.state = pf.state) "STATE_NAME",
          pf."CRT_DATE",
          pf."DATA_SIGN",
          pf."USERID",
          pf."PAY_DATE",
          pf."MATCH_DATE"
     FROM pfu.pfu_file pf
    WHERE pf.state = 'MATCH_SEND';



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_FILE_KVIT2_HISTORY.sql =========**
PROMPT ===================================================================================== 
