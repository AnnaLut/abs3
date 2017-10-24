

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_VISA_CHANGE_BIDS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_VISA_CHANGE_BIDS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_VISA_CHANGE_BIDS ("BID_ID", "SUBPRODUCT_ID", "SUBPRODUCT_NAME", "SUBPRODUCT_DESC", "CRT_DATE", "RNK", "F", "I", "O", "FIO", "BDATE", "INN", "SUMM", "OWN_FUNDS", "TERM", "CREDIT_CURRENCY", "SINGLE_FEE", "MONTHLY_FEE", "INTEREST_RATE", "REPAYMENT_METHOD", "REPAYMENT_METHOD_TEXT", "REPAYMENT_DAY", "GARANTEES", "MGR_ID", "MGR_FIO", "BRANCH", "BRANCH_NAME", "BRANCH_HIERARCHY", "STATES", "INIT_PAYMENT_MTD", "CHECKOUTED", "CHECKOUT_DAT", "CHECKOUT_USER_ID", "CHECKOUT_USER_FIO", "CHECKOUT_USER_BRANCH", "SRV_HIERARCHY") AS 
  select b."BID_ID",b."SUBPRODUCT_ID",b."SUBPRODUCT_NAME",b."SUBPRODUCT_DESC",b."CRT_DATE",b."RNK",b."F",b."I",b."O",b."FIO",b."BDATE",b."INN",b."SUMM",b."OWN_FUNDS",b."TERM",b."CREDIT_CURRENCY",b."SINGLE_FEE",b."MONTHLY_FEE",b."INTEREST_RATE",b."REPAYMENT_METHOD",b."REPAYMENT_METHOD_TEXT",b."REPAYMENT_DAY",b."GARANTEES",b."MGR_ID",b."MGR_FIO",b."BRANCH",b."BRANCH_NAME",b."BRANCH_HIERARCHY",b."STATES",b."INIT_PAYMENT_MTD",
       bs.checkouted,
       bs.checkout_dat,
       bs.checkout_user_id,
       sb.fio as checkout_user_fio,
       sb.branch as checkout_user_branch,
       sh.id as srv_hierarchy
  from v_wcs_bids        b,
       wcs_bid_states    bs,
       wcs_srv_hierarchy sh,
       wcs_services      s,
       staff$base sb
 where b.bid_id = bs.bid_id
   and bs.state_id = 'NEW_VISA'
   and bs.checkouted = 1
   and bs.checkout_user_id = sb.id
   and sh.id = b.branch_hierarchy
   and s.id = 'VISA'
   and sb.branch like sys_context('bars_context', 'user_branch_mask');

PROMPT *** Create  grants  V_WCS_VISA_CHANGE_BIDS ***
grant SELECT                                                                 on V_WCS_VISA_CHANGE_BIDS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_VISA_CHANGE_BIDS.sql =========***
PROMPT ===================================================================================== 
