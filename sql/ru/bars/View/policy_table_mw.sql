

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/POLICY_TABLE_MW.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view POLICY_TABLE_MW ***

  CREATE OR REPLACE FORCE VIEW BARS.POLICY_TABLE_MW ("TABLE_NAME", "SELECT_POLICY", "INSERT_POLICY", "UPDATE_POLICY", "DELETE_POLICY", "REPL_TYPE", "POLICY_GROUP", "OWNER", "POLICY_COMMENT", "CHANGE_TIME", "APPLY_TIME", "WHO_ALTER", "WHO_CHANGE", "WM_MODIFIED_BY", "WM_SEEN_BY", "WM_OPTYPE") AS 
  SELECT lt.TABLE_NAME,lt.SELECT_POLICY,lt.INSERT_POLICY,lt.UPDATE_POLICY,lt.DELETE_POLICY,lt.REPL_TYPE,lt.POLICY_GROUP,lt.OWNER,lt.POLICY_COMMENT,lt.CHANGE_TIME,lt.APPLY_TIME,lt.WHO_ALTER,lt.WHO_CHANGE, mwv.modified_by WM_modified_by, mwv.seen_by WM_seen_by,
        decode(lt.delstatus,10,'I','U') WM_optype
     FROM BARS.POLICY_TABLE_LT lt, wm$mw_versions_view_9i mwv
     WHERE lt.version = mwv.version 
     AND lt.nextver != ',' || lt.version || ','
     AND (nextver = '-1' or
          not exists (select 1 from wm$mw_nextvers_view nv
                       where nv.next_vers = lt.nextver)
         )
     AND delstatus > 0
     WITH READ ONLY;

PROMPT *** Create  grants  POLICY_TABLE_MW ***
grant SELECT                                                                 on POLICY_TABLE_MW to ABS_ADMIN;
grant SELECT                                                                 on POLICY_TABLE_MW to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on POLICY_TABLE_MW to START1;
grant SELECT                                                                 on POLICY_TABLE_MW to WR_ALL_RIGHTS;
grant SELECT                                                                 on POLICY_TABLE_MW to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/POLICY_TABLE_MW.sql =========*** End **
PROMPT ===================================================================================== 
