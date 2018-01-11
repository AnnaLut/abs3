

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DWH_REPORTS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DWH_REPORTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DWH_REPORTS ("ID", "NAME", "TYPEID", "PARAMS", "TEMPLATE_NAME", "RESULT_FILE_NAME", "SQLPREPARE", "DESCRIPTION", "FORM_PROC", "STMT", "FILE_NAME", "ENCODING", "TYPE_NAME", "TYPE_DESC", "TYPE_VALUE", "MODULE_ID", "MODULE_NAME") AS 
  select   
        r.id,
        r.name,
        r.typeid,
        r.params,
        r.template_name,
        r.result_file_name,
        r.sqlprepare,
        r.description,
        r.form_proc,
        r.stmt,
        r.file_name,
        r.encoding,
        rt.name,
        rt.description,
        rt.value, 
        rl.MODULE_ID, 
        m.NAME MODULE_NAME
from dwh_reports r
join dwh_report_type rt on r.typeid = rt.id
JOIN dwh_report_links rl ON r.id = rl.report_id
JOIN applist m ON m.codeapp = rl.MODULE_ID
order by r.id;

PROMPT *** Create  grants  V_DWH_REPORTS ***
grant SELECT                                                                 on V_DWH_REPORTS   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DWH_REPORTS   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DWH_REPORTS   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DWH_REPORTS.sql =========*** End *** 
PROMPT ===================================================================================== 
