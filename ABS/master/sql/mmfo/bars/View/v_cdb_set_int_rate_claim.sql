

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CDB_SET_INT_RATE_CLAIM.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CDB_SET_INT_RATE_CLAIM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CDB_SET_INT_RATE_CLAIM ("ID", "DEAL_NUMBER", "INTEREST_RATE_DATE", "INTEREST_RATE", "ALLEGRO_COMMENT", "ALLEGRO_CLAIM_ID", "SYS_TIME", "CLAIM_STATE_ID", "CLAIM_STATE") AS 
  select "ID","DEAL_NUMBER","INTEREST_RATE_DATE","INTEREST_RATE","ALLEGRO_COMMENT","ALLEGRO_CLAIM_ID","SYS_TIME","CLAIM_STATE_ID","CLAIM_STATE" from cdb.v_cdb_set_int_rate_claim;

PROMPT *** Create  grants  V_CDB_SET_INT_RATE_CLAIM ***
grant SELECT                                                                 on V_CDB_SET_INT_RATE_CLAIM to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CDB_SET_INT_RATE_CLAIM.sql =========*
PROMPT ===================================================================================== 
