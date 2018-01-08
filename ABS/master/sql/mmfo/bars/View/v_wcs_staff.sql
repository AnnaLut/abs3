

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_STAFF.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_STAFF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_STAFF ("ID", "FIO", "LOGNAME", "TYPE", "TABN", "BAX", "TBAX", "DISABLE", "ADATE1", "ADATE2", "RDATE1", "RDATE2", "CLSID", "APPROVE", "KF", "BRANCH", "TOBO", "COUNTCONN", "COUNTPASS", "PROFILE", "CSCHEMA", "USEARC", "WEB_PROFILE", "ACTIVE", "EXPIRED", "USEGTW", "BLK", "TBLK", "CAN_SELECT_BRANCH", "CHGPWD", "TIP") AS 
  select s."ID",s."FIO",s."LOGNAME",s."TYPE",s."TABN",s."BAX",s."TBAX",s."DISABLE",s."ADATE1",s."ADATE2",s."RDATE1",s."RDATE2",s."CLSID",s."APPROVE",s."KF",s."BRANCH",s."TOBO",s."COUNTCONN",s."COUNTPASS",s."PROFILE",s."CSCHEMA",s."USEARC",s."WEB_PROFILE",s."ACTIVE",s."EXPIRED",s."USEGTW",s."BLK",s."TBLK",s."CAN_SELECT_BRANCH",s."CHGPWD",s."TIP" from staff s;

PROMPT *** Create  grants  V_WCS_STAFF ***
grant SELECT                                                                 on V_WCS_STAFF     to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_STAFF     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_STAFF     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_STAFF.sql =========*** End *** ==
PROMPT ===================================================================================== 
