

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/View/V_CDB_TRANSACTION_TRACK.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CDB_TRANSACTION_TRACK ***

  CREATE OR REPLACE FORCE VIEW CDB.V_CDB_TRANSACTION_TRACK ("TRANSACTION_ID", "TRANSACTION_STATE_ID", "CLAIM_STATE", "SYS_TIME", "TRACKING_COMMENT") AS 
  select tt.transaction_id,
       tt.state transaction_state_id,
       ts.enumeration_code claim_state,
       tt.sys_time,
       tt.error_message tracking_comment
from   transaction_tracking tt
left join enumeration_value ts on ts.enumeration_type_id = 401 /*cdb_bars_client.ET_TRANSACTION_STATE*/ and
                                  ts.enumeration_id = tt.state;

PROMPT *** Create  grants  V_CDB_TRANSACTION_TRACK ***
grant SELECT                                                                 on V_CDB_TRANSACTION_TRACK to BARSREADER_ROLE;
grant SELECT                                                                 on V_CDB_TRANSACTION_TRACK to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CDB_TRANSACTION_TRACK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/View/V_CDB_TRANSACTION_TRACK.sql =========***
PROMPT ===================================================================================== 
