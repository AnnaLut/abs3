

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USER_BRANCHES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USER_BRANCHES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USER_BRANCHES ("BRANCH", "NAME", "B040", "DESCRIPTION", "IDPDR", "DATE_OPENED", "DATE_CLOSED", "DELETED", "SAB") AS 
  select b."BRANCH",b."NAME",b."B040",b."DESCRIPTION",b."IDPDR",b."DATE_OPENED",b."DATE_CLOSED",b."DELETED",b."SAB"
  from branch b, staff$base s
 where s.id = sys_context('bars_global','user_id')
   and b.branch like s.branch||'%'
   and b.date_closed is null
  order by 1;

PROMPT *** Create  grants  V_USER_BRANCHES ***
grant SELECT                                                                 on V_USER_BRANCHES to BARSREADER_ROLE;
grant SELECT                                                                 on V_USER_BRANCHES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_USER_BRANCHES to START1;
grant SELECT                                                                 on V_USER_BRANCHES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USER_BRANCHES.sql =========*** End **
PROMPT ===================================================================================== 
