

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SRV_BIDS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SRV_BIDS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SRV_BIDS ("BID_ID", "SUBPRODUCT_ID", "SUBPRODUCT_NAME", "SUBPRODUCT_DESC", "CRT_DATE", "RNK", "F", "I", "O", "FIO", "BDATE", "INN", "SUMM", "OWN_FUNDS", "TERM", "CREDIT_CURRENCY", "SINGLE_FEE", "MONTHLY_FEE", "INTEREST_RATE", "REPAYMENT_METHOD", "REPAYMENT_METHOD_TEXT", "REPAYMENT_DAY", "GARANTEES", "MGR_ID", "MGR_FIO", "BRANCH", "BRANCH_NAME", "BRANCH_HIERARCHY", "STATES", "INIT_PAYMENT_MTD", "SRV", "SRV_HIERARCHY", "CHECKOUTED") AS 
  select b."BID_ID",b."SUBPRODUCT_ID",b."SUBPRODUCT_NAME",b."SUBPRODUCT_DESC",b."CRT_DATE",b."RNK",b."F",b."I",b."O",b."FIO",b."BDATE",b."INN",b."SUMM",b."OWN_FUNDS",b."TERM",b."CREDIT_CURRENCY",b."SINGLE_FEE",b."MONTHLY_FEE",b."INTEREST_RATE",b."REPAYMENT_METHOD",b."REPAYMENT_METHOD_TEXT",b."REPAYMENT_DAY",b."GARANTEES",b."MGR_ID",b."MGR_FIO",b."BRANCH",b."BRANCH_NAME",b."BRANCH_HIERARCHY",b."STATES",b."INIT_PAYMENT_MTD",
       decode(s.id,
              'SECURITY_SERVICE',
              'ss',
              'LAW_SERVICE',
              'ls',
              'ASSETS_SERVICE',
              'as',
              'RISK_DEPARTMENT',
              'rs',
              'FINANCE_DEPARTMENT',
              'fs') as srv,
       sh.id as srv_hierarchy,
       bs.checkouted
  from v_wcs_bids        b,
       wcs_bid_states    bs,
       wcs_srv_hierarchy sh,
       wcs_services      s,
       wcs_user_responsibility ur
 where b.bid_id = bs.bid_id
   and ur.staff_id = user_id
   and ur.srv_id = s.id
   and ur.srv_hierarchy = sh.id
   and ur.branch = b.branch
   and 1 = case
         when s.id = 'SECURITY_SERVICE' and
              bs.state_id in ('NEW_SECURITY_S_PRC',
                              'NEW_RU_SECURITY_S_PRC',
                              'NEW_CA_SECURITY_S_PRC') then
          1
         when s.id = 'LAW_SERVICE' and
              bs.state_id in
              ('NEW_LAW_S_PRC', 'NEW_RU_LAW_S_PRC', 'NEW_CA_LAW_S_PRC') then
          1
         when s.id = 'ASSETS_SERVICE' and
              bs.state_id in ('NEW_PROBLEMACTIVE_S_PRC',
                              'NEW_RU_PROBLEMACTIVE_S_PRC',
                              'NEW_CA_PROBLEMACTIVE_S_PRC') then
          1
         when s.id = 'RISK_DEPARTMENT' and
              bs.state_id in ('NEW_CA_RISK_S_PRC') then
          1
         when s.id = 'FINANCE_DEPARTMENT' and
              bs.state_id in ('NEW_CA_FINANCE_S_PRC') then
          1
       end
   and (bs.checkouted = 0 or bs.checkout_user_id = user_id)
   and sh.id = case
         when bs.state_id in ('NEW_SECURITY_S_PRC',
                              'NEW_LAW_S_PRC',
                              'NEW_PROBLEMACTIVE_S_PRC') then
          'TOBO'
         when bs.state_id in ('NEW_RU_SECURITY_S_PRC',
                              'NEW_RU_LAW_S_PRC',
                              'NEW_RU_PROBLEMACTIVE_S_PRC') then
          'RU'
         when bs.state_id in ('NEW_CA_SECURITY_S_PRC',
                              'NEW_CA_LAW_S_PRC',
                              'NEW_CA_PROBLEMACTIVE_S_PRC',
                              'NEW_CA_RISK_S_PRC',
                              'NEW_CA_FINANCE_S_PRC') then
          'CA'
       end
   and s.id in ('SECURITY_SERVICE',
                'LAW_SERVICE',
                'ASSETS_SERVICE',
                'RISK_DEPARTMENT',
                'FINANCE_DEPARTMENT');

PROMPT *** Create  grants  V_WCS_SRV_BIDS ***
grant SELECT                                                                 on V_WCS_SRV_BIDS  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SRV_BIDS.sql =========*** End ***
PROMPT ===================================================================================== 
