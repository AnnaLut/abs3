

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ALT_CORPS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ALT_CORPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ALT_CORPS ("ID", "CORPORATION_NAME") AS 
  select t.ID, t.CORPORATION_NAME from OB_CORPORATION t where t.PARENT_ID is null and t.STATE_ID = 1 and t.CORPORATION_CODE is null
;

PROMPT *** Create  grants  V_ALT_CORPS ***
grant SELECT                                                                 on V_ALT_CORPS     to BARSREADER_ROLE;
grant SELECT                                                                 on V_ALT_CORPS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ALT_CORPS     to CORP_CLIENT;
grant SELECT                                                                 on V_ALT_CORPS     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ALT_CORPS.sql =========*** End *** ==
PROMPT ===================================================================================== 
