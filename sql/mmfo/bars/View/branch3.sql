

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BRANCH3.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view BRANCH3 ***

  CREATE OR REPLACE FORCE VIEW BARS.BRANCH3 ("BRANCH", "NAME", "B040", "DESCRIPTION", "IDPDR", "DATE_OPENED", "DATE_CLOSED", "DELETED", "SAB", "OBL", "TOBO", "NAME_ALT") AS 
  SELECT "BRANCH","NAME","B040","DESCRIPTION","IDPDR","DATE_OPENED","DATE_CLOSED","DELETED","SAB","OBL","TOBO","NAME_ALT" from branch WHERE LENGTH (branch) = 22;

PROMPT *** Create  grants  BRANCH3 ***
grant SELECT                                                                 on BRANCH3         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BRANCH3         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BRANCH3.sql =========*** End *** ======
PROMPT ===================================================================================== 
