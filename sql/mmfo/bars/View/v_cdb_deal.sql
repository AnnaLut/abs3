

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CDB_DEAL.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CDB_DEAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CDB_DEAL ("ID", "DEAL_NUMBER", "LENDER_MFO", "LENDER_NAME", "BORROWER_MFO", "BORROWER_NAME", "OPEN_DATE", "EXPIRY_DATE", "CLOSE_DATE", "AMOUNT", "CURRENCY_ID", "INTEREST_RATE", "INTEREST_CALENDAR_ID", "INTEREST_CALENDAR") AS 
  select "ID","DEAL_NUMBER","LENDER_MFO","LENDER_NAME","BORROWER_MFO","BORROWER_NAME","OPEN_DATE","EXPIRY_DATE","CLOSE_DATE","AMOUNT","CURRENCY_ID","INTEREST_RATE","INTEREST_CALENDAR_ID","INTEREST_CALENDAR" from cdb.v_cdb_deal;

PROMPT *** Create  grants  V_CDB_DEAL ***
grant SELECT                                                                 on V_CDB_DEAL      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CDB_DEAL.sql =========*** End *** ===
PROMPT ===================================================================================== 
