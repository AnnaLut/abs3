

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BRANCH_MFO.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view BRANCH_MFO ***

  CREATE OR REPLACE FORCE VIEW BARS.BRANCH_MFO ("MFO", "NAME") AS 
  SELECT SUBSTR(BRANCH,2,6) MFO, NAME
FROM BRANCH
WHERE LENGTH(BRANCH)=8
 ;

PROMPT *** Create  grants  BRANCH_MFO ***
grant SELECT                                                                 on BRANCH_MFO      to BARSREADER_ROLE;
grant SELECT                                                                 on BRANCH_MFO      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BRANCH_MFO      to START1;
grant SELECT                                                                 on BRANCH_MFO      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BRANCH_MFO      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BRANCH_MFO.sql =========*** End *** ===
PROMPT ===================================================================================== 
