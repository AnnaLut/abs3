

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/View/V_CDB_NEW_DEAL_TRAN.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CDB_NEW_DEAL_TRAN ***

  CREATE OR REPLACE FORCE VIEW CDB.V_CDB_NEW_DEAL_TRAN ("ID", "TRANSACTION_TYPE_ID", "TRANSACTION_TYPE", "MFO", "BRANCH_NAME", "DEAL_KIND_ID", "DEAL_KIND", "DEAL_NUMBER", "OPEN_DATE", "EXPIRY_DATE", "AMOUNT", "CURRENCY_ID", "INTEREST_RATE", "INTEREST_CALENDAR_ID", "INTEREST_CALENDAR", "MAIN_ACCOUNT", "INTEREST_ACCOUNT", "TRANSIT_ACCOUNT", "PARTY_MFO", "PARTY_BRANCH_NAME", "PARTY_MAIN_ACCOUNT", "PARTY_INTEREST_ACCOUNT", "TRANSACTION_STATE_ID", "TRANSACTION_STATE", "PRIORITY_GROUP", "FAIL_COUNTER") AS 
  select bt.id,
       bt.transaction_type transaction_type_id,
       (select ttp.enumeration_name
        from   enumeration_value ttp
        where  ttp.enumeration_type_id = 402 /*cdb_bars_client.ET_TRANSACTION_TYPE*/ and
               ttp.enumeration_id = bt.transaction_type) transaction_type,
       b.branch_code mfo,
       b.branch_name,
       bd.product deal_kind_id,
       (select dt.enumeration_name
        from   enumeration_value dt
        where  dt.enumeration_type_id = 405 /*cdb_bars_client.ET_DEAL_KIND*/ and
               dt.enumeration_id = bd.product) deal_kind,
       d.deal_number,
       d.open_date,
       d.expiry_date,
       d.amount,
       (select c.iso_code
        from   currency c
        where  c.id = d.currency_id) currency_id,
       cdb_deal.get_deal_interest_rate(d.id, 1 /*cdb_deal.RATE_KIND_MAIN*/) interest_rate,
       d.base_year interest_calendar_id,
       (select ic.enumeration_name
        from   enumeration_value ic
        where  ic.enumeration_type_id = 403 /*cdb_bars_client.ET_INTEREST_CALENDAR*/ and
               ic.enumeration_id = d.base_year) interest_calendar,
       (select ma.account_number
        from   bars_account ma
        where  ma.id = bd.main_account_id) main_account,
       (select ia.account_number
        from   bars_account ia
        where  ia.id = bd.interest_account_id) interest_account,
       (select ta.account_number
        from   bars_account ta
        where  ta.id = bd.transit_account_id) transit_account,
       pb.branch_code party_mfo,
       pb.branch_name party_branch_name,
       (select pma.account_number
        from   bars_account pma
        where  pma.id = pbd.main_account_id) party_main_account,
       (select pia.account_number
        from   bars_account pia
        where  pia.id = pbd.interest_account_id) party_interest_account,
       bt.state transaction_state_id,
       (select bts.enumeration_code
        from   enumeration_value bts
        where  bts.enumeration_type_id = 401 /*cdb_bars_client.ET_TRANSACTION_STATE*/ and
               bts.enumeration_id = bt.state) transaction_state,
       bt.priority_group,
       bt.fail_counter
from   bars_transaction bt
join   bars_object bo on bo.id = bt.object_id
join   bars_deal bd on bd.id = bt.object_id
join   deal d on d.id = bo.deal_id
join   branch b on b.id = bo.branch_id
left join bars_object pbo on pbo.id = bd.party_bars_deal_id
left join bars_deal pbd on pbd.id = bd.party_bars_deal_id
left join branch pb on pb.id = pbo.branch_id
where bt.transaction_type = 1 /*cdb_bars_client.TRAN_TYPE_BARS_DEAL*/;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/View/V_CDB_NEW_DEAL_TRAN.sql =========*** End
PROMPT ===================================================================================== 
