

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DOK_DN.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view DOK_DN ***

  CREATE OR REPLACE FORCE VIEW BARS.DOK_DN ("FDAT", "ID", "KOL", "S") AS 
  select fdat, id, kol, s from dok_dn1  where s<>0
union all
select fdat, 100, sum(kol), sum(s)
from dok_dn1 where s<>0 and id not in (9,99) group by fdat
union all
select fdat, 109, sum(kol), sum(s)
from dok_dn1 where s<>0 and id in (9,99) group by fdat
;

PROMPT *** Create  grants  DOK_DN ***
grant SELECT                                                                 on DOK_DN          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DOK_DN          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DOK_DN.sql =========*** End *** =======
PROMPT ===================================================================================== 
