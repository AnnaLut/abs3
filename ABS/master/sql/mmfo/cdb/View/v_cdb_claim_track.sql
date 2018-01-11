

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/View/V_CDB_CLAIM_TRACK.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CDB_CLAIM_TRACK ***

  CREATE OR REPLACE FORCE VIEW CDB.V_CDB_CLAIM_TRACK ("CLAIM_ID", "CLAIM_STATE_ID", "CLAIM_STATE", "SYS_TIME", "TRACKING_COMMENT") AS 
  select ct.claim_id,
       ct.state claim_state_id,
       cs.enumeration_code claim_state,
       ct.sys_time,
       ct.comment_text || case when ct.stack_trace is not null then
                                    chr(13) || chr(10) || dbms_lob.substr(ct.stack_trace, 4000)
                               else null
                          end tracking_comment
from   claim_tracking ct
left join enumeration_value cs on cs.enumeration_type_id = 101 /*cdb_claim.ET_CLAIM_STATE*/ and
                                  cs.enumeration_id = ct.state;

PROMPT *** Create  grants  V_CDB_CLAIM_TRACK ***
grant SELECT                                                                 on V_CDB_CLAIM_TRACK to BARSREADER_ROLE;
grant SELECT                                                                 on V_CDB_CLAIM_TRACK to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CDB_CLAIM_TRACK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/View/V_CDB_CLAIM_TRACK.sql =========*** End *
PROMPT ===================================================================================== 
