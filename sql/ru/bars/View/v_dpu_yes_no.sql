

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPU_YES_NO.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPU_YES_NO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPU_YES_NO ("ID", "CODE", "DSC") AS 
  select 1, 'Y', 'връ'
  from dual
 union all
select 0, 'N', 'ЭГ'
  from dual
;

PROMPT *** Create  grants  V_DPU_YES_NO ***
grant SELECT                                                                 on V_DPU_YES_NO    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPU_YES_NO.sql =========*** End *** =
PROMPT ===================================================================================== 
