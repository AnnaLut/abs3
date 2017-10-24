

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/POLICY_TABLE_BASE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view POLICY_TABLE_BASE ***

  CREATE OR REPLACE FORCE VIEW BARS.POLICY_TABLE_BASE ("TABLE_NAME", "SELECT_POLICY", "INSERT_POLICY", "UPDATE_POLICY", "DELETE_POLICY", "REPL_TYPE", "POLICY_GROUP", "OWNER", "POLICY_COMMENT", "CHANGE_TIME", "APPLY_TIME", "WHO_ALTER", "WHO_CHANGE", "WM_ROWID", "WM_VERSION", "WM_NEXTVER", "WM_DELSTATUS", "WM_LTLOCK") AS 
  SELECT TABLE_NAME,SELECT_POLICY,INSERT_POLICY,UPDATE_POLICY,DELETE_POLICY,REPL_TYPE,POLICY_GROUP,OWNER,POLICY_COMMENT,CHANGE_TIME,APPLY_TIME,WHO_ALTER,WHO_CHANGE, rowid WM_rowid, version WM_version, nextver WM_nextver, delstatus WM_delstatus, ltlock WM_ltlock
      FROM BARS.POLICY_TABLE_LT LT
      WHERE delstatus >=0 and
        ((version = 0 and nextver = '-1')
         OR
         (version in (select parent_vers from wmsys.wm$table_parvers_view
                      where table_name = 'BARS.POLICY_TABLE') and
         (nextver = '-1' or
          not exists (select 1 from wmsys.wm$current_nextvers_view where nextver = next_vers))));

PROMPT *** Create  grants  POLICY_TABLE_BASE ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on POLICY_TABLE_BASE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/POLICY_TABLE_BASE.sql =========*** End 
PROMPT ===================================================================================== 
