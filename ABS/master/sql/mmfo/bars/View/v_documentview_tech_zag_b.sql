

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DOCUMENTVIEW_TECH_ZAG_B.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DOCUMENTVIEW_TECH_ZAG_B ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DOCUMENTVIEW_TECH_ZAG_B ("REF", "FN_B", "DAT_B", "DATK_B") AS 
  select a.ref as ref, zb.fn as fn_b, zb.dat as dat_b, zb.datk as datk_b
from arc_rrp a, zag_b zb where a.fn_b = zb.fn and a.dat_b = zb.dat
;

PROMPT *** Create  grants  V_DOCUMENTVIEW_TECH_ZAG_B ***
grant SELECT                                                                 on V_DOCUMENTVIEW_TECH_ZAG_B to BARSREADER_ROLE;
grant SELECT                                                                 on V_DOCUMENTVIEW_TECH_ZAG_B to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DOCUMENTVIEW_TECH_ZAG_B to START1;
grant SELECT                                                                 on V_DOCUMENTVIEW_TECH_ZAG_B to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DOCUMENTVIEW_TECH_ZAG_B.sql =========
PROMPT ===================================================================================== 
