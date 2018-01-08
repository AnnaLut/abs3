

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_KB_R013.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KB_R013 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_KB_R013 ("R020", "KL", "TXT", "D_OPEN") AS 
  select r020, R020||'.'||R013 kl, substr(TXT,1,100) txt,  D_OPEN from  KL_R013 where prem ='สม'  and d_close is null;

PROMPT *** Create  grants  V_KB_R013 ***
grant SELECT                                                                 on V_KB_R013       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_KB_R013       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_KB_R013.sql =========*** End *** ====
PROMPT ===================================================================================== 
