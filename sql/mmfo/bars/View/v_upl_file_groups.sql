

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_UPL_FILE_GROUPS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_UPL_FILE_GROUPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_UPL_FILE_GROUPS ("JOB_NAME", "GROUP_ID", "GROUP_NAME", "FILE_ID", "FILE_CODE", "FILE_NAME", "SQL_ID") AS 
  SELECT JOB_NAME,
       GROUP_ID,
       GROUP_NAME,
       FILE_ID,
       FILE_CODE,
       FILE_NAME,
       SQL_ID
  FROM BARSUPL.V_UPL_FILE_GROUPS;

PROMPT *** Create  grants  V_UPL_FILE_GROUPS ***
grant SELECT                                                                 on V_UPL_FILE_GROUPS to BARSREADER_ROLE;
grant SELECT                                                                 on V_UPL_FILE_GROUPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_UPL_FILE_GROUPS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_UPL_FILE_GROUPS.sql =========*** End 
PROMPT ===================================================================================== 
