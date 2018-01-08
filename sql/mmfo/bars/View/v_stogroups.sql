

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STOGROUPS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STOGROUPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STOGROUPS ("GRP_ID", "GRP_NAME", "TOBO") AS 
  select idg, name, tobo
  from sto_grp
 where tobo = tobopack.gettobo
    or tobo is null;

PROMPT *** Create  grants  V_STOGROUPS ***
grant SELECT                                                                 on V_STOGROUPS     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_STOGROUPS     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_STOGROUPS     to STO;
grant SELECT                                                                 on V_STOGROUPS     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_STOGROUPS     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STOGROUPS.sql =========*** End *** ==
PROMPT ===================================================================================== 
