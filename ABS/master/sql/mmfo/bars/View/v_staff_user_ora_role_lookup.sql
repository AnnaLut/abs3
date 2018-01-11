

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STAFF_USER_ORA_ROLE_LOOKUP.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STAFF_USER_ORA_ROLE_LOOKUP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STAFF_USER_ORA_ROLE_LOOKUP ("ROLE_NAME") AS 
  select role_name from roles$base
;

PROMPT *** Create  grants  V_STAFF_USER_ORA_ROLE_LOOKUP ***
grant SELECT                                                                 on V_STAFF_USER_ORA_ROLE_LOOKUP to BARSREADER_ROLE;
grant SELECT                                                                 on V_STAFF_USER_ORA_ROLE_LOOKUP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_STAFF_USER_ORA_ROLE_LOOKUP to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STAFF_USER_ORA_ROLE_LOOKUP.sql ======
PROMPT ===================================================================================== 
