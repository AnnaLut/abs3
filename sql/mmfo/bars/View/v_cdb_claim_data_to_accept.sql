

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CDB_CLAIM_DATA_TO_ACCEPT.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CDB_CLAIM_DATA_TO_ACCEPT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CDB_CLAIM_DATA_TO_ACCEPT ("ID", "CLAIM_TYPE_ID", "CLAIM_TYPE", "CLAIM_ID", "DEAL_NUMBER", "LENDER_CODE", "BORROWER_CODE", "START_DATE", "END_DATE", "AMOUNT", "CURRENCY_ID", "INTEREST_RATE_DATE", "INTEREST_RATE", "END_DATE_FLAG", "AMOUNT_FLAG", "INTEREST_DATE_FLAG", "INTEREST_RATE_FLAG", "COMMENT_TEXT") AS 
  select "ID","CLAIM_TYPE_ID","CLAIM_TYPE","CLAIM_ID","DEAL_NUMBER","LENDER_CODE","BORROWER_CODE","START_DATE","END_DATE","AMOUNT","CURRENCY_ID","INTEREST_RATE_DATE","INTEREST_RATE","END_DATE_FLAG","AMOUNT_FLAG","INTEREST_DATE_FLAG","INTEREST_RATE_FLAG","COMMENT_TEXT" from cdb.v_cdb_claim_data_to_accept;

PROMPT *** Create  grants  V_CDB_CLAIM_DATA_TO_ACCEPT ***
grant SELECT                                                                 on V_CDB_CLAIM_DATA_TO_ACCEPT to BARSREADER_ROLE;
grant SELECT                                                                 on V_CDB_CLAIM_DATA_TO_ACCEPT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CDB_CLAIM_DATA_TO_ACCEPT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CDB_CLAIM_DATA_TO_ACCEPT.sql ========
PROMPT ===================================================================================== 
