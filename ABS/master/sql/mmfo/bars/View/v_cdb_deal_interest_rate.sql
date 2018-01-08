

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CDB_DEAL_INTEREST_RATE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CDB_DEAL_INTEREST_RATE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CDB_DEAL_INTEREST_RATE ("DEAL_ID", "DEAL_NUMBER", "RATE_KIND_ID", "RATE_KIND", "START_DATE", "INTEREST_RATE") AS 
  select "DEAL_ID","DEAL_NUMBER","RATE_KIND_ID","RATE_KIND","START_DATE","INTEREST_RATE" from cdb.v_cdb_deal_interest_rate;

PROMPT *** Create  grants  V_CDB_DEAL_INTEREST_RATE ***
grant SELECT                                                                 on V_CDB_DEAL_INTEREST_RATE to BARSREADER_ROLE;
grant SELECT                                                                 on V_CDB_DEAL_INTEREST_RATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CDB_DEAL_INTEREST_RATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CDB_DEAL_INTEREST_RATE.sql =========*
PROMPT ===================================================================================== 
