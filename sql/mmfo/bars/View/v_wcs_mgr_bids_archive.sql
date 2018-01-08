

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_MGR_BIDS_ARCHIVE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_MGR_BIDS_ARCHIVE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_MGR_BIDS_ARCHIVE ("BID_ID", "SUBPRODUCT_ID", "SUBPRODUCT_NAME", "CRT_DATE", "STATUS", "RNK", "F", "I", "O", "FIO", "BDATE", "INN", "WORK_MAIN_NAME", "WORK_MAIN_INN", "WORK_ADD_NAME", "WORK_ADD_INN", "PROPERTY_COST", "SUMM", "OWN_FUNDS", "TERM", "CREDIT_CURRENCY", "SINGLE_FEE", "MONTHLY_FEE", "INTEREST_RATE", "REPAYMENT_METHOD", "REPAYMENT_DAY", "GARANTEES", "GARANTEES_IDS", "MGR_ID", "MGR_FIO", "BRANCH", "BRANCH_NAME", "BRANCH_HIERARCHY", "STATES") AS 
  select b."BID_ID",b."SUBPRODUCT_ID",b."SUBPRODUCT_NAME",b."CRT_DATE",b."STATUS",b."RNK",b."F",b."I",b."O",b."FIO",b."BDATE",b."INN",b."WORK_MAIN_NAME",b."WORK_MAIN_INN",b."WORK_ADD_NAME",b."WORK_ADD_INN",b."PROPERTY_COST",b."SUMM",b."OWN_FUNDS",b."TERM",b."CREDIT_CURRENCY",b."SINGLE_FEE",b."MONTHLY_FEE",b."INTEREST_RATE",b."REPAYMENT_METHOD",b."REPAYMENT_DAY",b."GARANTEES",b."GARANTEES_IDS",b."MGR_ID",b."MGR_FIO",b."BRANCH",b."BRANCH_NAME",b."BRANCH_HIERARCHY",b."STATES"
  from v_wcs_bids_archive b;

PROMPT *** Create  grants  V_WCS_MGR_BIDS_ARCHIVE ***
grant SELECT                                                                 on V_WCS_MGR_BIDS_ARCHIVE to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_MGR_BIDS_ARCHIVE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_MGR_BIDS_ARCHIVE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_MGR_BIDS_ARCHIVE.sql =========***
PROMPT ===================================================================================== 
