

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/View/V_CDB_CLAIM.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CDB_CLAIM ***

  CREATE OR REPLACE FORCE VIEW CDB.V_CDB_CLAIM ("ID", "REGION_MFO", "DEAL_NUMBER", "CLAIM_TYPE_ID", "CLAIM_TYPE", "CLAIM_STATE_ID", "CLAIM_STATE", "ALLEGRO_CLAIM_ID", "LAST_TRACKING_MESSAGE", "SYS_TIME") AS 
  select c.id,
       cdb_claim.get_claim_region_code(c.id, c.claim_type_id) region_mfo,
       cdb_claim.get_claim_deal_number(c.id, c.claim_type_id) deal_number,
       c.claim_type_id,
       ctp.enumeration_name claim_type,
       c.state claim_state_id,
       cs.enumeration_code claim_state,
       ce.external_id allegro_claim_id,
       (select ctt.comment_text || case when ctt.stack_trace is not null then
                                             chr(13) || chr(10) || dbms_lob.substr(ctt.stack_trace, 4000)
                                        else null
                                   end
        from   claim_tracking ctt
        where  ctt.rowid = (select min(ct.rowid) keep (dense_rank last order by ct.id)
                            from   claim_tracking ct
                            where  ct.claim_id = c.id)) last_tracking_message,
       c.sys_time
from   claim c
left join claim_external_id ce on ce.claim_id = c.id
left join enumeration_value ctp on ctp.enumeration_type_id = 102 /*cdb_claim.ET_CLAIM_TYPE*/ and
                                   ctp.enumeration_id = c.claim_type_id
left join enumeration_value cs on cs.enumeration_type_id = 101 /*cdb_claim.ET_CLAIM_STATE*/ and
                                  cs.enumeration_id = c.state
where c.sys_time >= (trunc(sysdate) - 7) or
      c.state not in (9 /*cdb_claim.CLAIM_STATE_COMPLETED*/, 8 /*cdb_claim.CLAIM_STATE_CANCELED*/, 10 /*cdb_claim.CLAIM_STATE_PARTIAL_COMPLETED*/);

PROMPT *** Create  grants  V_CDB_CLAIM ***
grant SELECT                                                                 on V_CDB_CLAIM     to BARSREADER_ROLE;
grant SELECT                                                                 on V_CDB_CLAIM     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CDB_CLAIM     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/View/V_CDB_CLAIM.sql =========*** End *** ===
PROMPT ===================================================================================== 
