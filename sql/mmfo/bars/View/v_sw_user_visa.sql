

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SW_USER_VISA.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SW_USER_VISA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SW_USER_VISA ("GRPID", "GRPNAME") AS 
  select  v.grpid, v.grpname
  from v_user_visa v, sw_chklist s
 where v.grpid = s.idchk
 ;

PROMPT *** Create  grants  V_SW_USER_VISA ***
grant SELECT                                                                 on V_SW_USER_VISA  to BARS013;
grant SELECT                                                                 on V_SW_USER_VISA  to BARSREADER_ROLE;
grant SELECT                                                                 on V_SW_USER_VISA  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SW_USER_VISA  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SW_USER_VISA  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SW_USER_VISA.sql =========*** End ***
PROMPT ===================================================================================== 
