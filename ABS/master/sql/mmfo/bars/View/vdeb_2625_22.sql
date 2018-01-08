

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VDEB_2625_22.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view VDEB_2625_22 ***

  CREATE OR REPLACE FORCE VIEW BARS.VDEB_2625_22 ("BRANCH", "FDAT", "TT", "NBSB", "KOL", "S") AS 
  select a.branch,  p.fdat, o.tt, substr(o.nlsb,1,4), count(*) KOL, sum(o.s)/100 S
from accounts a, oper o, opldok p
where  a.nbs ='2625' and a.ob22='22'
  and  a.acc = p.acc and p.dk  = 0
  and p.fdat >=NVL (TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy'), gl.bd  )
  and p.fdat <=NVL (TO_DATE (pul.get_mas_ini_val ('sFdat2'), 'dd.mm.yyyy'), gl.bd  )
  and  p.ref = o.ref and p.sos = 5
group by a.branch,  p.fdat, o.tt, substr(o.nlsb,1,4);

PROMPT *** Create  grants  VDEB_2625_22 ***
grant SELECT                                                                 on VDEB_2625_22    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VDEB_2625_22    to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VDEB_2625_22.sql =========*** End *** =
PROMPT ===================================================================================== 
