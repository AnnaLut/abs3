

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BUCH_X.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view BUCH_X ***

  CREATE OR REPLACE FORCE VIEW BARS.BUCH_X ("ND", "NLSA", "NAM_A", "MFOB", "NLSB", "NAM_B", "S", "NAZN", "ID_A", "D_REC", "VOB", "VDAT") AS 
  select nd, nlsa, nam_a, mfob, nlsb, nam_b, s, nazn, id_a, d_rec, vob,vdat
from oper
where
  tt='KL2' and sos=-1 and
  vdat=bankdate;

PROMPT *** Create  grants  BUCH_X ***
grant SELECT                                                                 on BUCH_X          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BUCH_X          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BUCH_X.sql =========*** End *** =======
PROMPT ===================================================================================== 
