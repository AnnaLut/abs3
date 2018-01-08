

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STAFF_USER_ROLE_LOOKUP.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STAFF_USER_ROLE_LOOKUP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STAFF_USER_ROLE_LOOKUP ("ID", "ROLE_CODE", "ROLE_NAME") AS 
  select t.id, t.role_code, t.role_name
from   staff_role t
where  t.state_id = 1 /*user_role_utl.ROLE_STATE_ACTIVE*/
;

PROMPT *** Create  grants  V_STAFF_USER_ROLE_LOOKUP ***
grant SELECT                                                                 on V_STAFF_USER_ROLE_LOOKUP to BARSREADER_ROLE;
grant SELECT                                                                 on V_STAFF_USER_ROLE_LOOKUP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_STAFF_USER_ROLE_LOOKUP to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STAFF_USER_ROLE_LOOKUP.sql =========*
PROMPT ===================================================================================== 
