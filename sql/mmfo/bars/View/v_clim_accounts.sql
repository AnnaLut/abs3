

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CLIM_ACCOUNTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CLIM_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CLIM_ACCOUNTS ("MFO", "BRANCH", "ACC_CASHTYPE", "ACC_ID", "ACC_BALNUMBER", "ACC_NUMBER", "ACC_OB22", "ACC_CURRENCY", "ACC_NAME", "ACC_BALANCE", "ACC_OPEN_DATE", "ACC_CLOSE_DATE", "ACC_DAPP") AS 
  SELECT a.KF AS mfo,
       a.branch,
       CASE
          WHEN a.nbs = '1001'
          THEN
             'CASH'
          WHEN a.nbs = '1002'
          THEN
             CASE
                WHEN cashs_nls IS NOT NULL AND cashs_nls IS NULL THEN 'CASHS'
                ELSE 'CASH'
             END
          WHEN a.nbs = '1004'
          THEN
             'ATM'
          WHEN a.nbs = '1005'
          THEN
             'INCASH'
          WHEN a.nbs = '1007'
          THEN
             'INROAD'
          ELSE
             'UNKNOWN'
       END
          AS acc_cashtype,
       a.acc AS acc_id,
       a.nbs AS acc_balnumber,
       a.nls AS acc_number,
       a.ob22 AS acc_ob22,
       a.kv AS acc_currency,
       a.nms AS acc_name,
       fost (a.acc, bankdate) AS acc_balance,
       a.daos AS acc_open_date,
       a.dazs AS acc_close_date,
       -- a.dapp as acc_dapp
       bankdate as acc_dapp -- for test
  FROM (SELECT a.*,
               (SELECT val
                  FROM branch_parameters p
                 WHERE     a.branch = p.branch
                       AND p.tag = 'CASH'
                       AND p.val = a.nls)
                  cash_nls,
               (SELECT val
                  FROM branch_parameters p
                 WHERE     a.branch = p.branch
                       AND p.tag = 'CASHS'
                       AND p.val = a.nls)
                  cashs_nls
          FROM accounts a
         WHERE nbs LIKE '100%' AND (dazs IS NULL OR dazs >= clim_ru_pack.get_startdate)) a;

PROMPT *** Create  grants  V_CLIM_ACCOUNTS ***
grant SELECT                                                                 on V_CLIM_ACCOUNTS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CLIM_ACCOUNTS.sql =========*** End **
PROMPT ===================================================================================== 
