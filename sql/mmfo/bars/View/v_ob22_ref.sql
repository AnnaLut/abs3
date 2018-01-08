

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OB22_REF.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OB22_REF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OB22_REF ("REF", "NLSD_N", "NLSK_N", "FDAT", "S", "OTM") AS 
  select p.ref, '0' nlsd_n ,n.nlsn nlsk_n ,p.fdat,p.s,p.otm
from   opldok p, v_ob22nu n
where  p.acc=n.acc and p.dk=0
--       and  not exists (SELECT 1 FROM  opldok WHERE  ref=p.ref and tt='PO3')
         and  bitand(nvl(otm,0),1) = 0 and bitand(nvl(otm,0),2) = 0
union all
select p.ref, n.nlsn nlsd_n ,'0' nlsk_n ,p.fdat,p.s,p.otm
from   opldok p, v_ob22nu n
where  p.acc=n.acc and p.dk=1
--       and not exists (SELECT 1 FROM  opldok WHERE  ref=p.ref and tt='PO3')
       and  bitand(nvl(otm,0),1) = 0 and bitand(nvl(otm,0),2) = 0
order by 1
 ;

PROMPT *** Create  grants  V_OB22_REF ***
grant SELECT                                                                 on V_OB22_REF      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OB22_REF      to NALOG;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OB22_REF      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OB22_REF.sql =========*** End *** ===
PROMPT ===================================================================================== 
