

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/S_FN.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  view S_FN ***

  CREATE OR REPLACE FORCE VIEW BARS.S_FN ("NLSF", "NLSN", "DDRR") AS 
  select a.nls,b.nls, c.p080
from accounts a, accounts b, sbnal c
where a.accc=b.acc and
substr(a.nls,1,4)=c.r020_fa and
substr(b.nls,1,4)=c.r020;

PROMPT *** Create  grants  S_FN ***
grant SELECT                                                                 on S_FN            to BARSREADER_ROLE;
grant SELECT                                                                 on S_FN            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_FN            to START1;
grant SELECT                                                                 on S_FN            to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/S_FN.sql =========*** End *** =========
PROMPT ===================================================================================== 
