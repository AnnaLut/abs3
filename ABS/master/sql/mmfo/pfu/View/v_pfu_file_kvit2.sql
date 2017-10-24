

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_FILE_KVIT2.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_FILE_KVIT2 ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_FILE_KVIT2 ("ID", "ENVELOPE_REQUEST_ID", "CHECK_SUM", "CHECK_LINES_COUNT", "PAYMENT_DATE", "FILE_NUMBER", "FILE_NAME", "FILE_DATA", "STATE", "STATE_NAME", "CRT_DATE", "DATA_SIGN", "USERID") AS 
  select "ID",
       "ENVELOPE_REQUEST_ID",
       "CHECK_SUM",
       "CHECK_LINES_COUNT",
       "PAYMENT_DATE",
       "FILE_NUMBER",
       "FILE_NAME",
       "FILE_DATA",
       "STATE",
       (select fs.state_name from pfu_file_state fs where fs.state = p.state) state_name,
       "CRT_DATE",
       "DATA_SIGN",
       "USERID"
    from pfu_file p
   where state = 'PAYED';



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_FILE_KVIT2.sql =========*** End **
PROMPT ===================================================================================== 
