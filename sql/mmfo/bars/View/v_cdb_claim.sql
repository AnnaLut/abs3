

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CDB_CLAIM.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CDB_CLAIM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CDB_CLAIM ("ID", "REGION_MFO", "DEAL_NUMBER", "CLAIM_TYPE_ID", "CLAIM_TYPE", "CLAIM_STATE_ID", "CLAIM_STATE", "ALLEGRO_CLAIM_ID", "LAST_TRACKING_MESSAGE", "SYS_TIME") AS 
  select "ID","REGION_MFO","DEAL_NUMBER","CLAIM_TYPE_ID","CLAIM_TYPE","CLAIM_STATE_ID","CLAIM_STATE","ALLEGRO_CLAIM_ID","LAST_TRACKING_MESSAGE","SYS_TIME" from cdb.v_cdb_claim;

PROMPT *** Create  grants  V_CDB_CLAIM ***
grant SELECT                                                                 on V_CDB_CLAIM     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CDB_CLAIM.sql =========*** End *** ==
PROMPT ===================================================================================== 
