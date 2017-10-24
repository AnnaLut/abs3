

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/POLICY_TABLE_PKDC.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view POLICY_TABLE_PKDC ***

  CREATE OR REPLACE FORCE VIEW BARS.POLICY_TABLE_PKDC ("TABLE_NAME", "POLICY_GROUP", "OWNER", "WM_DINFO", "WM_THISCHILDSOURCEVER", "WM_THISCHILDSOURCEDS", "WM_OTHERCHILDSOURCEVER", "WM_OTHERCHILDSOURCEDS", "WM$THISCHILDSOURCEVER", "WM$OTHERCHILDSOURCEVER", "WM_THISRID", "WM_OTHERRID", "WM_BASERID") AS 
  select TABLE_NAME,POLICY_GROUP,OWNER,WM_dinfo,
            WM_thischildsourcever,  WM_thischildsourceds, WM_otherchildsourcever, WM_otherchildsourceds,
                       decode (wm_thischildsourcever, 0, 0,
                decode(sys_context('lt_ctx','isCRCase'), 'NO',-2,
                       decode((select 1 from wm$base_hierarchy_view
                               where version = wm_thischildsourcever)
                              , null, -2, wm_thischildsourcever))) wm$thischildsourcever,
                decode (wm_otherchildsourcever, null, -2,
                        0,0,decode(sys_context('lt_ctx','isCRCase'), 'NO',-2,
                       decode(sys_context('lt_ctx','isAncestor'),'true', -2,
                           decode((select 1 from wm$base_hierarchy_view
                                   where version = wm_otherchildsourcever), null,
                                   -2, wm_otherchildsourcever)))) wm$otherchildsourcever,
            WM_thisRID, WM_otherRID,
            (select other.rowid from BARS.POLICY_TABLE_LT other
             where (this.TABLE_NAME = other.TABLE_NAME and this.POLICY_GROUP = other.POLICY_GROUP and this.OWNER = other.OWNER) and
                   other.version in (select version from wmsys.wm$base_hierarchy_view) and
                   other.nextver not in (select next_vers from wmsys.wm$base_nextver_view)) WM_baseRID
    from BARS.POLICY_TABLE_PKDB this 
     where sys_context('lt_ctx', 'isAncestor') = 'false' or
           NOT EXISTS (
           select 1 from BARS.POLICY_TABLE_AUX other
            where (this.TABLE_NAME = other.TABLE_NAME and this.POLICY_GROUP = other.POLICY_GROUP and this.OWNER = other.OWNER) and
           ((other.childstate  = this.WM_thisWspc and 
             other.parentstate = this.WM_otherWspc and
             other.snapshotchild = this.WM_thisdelstatus and 
             (this.WM_otherdelstatus is null OR 
              other.snapshotparent = this.WM_otherdelstatus) and
             other.value = 1) OR
            (other.childstate = this.WM_otherWspc and 
             other.parentstate = this.WM_thisWspc and
             (this.WM_otherdelstatus is null OR 
              other.snapshotchild = this.WM_otherdelstatus) and 
             other.snapshotparent = this.WM_thisdelstatus and
             other.value = 1)) );

PROMPT *** Create  grants  POLICY_TABLE_PKDC ***
grant SELECT                                                                 on POLICY_TABLE_PKDC to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/POLICY_TABLE_PKDC.sql =========*** End 
PROMPT ===================================================================================== 
