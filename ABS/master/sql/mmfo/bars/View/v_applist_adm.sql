

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_APPLIST_ADM.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_APPLIST_ADM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_APPLIST_ADM ("ID", "ARM_CODE", "ARM_NAME", "APPLICATION_TYPE") AS 
  select a.id, a.codeapp arm_code, a.name arm_name, list_utl.get_item_name('ARM_TYPE', a.frontend) application_type
from applist a
;

PROMPT *** Create  grants  V_APPLIST_ADM ***
grant SELECT                                                                 on V_APPLIST_ADM   to BARSREADER_ROLE;
grant SELECT                                                                 on V_APPLIST_ADM   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_APPLIST_ADM   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_APPLIST_ADM.sql =========*** End *** 
PROMPT ===================================================================================== 
