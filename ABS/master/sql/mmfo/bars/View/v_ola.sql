

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OLA.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OLA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OLA ("YYYYMM", "NMS", "KV", "NLS", "DOS", "KOS", "OST", "PR", "DAZS", "SROK", "NLSN", "DOSN", "KOSN", "OSTN") AS 
  select f.YM, substr(a.nms,1,35),a.kv, a.nls,
       to_char(fdos(a.acc,f.fdat1,f.fdat2)/100,'99,999,999.99'),
       to_char(fkos(a.acc,f.fdat1,f.fdat2)/100,'99,999,999.99'),
       to_char(fost(a.acc,f.fdat2)/100        ,'99,999,999.99'),
       to_char(acrn.fproc(a.acc,f.fdat2),'999.99'),
       a.mdate,a.mdate-f.fdat2,
       n.nls,
       to_char(fdos(n.acc,f.fdat1,f.fdat2)/100,'999,999.99'),
       to_char(fkos(n.acc,f.fdat1,f.fdat2)/100,'999,999.99'),
       to_char(fost(n.acc,f.fdat2)/100        ,'999,999.99')
from (select to_char(fdat,'yyyy-mm') YM,
             min(fdat) fdat1,
             max(fdat) fdat2
      from fdat
      group by to_char(fdat,'yyyy-mm')
     ) f,
     accounts a, accounts n, int_accn i
where a.acc=i.acc and i.acra=n.acc and i.id=0 and
    (a.dazs is null or a.dazs <f.fdat1);

PROMPT *** Create  grants  V_OLA ***
grant SELECT                                                                 on V_OLA           to BARSREADER_ROLE;
grant SELECT                                                                 on V_OLA           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OLA           to START1;
grant SELECT                                                                 on V_OLA           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OLA.sql =========*** End *** ========
PROMPT ===================================================================================== 
