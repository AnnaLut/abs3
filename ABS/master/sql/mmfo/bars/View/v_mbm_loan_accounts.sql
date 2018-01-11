

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBM_LOAN_ACCOUNTS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBM_LOAN_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBM_LOAN_ACCOUNTS ("CUST_ID", "LOAN_TYPE", "CONTRACT_DATE", "CONTRACT_NUMBER", "DATE_END", "PERCENTS", "PAY_PERIOD", "CUR_CODE", "AMOUNT", "REST", "COMMISSION", "OVERDUE_COMMISSION", "REPAYMENT_ACC_NUMBER", "REPAYMENT_ACC_CURRENCY_CODE", "REPAYMENT_NAME", "REPAYMENT_BANK_CODE", "REPAYMENT_BANK_NAME", "REPAYMENT_TAX_CODE", "PERCENT_AMOUNT", "PERCENT_PAY_TERM", "OUTSTANDING_DEBT", "OUTSTANDING_PRC", "OUTSTANDING_PERCENT", "STATUS", "STATUS_NAME", "DATE_BEGIN", "MIN_REPAY", "PERCENT_PAY", "OUT_FINE", "TOTAL_SUM", "PAYTERM", "REF_TDN", "AMOUNT_EARLY_PAY", "LAST_PAY_DATE", "LAST_PAY_AMOUNT", "ADD_SUM") AS 
  SELECT cc.rnk AS cust_id,
          (SELECT t.name
             FROM cc_potra t
            WHERE t.id = cc.prod)
             AS loan_type,
          cc.Sdate AS contract_date,
          cc.cc_id AS contract_number,
          cc.Wdate AS date_end,
          bars_dbo.get_percent_rate (cc.nd) AS percents,
          (SELECT name
             FROM freq f
            WHERE f.freq = aa.freq)
             AS pay_period,
          (SELECT lcv
             FROM TABVAL t
            WHERE t.kv = aa.kv)
             AS cur_code,
          cc.sdog AS amount,
          (SELECT ABS (SUM (bars_dbo.convertVal (
                               fost (a.acc, TRUNC (SYSDATE)),
                               a.kv,
                               aa.kv,
                               gl.bd)))
             FROM accounts a, nd_acc n
            WHERE n.acc = a.acc AND a.tip = 'SS' AND n.nd = cc.nd)
             AS rest,

          (SELECT ABS (SUM (bars_dbo.convertVal (
                               fost (a.acc, TRUNC (SYSDATE)),
                               a.kv,
                               aa.kv,
                               gl.bd)))
             FROM accounts a, nd_acc n
            WHERE n.acc = a.acc AND a.tip = 'SK0' AND n.nd = cc.nd)
             AS COMMISSION,

          (SELECT ABS (SUM (bars_dbo.convertVal (
                               fost (a.acc, TRUNC (SYSDATE)),
                               a.kv,
                               aa.kv,
                               gl.bd)))
             FROM accounts a, nd_acc n
            WHERE n.acc = a.acc AND a.tip = 'SK9' AND n.nd = cc.nd)
             AS OVERDUE_COMMISSION

          ,acc_rep.acc_number as repayment_acc_number
          ,acc_rep.acc_currency_code as repayment_acc_currency_code
          ,acc_rep.name as repayment_name
          ,acc_rep.bank_code as repayment_bank_code
          ,acc_rep.bank_name as repayment_bank_name
          ,acc_rep.tax_code as repayment_tax_code


          ,(SELECT ABS (SUM (bars_dbo.convertVal (
                               fost (a.acc, TRUNC (SYSDATE)),
                               a.kv,
                               aa.kv,
                               gl.bd)))
             FROM accounts a, nd_acc n
            WHERE n.acc = a.acc AND a.tip = 'SN' AND n.nd = cc.nd)
             AS percent_amount,
          (CASE
              WHEN (SELECT NVL (SUM (bars_dbo.convertVal (
                                        fost (a.acc, TRUNC (SYSDATE)),
                                        a.kv,
                                        aa.kv,
                                        gl.bd)),
                                0)
                      FROM accounts a, nd_acc n
                     WHERE     n.acc = a.acc
                           AND a.tip IN ('SN', 'SPN', 'SLN')
                           AND n.nd = cc.nd) < 0
              THEN
                 TRUNC (SYSDATE)
              ELSE
                 (SELECT MIN (fdat)
                    FROM cc_lim l
                   WHERE     l.fdat >= TRUNC (SYSDATE)
                         AND l.nd = cc.nd
                         AND NVL (l.sumo - l.sumg - NVL (l.sumk, 0), 0) != 0)
           END)
             AS percent_pay_term,
          (SELECT ABS (SUM (bars_dbo.convertVal (
                               fost (a.acc, TRUNC (SYSDATE)),
                               a.kv,
                               aa.kv,
                               gl.bd)))
             FROM accounts a, nd_acc n
            WHERE n.acc = a.acc AND a.tip IN ('SP', 'SL') AND n.nd = cc.nd)
             AS outstanding_debt,
          (SELECT ABS (SUM (bars_dbo.convertVal (
                               fost (a.acc, TRUNC (SYSDATE)),
                               a.kv,
                               aa.kv,
                               gl.bd)))
             FROM accounts a, nd_acc n
            WHERE n.acc = a.acc AND a.tip IN ('SPN', 'SLN') AND n.nd = cc.nd)
             AS outstanding_prc,
          (SELECT   acrn.FPROCN (a.acc, 0, TRUNC (SYSDATE))
                  + acrn.FPROCN (a.acc, 2, TRUNC (SYSDATE))
             FROM accounts a, nd_acc n
            WHERE     nd = cc.nd
                  AND a.acc = n.acc
                  AND a.tip = 'SP'
                  AND a.dazs IS NULL
                  AND a.kv = aa.kv)
             AS outstanding_percent,
          (SELECT DECODE (t.sos,  10, 0,  15, 1,  13, 2)
             FROM CC_SOS t
            WHERE t.sos = cc.sos)
             AS status,
          (SELECT t.name
             FROM CC_SOS t
            WHERE t.sos = cc.sos)
             AS status_name,
          aa.wdate AS date_begin,
          (  (SELECT bars_dbo.plan_sum_pog (c.nd,
                                            a.kv,
                                            a.vid,
                                            a.ostx,
                                            0)
                FROM cc_deal c, accounts a, nd_acc n
               WHERE     a.acc = n.acc
                     AND n.nd = c.nd
                     AND a.tip = 'LIM'
                     AND c.nd = cc.nd
                     AND a.kv = aa.kv)
           + (SELECT ABS (SUM (bars_dbo.convertVal (
                                  fost (a.acc, TRUNC (SYSDATE)),
                                  a.kv,
                                  aa.kv,
                                  gl.bd)))
                FROM accounts a, nd_acc n
               WHERE     n.acc = a.acc
                     AND a.tip IN ('SN', 'SPN', 'SLN', 'SN8', 'SK0', 'SK9')
                     AND n.nd = cc.nd))
             AS min_repay,
          (SELECT (SELECT NVL (sumo - sumg - NVL (sumk, 0), 0)
                     FROM cc_lim
                    WHERE     nd = cc.nd
                          AND fdat =
                                 (SELECT MIN (fdat)
                                    FROM cc_lim l
                                   WHERE     nd = cc.nd
                                         AND NVL (sumo, 0) != 0
                                         AND fdat > TRUNC (SYSDATE)))
             FROM DUAL)
             AS percent_pay,
          (SELECT ABS (SUM (bars_dbo.convertVal (
                               fost (a.acc, TRUNC (SYSDATE)),
                               a.kv,
                               aa.kv,
                               gl.bd)))
             FROM accounts a, nd_acc n
            WHERE n.acc = a.acc AND a.tip = 'SN8' AND n.nd = cc.nd)
             AS out_fine,
          (  (SELECT bars_dbo.plan_sum_pog (c.nd,
                                            a.kv,
                                            a.vid,
                                            a.ostx,
                                            0)
                FROM cc_deal c, accounts a, nd_acc n
               WHERE     a.acc = n.acc
                     AND n.nd = c.nd
                     AND a.tip = 'LIM'
                     AND c.nd = cc.nd
                     AND a.kv = aa.kv)
           + (SELECT ABS (SUM (bars_dbo.convertVal (
                                  fost (a.acc, TRUNC (SYSDATE)),
                                  a.kv,
                                  aa.kv,
                                  gl.bd)))
                FROM accounts a, nd_acc n
               WHERE     n.acc = a.acc
                     AND a.tip IN ('SN', 'SPN', 'SLN', 'SN8', 'SK0', 'SK9')
                     AND n.nd = cc.nd))
             AS total_sum,
          --Дата след погашения
          (SELECT MIN (fdat)
             FROM cc_lim l
            WHERE     l.nd = cc.nd
                  AND lim2 <
                         (SELECT ABS (fost (a.acc, gl.bd))
                            FROM nd_acc n, accounts a
                           WHERE     a.acc = n.acc
                                 AND n.nd = cc.nd
                                 AND a.tip = 'LIM')
                  AND l.fdat > TRUNC (SYSDATE)
                  AND NVL (l.sumo, 0) != 0)
             PayTerm,
          TO_NUMBER (cc.nd) AS ref_tdn,
          --Сумма досрочного погашения
          (SELECT ABS (SUM (bars_dbo.convertVal (
                               fost (a.acc, TRUNC (SYSDATE)),
                               a.kv,
                               aa.kv,
                               gl.bd)))
             FROM accounts a, nd_acc n
            WHERE     n.nd = cc.nd
                  AND n.acc = a.acc
                  AND a.tip IN
                         ('SS ',                          -- SS  Основний борг
                          'SN ',                        -- SN  Процентний борг
                          'SP ',                   -- SP  Просрочений осн.борг
                          'SPN',                  -- SPN Просрочений проц.борг
                          'SL ',                     -- SL  Сумнівний осн.борг
                          'SLN',           -- SLN Сомнительный процентный долг
                          'SK0',               -- SK0 Нарах. комісія за кредит
                          'SK9',             -- SK9 Просроч. комісія за кредит
                          'SN8'                              -- SN8 Нарах.пеня
                               ))
             AS amount_early_pay,
          -- Остання оплата по кредиту
          (SELECT MAX (s.fdat)
             FROM nd_acc n, accounts a, saldoa s
            WHERE     a.acc = s.acc
                  AND n.acc = a.acc
                  AND nd = cc.nd
                  AND tip = 'SG'
                  AND s.kos != 0)
             AS last_pay_date,
          --сума останнього погашення
          (SELECT sa.kos
             FROM nd_acc nn, accounts aa, saldoa sa
            WHERE     aa.acc = sa.acc
                  AND nn.acc = aa.acc
                  AND aa.tip = 'SG'
                  AND nn.nd = cc.nd
                  AND sa.fdat =
                         (SELECT MAX (s.fdat)
                            FROM nd_acc n, accounts a, saldoa s
                           WHERE     a.acc = s.acc
                                 AND n.acc = a.acc
                                 AND n.nd = cc.nd
                                 AND a.tip = 'SG'
                                 AND s.kos != 0))
             AS last_pay_amount,
          (SELECT cck_plan_sum_pog (c.nd,
                                    a.kv,
                                    a.vid,
                                    a.ostx,
                                    0)
             FROM cc_deal c, accounts a, nd_acc n
            WHERE     a.acc = n.acc
                  AND n.nd = c.nd
                  AND a.tip = 'LIM'
                  AND c.nd = cc.nd
                  AND a.kv = aa.kv)
             add_sum
     FROM cc_deal cc
        ,cc_add aa
        ,(SELECT
                a.nls as acc_number
                ,a.nms as name
                ,a.dazs
                ,a.tip
                ,a.kv
                ,v.lcv as acc_currency_code
                ,n.nd
                ,c.okpo as tax_code
                ,b.mfo as bank_code
                ,b.nb as bank_name
            FROM
                accounts a
                ,customer c
                ,nd_acc n
                ,banks$base b
                ,tabval v
            WHERE
                n.acc = a.acc
                AND a.tip IN ('SG')
                AND a.dazs IS NULL
                AND c.rnk = a.rnk
                AND b.mfo = a.kf
                AND v.kv = a.kv
           ) acc_rep

    WHERE aa.nd = cc.nd
        AND aa.kf = cc.kf
        AND cc.sos NOT IN (14, 15)

        AND +acc_rep.kv = aa.kv
        AND +acc_rep.nd = cc.nd
        ;

PROMPT *** Create  grants  V_MBM_LOAN_ACCOUNTS ***
grant SELECT                                                                 on V_MBM_LOAN_ACCOUNTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_MBM_LOAN_ACCOUNTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_MBM_LOAN_ACCOUNTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBM_LOAN_ACCOUNTS.sql =========*** En
PROMPT ===================================================================================== 
