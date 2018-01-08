

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CDB_CHANGE_AMOUNT_CLAIM.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CDB_CHANGE_AMOUNT_CLAIM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CDB_CHANGE_AMOUNT_CLAIM ("ID", "DEAL_NUMBER", "NEW_DEAL_AMOUNT", "ALLEGRO_COMMENT", "ALLEGRO_CLAIM_ID", "SYS_TIME", "CLAIM_STATE_ID", "CLAIM_STATE") AS 
  select "ID","DEAL_NUMBER","NEW_DEAL_AMOUNT","ALLEGRO_COMMENT","ALLEGRO_CLAIM_ID","SYS_TIME","CLAIM_STATE_ID","CLAIM_STATE" from cdb.v_cdb_change_amount_claim;

PROMPT *** Create  grants  V_CDB_CHANGE_AMOUNT_CLAIM ***
grant SELECT                                                                 on V_CDB_CHANGE_AMOUNT_CLAIM to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CDB_CHANGE_AMOUNT_CLAIM.sql =========
PROMPT ===================================================================================== 
