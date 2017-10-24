

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/JANA.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  view JANA ***

  CREATE OR REPLACE FORCE VIEW BARS.JANA ("NMS", "NLS", "OSTC", "MFOA", "NLSA", "NAMA", "SDE", "SKR", "MFOB", "NLSB", "NAMB", "ND") AS 
  select substr(nms,1,35),
c.nls,c.ostc, a.mfoa,a.nlsa,
LTRIM(RTRIM(a.NAM_A)),
decode (o.dk,1,a.s,0),decode (o.dk,0,a.s,0),
a.mfob,a.nlsb,
LTRIM(RTRIM(a.NAM_b)),
a.nd
from accounts c, opldok o, arc_rrp a
where o.fdat=bankdate and
      o.acc =c.acc    and
      c.tip in ('N00','L00') and
      o.txt in (a.fn_a,a.fn_b) and a.s>0;

PROMPT *** Create  grants  JANA ***
grant SELECT                                                                 on JANA            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on JANA            to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/JANA.sql =========*** End *** =========
PROMPT ===================================================================================== 
