

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/POLICY_TABLE_CONS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view POLICY_TABLE_CONS ***

  CREATE OR REPLACE FORCE VIEW BARS.POLICY_TABLE_CONS ("TABLE_NAME", "SELECT_POLICY", "INSERT_POLICY", "UPDATE_POLICY", "DELETE_POLICY", "REPL_TYPE", "POLICY_GROUP", "OWNER", "POLICY_COMMENT", "CHANGE_TIME", "APPLY_TIME", "WHO_ALTER", "WHO_CHANGE", "WM_VERSION", "WM_DELSTATUS", "WM_NEXTVER", "WM_LTLOCK", "WM_ROWID") AS 
  SELECT lt.TABLE_NAME,lt.SELECT_POLICY,lt.INSERT_POLICY,lt.UPDATE_POLICY,lt.DELETE_POLICY,lt.REPL_TYPE,lt.POLICY_GROUP,lt.OWNER,lt.POLICY_COMMENT,lt.CHANGE_TIME,lt.APPLY_TIME,lt.WHO_ALTER,lt.WHO_CHANGE, lt.version WM_version, lt.delstatus WM_delstatus, lt.nextver WM_nextver, lt.ltlock WM_ltlock, lt.rowid WM_rowid 
   FROM BARS.POLICY_TABLE_LT lt
   WHERE version IN (select version from wmsys.wm$current_cons_versions_view)
     and (lt.nextver = '-1' or
          not exists (select 1 from wmsys.wm$current_cons_nextvers_view where lt.nextver = next_vers))
     WITH READ ONLY;

PROMPT *** Create  grants  POLICY_TABLE_CONS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on POLICY_TABLE_CONS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/POLICY_TABLE_CONS.sql =========*** End 
PROMPT ===================================================================================== 
