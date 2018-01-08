

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DOCUMENTVIEW_TECH.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DOCUMENTVIEW_TECH ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DOCUMENTVIEW_TECH ("REF", "PDAT", "DATP", "FN_A", "DAT_A", "DATK_A", "DAT_2_A", "FN_B", "DAT_B", "DATK_B") AS 
  select o.ref, o.pdat, o.datp,
       za.fn_a, za.dat_a, za.datk_a, za.dat_2_a,
       zb.fn_b, zb.dat_b, zb.datk_b
from oper o, v_documentview_tech_zag_a za, v_documentview_tech_zag_b zb
where o.ref = za.ref(+) and o.ref = zb.ref(+)
;

PROMPT *** Create  grants  V_DOCUMENTVIEW_TECH ***
grant SELECT                                                                 on V_DOCUMENTVIEW_TECH to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DOCUMENTVIEW_TECH to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DOCUMENTVIEW_TECH.sql =========*** En
PROMPT ===================================================================================== 
