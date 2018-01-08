

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CIN_OPERW.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view CIN_OPERW ***

  CREATE OR REPLACE FORCE VIEW BARS.CIN_OPERW ("TAG", "NAME_TAG", "NOM", "LOT", "TK", "NAME_TK", "REF", "SK_A1", "MFO", "NLS", "KOL", "A1") AS 
  select
    TAG, NAME_tag, NOM, LOT, tk, name_tk, ref, SK_A1, mfo, nls, kol,
    sk_a1 * kol
from (select
        c.tag, c.name name_tag,c.nom, c.kol lot, t.id tk, t.name name_tk,
        o.ref, k.SK_A1,t.mfo,t.nls,
        to_number(substr(value, instr( value,':',1)+1,5 )) kol
      from cin_tag c, cin_tk t,  cin_tag_tk k, oper o, operw w
      where c.tag  = w.tag
        and w.ref  = o.ref
        and t.id   = k.tk
        and k.tag  = c.tag
        and o.mfob = t.mfo
        and o.nlsb = t.nls  )
;

PROMPT *** Create  grants  CIN_OPERW ***
grant SELECT                                                                 on CIN_OPERW       to BARSREADER_ROLE;
grant SELECT                                                                 on CIN_OPERW       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIN_OPERW       to PYOD001;
grant SELECT                                                                 on CIN_OPERW       to START1;
grant SELECT                                                                 on CIN_OPERW       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CIN_OPERW.sql =========*** End *** ====
PROMPT ===================================================================================== 
