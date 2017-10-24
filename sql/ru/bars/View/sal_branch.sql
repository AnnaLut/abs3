

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SAL_BRANCH.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view SAL_BRANCH ***

  CREATE OR REPLACE FORCE VIEW BARS.SAL_BRANCH ("DAPP", "ACCC", "ACC", "NLS", "KV", "NMS", "GRP", "FDAT", "OSTF", "DOS", "KOS", "OST", "NBS", "ISP", "NLSALT", "DAZS", "APP", "TIP", "DAOS", "PAP", "RNK", "TOBO", "BRANCH", "KF") AS 
  select "DAPP","ACCC","ACC","NLS","KV","NMS","GRP","FDAT","OSTF","DOS","KOS","OST","NBS","ISP","NLSALT","DAZS","APP","TIP","DAOS","PAP","RNK","TOBO","BRANCH","KF"
     from sal;

PROMPT *** Create  grants  SAL_BRANCH ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SAL_BRANCH      to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on SAL_BRANCH      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SAL_BRANCH      to RCC_DEAL;
grant SELECT                                                                 on SAL_BRANCH      to RPBN001;
grant SELECT                                                                 on SAL_BRANCH      to SALGL;
grant SELECT                                                                 on SAL_BRANCH      to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SAL_BRANCH      to WR_ALL_RIGHTS;
grant SELECT                                                                 on SAL_BRANCH      to WR_CUSTLIST;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SAL_BRANCH.sql =========*** End *** ===
PROMPT ===================================================================================== 
