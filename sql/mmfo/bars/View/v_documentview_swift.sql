

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DOCUMENTVIEW_SWIFT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DOCUMENTVIEW_SWIFT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DOCUMENTVIEW_SWIFT ("REF", "SWREF", "TAG", "OPT", "VALUE", "SEQ", "N") AS 
  select o.ref, w.swref, w.tag, w.opt, w.value, w.seq, w.n
from sw_operw w, sw_oper o
where o.swref = w.swref
order by w.seq, w.tag, w.opt;

PROMPT *** Create  grants  V_DOCUMENTVIEW_SWIFT ***
grant SELECT                                                                 on V_DOCUMENTVIEW_SWIFT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DOCUMENTVIEW_SWIFT to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DOCUMENTVIEW_SWIFT.sql =========*** E
PROMPT ===================================================================================== 
