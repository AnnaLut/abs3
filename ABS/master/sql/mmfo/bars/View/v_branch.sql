

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BRANCH.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BRANCH ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BRANCH ("MFO", "MFOU", "MFOP", "SAB", "NB", "KU") AS 
  select   b.mfo, b.mfou, b.mfop, b.sab, b.nb, c.ku -- все действующие филиал_
from     banks b, rcukru c,
         (select  * from lkl_rrp
           where kv=980
             and mfo<>'300465'
             and mfo<>f_ourmfo) l
where    b.mfo=l.mfo
  and    b.mfo=c.mfo
  and    to_number(b.mfo) = c.mfo
union all                       -- которые уже мигрировали
select   l.mfo, b.mfou, f_ourmfo mfop,  b.sab, b.nb, c.ku
from      banks b, rcukru c,
         (select distinct filial mfo from s6_migrnls) l
where    b.mfo=l.mfo
  and    b.mfo=c.mfo
  and    to_number(b.mfo) = c.mfo  ;

PROMPT *** Create  grants  V_BRANCH ***
grant SELECT                                                                 on V_BRANCH        to BARSREADER_ROLE;
grant SELECT                                                                 on V_BRANCH        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BRANCH        to NALOG;
grant SELECT                                                                 on V_BRANCH        to RPBN002;
grant SELECT                                                                 on V_BRANCH        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BRANCH        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BRANCH.sql =========*** End *** =====
PROMPT ===================================================================================== 
