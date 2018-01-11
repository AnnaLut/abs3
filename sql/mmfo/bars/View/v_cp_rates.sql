

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_RATES.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_RATES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_RATES ("ID", "CP_ID", "VDATE", "BSUM", "RATE_O", "RATE_B", "RATE_S", "IDB", "DY", "KOEFF", "PRO", "IDU", "PRI") AS 
  SELECT ID,
       (SELECT cp_id
          FROM cp_kod
         WHERE id = cr.id)
          cp_id,
       VDATE,
       BSUM,
       RATE_O,
       RATE_B,
       RATE_S,
       IDB,
       DY,
       KOEFF,
       PRO,
       IDU,
       PRI
  FROM CP_RATES cr;

PROMPT *** Create  grants  V_CP_RATES ***
grant SELECT                                                                 on V_CP_RATES      to BARSREADER_ROLE;
grant SELECT                                                                 on V_CP_RATES      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_RATES      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_RATES.sql =========*** End *** ===
PROMPT ===================================================================================== 
