

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CDB_NEW_DEAL_CLAIM.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CDB_NEW_DEAL_CLAIM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CDB_NEW_DEAL_CLAIM ("ID", "DEAL_NUMBER", "OPEN_DATE", "EXPIRY_DATE", "LENDER_CODE", "LENDER_NAME", "BORROWER_CODE", "BORROWER_NAME", "AMOUNT", "CURRENCY_ID", "INTEREST_RATE", "INTEREST_CALENDAR_ID", "INTEREST_CALENDAR", "ALLEGRO_COMMENT", "ALLEGRO_CLAIM_ID", "SYS_TIME", "CLAIM_STATE_ID", "CLAIM_STATE") AS 
  select "ID","DEAL_NUMBER","OPEN_DATE","EXPIRY_DATE","LENDER_CODE","LENDER_NAME","BORROWER_CODE","BORROWER_NAME","AMOUNT","CURRENCY_ID","INTEREST_RATE","INTEREST_CALENDAR_ID","INTEREST_CALENDAR","ALLEGRO_COMMENT","ALLEGRO_CLAIM_ID","SYS_TIME","CLAIM_STATE_ID","CLAIM_STATE" from cdb.v_cdb_new_deal_claim;

PROMPT *** Create  grants  V_CDB_NEW_DEAL_CLAIM ***
grant SELECT                                                                 on V_CDB_NEW_DEAL_CLAIM to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CDB_NEW_DEAL_CLAIM.sql =========*** E
PROMPT ===================================================================================== 
