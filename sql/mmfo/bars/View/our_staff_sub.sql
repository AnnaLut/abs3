

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OUR_STAFF_SUB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view OUR_STAFF_SUB ***

  CREATE OR REPLACE FORCE VIEW BARS.OUR_STAFF_SUB ("ID", "FIO", "LOGNAME", "TYPE", "TABN", "DISABLE", "ADATE1", "ADATE2", "RDATE1", "RDATE2", "USEARC") AS 
  select id, fio, logname, type, tabn, disable, adate1, adate2, rdate1, rdate2, usearc
  from staff$base
 where (branch <> sys_context('bars_context','user_branch')
        and
	branch like sys_context('bars_context','user_branch_mask'))
	or
        sys_context('bars_context','user_branch') = '/'
 ;

PROMPT *** Create  grants  OUR_STAFF_SUB ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OUR_STAFF_SUB   to ABS_ADMIN;
grant SELECT                                                                 on OUR_STAFF_SUB   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OUR_STAFF_SUB   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OUR_STAFF_SUB   to START1;
grant SELECT                                                                 on OUR_STAFF_SUB   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OUR_STAFF_SUB   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OUR_STAFF_SUB.sql =========*** End *** 
PROMPT ===================================================================================== 
