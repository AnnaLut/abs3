

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/View/V_CDB_DEAL_INTEREST_RATE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CDB_DEAL_INTEREST_RATE ***

  CREATE OR REPLACE FORCE VIEW CDB.V_CDB_DEAL_INTEREST_RATE ("DEAL_ID", "DEAL_NUMBER", "RATE_KIND_ID", "RATE_KIND", "START_DATE", "INTEREST_RATE") AS 
  select dir.deal_id,
       d.deal_number,
       dir.rate_kind rate_kind_id,
       rk.enumeration_name rate_kind,
       dir.start_date,
       dir.interest_rate
from   deal_interest_rate dir
join   deal d on d.id = dir.deal_id
left join enumeration_value rk on rk.enumeration_type_id = 501 /*cdb_deal.ET_RATE_KIND*/ and
                                  rk.enumeration_id = dir.rate_kind;

PROMPT *** Create  grants  V_CDB_DEAL_INTEREST_RATE ***
grant SELECT                                                                 on V_CDB_DEAL_INTEREST_RATE to BARSREADER_ROLE;
grant SELECT                                                                 on V_CDB_DEAL_INTEREST_RATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CDB_DEAL_INTEREST_RATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/View/V_CDB_DEAL_INTEREST_RATE.sql =========**
PROMPT ===================================================================================== 
