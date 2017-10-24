

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBDK_ACCOUNT_MODEL.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBDK_ACCOUNT_MODEL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBDK_ACCOUNT_MODEL ("REF", "FDAT", "TT", "AMNT_DB", "AMNT_CR", "SOS", "NMS", "NLS", "KV", "DIG", "ND") AS 
  SELECT o.ref,
       o.fdat,
       o.tt,
       decode(o.dk,0,o.s,0)/power(10,t.dig) as amnt_DB,
       decode(o.dk,1,o.s,0)/power(10,t.dig) as AMNT_CR,
       o.sos,
       a.nms,
       a.nls,
       a.kv,
       t.dig,
       mb.ND
  FROM bars.opldok o
  JOIN bars.accounts a ON ( a.KF = o.KF and a.acc = o.acc )
  JOIN bars.tabval$global t ON a.kv = t.kv
  JOIN bars.mbd_k_r mb ON o.ref=mb.ref
ORDER BY o.fdat, o.ref, o.stmt, o.dk;

PROMPT *** Create  grants  V_MBDK_ACCOUNT_MODEL ***
grant SELECT                                                                 on V_MBDK_ACCOUNT_MODEL to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBDK_ACCOUNT_MODEL.sql =========*** E
PROMPT ===================================================================================== 
