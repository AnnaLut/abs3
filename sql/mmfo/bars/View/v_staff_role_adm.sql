

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STAFF_ROLE_ADM.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STAFF_ROLE_ADM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STAFF_ROLE_ADM ("ID", "ROLE_CODE", "ROLE_NAME", "STATE_NAME") AS 
  select t.id,
       t.role_code,
       t.role_name,
       list_utl.get_item_name('STAFF_ROLE_STATE', t.state_id) state_name
from   staff_role t
where  state_id <> 3 /*user_role_utl,ROLE_STATE_CLOSED*/;

PROMPT *** Create  grants  V_STAFF_ROLE_ADM ***
grant SELECT                                                                 on V_STAFF_ROLE_ADM to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STAFF_ROLE_ADM.sql =========*** End *
PROMPT ===================================================================================== 
