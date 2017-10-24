

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/S_FN1.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view S_FN1 ***

  CREATE OR REPLACE FORCE VIEW BARS.S_FN1 ("NLSF", "NLSN", "DDRR") AS 
  select distinct a.nls,b.nls, c.p080
from accounts a, accounts b, sbnal c
where a.accc=b.acc and
substr(a.nls,1,4)=c.r020_fa and
substr(b.nls,1,4)=c.r020;

PROMPT *** Create  grants  S_FN1 ***
grant SELECT                                                                 on S_FN1           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_FN1           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/S_FN1.sql =========*** End *** ========
PROMPT ===================================================================================== 
