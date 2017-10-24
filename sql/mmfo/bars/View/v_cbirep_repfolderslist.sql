

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CBIREP_REPFOLDERSLIST.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CBIREP_REPFOLDERSLIST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CBIREP_REPFOLDERSLIST ("CODEAPP", "FOLDER_ID", "FOLDER_TYPE", "FOLDER_NAME") AS 
  select cr.codeapp,
       cr.folder_id,
       rf.type as folder_type,
       rf.name as folder_name
  from (select distinct codeapp, folder_id from v_cbirep_replist) cr,
       reportsf rf
 where cr.folder_id = rf.idf 
 ;

PROMPT *** Create  grants  V_CBIREP_REPFOLDERSLIST ***
grant SELECT                                                                 on V_CBIREP_REPFOLDERSLIST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CBIREP_REPFOLDERSLIST to WR_CBIREP;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CBIREP_REPFOLDERSLIST.sql =========**
PROMPT ===================================================================================== 
