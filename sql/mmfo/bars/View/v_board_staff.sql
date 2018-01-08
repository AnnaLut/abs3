

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BOARD_STAFF.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BOARD_STAFF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BOARD_STAFF ("ID", "FIO", "LOGNAME", "TYPE", "TABN", "BAX", "TBAX", "DISABLE", "ADATE1", "ADATE2", "RDATE1", "RDATE2", "CLSID", "APPROVE", "BRANCH", "COUNTCONN", "COUNTPASS", "PROFILE", "USEARC", "CSCHEMA", "WEB_PROFILE", "POLICY_GROUP", "ACTIVE", "CREATED", "EXPIRED", "CHKSUM", "USEGTW", "BLK", "TBLK") AS 
  select "ID","FIO","LOGNAME","TYPE","TABN","BAX","TBAX","DISABLE","ADATE1","ADATE2","RDATE1","RDATE2","CLSID","APPROVE","BRANCH","COUNTCONN","COUNTPASS","PROFILE","USEARC","CSCHEMA","WEB_PROFILE","POLICY_GROUP","ACTIVE","CREATED","EXPIRED","CHKSUM","USEGTW","BLK","TBLK" from staff$base where logname in (select writer from bars_board)
 ;

PROMPT *** Create  grants  V_BOARD_STAFF ***
grant SELECT                                                                 on V_BOARD_STAFF   to BARSREADER_ROLE;
grant SELECT                                                                 on V_BOARD_STAFF   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BOARD_STAFF   to BASIC_INFO;
grant SELECT                                                                 on V_BOARD_STAFF   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BOARD_STAFF   to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_BOARD_STAFF   to WR_BOARD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BOARD_STAFF.sql =========*** End *** 
PROMPT ===================================================================================== 
