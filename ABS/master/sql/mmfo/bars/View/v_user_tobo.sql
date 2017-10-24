

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USER_TOBO.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USER_TOBO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USER_TOBO ("TOBO", "NAME") AS 
  select t.tobo,t.name from tobo t, staff_branch s 
where t.tobo=s.branch and s.id=BARS.USER_ID

 ;

PROMPT *** Create  grants  V_USER_TOBO ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_USER_TOBO     to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_USER_TOBO     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_USER_TOBO     to BASIC_INFO;
grant SELECT                                                                 on V_USER_TOBO     to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_USER_TOBO     to V_USER_TOBO;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_USER_TOBO     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_USER_TOBO     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USER_TOBO.sql =========*** End *** ==
PROMPT ===================================================================================== 
