

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBDK_CC_SWTRACE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBDK_CC_SWTRACE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBDK_CC_SWTRACE ("RNK", "KV", "SWO_BIC", "SWO_ACC", "SWO_ALT", "INTERM_B", "FIELD_58D", "NLS") AS 
  SELECT
   rnk,
   kv,
   swo_bic,
   swo_acc,
   swo_alt,
   interm_b,
   field_58d,
   nls
FROM cc_swtrace;

PROMPT *** Create  grants  V_MBDK_CC_SWTRACE ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_MBDK_CC_SWTRACE to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_MBDK_CC_SWTRACE to START1;
grant FLASHBACK,SELECT                                                       on V_MBDK_CC_SWTRACE to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBDK_CC_SWTRACE.sql =========*** End 
PROMPT ===================================================================================== 
