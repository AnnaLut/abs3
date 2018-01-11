

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BANK_METALS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BANK_METALS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BANK_METALS ("KF", "BRANCH", "KOD", "KV", "PROBA", "VES", "VES_UN", "TYPE_", "CENA", "CENA_K", "CENA_NOMI", "NLS_3800", "NAME", "NAME_COMMENT") AS 
  SELECT l.kf, l.branch, m.kod, m.kv, m.proba, m.ves, m.ves_un, m.type_,
          l.cena, l.cena_k, m.cena_nomi, a.nls nls_3800, m.NAME,
          m.name_comment
     FROM bank_metals m, bank_metals$local l, accounts a
    WHERE m.kod = l.kod AND l.acc_3800 = a.acc(+);

PROMPT *** Create  grants  V_BANK_METALS ***
grant SELECT                                                                 on V_BANK_METALS   to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BANK_METALS   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_BANK_METALS   to PYOD001;
grant SELECT                                                                 on V_BANK_METALS   to START1;
grant SELECT                                                                 on V_BANK_METALS   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BANK_METALS   to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_BANK_METALS   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BANK_METALS.sql =========*** End *** 
PROMPT ===================================================================================== 
