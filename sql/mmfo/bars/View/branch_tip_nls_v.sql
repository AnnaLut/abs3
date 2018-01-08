

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BRANCH_TIP_NLS_V.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view BRANCH_TIP_NLS_V ***

  CREATE OR REPLACE FORCE VIEW BARS.BRANCH_TIP_NLS_V ("TIP", "NBS", "OB22", "MASK", "TXT") AS 
  select b.TIP,
  b.NBS ,
  b.OB22 ,
  b.MASK , o.txt from  BRANCH_TIP_NLS b, SB_OB22 o where b.nbs=o.R020 and b.ob22=o.OB22 
 ;

PROMPT *** Create  grants  BRANCH_TIP_NLS_V ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BRANCH_TIP_NLS_V to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BRANCH_TIP_NLS_V to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BRANCH_TIP_NLS_V to CUST001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BRANCH_TIP_NLS_V to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on BRANCH_TIP_NLS_V to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BRANCH_TIP_NLS_V.sql =========*** End *
PROMPT ===================================================================================== 
