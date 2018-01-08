

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_EXCLUDE_WEB_PAGES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_EXCLUDE_WEB_PAGES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_EXCLUDE_WEB_PAGES ("PAGE_NAME") AS 
  SELECT '/barsroot/barsweb/head.aspx' FROM DUAL
UNION ALL
  SELECT '/barsroot/barsweb/applist.aspx' FROM DUAL
UNION ALL
  SELECT '/barsroot/barsweb/default.aspx' FROM DUAL
UNION ALL
  SELECT '/barsroot/barsweb/adminpsw.aspx' FROM DUAL
UNION ALL
  SELECT '/barsroot/barsweb/welcome.aspx' FROM DUAL
UNION ALL
  SELECT '/barsroot/docinput/askbeforepay.aspx\S+' FROM DUAL
UNION ALL
  SELECT '/barsroot/webservices/filter.aspx?table=\w+'||'&'||'\S+' FROM DUAL
UNION ALL
  SELECT '/barsroot/crystalreports/printreport.aspx?template=\S*' FROM DUAL
UNION ALL
  SELECT '/barsroot/crystalreports/default.aspx?template=\S*' FROM DUAL
UNION ALL
  SELECT '/barsroot/barsweb/settobocookie.aspx' FROM DUAL
UNION ALL
  SELECT '/barsroot/barsweb/references/reflist.aspx\S*' FROM DUAL
UNION ALL
  SELECT '/barsroot/barsweb/optionlist.aspx?key=\S*' FROM DUAL 
 ;

PROMPT *** Create  grants  V_EXCLUDE_WEB_PAGES ***
grant SELECT                                                                 on V_EXCLUDE_WEB_PAGES to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_EXCLUDE_WEB_PAGES.sql =========*** En
PROMPT ===================================================================================== 
