

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/POLICY_TABLE_CONF.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view POLICY_TABLE_CONF ***

  CREATE OR REPLACE FORCE VIEW BARS.POLICY_TABLE_CONF ("WM_WORKSPACE", "TABLE_NAME", "SELECT_POLICY", "INSERT_POLICY", "UPDATE_POLICY", "DELETE_POLICY", "REPL_TYPE", "POLICY_GROUP", "OWNER", "POLICY_COMMENT", "CHANGE_TIME", "APPLY_TIME", "WHO_ALTER", "WHO_CHANGE", "WM_DELETED") AS 
  select WM_workspace,TABLE_NAME,SELECT_POLICY,INSERT_POLICY,UPDATE_POLICY,DELETE_POLICY,REPL_TYPE,POLICY_GROUP,OWNER,POLICY_COMMENT,CHANGE_TIME,APPLY_TIME,WHO_ALTER,WHO_CHANGE,WM_deleted
     from
     ((select /*+ ORDERED USE_NL(pkc e) */
             decode(e.wm_rid, pkc.WM_ridchild,   sys_context('lt_ctx','conflict_state'),
                              pkc.WM_ridbase,    'BASE',
                              pkc.WM_ridparent,  sys_context('lt_ctx','parent_conflict_state'))  WM_workspace,
             decode(e.wm_rid, pkc.WM_ridbase,    decode(sign(e.delstatus)*floor(abs(e.delstatus/10)),0,'NE',-1,'YES','NO'),
                              decode(sign(e.delstatus), -1, 'YES', 'NO')) WM_deleted,
             decode(e.wm_rid, pkc.WM_ridchild,  1,
                              pkc.WM_ridbase,   2,
                              pkc.WM_ridparent, 3) WM_pos,
             pkc.TABLE_NAME,e.SELECT_POLICY,e.INSERT_POLICY,e.UPDATE_POLICY,e.DELETE_POLICY,e.REPL_TYPE,pkc.POLICY_GROUP,pkc.OWNER,e.POLICY_COMMENT,e.CHANGE_TIME,e.APPLY_TIME,e.WHO_ALTER,e.WHO_CHANGE
      from BARS.POLICY_TABLE_PKC pkc,
           (select lt.*, lt.rowid wm_rid from BARS.POLICY_TABLE_LT lt) e
      where (e.wm_rid= pkc.WM_ridparent or e.wm_rid= pkc.WM_ridchild or e.wm_rid= pkc.WM_ridbase) and
            pkc.TABLE_NAME = e.TABLE_NAME AND pkc.POLICY_GROUP = e.POLICY_GROUP AND pkc.OWNER = e.OWNER)
      union all
     (select 'BASE'  WM_workspace, 'NE' WM_deleted, 2 WM_pos, pkc.TABLE_NAME, cast(NULL as VARCHAR2(1)), cast(NULL as VARCHAR2(1)), cast(NULL as VARCHAR2(1)), cast(NULL as VARCHAR2(1)), cast(NULL as VARCHAR2(1)), pkc.POLICY_GROUP, pkc.OWNER, cast(NULL as VARCHAR2(1)), cast(NULL as DATE), cast(NULL as DATE), cast(NULL as VARCHAR2(1)), cast(NULL as VARCHAR2(1))
      from   BARS.POLICY_TABLE_pkc pkc
      where (pkc.WM_ridbase is null))
     ) c order by TABLE_NAME,POLICY_GROUP,OWNER,WM_pos;

PROMPT *** Create  grants  POLICY_TABLE_CONF ***
grant SELECT                                                                 on POLICY_TABLE_CONF to ABS_ADMIN;
grant SELECT                                                                 on POLICY_TABLE_CONF to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on POLICY_TABLE_CONF to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on POLICY_TABLE_CONF to WR_ALL_RIGHTS;
grant SELECT                                                                 on POLICY_TABLE_CONF to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/POLICY_TABLE_CONF.sql =========*** End 
PROMPT ===================================================================================== 
