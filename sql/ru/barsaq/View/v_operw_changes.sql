

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_OPERW_CHANGES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OPERW_CHANGES ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_OPERW_CHANGES ("REF", "TAG", "VALUE") AS 
  select ref, tag, value from bars.operw
where ref in (select ref from barsaq.tmp_dual_opldok);



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_OPERW_CHANGES.sql =========*** End 
PROMPT ===================================================================================== 
