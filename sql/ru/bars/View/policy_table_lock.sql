

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/POLICY_TABLE_LOCK.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view POLICY_TABLE_LOCK ***

  CREATE OR REPLACE FORCE VIEW BARS.POLICY_TABLE_LOCK ("TABLE_NAME", "SELECT_POLICY", "INSERT_POLICY", "UPDATE_POLICY", "DELETE_POLICY", "REPL_TYPE", "POLICY_GROUP", "OWNER", "POLICY_COMMENT", "CHANGE_TIME", "APPLY_TIME", "WHO_ALTER", "WHO_CHANGE", "WM_LOCKMODE", "WM_USERNAME", "WM_LOCKINGWORKSPACE", "WM_INCURWORKSPACE") AS 
  select TABLE_NAME,SELECT_POLICY,INSERT_POLICY,UPDATE_POLICY,DELETE_POLICY,REPL_TYPE,POLICY_GROUP,OWNER,POLICY_COMMENT,CHANGE_TIME,APPLY_TIME,WHO_ALTER,WHO_CHANGE,
         decode(substr(wm_ltlock, instr(wm_ltlock, '$M#', 1, 1)+3, instr(wm_ltlock, '$M#', 1, 2)-instr(wm_ltlock, '$M#', 1, 1)-3),
                'E','EXCLUSIVE','S','SHARED',
                'WE','WORKSPACE EXCLUSIVE','VE','VERSION EXCLUSIVE') WM_lockmode,
         substr(wm_ltlock,
                instr(wm_ltlock, '$U#', 1, 1)+3,
                instr(wm_ltlock, '$U#', 1, 2)-instr(wm_ltlock, '$U#', 1, 1)-3) WM_username,
         substr(wm_ltlock,
                instr(wm_ltlock, '$S#', 1, 1)+3,
                instr(wm_ltlock, '$S#', 1, 2)-instr(wm_ltlock, '$S#', 1, 1)-3) WM_lockingworkspace,
         decode(wmsys.lt_ctx_pkg.getstatefromver(WM_version),
                nvl(sys_context('lt_ctx','state'),'LIVE'), 'YES',
                'NO') WM_incurworkspace
       from BARS.POLICY_TABLE_base b
       where substr(wm_ltlock, 2, instr(wm_ltlock, '@', 2, 1) - 2) is not null
         and WM_delstatus >= 0 
       union all
       select TABLE_NAME,SELECT_POLICY,INSERT_POLICY,UPDATE_POLICY,DELETE_POLICY,REPL_TYPE,POLICY_GROUP,OWNER,POLICY_COMMENT,CHANGE_TIME,APPLY_TIME,WHO_ALTER,WHO_CHANGE,'SHARED' WM_lockmode,
         substr(wm_ltlock,
                instr(wm_ltlock, '$#', 1, 1)+2,
                instr(wm_ltlock, '$#', 1, 2)-instr(wm_ltlock, '$#', 1, 1)-2) WM_username,
         avh.workspace WM_lockingworkspace,
         decode(wmsys.lt_ctx_pkg.getstatefromver(WM_version),
                nvl(sys_context('lt_ctx','state'),'LIVE'), 'YES',
                'NO') WM_incurworkspace
       from BARS.POLICY_TABLE_base b, all_version_hview avh
       where substr(wm_ltlock, 2, instr(wm_ltlock, '@', 2, 1) - 2) is null
         and wmsys.lt_ctx_pkg.GetCurrentLockingMode = 'PESSIMISTIC_LOCKING'
         and b.WM_delstatus >= 0
         and b.WM_nextver != '-1'
         and avh.version = to_number(substr(b.WM_nextver, 2, instr(b.WM_nextver,',',2)-2))
       WITH READ ONLY;

PROMPT *** Create  grants  POLICY_TABLE_LOCK ***
grant SELECT                                                                 on POLICY_TABLE_LOCK to ABS_ADMIN;
grant SELECT                                                                 on POLICY_TABLE_LOCK to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on POLICY_TABLE_LOCK to START1;
grant SELECT                                                                 on POLICY_TABLE_LOCK to WR_ALL_RIGHTS;
grant SELECT                                                                 on POLICY_TABLE_LOCK to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/POLICY_TABLE_LOCK.sql =========*** End 
PROMPT ===================================================================================== 
