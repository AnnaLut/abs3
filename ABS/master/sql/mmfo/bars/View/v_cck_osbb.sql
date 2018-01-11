

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_OSBB.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_OSBB ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_OSBB ("ND", "CC_ID", "RNK", "VIDD", "SDOG", "SDATE", "WDATE", "BRANCH", "PROD", "ERR") AS 
  SELECT ND,
          CC_ID,
          RNK,
          VIDD,
          SDOG,
          SDATE,
          WDATE,
          BRANCH,
          PROD,
          (SELECT COUNT (*)
             FROM tmp_operW
            WHERE ord = d.nd)
     FROM cc_deal d
    WHERE     sos >= 10
          AND sos < 14 -- Продукт не менялся поэтому добавляем новый
          AND (prod LIKE '206219%' OR prod LIKE '206309%' or prod LIKE '206326%');

PROMPT *** Create  grants  V_CCK_OSBB ***
grant SELECT                                                                 on V_CCK_OSBB      to BARSREADER_ROLE;
grant SELECT                                                                 on V_CCK_OSBB      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCK_OSBB      to START1;
grant SELECT                                                                 on V_CCK_OSBB      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_OSBB.sql =========*** End *** ===
PROMPT ===================================================================================== 
