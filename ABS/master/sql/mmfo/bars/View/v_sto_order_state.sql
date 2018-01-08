

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STO_ORDER_STATE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STO_ORDER_STATE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STO_ORDER_STATE ("ID", "NAME") AS 
  select 1 as  id, 'Новий' as name from dual
union all
select 2 as id,'Підтверджений' as name from dual
union all
select 3 as id, 'Скасований' as name from dual;

PROMPT *** Create  grants  V_STO_ORDER_STATE ***
grant SELECT                                                                 on V_STO_ORDER_STATE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STO_ORDER_STATE.sql =========*** End 
PROMPT ===================================================================================== 
