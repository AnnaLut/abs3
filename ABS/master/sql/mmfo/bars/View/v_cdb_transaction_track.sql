

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CDB_TRANSACTION_TRACK.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CDB_TRANSACTION_TRACK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CDB_TRANSACTION_TRACK ("TRANSACTION_ID", "TRANSACTION_STATE_ID", "CLAIM_STATE", "SYS_TIME", "TRACKING_COMMENT") AS 
  select "TRANSACTION_ID","TRANSACTION_STATE_ID","CLAIM_STATE","SYS_TIME","TRACKING_COMMENT" from cdb.v_cdb_transaction_track;

PROMPT *** Create  grants  V_CDB_TRANSACTION_TRACK ***
grant SELECT                                                                 on V_CDB_TRANSACTION_TRACK to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CDB_TRANSACTION_TRACK.sql =========**
PROMPT ===================================================================================== 
