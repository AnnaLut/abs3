

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_DOK_DNK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_DOK_DNK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_DOK_DNK ("ID", "CP_ID", "CP_REF", "DATE_RUN", "DESCRIPTION") AS 
  select "ID","CP_ID","CP_REF","DATE_RUN","DESCRIPTION" from CP_DOK_DNK
where trunc(date_run) = trunc(sysdate)
order by ID;

PROMPT *** Create  grants  V_CP_DOK_DNK ***
grant SELECT                                                                 on V_CP_DOK_DNK    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_DOK_DNK.sql =========*** End *** =
PROMPT ===================================================================================== 
