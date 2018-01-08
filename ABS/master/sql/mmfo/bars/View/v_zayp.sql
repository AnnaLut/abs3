

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAYP.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAYP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAYP ("RNK", "NMK", "OKPO", "KV", "NLS", "DAPP", "OSTC", "NLSV", "MFOV") AS 
  SELECT c.rnk,
            c.nmk,
            c.okpo,
            a.kv,
            a.nls,
            a.dapp,
            a.ostc / 100,
            z.nlsv,
            z.mfov
       FROM accounts a, cust_zay z, customer c
      WHERE     z.rnk = c.rnk
            AND a.nls = z.nls29
            AND z.nlsv IS NOT NULL
            AND z.mfov IS NOT NULL
            AND /*(   z.mfov <> SUBSTR (f_ourmfo, 1, 6)
                 OR*/     z.mfov = SUBSTR (f_ourmfo, 1, 6)
                    AND z.nlsv IN (SELECT nls
                                     FROM accounts
                                    WHERE nls = z.nlsv AND kv = a.kv)/*)*/
            AND a.ostc = a.ostb
            AND a.ostc <> 0
            AND a.nls <> z.nlsv
   ORDER BY 3, 2, 1;

PROMPT *** Create  grants  V_ZAYP ***
grant SELECT                                                                 on V_ZAYP          to BARSREADER_ROLE;
grant SELECT                                                                 on V_ZAYP          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAYP.sql =========*** End *** =======
PROMPT ===================================================================================== 
