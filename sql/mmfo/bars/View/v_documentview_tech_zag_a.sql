

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DOCUMENTVIEW_TECH_ZAG_A.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DOCUMENTVIEW_TECH_ZAG_A ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DOCUMENTVIEW_TECH_ZAG_A ("REF", "FN_A", "DAT_A", "DATK_A", "DAT_2_A") AS 
  select a.ref as ref, za.fn as fn_a, za.dat as dat_a, za.datk as datk_a, za.dat_2 as dat_2_a
from arc_rrp a, zag_a za where a.fn_a = za.fn and a.dat_a = za.dat
;

PROMPT *** Create  grants  V_DOCUMENTVIEW_TECH_ZAG_A ***
grant SELECT                                                                 on V_DOCUMENTVIEW_TECH_ZAG_A to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DOCUMENTVIEW_TECH_ZAG_A to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DOCUMENTVIEW_TECH_ZAG_A.sql =========
PROMPT ===================================================================================== 
