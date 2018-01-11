

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SAL_GL.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view SAL_GL ***

  CREATE OR REPLACE FORCE VIEW BARS.SAL_GL ("DAPP", "ACCC", "ACC", "NLS", "KV", "NMS", "GRP", "FDAT", "OSTF", "DOS", "KOS", "OST", "NBS", "ISP", "NLSALT", "DAZS", "APP", "TIP", "DAOS", "PAP", "RNK", "TOBO", "BRANCH", "KF") AS 
  select "DAPP","ACCC","ACC","NLS","KV","NMS","GRP","FDAT","OSTF","DOS","KOS","OST","NBS","ISP","NLSALT","DAZS","APP","TIP","DAOS","PAP","RNK","TOBO","BRANCH","KF"
  from sal_branch;

PROMPT *** Create  grants  SAL_GL ***
grant SELECT                                                                 on SAL_GL          to BARSREADER_ROLE;
grant SELECT                                                                 on SAL_GL          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SAL_GL          to RPBN001;
grant SELECT                                                                 on SAL_GL          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SAL_GL          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SAL_GL.sql =========*** End *** =======
PROMPT ===================================================================================== 
