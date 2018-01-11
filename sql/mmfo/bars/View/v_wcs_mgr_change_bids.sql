

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_MGR_CHANGE_BIDS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_MGR_CHANGE_BIDS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_MGR_CHANGE_BIDS ("BID_ID", "SUBPRODUCT_ID", "SUBPRODUCT_NAME", "SUBPRODUCT_DESC", "CRT_DATE", "RNK", "F", "I", "O", "FIO", "BDATE", "INN", "SUMM", "OWN_FUNDS", "TERM", "CREDIT_CURRENCY", "SINGLE_FEE", "MONTHLY_FEE", "INTEREST_RATE", "REPAYMENT_METHOD", "REPAYMENT_METHOD_TEXT", "REPAYMENT_DAY", "GARANTEES", "MGR_ID", "MGR_FIO", "BRANCH", "BRANCH_NAME", "BRANCH_HIERARCHY", "STATES", "INIT_PAYMENT_MTD") AS 
  select b."BID_ID",b."SUBPRODUCT_ID",b."SUBPRODUCT_NAME",b."SUBPRODUCT_DESC",b."CRT_DATE",b."RNK",b."F",b."I",b."O",b."FIO",b."BDATE",b."INN",b."SUMM",b."OWN_FUNDS",b."TERM",b."CREDIT_CURRENCY",b."SINGLE_FEE",b."MONTHLY_FEE",b."INTEREST_RATE",b."REPAYMENT_METHOD",b."REPAYMENT_METHOD_TEXT",b."REPAYMENT_DAY",b."GARANTEES",b."MGR_ID",b."MGR_FIO",b."BRANCH",b."BRANCH_NAME",b."BRANCH_HIERARCHY",b."STATES",b."INIT_PAYMENT_MTD"
  from v_wcs_bids b
 where b.branch like sys_context('bars_context', 'user_branch_mask')
   and not exists
 (select *
          from wcs_bid_states bs
         where bs.bid_id = b.bid_id
           and bs.state_id in ('NEW_DENY', 'NEW_DONE', 'APP_ERR', 'SYS_ERR'))
   and 0 = wcs_utl.has_bid_state(b.bid_id, 'NEW_SBP_SELECTING');

PROMPT *** Create  grants  V_WCS_MGR_CHANGE_BIDS ***
grant SELECT                                                                 on V_WCS_MGR_CHANGE_BIDS to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_MGR_CHANGE_BIDS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_MGR_CHANGE_BIDS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_MGR_CHANGE_BIDS.sql =========*** 
PROMPT ===================================================================================== 
