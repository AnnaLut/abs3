

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SAL_BRANCH.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view SAL_BRANCH ***

  CREATE OR REPLACE FORCE VIEW BARS.SAL_BRANCH ("DAPP", "ACCC", "ACC", "NLS", "KV", "NMS", "GRP", "FDAT", "OSTF", "DOS", "KOS", "OST", "NBS", "ISP", "NLSALT", "DAZS", "APP", "TIP", "DAOS", "PAP", "RNK", "TOBO", "BRANCH", "KF") AS 
  SELECT s.DAPP
     , s.ACCC
     , s.ACC
     , s.NLS
     , s.KV
     , s.NMS
     , s.GRP
     , s.FDAT
     , s.OSTF
     , s.DOS
     , s.KOS
     , s.OST
     , s.NBS
     , s.ISP
     , s.NLSALT
     , s.DAZS
     , s.APP
     , s.TIP
     , s.DAOS
     , s.PAP
     , s.RNK
     , s.TOBO
     , s.BRANCH
     , s.KF
  from SAL s
  join V_USER_ALLOWED_BRANCHES b
    on ( b.BRANCH = s.BRANCH );

PROMPT *** Create  grants  SAL_BRANCH ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SAL_BRANCH      to ABS_ADMIN;
grant SELECT                                                                 on SAL_BRANCH      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SAL_BRANCH      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SAL_BRANCH      to RCC_DEAL;
grant SELECT                                                                 on SAL_BRANCH      to RPBN001;
grant SELECT                                                                 on SAL_BRANCH      to SALGL;
grant SELECT                                                                 on SAL_BRANCH      to START1;
grant SELECT                                                                 on SAL_BRANCH      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SAL_BRANCH      to WR_ALL_RIGHTS;
grant SELECT                                                                 on SAL_BRANCH      to WR_CUSTLIST;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SAL_BRANCH.sql =========*** End *** ===
PROMPT ===================================================================================== 
