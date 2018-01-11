

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/View/V_CDB_CLAIM_DATA_TO_ACCEPT.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CDB_CLAIM_DATA_TO_ACCEPT ***

  CREATE OR REPLACE FORCE VIEW CDB.V_CDB_CLAIM_DATA_TO_ACCEPT ("ID", "CLAIM_TYPE_ID", "CLAIM_TYPE", "CLAIM_ID", "DEAL_NUMBER", "LENDER_CODE", "BORROWER_CODE", "START_DATE", "END_DATE", "AMOUNT", "CURRENCY_ID", "INTEREST_RATE_DATE", "INTEREST_RATE", "END_DATE_FLAG", "AMOUNT_FLAG", "INTEREST_DATE_FLAG", "INTEREST_RATE_FLAG", "COMMENT_TEXT") AS 
  select c.id,
       c.claim_type_id,
       (select ct.enumeration_name
        from   enumeration_value ct
        where  ct.enumeration_type_id = 102 /*cdb_claim.ET_CLAIM_TYPE*/ and
               ct.enumeration_id = c.claim_type_id) claim_type,
       cdat."CLAIM_ID",cdat."DEAL_NUMBER",cdat."LENDER_CODE",cdat."BORROWER_CODE",cdat."START_DATE",cdat."END_DATE",cdat."AMOUNT",cdat."CURRENCY_ID",cdat."INTEREST_RATE_DATE",cdat."INTEREST_RATE",cdat."END_DATE_FLAG",cdat."AMOUNT_FLAG",cdat."INTEREST_DATE_FLAG",cdat."INTEREST_RATE_FLAG",
       (select dbms_lob.substr(cc.comment_text, 4000)
       from   claim_comment cc
       where  cc.claim_id = c.id) comment_text
from   claim c
join   (select dat.claim_id,
               d.deal_number,
               (select lb.branch_name
                from   branch lb
                where  lb.id = d.lender_id) lender_code,
               (select bb.branch_name
                from   branch bb
                where  bb.id = d.borrower_id) borrower_code,
               d.open_date start_date,
               nvl(dat.end_date, d.expiry_date) end_date,
               nvl(dat.amount, d.amount) amount,
               (select cur.iso_code
                from   currency cur
                where  cur.id = d.currency_id) currency_id,
               case when dat.interest_rate_date is null then
                         (select max(dir.start_date)
                          from   deal_interest_rate dir
                          where  dir.deal_id = d.id and
                                 dir.rate_kind = 1 /*cdb_deal.RATE_KIND_MAIN*/)
                    else dat.interest_rate_date
               end interest_rate_date,
               case when dat.interest_rate is null then
                         (select min(dir.interest_rate) keep (dense_rank last order by dir.start_date)
                          from   deal_interest_rate dir
                          where  dir.deal_id = d.id and
                                 dir.rate_kind = 1 /*cdb_deal.RATE_KIND_MAIN*/)
                    else dat.interest_rate
               end interest_rate,
               dat.end_date_flag,
               dat.amount_flag,
               dat.interest_date_flag,
               dat.interest_rate_flag
        from (select ca.claim_id, ca.deal_number, null end_date, ca.new_deal_amount amount, null interest_rate_date, null interest_rate, 0 end_date_flag, 1 amount_flag, 0 interest_date_flag, 0 interest_rate_flag from claim_change_amount ca union all
              select cir.claim_id, cir.deal_number, null, null, cir.interest_rate_date, cir.interest_rate, 0, 0, 1, 1 from claim_change_interest_rate cir union all
              select ced.claim_id, ced.deal_number, ced.expiry_date, null, null, null, 1, 0, 0, 0 from claim_change_expiry_date ced union all
              select cd.claim_id, cd.deal_number, cd.close_date, null, null, null, 1, 0, 0, 0 from claim_close_deal cd) dat
        left join deal d on d.deal_number = dat.deal_number
        union all
        select nd.claim_id, nd.deal_number,
               (select lb.branch_name
                from   branch lb
                where  lb.branch_code = nd.lender_code),
               (select bb.branch_name
                from   branch bb
                where  bb.branch_code = nd.borrower_code),
               nd.open_date,
               nd.expiry_date,
               nd.amount,
               (select cur.iso_code
                from   currency cur
                where  cur.id = nd.currency_id),
               nd.open_date,
               nd.interest_rate,
               0, 0, 0, 0
        from   claim_new_deal nd) cdat on c.id = cdat.claim_id
where  c.state = 4 /*cdb_claim.CLAIM_STATE_CHECKED*/;

PROMPT *** Create  grants  V_CDB_CLAIM_DATA_TO_ACCEPT ***
grant SELECT                                                                 on V_CDB_CLAIM_DATA_TO_ACCEPT to BARSREADER_ROLE;
grant SELECT                                                                 on V_CDB_CLAIM_DATA_TO_ACCEPT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CDB_CLAIM_DATA_TO_ACCEPT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/View/V_CDB_CLAIM_DATA_TO_ACCEPT.sql =========
PROMPT ===================================================================================== 
