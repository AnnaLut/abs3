

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_EPP_LINE_ALL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_EPP_LINE_ALL ***

  CREATE OR REPLACE FORCE VIEW PFU.V_EPP_LINE_ALL ("ID", "BATCH_REQUEST_ID", "BATCH_DATE", "LINE_ID", "EPP_NUMBER", "EPP_EXPIRY_DATE", "RNK", "LAST_NAME", "FIRST_NAME", "MIDDLE_NAME", "DATE_OF_BIRTH", "PHONE_NUMBERS", "TAX_REGISTRATION_NUMBER", "DOCUMENT_TYPE", "DOCUMENT_ID", "DOCUMENT_ISSUE_DATE", "DOCUMENT_ISSUER", "BANK_MFO", "BRANCH", "ACCOUNT_NUMBER", "STATE_ID", "STATE_NAME", "ACTIVATION_DATE", "DESTRUCTION_DATE", "BLOCK_DATE", "UNBLOCK_DATE", "PENS_TYPE", "TYPE_CARD", "TERM_CARD") AS 
  select el.ID,
        el.BATCH_REQUEST_ID,
        ebr.BATCH_DATE,
        el.LINE_ID,
        el.EPP_NUMBER,
        el.EPP_EXPIRY_DATE,
        el.RNK,
        el.LAST_NAME,
        el.FIRST_NAME,
        el.MIDDLE_NAME,
        el.DATE_OF_BIRTH,
        el.PHONE_NUMBERS,
        el.TAX_REGISTRATION_NUMBER,
        el.DOCUMENT_TYPE,
        el.DOCUMENT_ID,
        el.DOCUMENT_ISSUE_DATE,
        el.DOCUMENT_ISSUER,
        el.BANK_MFO,
        el.BRANCH,
        el.ACCOUNT_NUMBER,
        el.STATE_ID,
        (select els.name from pfu_epp_line_state els where els.id = el.state_id) state_name,
        el.ACTIVATION_DATE,
        el.DESTRUCTION_DATE,
        el.BLOCK_DATE,
        el.UNBLOCK_DATE,
        el.PENS_TYPE,
        el.TYPE_CARD,
        el.TERM_CARD
   from pfu_epp_line el
   join pfu_epp_batch_request ebr on ebr.id = el.batch_request_id;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_EPP_LINE_ALL.sql =========*** End *** 
PROMPT ===================================================================================== 
