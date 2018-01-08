

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V7_OVRN.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V7_OVRN ***

  CREATE OR REPLACE FORCE VIEW BARS.V7_OVRN ("REF", "ACC", "DATM", "ND", "VDAT", "S", "TT", "ID_A", "NAM_A", "NLSA", "MFOA", "NAZN", "NAM_B", "NLSB", "MFOB") AS 
  select d.REF, d.ACC, d.datm , o.ND, o.VDAT, o.S/100 s , o.tt, o.ID_A, o.NAM_A, o.NLSA, o.MFOA, o.NAZN, o.NAM_B, o.NLSB, o.MFOB
from OVR_CHKO_DET  d, oper o
where d.ref = o.ref  and acc   = PUL.get('ACC26')  and d.datm = TO_DATE ( pul.get ('DATM01'), 'dd.mm.yyyy');

PROMPT *** Create  grants  V7_OVRN ***
grant SELECT                                                                 on V7_OVRN         to BARSREADER_ROLE;
grant SELECT                                                                 on V7_OVRN         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V7_OVRN         to START1;
grant SELECT                                                                 on V7_OVRN         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V7_OVRN.sql =========*** End *** ======
PROMPT ===================================================================================== 
