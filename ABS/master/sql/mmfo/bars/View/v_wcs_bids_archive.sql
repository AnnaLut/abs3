

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BIDS_ARCHIVE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BIDS_ARCHIVE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BIDS_ARCHIVE ("BID_ID", "SUBPRODUCT_ID", "SUBPRODUCT_NAME", "CRT_DATE", "STATUS", "RNK", "F", "I", "O", "FIO", "BDATE", "INN", "WORK_MAIN_NAME", "WORK_MAIN_INN", "WORK_ADD_NAME", "WORK_ADD_INN", "PROPERTY_COST", "SUMM", "OWN_FUNDS", "TERM", "CREDIT_CURRENCY", "SINGLE_FEE", "MONTHLY_FEE", "INTEREST_RATE", "REPAYMENT_METHOD", "REPAYMENT_DAY", "GARANTEES", "GARANTEES_IDS", "MGR_ID", "MGR_FIO", "BRANCH", "BRANCH_NAME", "BRANCH_HIERARCHY", "STATES") AS 
  select b.bid_id,
       b.subproduct_id,
       b.subproduct_name,
       b.crt_date,
       case
         when wcs_utl.has_bid_state(b.bid_id, 'SYS_ERR') = 1 or
              wcs_utl.has_bid_state(b.bid_id, 'APP_ERR') = 1 then
          'ERR'
         when wcs_utl.has_bid_state(b.bid_id, 'NEW_DENY') = 1 then
          'DENY'
         when wcs_utl.has_bid_state(b.bid_id, 'NEW_DONE') = 1 then
          'DONE'
         else
          'PROC'
       end as status,
       b.rnk,
       b.f,
       b.i,
       b.o,
       b.fio,
       b.bdate,
       b.inn,
       wcs_utl.get_answ(b.bid_id, 'CL_25') as work_main_name,
       wcs_utl.get_answ(b.bid_id, 'CL_0_9') as work_main_inn,
       wcs_utl.get_answ(b.bid_id, 'CL_28') as work_add_name,
       wcs_utl.get_answ(b.bid_id, 'CL_0_13') as work_add_inn,
       to_number(wcs_utl.get_creditdata(b.bid_id, 'PROPERTY_COST')) as property_cost,
       b.summ,
       b.own_funds,
       b.term,
       b.credit_currency,
       b.single_fee,
       b.monthly_fee,
       b.interest_rate,
       b.repayment_method,
       b.repayment_day,
       b.garantees,
       (select ',' || g_gid || ',' || vh_gid || ',' || m_gid || ',' ||
               ml_gid || ',' || d_gid || ',' || p_gid || ',' || v_gid as garantees
          from (select bg.bid_id, bg.garantee_id
                  from v_wcs_bid_garantees bg
                 group by bg.bid_id, bg.garantee_id) pivot(max(garantee_id) as gid for garantee_id in('GUARANTOR' as g,
                                                                                                      'VEHICLE' as vh,
                                                                                                      'MORTGAGE' as m,
                                                                                                      'MORTGAGE_LAND' as ml,
                                                                                                      'DEPOSIT' as d,
                                                                                                      'PRODUCT' as p,
                                                                                                      'VALUABLES' as v))
         where bid_id = b.bid_id) as garantees_ids,
       b.mgr_id,
       b.mgr_fio,
       b.branch,
       b.branch_name,
       b.branch_hierarchy,
       b.states
 from v_wcs_bids b, wcs_subproducts sbp, staff$base sb, branch brc
 where b.subproduct_id = sbp.id
   and b.mgr_id = sb.id
   and b.branch = brc.branch
 order by b.bid_id desc
;

PROMPT *** Create  grants  V_WCS_BIDS_ARCHIVE ***
grant SELECT                                                                 on V_WCS_BIDS_ARCHIVE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BIDS_ARCHIVE.sql =========*** End
PROMPT ===================================================================================== 
