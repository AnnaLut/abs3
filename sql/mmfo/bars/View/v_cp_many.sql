

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_MANY.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_MANY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_MANY ("B", "BRANCH", "NLS", "RNK", "CP_ID", "QUOT_SIGN", "ID", "DOX", "KV", "DAT_EM", "DATP", "EMI", "DCP", "FIN23", "VNCRR", "K23", "REF", "DATD", "NOMD", "BV", "PV", "NBS", "IRR0", "REZ23", "PEREOC", "COST", "PRC", "KAT23") AS 
  SELECT B,
          BRANCH,
          NLS,
          RNK,
          CP_ID,
          QUOT_SIGN,
          ID,
          DOX,
          KV,
          DAT_EM,
          DATP,
          EMI,
          DCP,
          FIN23,
          VNCRR,
          K23,
          REF,
          DATD,
          NOMD,
          BV,
          PV,
          NBS,
          round(IRR0,8),
          DECODE (k23, 0, 0, REZ23),
          PEREOC,
          COST,
          ROUND (REZ23 * 100 / cost, 0) PRC,
          --CASE
          --   WHEN NVL (QUOT_SIGN, 0) != 1 THEN KAT23
          --   WHEN ROUND (REZ23 * 100 / cost, 0) < 1 THEN 1 --    K от  0% до   1%   - 1
          --   WHEN ROUND (REZ23 * 100 / cost, 0) < 21 THEN 2 --    K от  1% до  20%   - 2
          --   WHEN ROUND (REZ23 * 100 / cost, 0) < 51 THEN 3 --    K от 21% до  50%   - 3
          --   WHEN ROUND (REZ23 * 100 / cost, 0) < 100 THEN 4 --    K от 51% до  99%   - 4
          --   ELSE 5                               --    K от 99% до 100%   - 5
          --END
          KAT23
     FROM V_CP_MANY1;

PROMPT *** Create  grants  V_CP_MANY ***
grant SELECT                                                                 on V_CP_MANY       to BARSREADER_ROLE;
grant SELECT                                                                 on V_CP_MANY       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_MANY       to START1;
grant SELECT                                                                 on V_CP_MANY       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_MANY.sql =========*** End *** ====
PROMPT ===================================================================================== 
