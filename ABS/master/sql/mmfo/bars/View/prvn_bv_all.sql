

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PRVN_BV_ALL.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view PRVN_BV_ALL ***

  CREATE OR REPLACE FORCE VIEW BARS.PRVN_BV_ALL ("MDAT", "KV", "VIDD", "AR", "NR", "IR", "ZZ", "ARQ", "NRQ", "IRQ", "ZZQ", "ZRQ") AS 
  select MDAT, kv, vidd, ar, nr, ir, zz,
       gl.p_icurval(kv,ar,mdat) arq,
       gl.p_icurval(kv,nr,mdat) nrq,
       gl.p_icurval(kv,ir,mdat) irq,
       gl.p_icurval(kv,zz,mdat) zzq,
       (gl.p_icurval(kv,ar,mdat) + gl.p_icurval(kv,nr,mdat) -  gl.p_icurval(kv,ir,mdat) ) ZRq
from (select MDAT, kv, vidd, round(sum(nvl(ar,0)),0)  ar ,
                             round(sum(nvl(nr,0)),0)  nr ,
                             round(sum(nvl(ir,0)),0)  ir ,
                             sum ( decode (cdat, mdat-1, nvl(REZ,0),  0) ) ZZ
      from  PRVN_BV_DETAILS
      group by MDAT, kv , vidd
      );

PROMPT *** Create  grants  PRVN_BV_ALL ***
grant SELECT                                                                 on PRVN_BV_ALL     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PRVN_BV_ALL     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PRVN_BV_ALL.sql =========*** End *** ==
PROMPT ===================================================================================== 
