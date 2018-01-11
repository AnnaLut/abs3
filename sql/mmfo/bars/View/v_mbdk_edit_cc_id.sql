

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBDK_EDIT_CC_ID.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBDK_EDIT_CC_ID ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBDK_EDIT_CC_ID ("ND", "CC_ID") AS 
  SELECT nd,
       cc_id
FROM CC_deal;

PROMPT *** Create  grants  V_MBDK_EDIT_CC_ID ***
grant SELECT                                                                 on V_MBDK_EDIT_CC_ID to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on V_MBDK_EDIT_CC_ID to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_MBDK_EDIT_CC_ID to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBDK_EDIT_CC_ID.sql =========*** End 
PROMPT ===================================================================================== 
