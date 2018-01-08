

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_ADM_BIDS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_ADM_BIDS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_ADM_BIDS ("BID_ID", "SUBPRODUCT_ID", "SUBPRODUCT_NAME", "CRT_DATE", "STATUS", "F", "I", "O", "FIO", "BDATE", "INN", "WORK_MAIN_NAME", "WORK_MAIN_INN", "WORK_ADD_NAME", "WORK_ADD_INN", "PROPERTY_COST", "SUMM", "OWN_FUNDS", "TERM", "CREDIT_CURRENCY", "SINGLE_FEE", "MONTHLY_FEE", "INTEREST_RATE", "REPAYMENT_METHOD", "REPAYMENT_DAY", "GARANTEES", "GARANTEES_IDS", "MGR_ID", "MGR_FIO", "BRANCH", "BRANCH_NAME", "BRANCH_HIERARCHY", "STATES", "CHECKOUT_DAT", "CHECKOUT_USER_ID", "CHECKOUT_USER_FIO", "CHECKOUT_USER_BRANCH") AS 
  SELECT b."BID_ID",
          b."SUBPRODUCT_ID",
          b."SUBPRODUCT_NAME",
          b."CRT_DATE",
          b."STATUS",
          b."F",
          b."I",
          b."O",
          b."FIO",
          b."BDATE",
          b."INN",
          b."WORK_MAIN_NAME",
          b."WORK_MAIN_INN",
          b."WORK_ADD_NAME",
          b."WORK_ADD_INN",
          b."PROPERTY_COST",
          b."SUMM",
          b."OWN_FUNDS",
          b."TERM",
          b."CREDIT_CURRENCY",
          b."SINGLE_FEE",
          b."MONTHLY_FEE",
          b."INTEREST_RATE",
          b."REPAYMENT_METHOD",
          b."REPAYMENT_DAY",
          b."GARANTEES",
          b."GARANTEES_IDS",
          b."MGR_ID",
          b."MGR_FIO",
          b."BRANCH",
          b."BRANCH_NAME",
          b."BRANCH_HIERARCHY",
          b."STATES",
          bsh.checkout_dat,
          bsh.checkout_user_id,
          sb.fio AS checkout_user_fio,
          sb.branch AS checkout_user_branch
     FROM v_wcs_bids_archive b,
          wcs_bid_states_history bsh,
          staff$base sb
    WHERE b.bid_id = bsh.bid_id
          AND bsh.change_action = 'CHECK_OUT'
          AND bsh.checkout_user_id = sb.id
          AND (b.status = 'PROC' or b.status = 'ERR')
          AND bsh.state_id='NEW_CREDITDATA_DI';

PROMPT *** Create  grants  V_WCS_ADM_BIDS ***
grant SELECT                                                                 on V_WCS_ADM_BIDS  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_ADM_BIDS.sql =========*** End ***
PROMPT ===================================================================================== 
