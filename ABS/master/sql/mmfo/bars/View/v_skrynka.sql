

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SKRYNKA.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SKRYNKA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SKRYNKA ("O_SK", "N_SK", "SNUM", "KEYUSED", "ISP_MO", "KEYNUMBER", "BRANCH") AS 
  select O_SK,N_SK,SNUM,KEYUSED,ISP_MO,KEYNUMBER,branch
from skrynka
union all
select O_SK,N_SK,SNUM,KEYUSED,ISP_MO,KEYNUMBER,branch
from skrynka_arc;

PROMPT *** Create  grants  V_SKRYNKA ***
grant SELECT                                                                 on V_SKRYNKA       to BARSREADER_ROLE;
grant SELECT                                                                 on V_SKRYNKA       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SKRYNKA       to DEP_SKRN;
grant SELECT                                                                 on V_SKRYNKA       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SKRYNKA       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SKRYNKA.sql =========*** End *** ====
PROMPT ===================================================================================== 
