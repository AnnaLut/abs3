

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/POLICY_TABLE_PKD.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view POLICY_TABLE_PKD ***

  CREATE OR REPLACE FORCE VIEW BARS.POLICY_TABLE_PKD ("TABLE_NAME", "POLICY_GROUP", "OWNER", "WM_DINFO", "WM_THISCHILDSOURCEVER", "WM_THISCHILDSOURCEDS", "WM_OTHERCHILDSOURCEVER", "WM_OTHERCHILDSOURCEDS", "WM_THISRID", "WM_OTHERRID", "WM_OTHERISNULL", "WM_BASERID") AS 
  select TABLE_NAME,POLICY_GROUP,OWNER,WM_dinfo,
             WM_thischildsourcever,  WM_thischildsourceds, WM_otherchildsourcever, WM_otherchildsourceds,
             WM_thisRID,
             nvl(WM_otherRID,  WM_baseRID) WM_otherRID, decode(WM_otherRID, null, 1, 0) WM_otherIsNull,
             decode(sys_context('lt_ctx','isCRCase'),
                    'NO', WM_baseRID,
                    (select other.rowid from BARS.POLICY_TABLE_LT other
      where (this.TABLE_NAME = other.TABLE_NAME and this.POLICY_GROUP = other.POLICY_GROUP and this.OWNER = other.OWNER) and
            version  =
               (decode(wm$thischildsourcever, -2,
                  decode(wm$otherchildsourcever,-2,-2,
                     wm$otherchildsourcever),
                    decode(wm$otherchildsourcever,-2, wm$thischildsourcever,
                     decode(sign(wm$otherchildsourcever - wm$thischildsourcever),
                             0, decode(sign(wm_otherchildsourceds - wm_thischildsourceds),
                                      1, wm$thischildsourcever, wm$otherchildsourcever),
                            1, wm$thischildsourcever, wm$otherchildsourcever)))) and 
            delstatus =
               (decode(wm$thischildsourcever, -2,
                   decode(wm$otherchildsourcever,-2,-2,
                      wm_otherchildsourceds),
                   decode(wm$otherchildsourcever,-2, wm_thischildsourceds,
                     decode(sign(wm_otherchildsourcever - wm$thischildsourcever),
                             0, decode(sign(wm_otherchildsourceds - wm_thischildsourceds),
                                       1, wm_thischildsourceds, wm_otherchildsourceds),
                            1, wm_thischildsourceds, wm_otherchildsourceds)))))) WM_baseRID
      from BARS.POLICY_TABLE_PKDC this ;

PROMPT *** Create  grants  POLICY_TABLE_PKD ***
grant SELECT                                                                 on POLICY_TABLE_PKD to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/POLICY_TABLE_PKD.sql =========*** End *
PROMPT ===================================================================================== 
