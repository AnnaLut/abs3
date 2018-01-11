

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUR_RATES_CA.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUR_RATES_CA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUR_RATES_CA ("VDATE", "KV", "LCV", "KV_NAME", "BASE_SUM", "RATE_OFFICIAL", "RATE_BUY", "RATE_SALE") AS 
  SELECT trunc(sysdate),
            t.kv,
            t.lcv,
            t.name,
            c.bsum,
            c.rate_o,
            c.rate_b,
            c.rate_s
       FROM cur_rates$base c, tabval$global t
      WHERE     c.branch = '/300465/'
            AND c.vdate = TRUNC (SYSDATE)
            AND c.kv = t.kv
            AND c.rate_b IS NOT NULL
            AND c.rate_s IS NOT NULL
   ORDER BY t.kv;

PROMPT *** Create  grants  V_CUR_RATES_CA ***
grant SELECT                                                                 on V_CUR_RATES_CA  to BARSREADER_ROLE;
grant SELECT                                                                 on V_CUR_RATES_CA  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUR_RATES_CA.sql =========*** End ***
PROMPT ===================================================================================== 
