

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/View/V_CDB_SET_INT_RATE_CLAIM.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CDB_SET_INT_RATE_CLAIM ***

  CREATE OR REPLACE FORCE VIEW CDB.V_CDB_SET_INT_RATE_CLAIM ("ID", "DEAL_NUMBER", "INTEREST_RATE_DATE", "INTEREST_RATE", "ALLEGRO_COMMENT", "ALLEGRO_CLAIM_ID", "SYS_TIME", "CLAIM_STATE_ID", "CLAIM_STATE") AS 
  select c.id,
       cir.deal_number,
       cir.interest_rate_date,
       cir.interest_rate,
       cc.comment_text allegro_comment,
       ce.external_id allegro_claim_id,
       c.sys_time,
       c.state claim_state_id,
       cs.enumeration_code claim_state
from   claim_change_interest_rate cir
join   claim c on c.id = cir.claim_id
left join claim_comment cc on cc.claim_id = c.id
left join claim_external_id ce on ce.claim_id = c.id
left join enumeration_value cs on cs.enumeration_type_id = 101 /*cdb_claim.ET_CLAIM_STATE*/ and
                                  cs.enumeration_id = c.state;

PROMPT *** Create  grants  V_CDB_SET_INT_RATE_CLAIM ***
grant SELECT                                                                 on V_CDB_SET_INT_RATE_CLAIM to BARSREADER_ROLE;
grant SELECT                                                                 on V_CDB_SET_INT_RATE_CLAIM to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CDB_SET_INT_RATE_CLAIM to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/View/V_CDB_SET_INT_RATE_CLAIM.sql =========**
PROMPT ===================================================================================== 
