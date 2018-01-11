

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PAY_MBDK.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PAY_MBDK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PAY_MBDK ("PAP", "NPP", "TXT", "ND", "KV", "NLS", "NLSN", "STP", "OK", "OSTC_A", "OSTC_B", "OSTB_A", "OSTB_B", "OSTF_A", "OSTF_B", "ACR_DAT", "WDATE", "LIMIT", "RNK", "SDATE") AS 
  SELECT y.pap,
          y.npp,
          y.txt,
          x.nd,
          x.kv,
          x.nls,
          x.nlsn,
          0 STP,
          0 ok,
          x.ostc_a,
          x.ostc_B,
          x.ostb_a,
          x.ostb_b,
          x.ostf_a,
          x.ostf_b,
          x.acr_dat,
          x.wdate,
          x.LIMIT,
          x.rnk,
          x.sdate
     FROM (SELECT d.nd,
                  a.pap,
                  a.nls,
                  b.nls nlsn,
                  a.kv,
                  d.LIMIT,
                  d.rnk,
                  a.ostc / 100 ostc_a,
                  b.ostc / 100 ostc_B,
                  a.acc,
                  a.ostb / 100 ostb_a,
                  b.ostb / 100 ostb_b,
                  a.ostf / 100 ostf_a,
                  b.ostf / 100 ostf_b,
                  i.acr_dat,
                  d.wdate,
                  d.sdate
             FROM cc_deal d,
                  cc_add c,
                  accounts a,
                  accounts b,
                  int_accn i
            WHERE     c.accs = a.acc
                  AND i.acra = b.acc
                  AND c.nd = d.nd
                  AND d.nd = TO_NUMBER (pul.Get_Mas_Ini_Val ('ND'))
                  AND i.acc = a.acc
                  AND i.id = a.pap - 1) x,
          (SELECT 1 pap,
                  10 NPP,
                  'Відправка на розміщення осн.суми'
                     txt
             FROM DUAL
           UNION ALL
           SELECT 1, 11, 'Прийняти погашення оcн.суми'
             FROM DUAL
           UNION ALL
           SELECT 1, 12, 'Нарахувати %%/доходы' FROM DUAL
           UNION ALL
           SELECT 1, 13, 'Прийняти погашення %%' FROM DUAL
           UNION ALL
           SELECT 2,
                  20,
                  'Прийняти на залучення осн.суму'
             FROM DUAL
           UNION ALL
           SELECT 2,
                  21,
                  'Повернути залучену осн.суму'
             FROM DUAL
           UNION ALL
           SELECT 2, 22, 'Нарахувати %%/витрати' FROM DUAL
           UNION ALL
           SELECT 2, 23, 'Перерахувати нарах %%' FROM DUAL) y
    WHERE     x.pap = y.pap
          --AND x.kv = 980                              -- про валюту - временно
          AND (   y.npp = 10 AND x.ostB_a = 0 AND x.ostB_a = x.ostC_a
               OR y.npp = 11 AND x.ostB_a < 0 AND x.ostB_a = x.ostC_a
               OR y.npp = 12 AND x.ostC_a < 0 AND x.acr_dat < x.wdate - 1
               OR y.npp = 13 AND x.ostB_b < 0 AND x.ostB_b = x.ostC_b
               OR y.npp = 20 AND x.ostB_a = 0 AND x.ostB_a = x.ostC_a
               OR y.npp = 21 AND x.ostB_a > 0 AND x.ostB_a = x.ostC_a
               OR y.npp = 22 AND x.ostC_a > 0 AND x.acr_dat < x.wdate - 1
               OR y.npp = 23 AND x.ostB_b > 0 AND x.ostB_b = x.ostC_b);

PROMPT *** Create  grants  V_PAY_MBDK ***
grant SELECT                                                                 on V_PAY_MBDK      to BARSREADER_ROLE;
grant SELECT                                                                 on V_PAY_MBDK      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PAY_MBDK      to START1;
grant SELECT                                                                 on V_PAY_MBDK      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PAY_MBDK.sql =========*** End *** ===
PROMPT ===================================================================================== 
