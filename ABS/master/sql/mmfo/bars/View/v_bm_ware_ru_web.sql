

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BM_WARE_RU_WEB.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BM_WARE_RU_WEB ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BM_WARE_RU_WEB ("KOD", "KV", "VES", "VES_UN", "TYPE_", "PROBA", "NAME", "CENA_PROD", "CENA_KUPI", "CENA_NOMI", "KOL") AS 
  SELECT b.KOD,
          b.KV,
          b.VES,
          b.VES_UN,
          b.TYPe_,
          b.PROBA,
          b.NAME,
          b.CENA_PROD,
          b.CENA_KUPI,
          b.CENA_NOMI,
          0 as kol
     FROM BANK_METALS b;

PROMPT *** Create  grants  V_BM_WARE_RU_WEB ***
grant SELECT                                                                 on V_BM_WARE_RU_WEB to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on V_BM_WARE_RU_WEB to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BM_WARE_RU_WEB to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BM_WARE_RU_WEB.sql =========*** End *
PROMPT ===================================================================================== 
