

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DOST.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  view DOST ***

  CREATE OR REPLACE FORCE VIEW BARS.DOST ("GRP", "GRP_NAME", "NLS", "ISP", "UI", "SECG", "FIO") AS 
  select g.id grp,substr(g.name,1,15) grp_name,a.nls nls,
a.isp isp,f.id ui,s.secg secg,substr(f.fio,1,20) fio
from groups g,groups_staff s,staff f,accounts a
where g.id=s.idg and s.idu=f.id and a.grp=g.id
and dazs is null group by
g.id,substr(g.name,1,15),a.nls,a.isp,f.id,s.secg,substr(f.fio,1,20);

PROMPT *** Create  grants  DOST ***
grant FLASHBACK,SELECT                                                       on DOST            to BARS_ACCESS_DEFROLE;
grant FLASHBACK,SELECT                                                       on DOST            to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DOST.sql =========*** End *** =========
PROMPT ===================================================================================== 
