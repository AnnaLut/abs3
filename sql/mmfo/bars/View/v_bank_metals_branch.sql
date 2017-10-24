

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BANK_METALS_BRANCH.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BANK_METALS_BRANCH ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BANK_METALS_BRANCH ("BRANCH", "KOD", "KV", "VES", "VES_UN", "TYPE_", "PROBA", "NAME", "NAME_COMMENT", "CENA", "CENA_K", "NLS_3800", "PDV", "CENA_NOMI", "SUM_KOM", "OB_22") AS 
  SELECT UNIQUE
          SYS_CONTEXT ('bars_context', 'user_branch') branch,
          m.kod,
          m.kv,
          m.ves,
          m.ves_un,
          m.type_,
          m.proba,
          m.NAME,
          m.name_comment,
          FIRST_VALUE (l.cena)
             OVER (PARTITION BY l.kod ORDER BY l.branch DESC)
             cena,
          FIRST_VALUE (l.cena_k)
             OVER (PARTITION BY l.kod ORDER BY l.branch DESC)
             cena_k,
          FIRST_VALUE (a.nls)
             OVER (PARTITION BY l.kod ORDER BY l.branch DESC)
             nls_3800,
          DECODE (m.type_, 2, 1, 0) pdv,
          FIRST_VALUE (m.cena_nomi)
             OVER (PARTITION BY m.kod ORDER BY l.branch DESC)
             cena_nomi,
          FIRST_VALUE (m.sum_kom)
             OVER (PARTITION BY m.kod ORDER BY l.branch DESC)
             sum_kom,
          FIRST_VALUE (m.ob_22)
             OVER (PARTITION BY m.kod ORDER BY l.branch DESC)
             ob_22
     FROM bank_metals m, bank_metals$local l, accounts a
    WHERE     SYS_CONTEXT ('bars_context', 'user_branch') LIKE
                 l.branch || '%'
          AND m.kod = l.kod
          AND l.acc_3800 = a.acc(+);

PROMPT *** Create  grants  V_BANK_METALS_BRANCH ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BANK_METALS_BRANCH to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_BANK_METALS_BRANCH to PYOD001;
grant SELECT                                                                 on V_BANK_METALS_BRANCH to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BANK_METALS_BRANCH to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_BANK_METALS_BRANCH to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BANK_METALS_BRANCH.sql =========*** E
PROMPT ===================================================================================== 
