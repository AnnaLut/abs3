

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_CRDSRV_BIDS_ARCHIVE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_CRDSRV_BIDS_ARCHIVE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_CRDSRV_BIDS_ARCHIVE ("BID_ID", "SUBPRODUCT_ID", "SUBPRODUCT_NAME", "CRT_DATE", "STATUS", "RNK", "F", "I", "O", "FIO", "BDATE", "INN", "WORK_MAIN_NAME", "WORK_MAIN_INN", "WORK_ADD_NAME", "WORK_ADD_INN", "PROPERTY_COST", "SUMM", "OWN_FUNDS", "TERM", "CREDIT_CURRENCY", "SINGLE_FEE", "MONTHLY_FEE", "INTEREST_RATE", "REPAYMENT_METHOD", "REPAYMENT_DAY", "GARANTEES", "GARANTEES_IDS", "MGR_ID", "MGR_FIO", "BRANCH", "BRANCH_NAME", "BRANCH_HIERARCHY", "STATES", "CHECKOUT_DAT", "CHECKIN_DAT", "CHECKOUT_USER_ID", "CHECKOUT_USER_FIO", "CHECKOUT_USER_BRANCH", "SRV_HIERARCHY") AS 
  select b."BID_ID",b."SUBPRODUCT_ID",b."SUBPRODUCT_NAME",b."CRT_DATE",b."STATUS",b."RNK",b."F",b."I",b."O",b."FIO",b."BDATE",b."INN",b."WORK_MAIN_NAME",b."WORK_MAIN_INN",b."WORK_ADD_NAME",b."WORK_ADD_INN",b."PROPERTY_COST",b."SUMM",b."OWN_FUNDS",b."TERM",b."CREDIT_CURRENCY",b."SINGLE_FEE",b."MONTHLY_FEE",b."INTEREST_RATE",b."REPAYMENT_METHOD",b."REPAYMENT_DAY",b."GARANTEES",b."GARANTEES_IDS",b."MGR_ID",b."MGR_FIO",b."BRANCH",b."BRANCH_NAME",b."BRANCH_HIERARCHY",b."STATES",
       bsh.checkout_dat,
       (select min(bsh0.change_dat)
          from wcs_bid_states_history bsh0
         where bsh0.bid_id = bsh.bid_id
           and bsh0.state_id = bsh.state_id
           and bsh0.change_action = 'CHECK_IN'
           and bsh0.change_dat > bsh.checkout_dat) as checkin_dat,
       bsh.checkout_user_id,
       sb.fio as checkout_user_fio,
       sb.branch as checkout_user_branch,
       sh.id as srv_hierarchy
  from v_wcs_bids_archive     b,
       wcs_bid_states_history bsh,
       wcs_srv_hierarchy      sh,
       staff$base             sb
 where b.bid_id = bsh.bid_id
   and bsh.state_id in
       ('NEW_CREDIT_S', 'NEW_RU_CREDIT_S', 'NEW_CA_CREDIT_S')
   and bsh.change_action = 'CHECK_OUT'
   and bsh.checkout_user_id = sb.id
   and decode(bsh.state_id,
              'NEW_CREDIT_S',
              'TOBO',
              'NEW_RU_CREDIT_S',
              'RU',
              'NEW_CA_CREDIT_S',
              'CA') = sh.id;

PROMPT *** Create  grants  V_WCS_CRDSRV_BIDS_ARCHIVE ***
grant SELECT                                                                 on V_WCS_CRDSRV_BIDS_ARCHIVE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_CRDSRV_BIDS_ARCHIVE.sql =========
PROMPT ===================================================================================== 
