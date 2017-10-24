

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CHECKS_WEB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CHECKS_WEB ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CHECKS_WEB ("PAP", "ID", "FDAT", "ND", "S", "MFO", "NLS", "OKPO", "REF1", "KV", "NB", "FIO", "BIC_E", "NAME", "NOM", "KOL", "TOBO", "NAMEUKRB", "MFOA") AS 
  (select c.ids as pap,
           c.id,
           c.fdat,
           c.nd,
           c.s / 100 s,
           c.mfo,
           c.nls,
           c.okpo,
           c.ref1,
           c.kv,
           b.nb,
           c.fio,
           c.bic_e,
           substr (s.name, 1, 38) name,
           c.nom,
           c.kol,
           c.tobo,
           l.nameukrb,
           c.mfoa
      from ch_1 c,
           banks b,
           ch_bic s,
           alegro l
     where     c.bic_e = s.bic_e(+)
           and c.tobo = l.num(+)
           and c.mfo = l.mfo(+)
           and nvl (c.mfoa, c.mfo) = b.mfo(+)
           and c.ref2 is null
           and c.kv = to_number (pul.get ('CHKVC')));

PROMPT *** Create  grants  V_CHECKS_WEB ***
grant SELECT                                                                 on V_CHECKS_WEB    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CHECKS_WEB.sql =========*** End *** =
PROMPT ===================================================================================== 
