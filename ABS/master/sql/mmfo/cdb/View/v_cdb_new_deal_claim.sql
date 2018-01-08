

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/View/V_CDB_NEW_DEAL_CLAIM.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CDB_NEW_DEAL_CLAIM ***

  CREATE OR REPLACE FORCE VIEW CDB.V_CDB_NEW_DEAL_CLAIM ("ID", "DEAL_NUMBER", "OPEN_DATE", "EXPIRY_DATE", "LENDER_CODE", "LENDER_NAME", "BORROWER_CODE", "BORROWER_NAME", "AMOUNT", "CURRENCY_ID", "INTEREST_RATE", "INTEREST_CALENDAR_ID", "INTEREST_CALENDAR", "ALLEGRO_COMMENT", "ALLEGRO_CLAIM_ID", "SYS_TIME", "CLAIM_STATE_ID", "CLAIM_STATE") AS 
  select c.id,
       cnd.deal_number,
       cnd.open_date,
       cnd.expiry_date,
       cnd.lender_code,
       bl.branch_name lender_name,
       cnd.borrower_code,
       bd.branch_name borrower_name,
       cnd.amount,
       cnd.currency_id,
       cnd.interest_rate,
       cnd.base_year interest_calendar_id,
       ic.enumeration_name interest_calendar,
       cc.comment_text allegro_comment,
       ce.external_id allegro_claim_id,
       c.sys_time,
       c.state claim_state_id,
       cs.enumeration_code claim_state
from   claim_new_deal cnd
join   claim c on c.id = cnd.claim_id
left join branch bl on bl.branch_code = cnd.lender_code
left join branch bd on bd.branch_code = cnd.borrower_code
left join claim_comment cc on cc.claim_id = c.id
left join claim_external_id ce on ce.claim_id = c.id
left join enumeration_value ic on ic.enumeration_type_id = 403 /*cdb_bars_client.ET_INTEREST_CALENDAR*/ and
                                  ic.enumeration_id = cnd.base_year
left join enumeration_value cs on cs.enumeration_type_id = 101 /*cdb_claim.ET_CLAIM_STATE*/ and
                                  cs.enumeration_id = c.state;

PROMPT *** Create  grants  V_CDB_NEW_DEAL_CLAIM ***
grant SELECT                                                                 on V_CDB_NEW_DEAL_CLAIM to BARSREADER_ROLE;
grant SELECT                                                                 on V_CDB_NEW_DEAL_CLAIM to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CDB_NEW_DEAL_CLAIM to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/View/V_CDB_NEW_DEAL_CLAIM.sql =========*** En
PROMPT ===================================================================================== 
