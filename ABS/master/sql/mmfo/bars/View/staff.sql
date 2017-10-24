

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/STAFF.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view STAFF ***

  CREATE OR REPLACE FORCE VIEW BARS.STAFF ("ID", "FIO", "LOGNAME", "TYPE", "TABN", "BAX", "TBAX", "DISABLE", "ADATE1", "ADATE2", "RDATE1", "RDATE2", "CLSID", "APPROVE", "KF", "BRANCH", "TOBO", "COUNTCONN", "COUNTPASS", "PROFILE", "CSCHEMA", "USEARC", "WEB_PROFILE", "ACTIVE", "EXPIRED", "USEGTW", "BLK", "TBLK", "CAN_SELECT_BRANCH", "CHGPWD", "TIP") AS 
  select id, fio, logname, type, tabn, bax, tbax, disable,
       adate1, adate2, rdate1, rdate2,
       clsid, approve, substr(bars_context.extract_mfo(branch),1,12) kf,
       branch, branch tobo, countconn, countpass, profile, cschema,
       usearc, web_profile, active, expired, usegtw,
       blk, tblk, can_select_branch, chgpwd, tip
  from staff$base
 where branch like sys_context('bars_context','user_branch_mask')
    or current_branch like sys_context('bars_context','user_branch_mask')
;

PROMPT *** Create  grants  STAFF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF           to ABS_ADMIN;
grant SELECT                                                                 on STAFF           to BARSAQ with grant option;
grant SELECT                                                                 on STAFF           to BARSAQ_ADM with grant option;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAFF           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAFF           to BASIC_INFO;
grant SELECT                                                                 on STAFF           to DPT;
grant SELECT                                                                 on STAFF           to DPT_ADMIN;
grant SELECT                                                                 on STAFF           to DPT_ROLE;
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on STAFF           to FINMON;
grant SELECT                                                                 on STAFF           to FINMON01;
grant SELECT                                                                 on STAFF           to RBL;
grant SELECT                                                                 on STAFF           to RCC_DEAL;
grant SELECT                                                                 on STAFF           to RPBN001;
grant SELECT                                                                 on STAFF           to SALGL;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF           to STAFF;
grant SELECT                                                                 on STAFF           to START1;
grant SELECT                                                                 on STAFF           to TOSS;
grant SELECT                                                                 on STAFF           to WEB_BALANS;
grant SELECT                                                                 on STAFF           to WR_ACRINT;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAFF           to WR_ALL_RIGHTS;
grant SELECT                                                                 on STAFF           to WR_CREPORTS;
grant SELECT                                                                 on STAFF           to WR_CUSTLIST;
grant SELECT                                                                 on STAFF           to WR_DOC_INPUT;
grant SELECT                                                                 on STAFF           to WR_KP;
grant SELECT                                                                 on STAFF           to WR_ND_ACCOUNTS;
grant FLASHBACK,SELECT                                                       on STAFF           to WR_REFREAD;
grant SELECT                                                                 on STAFF           to WR_VIEWACC;
grant SELECT                                                                 on STAFF           to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/STAFF.sql =========*** End *** ========
PROMPT ===================================================================================== 
