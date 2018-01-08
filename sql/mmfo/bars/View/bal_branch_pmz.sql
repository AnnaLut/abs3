

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BAL_BRANCH_PMZ.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view BAL_BRANCH_PMZ ***

  CREATE OR REPLACE FORCE VIEW BARS.BAL_BRANCH_PMZ ("DAT", "NBS", "BRANCH", "DOSQ", "KOSQ", "OSDQ", "OSKQ") AS 
  select last_day(caldt_date) DAT, nbs, branch,
       sum( DOSq )/100 dosq, sum( kOSq )/100 kosq,
       sum( decode(pa,-1, -OStq,0 ))/100 osdq, sum(decode(pa,1,OStq,0))/100 oskq
from (select c.caldt_date, a.nbs, a.branch,
              m.DOSq + m.crdosq dosq, m.KOSq + m.crkosq kosq,
        sign(m.ostq - m.crdosq + m.crkosq) PA, (m.ostq-m.crdosq + m.crkosq) OSTQ
      from v_gl a, ACCM_CALENDAR c, ACCM_AGG_MONBALS m
      where a.nbs not like '8%' and a.acc = m.acc and m.caldt_id = c.caldt_id
        and c.caldt_date =  add_months (TRUNC(gl.bd,'MM'), -1)
      ) group by caldt_date, nbs, branch;

PROMPT *** Create  grants  BAL_BRANCH_PMZ ***
grant SELECT                                                                 on BAL_BRANCH_PMZ  to BARSREADER_ROLE;
grant SELECT                                                                 on BAL_BRANCH_PMZ  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BAL_BRANCH_PMZ  to SALGL;
grant SELECT                                                                 on BAL_BRANCH_PMZ  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BAL_BRANCH_PMZ.sql =========*** End ***
PROMPT ===================================================================================== 
