

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FOREX_ACCOUNT_MODEL.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FOREX_ACCOUNT_MODEL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FOREX_ACCOUNT_MODEL ("REF", "FDAT", "TT", "AMNT_DB", "AMNT_CR", "SQ", "SOS", "NMS", "NLS", "KV", "DIG", "DEAL_TAG") AS 
  SELECT o.REF,
            o.fdat,
            o.tt,
            DECODE (o.dk, 0, o.s, 0) / POWER (10, t.dig) AS amnt_DB,
            DECODE (o.dk, 1, o.s, 0) / POWER (10, t.dig) AS AMNT_CR,
            o.sq / POWER (10, t.dig) AS sq,
            o.sos,
            a.nms,
            a.nls,
            a.kv,
            t.dig,
            fd.deal_tag
       FROM bars.opldok o
            JOIN bars.accounts a ON (a.KF = o.KF AND a.acc = o.acc)
            JOIN bars.tabval$global t ON a.kv = t.kv
            JOIN bars.fx_deal_ref fd ON o.REF = fd.REF
   ORDER BY o.fdat,
            o.REF,
            o.stmt,
            o.dk;

PROMPT *** Create  grants  V_FOREX_ACCOUNT_MODEL ***
grant SELECT                                                                 on V_FOREX_ACCOUNT_MODEL to BARSREADER_ROLE;
grant SELECT                                                                 on V_FOREX_ACCOUNT_MODEL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FOREX_ACCOUNT_MODEL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FOREX_ACCOUNT_MODEL.sql =========*** 
PROMPT ===================================================================================== 
