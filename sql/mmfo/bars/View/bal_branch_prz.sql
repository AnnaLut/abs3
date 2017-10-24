

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BAL_BRANCH_PRZ.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view BAL_BRANCH_PRZ ***

  CREATE OR REPLACE FORCE VIEW BARS.BAL_BRANCH_PRZ ("DAT", "NBS", "BRANCH", "DOSQ", "KOSQ", "OSDQ", "OSKQ") AS 
  select caldt_date DAT, nbs, branch,
       sum( DOSq )/100 dosq, sum( kOSq )/100 kosq,
       sum( OSdq )/100 osdq, sum( OSkq )/100 oskq
from (select c.caldt_date,a.nbs, a.branch,  m.DOSq, m.KOSq,
   decode (sign(m.ostq),-1,-m.ostq,0) osdq,decode (sign(m.ostq),1,m.ostq,0) oskq
      from v_gl a, ACCM_CALENDAR c, ACCM_SNAP_BALANCES m
      where a.nbs not like '8%' and a.acc = m.acc and m.caldt_id = c.caldt_id
        and c.caldt_date = Dat_Next_U ( gl.bd, -1)
      ) group by caldt_date, nbs, branch;

PROMPT *** Create  grants  BAL_BRANCH_PRZ ***
grant SELECT                                                                 on BAL_BRANCH_PRZ  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BAL_BRANCH_PRZ  to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BAL_BRANCH_PRZ.sql =========*** End ***
PROMPT ===================================================================================== 
