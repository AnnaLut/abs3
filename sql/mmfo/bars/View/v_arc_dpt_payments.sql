

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ARC_DPT_PAYMENTS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ARC_DPT_PAYMENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ARC_DPT_PAYMENTS ("DPT_ID", "REF", "BRANCH", "PDAT") AS 
  select p.dpt_id, p.ref, o.branch, o.pdat
  from dpt_payments p, oper o
 where p.ref = o.ref
;

PROMPT *** Create  grants  V_ARC_DPT_PAYMENTS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_ARC_DPT_PAYMENTS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ARC_DPT_PAYMENTS.sql =========*** End
PROMPT ===================================================================================== 
