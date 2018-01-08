

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BUCH_B2.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view BUCH_B2 ***

  CREATE OR REPLACE FORCE VIEW BARS.BUCH_B2 ("ND", "NLS", "NLSK", "MFO", "S", "PLAT") AS 
  select a.acc, p.nlsd, p.nlsk, 300175, p.s*100, a.nms
from provodki p, oper o, accounts a
where
 o.ref=2394740 and p.ref=o.ref and p.acck=a.acc
;

PROMPT *** Create  grants  BUCH_B2 ***
grant SELECT                                                                 on BUCH_B2         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BUCH_B2         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BUCH_B2.sql =========*** End *** ======
PROMPT ===================================================================================== 
