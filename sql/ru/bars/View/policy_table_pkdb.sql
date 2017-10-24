

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/POLICY_TABLE_PKDB.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view POLICY_TABLE_PKDB ***

  CREATE OR REPLACE FORCE VIEW BARS.POLICY_TABLE_PKDB ("TABLE_NAME", "POLICY_GROUP", "OWNER", "WM_DINFO", "WM_THISWSPC", "WM_OTHERWSPC", "WM_THISRID", "WM_THISDELSTATUS", "WM_THISCHILDSOURCEVER", "WM_THISCHILDSOURCEDS", "WM_OTHERRID", "WM_OTHERDELSTATUS", "WM_OTHERCHILDSOURCEVER", "WM_OTHERCHILDSOURCEDS") AS 
  select /*+ ORDERED PUSH_SUBQ */ this.TABLE_NAME,this.POLICY_GROUP,this.OWNER, 'diff1' WM_dinfo,
             sys_context('lt_ctx', 'diffWspc1') WM_thisWspc, sys_context('lt_ctx', 'diffWspc2') WM_otherWspc,
             this.WM_rid WM_thisRID,   this.delstatus  WM_thisDelstatus, 
                 substr(this.ltlock, (instr(this.ltlock, '*',1,1) + 1), 
                   (instr(this.ltlock, ',',(instr(this.ltlock, '*',1,1)),1) - 
                    instr(this.ltlock, '*',1,1) - 1)) wm_thisChildSourceVer,
                 substr(this.ltlock,(instr(this.ltlock,',',instr(this.ltlock, '*',1,1),1) + 1),
                   (instr(this.ltlock,',',instr(this.ltlock, '*',1,1),2) - 
                    instr(this.ltlock,',',instr(this.ltlock, '*',1,1),1) - 1 ) ) wm_thisChildSourceDS,
             other.WM_rid WM_otherRID, other.delstatus WM_otherDelstatus,
                 substr(other.ltlock, (instr(other.ltlock, '*',1,1) + 1), 
                   (instr(other.ltlock, ',',(instr(other.ltlock, '*',1,1)),1) - 
                    instr(other.ltlock, '*',1,1) - 1)) wm_otherChildSourceVer,
                 substr(other.ltlock,(instr(other.ltlock,',',instr(other.ltlock, '*',1,1),1) + 1),
                   (instr(other.ltlock,',',instr(other.ltlock, '*',1,1),2) - 
                    instr(other.ltlock,',',instr(other.ltlock, '*',1,1),1) - 1 ) ) wm_otherChildSourceDS
      from (select /*+ ORDERED */
                    lt.TABLE_NAME,lt.POLICY_GROUP,lt.OWNER ,lt.rowid WM_rid, lt.delstatus, lt.ltlock
              from wmsys.wm$net_diff1_hierarchy_view d1,
                   BARS.POLICY_TABLE_LT lt
              where lt.version = d1.version  and
                    lt.nextver not in(select next_vers from wmsys.wm$diff1_nextver_view)) this,
           (select /*+ ORDERED */
                    lt.TABLE_NAME,lt.POLICY_GROUP,lt.OWNER ,lt.rowid WM_rid, lt.delstatus, lt.ltlock
              from wmsys.wm$net_diff2_hierarchy_view d1,
                   BARS.POLICY_TABLE_LT lt
              where lt.version = d1.version  and
                    lt.nextver not in(select next_vers from wmsys.wm$diff2_nextver_view)) other
      where (this.TABLE_NAME=other.TABLE_NAME(+) and this.POLICY_GROUP=other.POLICY_GROUP(+) and this.OWNER=other.OWNER(+))
      union all
      select /*+ ORDERED PUSH_SUBQ */ this.TABLE_NAME,this.POLICY_GROUP,this.OWNER, 'diff2' WM_dinfo,
             sys_context('lt_ctx', 'diffWspc1') WM_thisWspc, sys_context('lt_ctx', 'diffWspc2') WM_otherWspc,
             this.WM_rid WM_thisRID,   this.delstatus  WM_thisDelstatus, 
                 substr(this.ltlock, (instr(this.ltlock, '*',1,1) + 1), 
                   (instr(this.ltlock, ',',(instr(this.ltlock, '*',1,1)),1) - 
                    instr(this.ltlock, '*',1,1) - 1)) wm_thisChildSourceVer,
                 substr(this.ltlock,(instr(this.ltlock,',',instr(this.ltlock, '*',1,1),1) + 1),
                   (instr(this.ltlock,',',instr(this.ltlock, '*',1,1),2) - 
                    instr(this.ltlock,',',instr(this.ltlock, '*',1,1),1) - 1 ) ) wm_thisChildSourceDS,
             other.WM_rid WM_otherRID, other.delstatus WM_otherDelstatus,
                 substr(other.ltlock, (instr(other.ltlock, '*',1,1) + 1), 
                   (instr(other.ltlock, ',',(instr(other.ltlock, '*',1,1)),1) - 
                    instr(other.ltlock, '*',1,1) - 1)) wm_otherChildSourceVer,
                 substr(other.ltlock,(instr(other.ltlock,',',instr(other.ltlock, '*',1,1),1) + 1),
                   (instr(other.ltlock,',',instr(other.ltlock, '*',1,1),2) - 
                    instr(other.ltlock,',',instr(other.ltlock, '*',1,1),1) - 1 ) ) wm_otherChildSourceDS
      from (select /*+ ORDERED */
                    lt.TABLE_NAME,lt.POLICY_GROUP,lt.OWNER ,lt.rowid WM_rid, lt.delstatus, lt.ltlock
              from wmsys.wm$net_diff2_hierarchy_view d1,
                   BARS.POLICY_TABLE_LT lt
              where lt.version = d1.version  and
                    lt.nextver not in(select next_vers from wmsys.wm$diff2_nextver_view)) this,
           (select /*+ ORDERED */
                    lt.TABLE_NAME,lt.POLICY_GROUP,lt.OWNER ,lt.rowid WM_rid, lt.delstatus, lt.ltlock
              from wmsys.wm$net_diff1_hierarchy_view d1,
                   BARS.POLICY_TABLE_LT lt
              where lt.version = d1.version  and
                    lt.nextver not in(select next_vers from wmsys.wm$diff1_nextver_view)) other
      where (this.TABLE_NAME=other.TABLE_NAME(+) and this.POLICY_GROUP=other.POLICY_GROUP(+) and this.OWNER=other.OWNER(+)) and (other.TABLE_NAME is null or other.POLICY_GROUP is null or other.OWNER is null);

PROMPT *** Create  grants  POLICY_TABLE_PKDB ***
grant SELECT                                                                 on POLICY_TABLE_PKDB to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/POLICY_TABLE_PKDB.sql =========*** End 
PROMPT ===================================================================================== 
