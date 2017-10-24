

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/POLICY_TABLE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view POLICY_TABLE ***

  CREATE OR REPLACE FORCE VIEW BARS.POLICY_TABLE ("TABLE_NAME", "SELECT_POLICY", "INSERT_POLICY", "UPDATE_POLICY", "DELETE_POLICY", "REPL_TYPE", "POLICY_GROUP", "OWNER", "POLICY_COMMENT", "CHANGE_TIME", "APPLY_TIME", "WHO_ALTER", "WHO_CHANGE") AS 
  SELECT TABLE_NAME,SELECT_POLICY,INSERT_POLICY,UPDATE_POLICY,DELETE_POLICY,REPL_TYPE,POLICY_GROUP,OWNER,POLICY_COMMENT,CHANGE_TIME,APPLY_TIME,WHO_ALTER,WHO_CHANGE
     FROM BARS.POLICY_TABLE_base b;

PROMPT *** Create  grants  POLICY_TABLE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on POLICY_TABLE    to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on POLICY_TABLE    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on POLICY_TABLE    to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on POLICY_TABLE    to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on POLICY_TABLE    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/POLICY_TABLE.sql =========*** End *** =
PROMPT ===================================================================================== 
