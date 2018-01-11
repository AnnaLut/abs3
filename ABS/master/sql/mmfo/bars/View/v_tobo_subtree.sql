

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TOBO_SUBTREE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TOBO_SUBTREE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TOBO_SUBTREE ("TOBO", "NAME") AS 
  SELECT TOBO, NAME
	FROM TOBO
	WHERE TOBO like decode(TOBOPACK.GETTOBO, '0', '%', TOBOPACK.GETTOBO)
 ;

PROMPT *** Create  grants  V_TOBO_SUBTREE ***
grant SELECT                                                                 on V_TOBO_SUBTREE  to BARSREADER_ROLE;
grant SELECT                                                                 on V_TOBO_SUBTREE  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_TOBO_SUBTREE  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_TOBO_SUBTREE  to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_TOBO_SUBTREE  to WR_CUSTREG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TOBO_SUBTREE.sql =========*** End ***
PROMPT ===================================================================================== 
