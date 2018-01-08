

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VAL_PROVODKI_Y.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view VAL_PROVODKI_Y ***

  CREATE OR REPLACE FORCE VIEW BARS.VAL_PROVODKI_Y ("PDAT", "NAZN", "SOS", "VOB", "FDAT", "REF", "TT", "KV", "NLSD", "NLSK", "S", "SQ", "OB_D", "NMSD", "OB_K", "NMSK") AS 
  SELECT o.PDAT, o.NAZN, o.sos, o.VOB,
       z.FDAT, z.REF ,  z.TT,  z.KV, z.NLSD, z.NLSK, z.S/100 s, z.SQ/100 sq, 
       ad.ob22 OB_D  , ad.NMS nmsD, ak.ob22  OB_K,  ak.nms NMSK
from oper o,
     accounts ad,  
     accounts ak,
   ( select * from PART_ZVT_DOC where nlsD LIKE PUL.GET('D')||'%' and nlsK LIKE PUL.GET('K')||'%' and fdat=pul_BD)  z 
where ad.nls = z.nlsd and ad.kv = z.kv
  and ak.nls = z.nlsk and ak.kv = z.kv
  and  o.ref = z.REF;

PROMPT *** Create  grants  VAL_PROVODKI_Y ***
grant SELECT                                                                 on VAL_PROVODKI_Y  to BARSREADER_ROLE;
grant SELECT                                                                 on VAL_PROVODKI_Y  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VAL_PROVODKI_Y  to START1;
grant SELECT                                                                 on VAL_PROVODKI_Y  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VAL_PROVODKI_Y.sql =========*** End ***
PROMPT ===================================================================================== 
