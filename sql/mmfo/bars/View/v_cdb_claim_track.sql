

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CDB_CLAIM_TRACK.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CDB_CLAIM_TRACK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CDB_CLAIM_TRACK ("CLAIM_ID", "CLAIM_STATE_ID", "CLAIM_STATE", "SYS_TIME", "TRACKING_COMMENT") AS 
  select "CLAIM_ID","CLAIM_STATE_ID","CLAIM_STATE","SYS_TIME","TRACKING_COMMENT" from cdb.v_cdb_claim_track;

PROMPT *** Create  grants  V_CDB_CLAIM_TRACK ***
grant SELECT                                                                 on V_CDB_CLAIM_TRACK to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CDB_CLAIM_TRACK.sql =========*** End 
PROMPT ===================================================================================== 
