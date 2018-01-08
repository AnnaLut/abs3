

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CDB_CLOSE_DEAL_CLAIM.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CDB_CLOSE_DEAL_CLAIM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CDB_CLOSE_DEAL_CLAIM ("ID", "DEAL_NUMBER", "CLOSE_DATE", "ALLEGRO_COMMENT", "ALLEGRO_CLAIM_ID", "SYS_TIME", "CLAIM_STATE_ID", "CLAIM_STATE") AS 
  select "ID","DEAL_NUMBER","CLOSE_DATE","ALLEGRO_COMMENT","ALLEGRO_CLAIM_ID","SYS_TIME","CLAIM_STATE_ID","CLAIM_STATE" from cdb.v_cdb_close_deal_claim;

PROMPT *** Create  grants  V_CDB_CLOSE_DEAL_CLAIM ***
grant SELECT                                                                 on V_CDB_CLOSE_DEAL_CLAIM to BARSREADER_ROLE;
grant SELECT                                                                 on V_CDB_CLOSE_DEAL_CLAIM to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CDB_CLOSE_DEAL_CLAIM to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CDB_CLOSE_DEAL_CLAIM.sql =========***
PROMPT ===================================================================================== 
