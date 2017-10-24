

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PF3800.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PF3800 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PF3800 ("NAL", "KV", "BRANCH", "REF", "DEB", "KRED", "N", "RAT", "Q", "PPF", "SPF", "B", "E") AS 
  SELECT   t.PR NAL, t.kv, t.branch, t.nd REF,
  t.nls  DEB, t.nlsalt KRED, t.n2/100 N, round(t.n4,4) Rat, t.n3/100 Q, round( div0( t.n1*100, t.n3), 1) PPF, t.n1/100 SPF , d.B, d.e
from CCK_AN_TMP T, V_SFDAT  D ;

PROMPT *** Create  grants  V_PF3800 ***
grant SELECT                                                                 on V_PF3800        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PF3800        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PF3800.sql =========*** End *** =====
PROMPT ===================================================================================== 
