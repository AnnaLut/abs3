

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CENTR_KUBM.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CENTR_KUBM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CENTR_KUBM ("KOD", "NAME", "CENA_KUPI", "CENA_PROD", "BRANCH", "CENA_K", "CENA", "OTM", "KV", "VES_G", "VES_U", "NAMET", "PROBA", "BRANCH_OLD", "KUP1GR", "PRD1GR") AS 
  SELECT k.kod, SUBSTR (k.NAME, 1, 100), k.cena_kupi / 100,
          k.cena_prod / 100, b.branch, b.cena_k / 100, b.cena / 100,
          b.acc_3800, k.kv, k.ves, k.ves_un, t.NAME, k.proba,
          NVL (b.branch_old, b.branch),
          DECODE (NVL (k.ves, 0), 0, 0, (b.cena_k / k.ves) / 100) kup1gr,
          DECODE (NVL (k.ves, 0), 0, 0, (b.cena / k.ves) / 100) prd1gr
     FROM bank_metals k, bank_metals$local b, bank_metals_type t
    WHERE k.kod = b.kod ----(+)
      AND k.type_ = t.kod
      AND (   k.cena_kupi IS NOT NULL
           OR k.cena_prod IS NOT NULL
           OR b.cena_k IS NOT NULL
           OR b.cena IS NOT NULL
          );

PROMPT *** Create  grants  V_CENTR_KUBM ***
grant SELECT                                                                 on V_CENTR_KUBM    to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on V_CENTR_KUBM    to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_CENTR_KUBM    to SALGL;
grant SELECT                                                                 on V_CENTR_KUBM    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CENTR_KUBM.sql =========*** End *** =
PROMPT ===================================================================================== 
