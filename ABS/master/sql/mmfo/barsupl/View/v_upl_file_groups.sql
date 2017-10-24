

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/View/V_UPL_FILE_GROUPS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_UPL_FILE_GROUPS ***

  CREATE OR REPLACE FORCE VIEW BARSUPL.V_UPL_FILE_GROUPS ("JOB_NAME", "GROUP_ID", "GROUP_NAME", "FILE_ID", "FILE_CODE", "FILE_NAME", "SQL_ID", "KF") AS 
  select p.JOB_NAME,
          fg.group_id,
          g.descript,
          fg.file_id,
          f.file_code,
          f.descript as file_descript,
          fg.sql_id,
          p.kf
     from BARSUPL.UPL_FILEGROUPS_RLN fg
          join BARSUPL.UPL_GROUPS g on (g.group_id = fg.group_id)
          join BARSUPL.UPL_FILES f on (f.file_id = fg.file_id)
          join (select JOB_NAME, to_number ( value) as GROUP_ID, KF
                  from BARSUPL.UPL_AUTOJOB_PARAM_VALUES
                 where PARAM = 'GROUPID') p
             on (p.group_id = g.group_id)
    where f.ISACTIVE = 1;

PROMPT *** Create  grants  V_UPL_FILE_GROUPS ***
grant SELECT                                                                 on V_UPL_FILE_GROUPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_UPL_FILE_GROUPS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/View/V_UPL_FILE_GROUPS.sql =========*** E
PROMPT ===================================================================================== 
