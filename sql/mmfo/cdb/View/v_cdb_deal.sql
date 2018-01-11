

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/View/V_CDB_DEAL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CDB_DEAL ***

  CREATE OR REPLACE FORCE VIEW CDB.V_CDB_DEAL ("ID", "DEAL_NUMBER", "LENDER_MFO", "LENDER_NAME", "BORROWER_MFO", "BORROWER_NAME", "OPEN_DATE", "EXPIRY_DATE", "CLOSE_DATE", "AMOUNT", "CURRENCY_ID", "INTEREST_RATE", "INTEREST_CALENDAR_ID", "INTEREST_CALENDAR") AS 
  select d.id,
       d.deal_number,
       lb.branch_code lender_mfo,
       lb.branch_name lender_name,
       db.branch_code borrower_mfo,
       db.branch_name borrower_name,
       d.open_date,
       d.expiry_date,
       d.close_date,
       d.amount,
       (select c.iso_code
        from   currency c
        where  c.id = d.currency_id) currency_id,
       (select min(dir.interest_rate) keep (dense_rank last order by dir.start_date)
        from   deal_interest_rate dir
        where  dir.deal_id = d.id and
               dir.rate_kind = 1 /*cdb_dispatcher.RATE_KIND_MAIN*/) interest_rate,
       d.base_year interest_calendar_id,
       ic.enumeration_name interest_calendar
from   deal d
join   branch lb on lb.id = d.lender_id
join   branch db on db.id = d.borrower_id
left join enumeration_value ic on ic.enumeration_type_id = 403 /*cdb_bars_client.ET_INTEREST_CALENDAR*/ and
                                  ic.enumeration_id = d.base_year;

PROMPT *** Create  grants  V_CDB_DEAL ***
grant SELECT                                                                 on V_CDB_DEAL      to BARSREADER_ROLE;
grant SELECT                                                                 on V_CDB_DEAL      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CDB_DEAL      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/View/V_CDB_DEAL.sql =========*** End *** ====
PROMPT ===================================================================================== 
