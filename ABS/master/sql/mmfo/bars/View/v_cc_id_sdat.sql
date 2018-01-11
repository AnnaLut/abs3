

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CC_ID_SDAT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CC_ID_SDAT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CC_ID_SDAT ("CC_ID", "NMS") AS 
  SELECT d.cc_id || ' â³ä ' || TO_CHAR (d.sdate, 'DD/MM/YYYY') AS cc_id,
       a.nms
  FROM accounts a, nd_acc n, cc_deal d
 WHERE d.nd = n.nd AND a.acc = n.acc;

PROMPT *** Create  grants  V_CC_ID_SDAT ***
grant SELECT                                                                 on V_CC_ID_SDAT    to BARSREADER_ROLE;
grant SELECT                                                                 on V_CC_ID_SDAT    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CC_ID_SDAT    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CC_ID_SDAT.sql =========*** End *** =
PROMPT ===================================================================================== 
