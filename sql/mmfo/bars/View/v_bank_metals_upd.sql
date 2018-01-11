

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BANK_METALS_UPD.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BANK_METALS_UPD ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BANK_METALS_UPD ("KOD", "NAME", "KV", "TYPE_", "PROBA", "VES", "VES_UN", "CENA", "CENA_K", "CENA_NOMI", "BRANCH", "ACTION", "ISP", "BDATE", "SDATE", "IDUPD") AS 
  SELECT m.kod, m.NAME, m.kv, m.type_, m.proba, m.ves, m.ves_un, u.cena,
          u.cena_k, m.cena_nomi, u.branch, a.NAME action,
          TO_CHAR (s.ID) || '  ' || SUBSTR (s.fio, 1, 100) isp, u.bdate,
          u.sdate, u.idupd
     FROM bank_metals$local_upd u,
          bank_metals m,
          bank_metals_action a,
          staff$base s
    WHERE u.kod = m.kod AND u.action_id = a.ID AND s.ID = u.isp;

PROMPT *** Create  grants  V_BANK_METALS_UPD ***
grant SELECT                                                                 on V_BANK_METALS_UPD to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BANK_METALS_UPD to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_BANK_METALS_UPD to PYOD001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BANK_METALS_UPD to START1;
grant SELECT                                                                 on V_BANK_METALS_UPD to UPLD;
grant FLASHBACK,SELECT                                                       on V_BANK_METALS_UPD to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BANK_METALS_UPD.sql =========*** End 
PROMPT ===================================================================================== 
