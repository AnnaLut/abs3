

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WEB_USERPARAMS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WEB_USERPARAMS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WEB_USERPARAMS ("USRID", "PAR", "VAL", "COMM") AS 
  SELECT USRID, PAR, VAL, COMM
FROM   WEB_USERPARAMS
WHERE  USRID = USER_ID
 ;

PROMPT *** Create  grants  V_WEB_USERPARAMS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_WEB_USERPARAMS to ABS_ADMIN;
grant SELECT                                                                 on V_WEB_USERPARAMS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_WEB_USERPARAMS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WEB_USERPARAMS to BASIC_INFO;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_WEB_USERPARAMS to START1;
grant SELECT                                                                 on V_WEB_USERPARAMS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_WEB_USERPARAMS to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_WEB_USERPARAMS to WR_CUSTLIST;
grant SELECT                                                                 on V_WEB_USERPARAMS to WR_DOCVIEW;
grant SELECT                                                                 on V_WEB_USERPARAMS to WR_TOBO_ACCOUNTS_LIST;
grant SELECT                                                                 on V_WEB_USERPARAMS to WR_USER_ACCOUNTS_LIST;
grant SELECT                                                                 on V_WEB_USERPARAMS to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WEB_USERPARAMS.sql =========*** End *
PROMPT ===================================================================================== 
