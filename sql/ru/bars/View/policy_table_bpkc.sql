

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/POLICY_TABLE_BPKC.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view POLICY_TABLE_BPKC ***

  CREATE OR REPLACE FORCE VIEW BARS.POLICY_TABLE_BPKC ("TABLE_NAME", "POLICY_GROUP", "OWNER", "WM_RIDCHILD", "WM_CHILDDS", "WM_CHILDVER", "WM_BASEVER", "WM_BASEDS", "WM_RIDPARENT", "WM_PARENTDS", "WM_PARENTVER", "WM_CHILDSTATE", "WM_PARENTSTATE") AS 
  select o1.TABLE_NAME, o1.POLICY_GROUP, o1.OWNER,
        o1.wm_rid WM_ridchild, o1.delstatus WM_childds,
        o1.version WM_childver,
        o1.WM_basever,
        o1.WM_baseds,
        o2.wm_rid WM_ridparent, o2.delstatus WM_parentds,
        o2.version WM_parentver,
        
        SYS_CONTEXT('lt_ctx','conflict_state') WM_childstate,
        SYS_CONTEXT('lt_ctx','parent_conflict_state') WM_parentstate
    from
    (select /*+ ORDERED */ o1.TABLE_NAME, o1.POLICY_GROUP, o1.OWNER,o1.rowid WM_rid, o1.version, o1.delstatus,substr(o1.ltlock, (instr(o1.ltlock, '*',1,1) + 1), 
       ((instr(o1.ltlock, ',',instr(o1.ltlock, '*',1,1),1)) - 
        instr(o1.ltlock, '*',1,1) - 1)) WM_basever, 
     substr(o1.ltlock, 
       (instr(o1.ltlock, ',',instr(o1.ltlock, '*',1,1),1) + 1),
         (instr(o1.ltlock, ',', instr(o1.ltlock, '*',1,1),2) - 
         instr(o1.ltlock, ',',instr(o1.ltlock, '*',1,1),1) - 1)) WM_baseds
            from wmsys.wm$curConflict_parvers_view cv,
                 BARS.POLICY_TABLE_LT o1
            where cv.vtid = 33
              and o1.version = cv.parent_vers
              and o1.version > (select post_version from wmsys.wm$workspaces_table 
                                where workspace = SYS_CONTEXT('lt_ctx','conflict_state'))
              and not exists (select 1 from wmsys.wm$curConflict_nextvers_view cnv 
                              where cnv.vtid = 33 and cnv.next_vers = o1.nextver)) o1,
    (select /*+ ORDERED */ o1.TABLE_NAME, o1.POLICY_GROUP, o1.OWNER,o1.rowid WM_rid, o1.version, o1.delstatus
            from wmsys.wm$parConflict_parvers_view cv,
                 BARS.POLICY_TABLE_LT o1
            where cv.vtid = 33
              and o1.version = cv.parent_vers
              
              and not exists (select 1 from wmsys.wm$parConflict_nextvers_view cnv 
                              where cnv.vtid = 33 and cnv.next_vers = o1.nextver)) o2
    where (o1.TABLE_NAME = o2.TABLE_NAME AND o1.POLICY_GROUP = o2.POLICY_GROUP AND o1.OWNER = o2.OWNER )
      and not (o1.WM_basever = o2.version and o1.WM_baseds = o2.delstatus);

PROMPT *** Create  grants  POLICY_TABLE_BPKC ***
grant SELECT                                                                 on POLICY_TABLE_BPKC to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/POLICY_TABLE_BPKC.sql =========*** End 
PROMPT ===================================================================================== 
