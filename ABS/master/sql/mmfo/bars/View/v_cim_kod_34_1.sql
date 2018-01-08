

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_KOD_34_1.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_KOD_34_1 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_KOD_34_1 ("ID", "NAME") AS 
  select 1, 'гарантований' from dual
union
select 2, 'негарантований' from dual
union
select 3, 'у гривнях від ЄБРР' from dual
;

PROMPT *** Create  grants  V_CIM_KOD_34_1 ***
grant SELECT                                                                 on V_CIM_KOD_34_1  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_KOD_34_1.sql =========*** End ***
PROMPT ===================================================================================== 
