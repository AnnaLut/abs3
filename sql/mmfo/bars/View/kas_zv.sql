

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KAS_ZV.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view KAS_ZV ***

  CREATE OR REPLACE FORCE VIEW BARS.KAS_ZV ("SOS", "IDM", "BRANCH", "IDZ", "DAT1", "IDU", "DAT2", "KV", "VID", "SVID", "KODV", "IDS", "REFA", "REFB", "S1", "K2", "K3", "K4", "NLSB", "NSM") AS 
  select k.SOS, k.IDM, k.BRANCH, k.IDZ, k.DAT1, k.IDU, k.DAT2, k.KV, k.VID,
       decode(k.VID, 1, '1.Готiвка' ,
                     2, '2.Вир.з БМ',
                     3, '3.Мон+Футл',
                     4, '4.Iншi,98*',
                        '???')        SVID,
       k.KODV, k.IDS, k.REFA, k.REFB, k.S S1,
       decode(k.VID,2,k.KOL, null) K2,
       decode(k.VID,3,k.KOL, null) K3,
       decode(k.VID,4,k.KOL, null) K4,
       k.nlsb, n.nsm
from KAS_Z k, kas_b n
where k.branch = n.branch ;

PROMPT *** Create  grants  KAS_ZV ***
grant SELECT                                                                 on KAS_ZV          to BARSREADER_ROLE;
grant SELECT                                                                 on KAS_ZV          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KAS_ZV          to PYOD001;
grant SELECT                                                                 on KAS_ZV          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KAS_ZV.sql =========*** End *** =======
PROMPT ===================================================================================== 
