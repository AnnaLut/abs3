

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BRANCH2.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view BRANCH2 ***

  CREATE OR REPLACE FORCE VIEW BARS.BRANCH2 ("BRANCH", "NAME", "B040", "DESCRIPTION", "IDPDR", "DATE_OPENED", "DATE_CLOSED", "DELETED", "SAB", "OBL") AS 
  SELECT "BRANCH","NAME","B040","DESCRIPTION","IDPDR","DATE_OPENED","DATE_CLOSED","DELETED","SAB","OBL" from branch WHERE LENGTH (branch) = 15;

PROMPT *** Create  grants  BRANCH2 ***
grant SELECT                                                                 on BRANCH2         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BRANCH2         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BRANCH2.sql =========*** End *** ======
PROMPT ===================================================================================== 
