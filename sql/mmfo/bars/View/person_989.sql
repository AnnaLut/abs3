

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PERSON_989.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view PERSON_989 ***

  CREATE OR REPLACE FORCE VIEW BARS.PERSON_989 ("RNK", "FIO", "DOK", "ATTR") AS 
  select c.rnk, c.nmk, p.passp, p.ser||' '||p.numdoc
from customer c, person p
where c.rnk=p.rnk and p.rnk in
(select rnk
 from accounts
 where nbs in ('9890','9892','9898')
   and dazs is null)
 ;

PROMPT *** Create  grants  PERSON_989 ***
grant SELECT                                                                 on PERSON_989      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PERSON_989      to PYOD001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PERSON_989      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PERSON_989.sql =========*** End *** ===
PROMPT ===================================================================================== 
