

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FILE_ACCOUNT_TYPES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FILE_ACCOUNT_TYPES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FILE_ACCOUNT_TYPES ("TYPE", "NAME") AS 
  select tip, name
from tips
where tip in ('DEP')
order by ord
 ;

PROMPT *** Create  grants  V_FILE_ACCOUNT_TYPES ***
grant SELECT                                                                 on V_FILE_ACCOUNT_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FILE_ACCOUNT_TYPES to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_FILE_ACCOUNT_TYPES to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FILE_ACCOUNT_TYPES.sql =========*** E
PROMPT ===================================================================================== 
