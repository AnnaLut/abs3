CREATE OR REPLACE VIEW V_OLDBPK_INT_RECKONING AS
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
          JOIN bpk_acc n ON a.acc = n.acc_2207 or a.acc = n.acc_ovr
          JOIN int_accn i ON i.acc = a.acc AND i.id = a.pap - 1
          JOIN customer c ON c.rnk = a.rnk
          LEFT JOIN accounts ia ON ia.acc = i.acra
          LEFT JOIN accounts inc ON inc.acc = i.acrb
    WHERE     t.reckoning_id = SYS_CONTEXT ('bars_pul', 'reckoning_id')
          AND t.interest_amount > 0
order by a.acc, i.id, t.date_from;
grant select on V_OLDBPK_INT_RECKONING to bars_access_defrole;
