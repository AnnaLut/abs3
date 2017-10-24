

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_CC_BIDS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_CC_BIDS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_CC_BIDS ("BID_ID", "SUBPRODUCT_ID", "SUBPRODUCT_NAME", "SUBPRODUCT_DESC", "CRT_DATE", "RNK", "F", "I", "O", "FIO", "BDATE", "INN", "SUMM", "OWN_FUNDS", "TERM", "CREDIT_CURRENCY", "SINGLE_FEE", "MONTHLY_FEE", "INTEREST_RATE", "REPAYMENT_METHOD", "REPAYMENT_METHOD_TEXT", "REPAYMENT_DAY", "GARANTEES", "MGR_ID", "MGR_FIO", "BRANCH", "BRANCH_NAME", "BRANCH_HIERARCHY", "STATES", "INIT_PAYMENT_MTD", "SRV_HIERARCHY", "CHECKOUTED", "STATUS_REVIEW") AS 
  select b."BID_ID",b."SUBPRODUCT_ID",b."SUBPRODUCT_NAME",b."SUBPRODUCT_DESC",b."CRT_DATE",b."RNK",b."F",b."I",b."O",b."FIO",b."BDATE",b."INN",b."SUMM",b."OWN_FUNDS",b."TERM",b."CREDIT_CURRENCY",b."SINGLE_FEE",b."MONTHLY_FEE",b."INTEREST_RATE",b."REPAYMENT_METHOD",b."REPAYMENT_METHOD_TEXT",b."REPAYMENT_DAY",b."GARANTEES",b."MGR_ID",b."MGR_FIO",b."BRANCH",b."BRANCH_NAME",b."BRANCH_HIERARCHY",b."STATES",b."INIT_PAYMENT_MTD",
       sh.id as srv_hierarchy,
       bs.checkouted,
       b.status_review
  from v_wcs_bids        b,
       wcs_bid_states    bs,
       wcs_srv_hierarchy sh,
       wcs_user_responsibility ur
 where b.bid_id = bs.bid_id
   and ur.staff_id = user_id
   and ur.srv_id = 'SECRETARY_CC'
   and ur.srv_hierarchy = sh.id
   and ur.branch = b.branch
   and bs.state_id in
       ('NEW_SECRETARYCC', 'NEW_RU_SECRETARYCC', 'NEW_CA_SECRETARYCC')
   and (bs.checkouted = 0 or bs.checkout_user_id = user_id)
   and decode(bs.state_id,
              'NEW_SECRETARYCC',
              'TOBO',
              'NEW_RU_SECRETARYCC',
              'RU',
              'NEW_CA_SECRETARYCC',
              'CA') = sh.id;

PROMPT *** Create  grants  V_WCS_CC_BIDS ***
grant SELECT                                                                 on V_WCS_CC_BIDS   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_CC_BIDS.sql =========*** End *** 
PROMPT ===================================================================================== 
