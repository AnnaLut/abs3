

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ROOT_CORPORATION.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ROOT_CORPORATION ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ROOT_CORPORATION ("ID", "EXTERNAL_ID", "CORPORATION_NAME") AS 
  select t.ID, t.EXTERNAL_ID, t.CORPORATION_NAME from OB_CORPORATION t where t.PARENT_ID is null and t.STATE_ID=1
;

PROMPT *** Create  grants  V_ROOT_CORPORATION ***
grant SELECT                                                                 on V_ROOT_CORPORATION to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ROOT_CORPORATION to CORP_CLIENT;
grant FLASHBACK,SELECT                                                       on V_ROOT_CORPORATION to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ROOT_CORPORATION.sql =========*** End
PROMPT ===================================================================================== 
