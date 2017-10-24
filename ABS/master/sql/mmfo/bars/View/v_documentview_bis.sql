

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DOCUMENTVIEW_BIS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DOCUMENTVIEW_BIS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DOCUMENTVIEW_BIS ("REF", "BIS") AS 
  select a.ref, b.nazn || decode(b.nazns, 33, b.d_rec, '') as bis
from arc_rrp a, arc_rrp b
where a.bis = 1 and a.fn_a = b.fn_a and a.dat_a = b.dat_a and
      a.rec <> b.rec and a.rec_a-a.bis = b.rec_a-b.bis and b.bis > 0
order by b.bis;

PROMPT *** Create  grants  V_DOCUMENTVIEW_BIS ***
grant SELECT                                                                 on V_DOCUMENTVIEW_BIS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DOCUMENTVIEW_BIS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DOCUMENTVIEW_BIS.sql =========*** End
PROMPT ===================================================================================== 
