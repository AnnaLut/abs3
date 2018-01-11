

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_UA.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_UA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_UA ("DAT_EM", "CP_ID", "KV", "EMI", "VIDD", "RYN", "DATP", "KOL", "NOM", "CENA", "CENA_KUP", "S_NAR", "S_NARQ", "DOK", "DNK", "DAT_R", "DAT_K", "REF", "IR", "ID", "ID_U", "FRM") AS 
  SELECT DAT_EM,  CP_ID,  KV,  EMI, VIDD, t.RYN, DATP,
          KOL, NOM, CENA, CENA_KUP, S_NAR, S_NARQ,
          DOK, DNK,
          DAT_R,
          DAT_K, REF,
          IR,
          ID,
          ID_U,
          FRM
     FROM tmp_cp_ua t
    WHERE 1=1 and frm = 25;

PROMPT *** Create  grants  V_CP_UA ***
grant SELECT                                                                 on V_CP_UA         to BARSREADER_ROLE;
grant SELECT                                                                 on V_CP_UA         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_UA         to START1;
grant SELECT                                                                 on V_CP_UA         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_UA.sql =========*** End *** ======
PROMPT ===================================================================================== 
