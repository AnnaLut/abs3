

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NOTPORTFOLIO_INT_RECKONING.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NOTPORTFOLIO_INT_RECKONING ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NOTPORTFOLIO_INT_RECKONING ("ACCOUNT_ID", "INTEREST_KIND", "CURRENCY_ID", "MFO", "PARTNER_NAME", "ACCOUNT_NUMBER", "ACCOUNT_REST", "INTEREST_RATE", "INTEREST_AMOUNT", "DATE_FROM", "DATE_TO", "PURPOSE", "OPERATION_TYPE", "INTEREST_ACCOUNT_NUMBER", "INCOME_ACCOUNT", "MESSAGE", "STATE_ID", "ID", "RECKONING_ID", "OPER_REF", "ISP") AS 
  SELECT t.account_id,
          t.interest_kind,
          a.kv currency_id,
          a.kf mfo,
          c.nmk partner_name,
          a.nls account_number,
          NVL (t.account_rest / 100, 0) account_rest,
          t.interest_rate,
          t.interest_amount / 100 interest_amount,
          t.date_from,
          t.date_to,
          t.purpose,
          NVL (i.tt, '%%1') operation_type,
          ia.nls interest_account_number,
          inc.nls income_account,
          t.MESSAGE,
          t.state_id,
          t.id,
          t.reckoning_id,
          t.oper_ref,
          a.isp
     FROM int_reckoning t
          JOIN accounts a ON a.acc = t.account_id
          JOIN notportfolio_nbs n ON a.nbs = n.nbs
          JOIN int_accn i ON i.acc = a.acc AND i.id = a.pap - 1
          JOIN customer c ON c.rnk = a.rnk
          LEFT JOIN accounts ia ON ia.acc = i.acra
          LEFT JOIN accounts inc ON inc.acc = i.acrb
    WHERE     t.reckoning_id = SYS_CONTEXT ('bars_pul', 'reckoning_id')
          AND t.interest_amount > 0
          AND NOT EXISTS
                 (SELECT 1
                    FROM cc_add l
                   WHERE l.accs = t.account_id)
          AND NOT EXISTS
                 (SELECT 1
                    FROM dpt_deposit d
                   WHERE d.acc = t.account_id)
order by a.acc, i.id, t.date_from;

PROMPT *** Create  grants  V_NOTPORTFOLIO_INT_RECKONING ***
grant SELECT                                                                 on V_NOTPORTFOLIO_INT_RECKONING to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NOTPORTFOLIO_INT_RECKONING.sql ======
PROMPT ===================================================================================== 
