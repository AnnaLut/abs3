

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BM_WARE_RU.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BM_WARE_RU ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BM_WARE_RU ("KOD", "KV", "VES", "VES_UN", "TYPE_", "PROBA", "NAME", "CENA_PROD", "CENA_KUPI", "CENA_NOMI", "KOL") AS 
  select b.KOD, b.KV,  b.VES,  b.VES_UN,  b.TYPe_,  b.PROBA,  b.NAME,
  b.CENA_PROD, b.CENA_KUPI, b.CENA_NOMI, d.dk
from BANK_METALS  b, dk d
where d.dk =0;

PROMPT *** Create  grants  V_BM_WARE_RU ***
grant SELECT                                                                 on V_BM_WARE_RU    to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on V_BM_WARE_RU    to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_BM_WARE_RU    to START1;
grant SELECT                                                                 on V_BM_WARE_RU    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BM_WARE_RU.sql =========*** End *** =
PROMPT ===================================================================================== 
