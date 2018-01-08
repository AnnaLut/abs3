

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BRANCH_ACCESS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BRANCH_ACCESS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BRANCH_ACCESS ("BRANCH", "NAME", "B040", "DESCRIPTION", "IDPDR", "DATE_OPENED", "DATE_CLOSED", "DELETED", "SAB") AS 
  select "BRANCH","NAME","B040","DESCRIPTION","IDPDR","DATE_OPENED","DATE_CLOSED","DELETED","SAB" from branch
 ;

PROMPT *** Create  grants  V_BRANCH_ACCESS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BRANCH_ACCESS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BRANCH_ACCESS.sql =========*** End **
PROMPT ===================================================================================== 
