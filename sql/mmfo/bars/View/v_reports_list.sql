

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_REPORTS_LIST.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_REPORTS_LIST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_REPORTS_LIST ("ID", "NAME", "DESCRIPTION", "FORM", "PARAM", "NDAT", "WT", "MASK", "NAMEW", "IDF", "NODEL", "PATH", "WT2", "DBTYPE") AS 
  select id, name, description, form, param, ndat, wt, mask,
       namew, idf, nvl(nodel,0), path, wt2, dbtype
  from reports
;

PROMPT *** Create  grants  V_REPORTS_LIST ***
grant SELECT                                                                 on V_REPORTS_LIST  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_REPORTS_LIST  to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_REPORTS_LIST.sql =========*** End ***
PROMPT ===================================================================================== 
